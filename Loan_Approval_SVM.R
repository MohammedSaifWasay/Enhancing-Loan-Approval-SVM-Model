#Mohammed Saif Wasay
#NUID: 002815958
#ALY6040 
#Data Mining Aplications #Module 4: Practise SVM MOdel:-

cat("\014") # clears console
rm(list = ls()) # clears global environment
try(dev.off(dev.list()["RStudioGD"]), silent = TRUE) # clears plots
try(p_unload(p_loaded(), character.only = TRUE), silent = TRUE) #clears packages
options(scipen = 100) # disables scientific notation for entire R session

# Load necessary libraries
library(dplyr)
library(tidyr)
library(e1071)
library(ggplot2)
library(gridExtra)

# Load the data
loan_data <- read.csv("C:/Users/Mohammed Saif Wasay/Documents/code/data/loan-train.csv")

# Data Exploration: Visualize distributions of numerical features
p1 <- ggplot(loan_data, aes(x=ApplicantIncome)) + geom_histogram(bins=30, fill="blue", color="black") + ggtitle("Distribution of Applicant Income")
p2 <- ggplot(loan_data, aes(x=LoanAmount)) + geom_histogram(bins=30, fill="green", color="black") + ggtitle("Distribution of Loan Amount")

# Visualize categorical data distribution
p3 <- ggplot(loan_data, aes(x=Gender, fill=Gender)) + geom_bar() + ggtitle("Gender Distribution")
p4 <- ggplot(loan_data, aes(x=Married, fill=Married)) + geom_bar() + ggtitle("Marital Status Distribution")

# Display plots
grid.arrange(p1, p2, p3, p4, nrow=2)

# Handling missing values
missing_before <- loan_data %>% summarise(across(everything(), ~sum(is.na(.))))
p5 <- ggplot(missing_before %>% pivot_longer(everything(), names_to = "variable", values_to = "value"), 
             aes(x=variable, y=value)) + 
  geom_bar(stat="identity", fill="red") + 
  ggtitle("Missing Values Before Imputation")
print(p5)

#Missing Value Imputation
loan_data$Gender[is.na(loan_data$Gender)] <- names(which.max(table(loan_data$Gender, useNA = "no")))
loan_data$Married[is.na(loan_data$Married)] <- names(which.max(table(loan_data$Married, useNA = "no")))
loan_data$Dependents[is.na(loan_data$Dependents)] <- names(which.max(table(loan_data$Dependents, useNA = "no")))
loan_data$Self_Employed[is.na(loan_data$Self_Employed)] <- names(which.max(table(loan_data$Self_Employed, useNA = "no")))
loan_data$LoanAmount[is.na(loan_data$LoanAmount)] <- median(loan_data$LoanAmount, na.rm = TRUE)
loan_data$Loan_Amount_Term[is.na(loan_data$Loan_Amount_Term)] <- median(loan_data$Loan_Amount_Term, na.rm = TRUE)
loan_data$Credit_History[is.na(loan_data$Credit_History)] <- median(loan_data$Credit_History, na.rm = TRUE)

#After Imputation: 
missing_after <- loan_data %>% summarise(across(everything(), ~sum(is.na(.))))
p6 <- ggplot(missing_after %>% pivot_longer(everything(), names_to = "variable", values_to = "value"), 
             aes(x=variable, y=value)) + 
  geom_bar(stat="identity", fill="green") + 
  ggtitle("Missing Values After Imputation")
print(p6)

# Remove Loan_ID and Convert categorical variables to factors
loan_data <- loan_data %>% select(-Loan_ID) %>%
  mutate(across(c(Gender, Married, Dependents, Education, Self_Employed, Property_Area, Loan_Status), factor))

# Split data into training and testing sets
set.seed(123)
train_data <- loan_data %>% sample_frac(.8)
test_data <- setdiff(loan_data, train_data)

# Train SVM model
svm_model <- try(svm(Loan_Status ~ ., data = train_data, type = 'C-classification', kernel = 'linear'))
# Generate predictions from the SVM model
predictions <- if (exists("svm_model") && !inherits(svm_model, "try-error")) predict(svm_model, test_data)

# Validate the presence of predictions and test data
if (!is.null(predictions) && !is.null(test_data$Loan_Status)) {
  confusion_matrix <- table(Predicted = predictions, Actual = test_data$Loan_Status)
  confusion_data <- as.data.frame(confusion_matrix)  # Convert table to data frame for ggplot
  
  # Fix potential issues with data frame structure
  names(confusion_data) <- c("Predicted", "Actual", "Freq")  # Ensure the column names are correct
  
  # Plotting the confusion matrix
  p7 <- ggplot(confusion_data, aes(x=Predicted, y=Freq, fill=Actual)) + 
    geom_bar(stat="identity", position="dodge") + 
    labs(title="Confusion Matrix of SVM Model", x="Predicted Label", y="Frequency") +
    theme_minimal()
  
  print(p7)  # Print the plot
  
  # Calculate and print accuracy
  accuracy <- sum(diag(confusion_matrix)) / sum(confusion_matrix)
  print(paste("Accuracy:", round(accuracy, 4)))  # Print the accuracy rounded to 4 decimal places
} else {
  print("Predictions not found or test data not properly loaded.")
}






