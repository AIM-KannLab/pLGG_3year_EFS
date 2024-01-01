# pLGG_3year_RFS
This repository is dedicated to the prediction of three-year recurrence-free survival in pediatric low-grade gliomas using preoperative MRI scans and clinical variables.

Pediatric low-grade gliomas (pLGG) are the most prevalent central nervous system tumors in children, representing 30-50% of cases. Accurate assessment of recurrence risk is crucial for targeted treatment in pediatric gliomas, challenged by the diverse nature of the tumors. This study aims to develop and validate a deep learning framework utilizing preoperative MRI scans to enhance the prediction of recurrence risk in pLGG. An end-to-end deep learning model was created, integrating pre-trained segmentation models for automated MRI feature extraction, eliminating the need for manual tumor delineation. The model was trained and validated using data from 200 subjects from Boston Children’s Hospital (BCH) and 196 subjects from the Children’s Brain Tumor Network (CBTN). It comprised three prognostic models: one based on clinical variables, one on MRI features, and a hybrid model incorporating both. This study successfully demonstrates that a deep learning approach, utilizing preoperative MRI scans and clinical data, can significantly enhance recurrence risk prediction in pLGG. Integrating automated MRI feature extraction with clinical variables offers a promising tool for more accurate risk stratification and individualized patient management in pediatric neuro-oncology. 

![Framework (1)-1](https://github.com/AIM-KannLab/pLGG_3year_RFS/assets/53992619/aa221dab-3cb9-4683-a4d1-4146229c1b8f)

This visual summary illustrates the integrated approach adopted in our study. We combined patient data from the BCH and CBTN cohorts and utilized MRI images alongside clinical variables such as age and resection status. To ensure robustness and reliability, a three-fold cross-validation method was implemented to obtain average accuracy. The process for deriving MRI image features involved a sequence of steps: preprocessing, tumor segmentation, and feature extraction. These features were then processed through fully connected neural layers and integrated with clinical data using a logistic hazard loss function. The outcome of the model is the generation of personalized recurrence-free survival curves, focusing specifically on three-year recurrence outcomes in this study.

This repository is for survival part of model which is the violet part. The segmentation part code and docker is located in: https://github.com/AIM-KannLab/pLGG_Segmentation and https://github.com/AIM-KannLab/pLGG_Segmentation_docker. The feature extraction part code is located in: https://github.com/AIM-KannLab/nnUnet_Features.

## Running python codes

1. Clone the repository
2. Navigate into the directory python
3. Create a virtual environment: python -m venv env
4. Activate the virtual environment:
- Windows: `.\env\Scripts\activate`
- macOS/Linux: `source env/bin/activate`
5. Install the required packages: pip install -r rfs_requirements.txt
6. Run the main.py. It tries to combine two datasets make survival models. It loads clinical data and features extracted from MRI images of two cohorts and tries to predict survival probabilities of subjects.

## R scripts
In this study, R was employed exclusively for generating plots. All values were pre-saved as CSV files from Python and then visualized using R. You can find the necessary R scripts within the 'R' folder.
