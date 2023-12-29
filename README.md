# pLGG_3year_RFS
This repository is dedicated to the prediction of three-year recurrence-free survival in pediatric low-grade gliomas using preoperative MRI scans and clinical variables.
Abstract  

Background: 

Pediatric low-grade gliomas (pLGG) are the most prevalent central nervous system tumors in children, representing 30-50% of cases. Accurate assessment of recurrence risk is crucial for targeted treatment in pediatric gliomas, challenged by the diverse nature of the tumors. This study aims to develop and validate a deep learning framework utilizing preoperative MRI scans to enhance the prediction of recurrence risk in pLGG. 

Methods: 

An end-to-end deep learning model was created, integrating pre-trained segmentation models for automated MRI feature extraction, eliminating the need for manual tumor delineation. The model was trained and validated using data from 200 subjects from Boston Children’s Hospital (BCH) and 196 subjects from the Children’s Brain Tumor Network (CBTN). It comprised three prognostic models: one based on clinical variables, one on MRI features, and a hybrid model incorporating both. 

Results: 

The hybrid model, integrating clinical and MRI data, demonstrated enhanced performance with a Concordance Index (C-index) of 0.88 (95% CI: 0.81-0.93) and an Area Under the Curve (AUC) of 0.88 (95% CI: 0.80-0.94). A marked improvement was observed compared to the clinical-only model, indicating the hybrid model's significantly better capability in stratifying risk levels among pLGG patients. 

Conclusions: 

This study successfully demonstrates that a deep learning approach, utilizing preoperative MRI scans and clinical data, can significantly enhance recurrence risk prediction in pLGG. Integrating automated MRI feature extraction with clinical variables offers a promising tool for more accurate risk stratification and individualized patient management in pediatric neuro-oncology. 
