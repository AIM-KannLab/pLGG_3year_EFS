from pycox.evaluation import EvalSurv
import numpy as np
from sklearn.metrics import roc_curve, roc_auc_score
import matplotlib.pyplot as plt
from lifelines import KaplanMeierFitter
import pandas as pd

def Eval_cindex(model, x_train, x_totaltest, x_test_bch, x_test_cbtn,
               durations_test_bch, events_test_bch, durations_test_cbtn,
               events_test_cbtn, durations_train, events_train,  durations_test, events_test):
    

    surv_train_cont = model.interpolate(40).predict_surv_df(x_train)
    surv_totaltest_cont = model.interpolate(40).predict_surv_df(x_totaltest)
    surv_test_cont_bch = model.interpolate(40).predict_surv_df(x_test_bch)
    surv_test_cont_cbtn = model.interpolate(40).predict_surv_df(x_test_cbtn)

    ev_total = EvalSurv(surv_totaltest_cont, durations_test, events_test, censor_surv='km')
    ctd_test_total = ev_total.concordance_td('antolini')
    print(f'C_td Score for test: {ctd_test_total}')

    ev_bch = EvalSurv(surv_test_cont_bch, durations_test_bch, events_test_bch, censor_surv='km')
    ctd_test_bch = ev_bch.concordance_td('antolini')
    print(f'C_td Score for test<BCH>: {ctd_test_bch}')

    ev_cbtn = EvalSurv(surv_test_cont_cbtn, durations_test_cbtn, events_test_cbtn, censor_surv='km')
    ctd_test_cbtn = ev_cbtn.concordance_td('antolini')
    print(f'C_td Score for test<CBTN>: {ctd_test_cbtn}')

    ev_train = EvalSurv(surv_train_cont, durations_train, events_train, censor_surv='km')
    ctd_train = ev_train.concordance_td('antolini')
    print(f'C_td Score for train: {ctd_train}')
    
    #calculating 95 confidence interval
    '''
    def bootstrap_cindex(surv, durations, events, n_iterations=1000):
        cindexs = []
        for _ in range(n_iterations):
            indices = np.random.randint(0, len(durations), len(durations)) 
            ctd = EvalSurv(surv[indices], durations[indices], events[indices], censor_surv='km').concordance_td('antolini')
            cindexs.append(ctd)
        sorted_cs = np.array(cindexs)
        sorted_cs.sort()
        conf_int = np.percentile(sorted_cs , [2.5, 97.5])
        return conf_int
    
    cindex_95ci_total = bootstrap_cindex(surv_totaltest_cont, durations_test, events_test)
    cindex_95ci_bch = bootstrap_cindex(surv_test_cont_bch, durations_test_bch, events_test_bch)
    cindex_95ci_cbtn = bootstrap_cindex(surv_test_cont_cbtn, durations_test_cbtn, events_test_cbtn)
    
    print(f"95 CI Cindex totaltest:{cindex_95ci_total}")
    print(f"95 CI Cindex bch:{cindex_95ci_bch}")
    print(f"95 CI Cindex cbtn:{cindex_95ci_cbtn}")
    '''

    # return ctd_test_total, ctd_test_bch, ctd_test_cbtn, ctd_train, cindex_95ci_total, cindex_95ci_bch, cindex_95ci_cbtn, ev_total, ev_bch, ev_cbtn, ev_train
    return ctd_test_total, ctd_test_bch, ctd_test_cbtn, ctd_train, ev_total, ev_bch, ev_cbtn, ev_train
