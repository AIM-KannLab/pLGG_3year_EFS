import pandas as pd
from sklearn.model_selection import StratifiedKFold, StratifiedShuffleSplit
import numpy as np
from Surv_models import clinical_model, image_model, hybrid_model
from sklearn.preprocessing import StandardScaler
from pycox.models import LogisticHazard
import os
import torch
from Evaluation import Eval_auc, Eval_calibration, Eval_cindex, Eval_ibs, Eval_KM

os.environ["CUDA_VISIBLE_DEVICES"] = "1"

#load clinical data 
# cbtn = pd.read_csv('/path_to_clinical_data_cbtn.csv')
# df_bch = pd.read_csv('/path_to_clinical_data_bch.csv')
df_bch = pd.read_csv('/media/sdb/Maryam/bch_clinic_200.csv')
cbtn = pd.read_csv('/media/sdb/Maryam/cbtn23_rfs.csv')

df_combined = pd.concat([df_bch, cbtn], ignore_index=True)
df_clinic_filtered = df_bch
df_clinic_cbtn = cbtn

#load MRI image features
df_sorted_feature = pd.read_csv('/media/sdb/Maryam/features_bch.csv')
df_sorted_feature_cbtn = pd.read_csv('/media/sdb/Maryam/getnnunet_feature/feat_nnunet_CB23.csv')
# df_sorted_feature = pd.read_csv('/path_to_image_features_bch.csv')
# df_sorted_feature_cbtn = pd.read_csv('/path_to_image_features_cbtn.csv')
df_combined_feature = pd.concat([df_sorted_feature, df_sorted_feature_cbtn], ignore_index=True)

#load the dataframe which have input clinical variables to the model in organized manner (categorized variables have been changed to numbers)
# twocol_bch = pd.read_csv('path_to_organized_bch.csv')
# twocol_cbtn = pd.read_csv('path_to_organized_cbtn.csv')
twocol_bch = pd.read_csv ('/media/sdb/Maryam/surv_anal/bch_for_merging_ageresec.csv')
twocol_cbtn = pd.read_csv('/media/sdb/Maryam/surv_anal/cbtn_for_merging_ageresec_1.csv')
twocol_combined =  pd.concat([twocol_bch, twocol_cbtn], ignore_index=True)

# Stratified three fold cross validation
skf_outer = StratifiedKFold(n_splits=3, shuffle=True, random_state=121274)
train_indices_bch = {}
val_indices_bch = {}
test_indices_bch = {}

fold = 1
for train_val_index, test_index in skf_outer.split(df_clinic_filtered, df_clinic_filtered['event_3year']):
    train_val, test = df_clinic_filtered.iloc[train_val_index], df_clinic_filtered.iloc[test_index]
    test_indices_bch[f"Fold_{fold}"] = test_index
    sss = StratifiedShuffleSplit(n_splits=1, test_size=0.2, random_state=121274)

    for train_index, val_index in sss.split(train_val, train_val['event_3year']):
        train, val = train_val.iloc[train_index], train_val.iloc[val_index]
        train_indices_bch[f"Fold_{fold}"] = train_index
        val_indices_bch[f"Fold_{fold}"] = val_index

        fold += 1

skf_outer = StratifiedKFold(n_splits=3, shuffle=True, random_state=121274)

train_indices_cbtn = {}
val_indices_cbtn = {}
test_indices_cbtn = {}

fold = 1
for train_val_index, test_index in skf_outer.split(df_clinic_cbtn, df_clinic_cbtn['event_3year']):
    train_val, test = df_clinic_cbtn.iloc[train_val_index], df_clinic_cbtn.iloc[test_index]
    test_indices_cbtn[f"Fold_{fold}"] = test_index
    sss = StratifiedShuffleSplit(n_splits=1, test_size=0.2, random_state=121274)

    for train_index, val_index in sss.split(train_val, train_val['event_3year']):
        train, val = train_val.iloc[train_index], train_val.iloc[val_index]
        train_indices_cbtn[f"Fold_{fold}"] = train_index
        val_indices_cbtn[f"Fold_{fold}"] = val_index

        fold += 1

for fold in train_indices_cbtn:
    train_indices_cbtn[fold] = [idx + (df_bch.shape[0]) for idx in train_indices_cbtn[fold]]
for fold in val_indices_cbtn:
    val_indices_cbtn[fold] = [idx + (df_bch.shape[0]) for idx in val_indices_cbtn[fold]]
