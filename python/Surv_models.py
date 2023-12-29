
import torchtuples as tt
from pycox.models import LogisticHazard
from network import survnet_1, survnet_2, survnet_3

def clinical_model(imfeat_train, col1_train, col2_train, target_train, 
                 imfeat_val, col1_val, col2_val, target_val,imfeat_totaltest, 
                 col1_totaltest, col2_totaltest,
                   imfeat_test_bch, col1_bch_test, col2_bch_test,
                    imfeat_test_cbtn, col1_cbtn_test, col2_cbtn_test,
                    labtrans):
    
    train = tt.tuplefy((col1_train, col2_train), target_train)
    val = tt.tuplefy((col1_val, col2_val), target_val)

    in_features = len(train[0])
    out_features = labtrans.out_features
    net = survnet_1(in_features, out_features)
    model = LogisticHazard(net, tt.optim.Adam(0.01), duration_index=labtrans.cuts)

    batch_size = 10
    epochs = 100
    callbacks = [tt.cb.EarlyStopping(patience=10)]
    log = model.fit(*train, batch_size, epochs, callbacks, True, val_data = val)

    x_train = ( col1_train, col2_train)
    x_val = (col1_val, col2_val)
    x_totaltest = (col1_totaltest, col2_totaltest)
    x_test_bch = ( col1_bch_test, col2_bch_test)
    x_test_cbtn = ( col1_cbtn_test, col2_cbtn_test)

    return model, log, x_train, x_val, x_totaltest, x_test_bch, x_test_cbtn

def image_model(imfeat_train, col1_train, col2_train, target_train, 
                 imfeat_val, col1_val, col2_val, target_val,imfeat_totaltest, 
                 col1_totaltest, col2_totaltest,
                   imfeat_test_bch, col1_bch_test, col2_bch_test,
                    imfeat_test_cbtn, col1_cbtn_test, col2_cbtn_test,
                    labtrans):


    train = tt.tuplefy(imfeat_train, target_train)
    val = tt.tuplefy(imfeat_val, target_val)

    in_features = imfeat_train.shape[1]
    out_features = labtrans.out_features
    net = survnet_2(in_features, out_features)
    model = LogisticHazard(net, tt.optim.Adam(0.01), duration_index=labtrans.cuts)

    batch_size = 10
    epochs = 100
    callbacks = [tt.cb.EarlyStopping(patience=10)]
    log = model.fit(*train, batch_size, epochs, callbacks, True, val_data = val)

    x_train = (imfeat_train)
    x_val = (imfeat_val)
    x_totaltest = imfeat_totaltest
    x_test_bch = (imfeat_test_bch)
    x_test_cbtn = (imfeat_test_cbtn)

    return model, log, x_train, x_val, x_totaltest, x_test_bch, x_test_cbtn

def hybrid_model(imfeat_train, col1_train, col2_train, target_train, 
                 imfeat_val, col1_val, col2_val, target_val,imfeat_totaltest, 
                 col1_totaltest, col2_totaltest,
                   imfeat_test_bch, col1_bch_test, col2_bch_test,
                    imfeat_test_cbtn, col1_cbtn_test, col2_cbtn_test,
                    labtrans):
    
    train = tt.tuplefy((imfeat_train, col1_train, col2_train), target_train)
    val = tt.tuplefy((imfeat_val, col1_val, col2_val), target_val)

    in_features = imfeat_train.shape[1]
    out_features = labtrans.out_features
    net = survnet_3(in_features, out_features)
    model = LogisticHazard(net, tt.optim.Adam(0.01), duration_index=labtrans.cuts)

    batch_size = 10
    epochs = 100
    callbacks = [tt.cb.EarlyStopping(patience=10)]
    log = model.fit(*train, batch_size, epochs, callbacks, True, val_data = val)

    x_train = (imfeat_train, col1_train, col2_train)
    x_val = (imfeat_val, col1_val, col2_val)
    x_totaltest = (imfeat_totaltest, col1_totaltest, col2_totaltest)
    x_test_bch = (imfeat_test_bch, col1_bch_test, col2_bch_test)
    x_test_cbtn = (imfeat_test_cbtn, col1_cbtn_test, col2_cbtn_test)

    return model, log, x_train, x_val, x_totaltest, x_test_bch, x_test_cbtn