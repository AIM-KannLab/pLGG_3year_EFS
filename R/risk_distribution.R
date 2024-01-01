library(vioplot)

risk_scores_model <- read.csv('C:/kannlab/R/csv/distrisk_cl_ageresec.csv')
risk_scores_train <- subset(risk_scores_model, Set == "Training")
risk_scores_test <- subset(risk_scores_model, Set == "Test")

# Setting graphical parameters to increase font sizes
par(cex.lab = 1.5,   # Increase size of axis labels
    cex.axis = 1.5,  # Increase size of axis tick labels
    cex.main = 1.5)  # Increase size of main title (if you add one)

# Plot for training data with specific y-axis label
vioplot(risk_scores_train$Risk_Score ~ risk_scores_train$Model, col = "lightblue", plotCentre = "line", side = "left", xlab= "Model", ylab="Risk Scores")

# Add the plot for test data
vioplot(risk_scores_test$Risk_Score ~ risk_scores_test$Model, col = "palevioletred", plotCentre = "line", side = "right", add = TRUE, xlab = "", ylab="")

# Add the legend with increased text size
legend("bottomleft", fill = c("lightblue", "palevioletred"), legend = c("Train", "Test"), title = "Dataset", cex = 1.2)