for fold in test_indices_cbtn:
    test_indices_cbtn[fold] = [idx + (df_bch.shape[0]) for idx in test_indices_cbtn[fold]]

merged_indices_train = {'Fold_1': [],
    'Fold_2': [],
    'Fold_3': []
    }

for fold in train_indices_bch:
    merged_indices_train[fold].extend(train_indices_cbtn[fold])
    merged_indices_train[fold].extend(train_indices_bch[fold])

merged_indices_val = {'Fold_1': [],
    'Fold_2': [],
    'Fold_3': []}

for fold in val_indices_bch:
    merged_indices_val[fold].extend(val_indices_cbtn[fold])
    merged_indices_val[fold].extend(val_indices_bch[fold])

merged_indices_test = {'Fold_1': [],
    'Fold_2': [],
    'Fold_3': []}

for fold in test_indices_bch:
    merged_indices_test[fold].extend(test_indices_cbtn[fold])
    merged_indices_test[fold].extend(test_indices_bch[fold])


#Making survival models, training and evaluation
np.random.seed(121274)
_ = torch.manual_seed(121274)

for fold in ['Fold_1', 'Fold_2', 'Fold_3']:
    indices_test_bch_fold = []
    indices_test_cbtn_fold = []
    for item in merged_indices_test[fold]:
        if item < (df_bch.shape[0]):
            indices_test_bch_fold.append(item)
        else:
            indices_test_cbtn_fold.append(item)

    df_train = df_combined_feature.loc[merged_indices_train[fold]]
    df_val = df_combined_feature.loc[merged_indices_val[fold]]
    df_totaltest = df_combined_feature.loc[merged_indices_test[fold]]
    df_test_bch = df_combined_feature.loc[indices_test_bch_fold]
    df_test_cbtn = df_combined_feature.loc[indices_test_cbtn_fold]

    df_train_target = df_combined.loc[merged_indices_train[fold]]
    df_val_target = df_combined.loc[merged_indices_val[fold]]
    df_totaltest_target = df_combined.loc[merged_indices_test[fold]]
    df_target_test_bch = df_combined.loc[indices_test_bch_fold]
    df_target_test_cbtn = df_combined.loc[indices_test_cbtn_fold]

    df_two_train = twocol_combined.loc[merged_indices_train[fold]]
    df_two_val = twocol_combined.loc[merged_indices_val[fold]]
    df_two_totaltest = twocol_combined.loc[merged_indices_test[fold]]
    df_two_bch_test = twocol_combined.loc[indices_test_bch_fold]
    df_two_cbtn_test = twocol_combined.loc[indices_test_cbtn_fold]

    scaler = StandardScaler()

    imfeat_train = scaler.fit_transform(df_train).astype('float32')
    imfeat_val = scaler.transform(df_val).astype('float32')
    imfeat_totaltest = scaler.transform(df_totaltest).astype('float32')
    imfeat_test_bch = scaler.transform(df_test_bch).astype('float32')
    imfeat_test_cbtn = scaler.transform(df_test_cbtn).astype('float32')

    df_two_train[['age']] = scaler.fit_transform(df_two_train[['age']]).astype('float32')
    df_two_val[['age']] = scaler.transform(df_two_val[['age']]).astype('float32')
    df_two_totaltest[['age']] = scaler.transform(df_two_totaltest[['age']]).astype('float32')
    df_two_bch_test[['age']] = scaler.transform(df_two_bch_test[['age']]).astype('float32')
    df_two_cbtn_test[['age']] = scaler.fit_transform(df_two_cbtn_test[['age']]).astype('float32')

    col1_train = (df_two_train['age'].astype('float32')).to_numpy()
    col2_train = (df_two_train['resection'].astype('float32')).to_numpy()

    col1_val = (df_two_val['age'].astype('float32')).to_numpy()
    col2_val = (df_two_val['resection'].astype('float32')).to_numpy()

    col1_totaltest = (df_two_totaltest['age'].astype('float32')).to_numpy()
    col2_totaltest = (df_two_totaltest['resection'].astype('float32')).to_numpy()

    col1_bch_test = (df_two_bch_test['age'].astype('float32')).to_numpy()
    col2_bch_test = (df_two_bch_test['resection'].astype('float32')).to_numpy()

    col1_cbtn_test = (df_two_cbtn_test['age'].astype('float32')).to_numpy()
    col2_cbtn_test = (df_two_cbtn_test['resection'].astype('float32')).to_numpy()

    col1_train = col1_train.reshape(len(col1_train),1)
    col2_train = col2_train.reshape(len(col2_train),1)

    col1_val = col1_val.reshape(len(col1_val),1)
    col2_val = col2_val.reshape(len(col2_val),1)

    col1_totaltest = col1_totaltest.reshape(len(col1_totaltest),1)
    col2_totaltest = col2_totaltest.reshape(len(col2_totaltest),1)

    col1_bch_test = col1_bch_test.reshape(len(col1_bch_test),1)
    col2_bch_test = col2_bch_test.reshape(len(col2_bch_test),1)

    col1_cbtn_test = col1_cbtn_test.reshape(len(col1_cbtn_test),1)
    col2_cbtn_test = col2_cbtn_test.reshape(len(col2_cbtn_test),1)

    get_target = lambda label_d: (label_d['time_event_3year'].values.astype(int), label_d['event_3year'].values.astype(int))

    get_target_cbtn = lambda label_d: (label_d['time_event_3year'].values.astype(int), label_d['event_3year'].values.astype(int))

    num_durations = 15
    labtrans = LogisticHazard.label_transform(num_durations)

    target_train = labtrans.fit_transform(*get_target(df_train_target))
    target_val = labtrans.transform(*get_target(df_val_target))
    target_totaltest = labtrans.transform(*get_target(df_totaltest_target))
    target_test_bch = labtrans.transform(*get_target(df_target_test_bch))
    target_test_cbtn = labtrans.transform(*get_target(df_target_test_cbtn))

    durations_train, events_train = get_target(df_train_target)
    durations_val, events_val = get_target(df_val_target)
    durations_totaltest, events_totaltest = get_target(df_totaltest_target)
    durations_test_bch, events_test_bch = get_target(df_target_test_bch)
    durations_test_cbtn, events_test_cbtn = get_target(df_target_test_cbtn)

    function_map = {
    'clinical': clinical_model,
    'image': image_model,
    'hybrid': hybrid_model}

    models = ['clinical', 'image', 'hybrid']

    for survmodel in models:
        if survmodel in function_map:
            print(fold)
            print(f"Survival model:{survmodel}")
            (model, log, x_train, x_val, x_totaltest, x_test_bch, x_test_cbtn) = function_map[survmodel](
                    imfeat_train, col1_train, col2_train, target_train, 
                 imfeat_val, col1_val, col2_val, target_val,imfeat_totaltest, 
                 col1_totaltest, col2_totaltest,
                   imfeat_test_bch, col1_bch_test, col2_bch_test,
                    imfeat_test_cbtn, col1_cbtn_test, col2_cbtn_test,
                    labtrans)
    

            (ctd_test_total, ctd_test_bch, ctd_test_cbtn, ctd_train, 
            ev_total, ev_bch, ev_cbtn, ev_train) = Eval_cindex(
            model, 
            x_train, 
            x_totaltest, 
            x_test_bch, 
            x_test_cbtn,
            durations_test_bch, 
            events_test_bch, 
            durations_test_cbtn,
            events_test_cbtn, 
            durations_train, 
            events_train,  
            durations_totaltest, 
            events_totaltest)

            (auc_value1, auc_bch_cl, auc_cbtn_cl) = Eval_auc(
                model,
                x_totaltest,
                x_test_bch,
                x_test_cbtn, 
                events_test_bch,
                events_test_cbtn,
                events_totaltest)
            
            IBS_bch, IBS_cbtn, IBS_totaltest, IBS_train = Eval_ibs(durations_train, ev_total, ev_train, ev_bch, ev_cbtn)

            (t_risk_1, ev_risk_1, t_risk_2, ev_risk_2, t_risk_1_test,
            ev_risk_1_test, t_risk_2_test, ev_risk_2_test) = Eval_KM(
            model,
            x_train, 
            x_totaltest, 
            x_val, 
            durations_train, 
            events_train,
            durations_totaltest,
            events_totaltest)

            ECE_bch, ECE_cbtn, ECE_total = Eval_calibration(
            model,
            x_totaltest,
            x_test_bch,
            x_test_cbtn,
            durations_test_bch,
            events_test_bch,
            durations_test_cbtn,
            events_test_cbtn, 
            durations_totaltest,
            events_totaltest)