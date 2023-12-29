import torch

class survnet_1(torch.nn.Module):
    
    def __init__(self, in_features, out_features):
               
        super(survnet_1, self).__init__()

        self.fc1 = torch.nn.Linear(in_features, 2000)
        self.fc2 = torch.nn.Linear(2000, 200)
        self.fc3 = torch.nn.Linear(200, out_features)
                
        self.relu = torch.nn.ReLU()
        self.BN1 = torch.nn.BatchNorm1d(2000)
        self.BN2 = torch.nn.BatchNorm1d(200)

        self.dropout = torch.nn.Dropout(0.3)
        
    
    def forward(self, col1_train, col2_train):

        x_train = torch.cat((col1_train, col2_train), dim =1)
        
        x1 = self.fc1(x_train)
        
        x2 = self.relu(x1)
        
        x3 = self.BN1(x2)
        
        x4 = self.dropout(x3)
                
        x5 = self.fc2(x4)
        
        x6 = self.relu(x5)
        
        x7 = self.BN2(x6)
        
        x8 = self.dropout(x7)
        
        x9 = self.fc3(x8)
                
        return x9

class survnet_2(torch.nn.Module):
    
    def __init__(self, in_features, out_features):
               
        super(survnet_2, self).__init__()

        self.fc1 = torch.nn.Linear(in_features, 2000)
        self.fc2 = torch.nn.Linear(2000, 200)
        self.fc3 = torch.nn.Linear(200, out_features)
                
        self.relu = torch.nn.ReLU()
        self.BN1 = torch.nn.BatchNorm1d(2000)
        self.BN2 = torch.nn.BatchNorm1d(200)

        self.dropout = torch.nn.Dropout(0.3)
        
    
    def forward(self, imfeat_train):
        
        x1 = self.fc1(imfeat_train)
        
        x2 = self.relu(x1)
        
        x3 = self.BN1(x2)
        
        x4 = self.dropout(x3)
                
        x5 = self.fc2(x4)
        
        x6 = self.relu(x5)
        
        x7 = self.BN2(x6)
        
        x8 = self.dropout(x7)
        
        x9 = self.fc3(x8)
                
        return x9
    
class survnet_3(torch.nn.Module):
    
    def __init__(self, in_features, out_features):
        
       
        super(survnet_3, self).__init__()

        self.fc1 = torch.nn.Linear(in_features, 2000)
        self.fc2 = torch.nn.Linear(2000, 200)
        self.fc3 = torch.nn.Linear(200+2, out_features)
        
        self.relu = torch.nn.ReLU()
        self.BN1 = torch.nn.BatchNorm1d(2000)
        self.BN2 = torch.nn.BatchNorm1d(200)

        self.dropout = torch.nn.Dropout(0.3)
        
    
    def forward(self, imfeat_train, col1_train, col2_train):
        
        x1 = self.fc1(imfeat_train)
        
        x2 = self.relu(x1)
        
        x3 = self.BN1(x2)
        
        x4 = self.dropout(x3)

        x5 = self.fc2(x4)
        
        x6 = self.relu(x5)
        
        x7 = self.BN2(x6)
        
        x8 = self.dropout(x7)


        merged_data = torch.cat((x8, col1_train, col2_train), dim=1)
        
        x9 = self.fc3(merged_data)
        
        return x9