def Eval_auc(model, x_totaltest, x_test_bch, x_test_cbtn, 
             events_test_bch,
               events_test_cbtn,
               events_totaltest):

    risk_scores1 = model.predict(x_totaltest)
    average_risk_scores1 = np.mean(risk_scores1, axis=1)

    y_true_binary1 = events_totaltest

    fpr1, tpr1, _ = roc_curve(y_true_binary1, average_risk_scores1)
    auc_value1 = roc_auc_score(y_true_binary1, average_risk_scores1)

    risk_scores2 = model.predict(x_test_bch)
    average_risk_scores2 = np.mean(risk_scores2, axis=1)

    y_true_binary2 = events_test_bch 

    fpr_bch_cl, tpr_bch_cl, _ = roc_curve(y_true_binary2, average_risk_scores2)
    auc_bch_cl = roc_auc_score(y_true_binary2, average_risk_scores2)

    risk_scores3 = model.predict(x_test_cbtn)
    average_risk_scores3 = np.mean(risk_scores3, axis=1)

    y_true_binary3 = events_test_cbtn

    fpr_cbtn_cl, tpr_cbtn_cl, _ = roc_curve(y_true_binary3, average_risk_scores3)
    auc_cbtn_cl = roc_auc_score(y_true_binary3, average_risk_scores3)

    print("****ROC Curves****")
    plt.figure()
    plt.plot(fpr1, tpr1, label=f" AUC totaltest = {auc_value1:.2f}")
    plt.plot(fpr_bch_cl, tpr_bch_cl, label=f" AUC BCH = {auc_bch_cl:.2f}")
    plt.plot(fpr_cbtn_cl, tpr_cbtn_cl, label=f" AUC CBTN = {auc_cbtn_cl:.2f}")
    plt.xlabel('False Positive Rate')
    plt.ylabel('True Positive Rate')
    plt.title('Receiver Operating Characteristic (ROC) Curve')
    plt.legend(loc="lower right")
    
    #calculating 95 confidence interval
    '''
    def bootstrap_auc(y_true, y_score, n_iterations=1000):
        aucs = []
        for _ in range(n_iterations):
            indices = np.random.randint(0, len(y_true), len(y_true)) 
            sample_auc = roc_auc_score(y_true[indices], y_score[indices])
            aucs.append(sample_auc)
        sorted_auc = np.array(aucs)
        sorted_auc.sort()
        conf_int = np.percentile(sorted_auc , [2.5, 97.5])
        return conf_int

    auc_95ci_total = bootstrap_auc(y_true_binary1, average_risk_scores1)
    auc_95ci_bch = bootstrap_auc(y_true_binary2, average_risk_scores2)
    auc_95ci_cbtn = bootstrap_auc(y_true_binary3, average_risk_scores3)

    print(f"95 CI AUC totaltest:{auc_95ci_total}")
    print(f"95 CI AUC bch:{auc_95ci_bch}")
    print(f"95 CI AUC cbtn:{auc_95ci_cbtn}")
    '''
    return auc_value1, auc_bch_cl, auc_cbtn_cl#, auc_95ci_total, auc_95ci_bch, auc_95ci_cbtn

def Eval_ibs(durations_train, ev_total, ev_train, ev_bch, ev_cbtn):

    time_grid = np.linspace(durations_train.min(), durations_train.max(), 100)

    IBS_bch = ev_bch.integrated_brier_score(time_grid)
    IBS_cbtn = ev_cbtn.integrated_brier_score(time_grid)
    IBS_train = ev_train.integrated_brier_score(time_grid)
    IBS_totaltest = ev_total.integrated_brier_score(time_grid)

    print(f'IBS Score for test<BCH>: {IBS_bch}')
    print(f'IBS Score for test<CBTN>: {IBS_cbtn}')
    print(f'IBS Score for totaltest: {IBS_totaltest}')
    print(f'IBS_train Score for train: {IBS_train}')

    return IBS_bch, IBS_cbtn, IBS_totaltest, IBS_train

def Eval_KM(model, x_train, x_totaltest, x_val, durations_train, 
            events_train, durations_totaltest, events_totaltest):

    risk_scores_train = model.predict(x_train)
    risk_scores_test = model.predict(x_totaltest)
    risk_scores_val = model.predict(x_val)

    average_risks_train = np.mean(risk_scores_train, axis=1)
    average_risks_test = np.mean(risk_scores_test, axis = 1)
    average_risks_val = np.mean(risk_scores_val, axis = 1)

    median_risk = np.median(average_risks_val)

    risk_mask1 = average_risks_train <= median_risk
    risk_mask2 = average_risks_train > median_risk

    risk_mask1_test = average_risks_test <= median_risk
    risk_mask2_test = average_risks_test > median_risk

    t_risk_1 = durations_train[risk_mask1]
    t_risk_2 = durations_train[risk_mask2]

    ev_risk_1 = events_train[risk_mask1]
    ev_risk_2 = events_train[risk_mask2]

    t_risk_1_test = durations_totaltest[risk_mask1_test]
    t_risk_2_test = durations_totaltest[risk_mask2_test] 

    ev_risk_1_test = events_totaltest[risk_mask1_test]
    ev_risk_2_test = events_totaltest[risk_mask2_test]

    print("****Kaplan Meier Curves Train****")
    kmf = KaplanMeierFitter()
    kmf.fit(t_risk_1, event_observed=ev_risk_1, label='Risk Group 1')
    kmf.plot(ci_show = False)
    kmf.fit(t_risk_2, event_observed=ev_risk_2, label='Risk Group 2')
    kmf.plot(ci_show = False)
    plt.title('Kaplan-Meier Curves')
    plt.ylabel('Recurrence free survival')
    plt.xlabel('Time(Days)')
    plt.legend()
    plt.show()

    print("****Kaplan Meier Curves Test****")
    kmf = KaplanMeierFitter()
    kmf.fit(t_risk_1_test, event_observed=ev_risk_1_test, label='Risk Group 1')
    kmf.plot(ci_show = False)
    kmf.fit(t_risk_2_test, event_observed=ev_risk_2_test, label='Risk Group 2')
    kmf.plot(ci_show = False)
    plt.title('Kaplan-Meier Curves')
    plt.ylabel('Recurrence free survival')
    plt.xlabel('Time(Days)')
    plt.legend()
    plt.show()

    return t_risk_1, ev_risk_1, t_risk_2, ev_risk_2, t_risk_1_test, ev_risk_1_test, t_risk_2_test, ev_risk_2_test

