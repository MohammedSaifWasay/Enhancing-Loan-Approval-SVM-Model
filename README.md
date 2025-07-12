# 💳 Enhancing Loan Approval Processes with SVM

This project presents a machine learning solution using **Support Vector Machines (SVM)** to predict **loan approval decisions** based on historical applicant data. By leveraging features such as income, credit history, employment status, and demographics, the model assists financial institutions in improving decision-making and minimizing default risks.

---

## 🧱 Project Structure & Milestones

### 🚀 Milestone 1: Data Collection & Preparation

- Imported dataset from CSV into R.
- Utilized R packages: `dplyr`, `ggplot2`, `e1071`, `tidyr`, `gridExtra`.
- **Exploratory Visualizations**:
  - Histograms for numeric variables (e.g., income, loan amount).
  - Bar plots for categorical variables (e.g., gender, marital status).
- **Missing Value Treatment**:
  - Categorical: Mode imputation.
  - Numeric: Median imputation.
- **Data Cleaning Steps**:
  - Removed `Loan_ID` (irrelevant identifier).
  - Converted categorical variables to `factor` type.

---

### 🧪 Milestone 2: Model Development

- **Model Type**: Support Vector Machine (SVM)
- **Kernel Used**: Linear
- **Data Split**:
  - 80% training
  - 20% testing (mutually exclusive)
- **Model Formula**:  
  `Loan_Status ~ .` (all remaining features)
- **Training Function**:  
  `svm(..., type = 'C-classification', kernel = 'linear')`
- **Error Handling**:  
  Implemented using `try()` to ensure robust execution

---

### 📈 Final Output & Evaluation

- **Confusion Matrix**: Used to assess prediction results (TP, TN, FP, FN)
- **Accuracy Achieved**: **82%**
- **Insights**:
  - The linear kernel worked effectively for this classification task.
  - The model performs well with simple, clean data and efficient preprocessing.
- **Visualizations**:
  - Missing value bar plots (before & after imputation)
  - Confusion matrix (actual vs predicted loan status)

---

## 🔍 Key Learnings

- SVM is a powerful method for binary classification problems in finance.
- Proper preprocessing (missing value imputation, factor conversion) significantly improves model accuracy.
- Visualizations enhance understanding of both data quality and model performance.
- Accuracy of 82% demonstrates promise for real-world implementation in lending institutions.

---

## 🧠 Author  
**Mohammed Saif Wasay**  
*Data Analytics Graduate — Northeastern University*  
*Machine Learning Enthusiast | Passionate about turning data into insights*  

🔗 [Connect with me on LinkedIn](https://www.linkedin.com/in/mohammed-saif-wasay-4b3b64199/)