def Eval_calibration(model, x_totaltest, x_test_bch,
                      x_test_cbtn, durations_test_bch, events_test_bch,
                      durations_test_cbtn, events_test_cbtn, 
                      durations_test_total,events_test_total ):

    surv_totaltest_disc = model.predict_surv_df(x_totaltest)
    surv_test_disc_bch = model.predict_surv_df(x_test_bch)
    surv_test_disc_cbtn = model.predict_surv_df(x_test_cbtn)

    observed = (durations_test_bch <= 1095) & (events_test_bch == 1)
    predict = surv_test_disc_bch.loc[1095,:]

    df_calib = pd.DataFrame({'predicted': predict, 'observed': observed})
    df_calib['bin'] = pd.qcut(df_calib['predicted'], q=5, duplicates='drop') 
    calib_data = df_calib.groupby('bin').agg('mean')
    df_calib['count'] = 1 
    df_calib['abs_diff'] = np.abs(df_calib['predicted'] - (1-df_calib['observed']))
    weighted_abs_diff = df_calib.groupby('bin').apply(lambda x: x['abs_diff'] * x['count'])
    ECE_bch = weighted_abs_diff.sum() / df_calib['count'].sum()

    print(f"Expected Calibration Error BCH: {ECE_bch}")
    fig, ax = plt.subplots()
    print("****calibration plot BCH test***")
    ax.plot(calib_data['predicted'], 1-calib_data['observed'], marker='o', label=f'Time: {1095} days')
    ax.plot([0, 1], [0, 1], 'k--', label='Perfectly calibrated')
    ax.set_xlabel('Predicted probability')
    ax.set_ylabel('Observed frequency')
    plt.show()

    observed = (durations_test_cbtn <= 1095) & (events_test_cbtn == 1)
    predict = surv_test_disc_cbtn.loc[1095,:]

    df_calib = pd.DataFrame({'predicted': predict, 'observed': observed})
    df_calib['bin'] = pd.qcut(df_calib['predicted'], q=5, duplicates='drop') 
    calib_data = df_calib.groupby('bin').agg('mean')
    df_calib['count'] = 1 
    df_calib['abs_diff'] = np.abs(df_calib['predicted'] - (1-df_calib['observed']))
    weighted_abs_diff = df_calib.groupby('bin').apply(lambda x: x['abs_diff'] * x['count'])
    ECE_cbtn = weighted_abs_diff.sum() / df_calib['count'].sum()

    print(f"Expected Calibration Error cbtn: {ECE_cbtn}")
    fig, ax = plt.subplots()
    print("****calibration plot CBTN test***")
    ax.plot(calib_data['predicted'], 1-calib_data['observed'], marker='o', label=f'Time: {1095} days')
    ax.plot([0, 1], [0, 1], 'k--', label='Perfectly calibrated')
    ax.set_xlabel('Predicted probability')
    ax.set_ylabel('Observed frequency')
    plt.show()

    observed = (durations_test_total <= 1095) & (events_test_total == 1)
    predict = surv_totaltest_disc.loc[1095,:]

    df_calib = pd.DataFrame({'predicted': predict, 'observed': observed})
    df_calib['bin'] = pd.qcut(df_calib['predicted'], q=5, duplicates='drop') 
    calib_data = df_calib.groupby('bin').agg('mean')
    df_calib['count'] = 1 
    df_calib['abs_diff'] = np.abs(df_calib['predicted'] - (1-df_calib['observed']))
    weighted_abs_diff = df_calib.groupby('bin').apply(lambda x: x['abs_diff'] * x['count'])
    ECE_total = weighted_abs_diff.sum() / df_calib['count'].sum()

    print(f"Expected Calibration Error total: {ECE_total}")
    fig, ax = plt.subplots()
    print("****calibration plot totaltest***")
    ax.plot(calib_data['predicted'], 1-calib_data['observed'], marker='o', label=f'Time: {1095} days')
    ax.plot([0, 1], [0, 1], 'k--', label='Perfectly calibrated')
    ax.set_xlabel('Predicted probability')
    ax.set_ylabel('Observed frequency')
    plt.show()
    
    return ECE_bch, ECE_cbtn, ECE_total
