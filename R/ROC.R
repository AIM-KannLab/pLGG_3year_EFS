# Load required libraries
library(ggplot2)

#CBTN
# Read data from CSV files
data_bch_cl <- read.csv('C:/kannlab/R/csv/roc_cbtn_cl.csv')
data_bch_im <- read.csv('C:/kannlab/R/csv/roc_cbtn_im.csv')
data_bch_imcl <- read.csv('C:/kannlab/R/csv/roc_cbtn_imcl.csv')

# Extract columns from the data
fpr_bch_cl <- as.numeric(data_bch_cl$fpr_cbtn_cl[-1])
tpr_bch_cl <- as.numeric(data_bch_cl$tpr_cbtn_cl[-1])
auc_bch_cl <- as.numeric(data_bch_cl$auc_cbtn_cl[1])

fpr_bch_im <- as.numeric(data_bch_im$fpr_cbtn_im[-1])
tpr_bch_im <- as.numeric(data_bch_im$tpr_cbtn_im[-1])
auc_bch_im <- as.numeric(data_bch_im$auc_cbtn_im[1])

fpr_bch_imcl <- as.numeric(data_bch_imcl$fpr_cbtn_imcl[-1])
tpr_bch_imcl <- as.numeric(data_bch_imcl$tpr_cbtn_imcl[-1])
auc_bch_imcl <- as.numeric(data_bch_imcl$auc_cbtn_imcl[1])

auc_bch_cl <- sprintf("%.2f", auc_bch_cl)
auc_bch_im <- sprintf("%.2f", auc_bch_im)
auc_bch_imcl <- sprintf("%.2f", auc_bch_imcl)



# Create a data frame for plotting
df <- data.frame(
  FPR = c(fpr_bch_cl, fpr_bch_im, fpr_bch_imcl),
  TPR = c(tpr_bch_cl, tpr_bch_im, tpr_bch_imcl),
  Model = c(rep("Clinical", length(fpr_bch_cl)), rep("Image", length(fpr_bch_im)), rep("Image plus clinical", length(fpr_bch_imcl)))
)


# Create the ROC curve plot
roc_plot <- ggplot(df, aes(x = FPR, y = TPR, color = Model)) +
  geom_abline(intercept = 0, slope = 1, linetype = "dashed") +
  #geom_smooth(method = "loess", se = FALSE, level = 0.70) +  # Add smoothing
  geom_line(size = 1.5)+
  labs(
    x = "False Positive Rate",
    y = "True Positive Rate",
    color = "Model"
  ) +
  theme_minimal() +
  scale_color_manual(
    values = c("Clinical" = "violetred", "Image" = "deepskyblue3", "Image plus clinical" = "yellowgreen"),
    labels = c(

      "Clinical" = paste("Clinical, AUC =", auc_bch_cl),
      "Image" = paste("Image, AUC =", auc_bch_im),
      "Image plus clinical" = paste("Image+clinical, AUC =", auc_bch_imcl)
    )
  ) +
  theme(legend.position = "bottom")

roc_plot <- roc_plot +
  theme(
    axis.title.x = element_text(size = 14),  # Increase X-axis title size
    axis.title.y = element_text(size = 14),  # Increase Y-axis title size
    axis.text.x = element_text(size = 14),   # Increase X-axis text size
    axis.text.y = element_text(size = 14),   # Increase Y-axis text size
    legend.title = element_text(size = 14),  # Increase Legend title size
    legend.text = element_text(size = 14)    # Increase Legend text size
  )

# Print the final plot
print(roc_plot)

##################################################################################
#BCH

data_bch_cl <- read.csv('C:/kannlab/R/csv/roc_bch_cl.csv')
data_bch_im <- read.csv('C:/kannlab/R/csv/roc_bch_im.csv')
data_bch_imcl <- read.csv('C:/kannlab/R/csv/roc_bch_imcl.csv')

# Extract columns from the data
fpr_bch_cl <- as.numeric(data_bch_cl$fpr_bch_cl[-1])
tpr_bch_cl <- as.numeric(data_bch_cl$tpr_bch_cl[-1])
auc_bch_cl <- as.numeric(data_bch_cl$auc_bch_cl[1])

fpr_bch_im <- as.numeric(data_bch_im$fpr_bch_im[-1])
tpr_bch_im <- as.numeric(data_bch_im$tpr_bch_im[-1])
auc_bch_im <- as.numeric(data_bch_im$auc_bch_im[1])

fpr_bch_imcl <- as.numeric(data_bch_imcl$fpr_bch_imcl[-1])
tpr_bch_imcl <- as.numeric(data_bch_imcl$tpr_bch_imcl[-1])
auc_bch_imcl <- as.numeric(data_bch_imcl$auc_bch_imcl[1])

auc_bch_cl <- sprintf("%.2f", auc_bch_cl)
auc_bch_im <- sprintf("%.2f", auc_bch_im)
auc_bch_imcl <- sprintf("%.2f", auc_bch_imcl)



# Create a data frame for plotting
df <- data.frame(
  FPR = c(fpr_bch_cl, fpr_bch_im, fpr_bch_imcl),
  TPR = c(tpr_bch_cl, tpr_bch_im, tpr_bch_imcl),
  Model = c(rep("Clinical", length(fpr_bch_cl)), rep("Image", length(fpr_bch_im)), rep("Image plus clinical", length(fpr_bch_imcl)))
)


# Create the ROC curve plot
roc_plot <- ggplot(df, aes(x = FPR, y = TPR, color = Model)) +
  geom_abline(intercept = 0, slope = 1, linetype = "dashed") +
  #geom_smooth(method = "loess", se = FALSE, level = 0.70) +  # Add smoothing
  geom_line(size = 1.5)+
  labs(
    x = "False Positive Rate",
    y = "True Positive Rate",
    color = "Model"
  ) +
  theme_minimal() +
  scale_color_manual(
    values = c("Clinical" = "violetred", "Image" = "deepskyblue3", "Image plus clinical" = "yellowgreen"),
    labels = c(
      
      "Clinical" = paste("Clinical, AUC =", auc_bch_cl),
      "Image" = paste("Image, AUC =", auc_bch_im),
      "Image plus clinical" = paste("Image+clinical, AUC =", auc_bch_imcl)
    )
  ) +
  theme(legend.position = "bottom")
roc_plot <- roc_plot +
  theme(
    axis.title.x = element_text(size = 14),  # Increase X-axis title size
    axis.title.y = element_text(size = 14),  # Increase Y-axis title size
    axis.text.x = element_text(size = 14),   # Increase X-axis text size
    axis.text.y = element_text(size = 14),   # Increase Y-axis text size
    legend.title = element_text(size = 14),  # Increase Legend title size
    legend.text = element_text(size = 14)    # Increase Legend text size
  )
# Print the final plot
print(roc_plot)

###################################################################################
data_bch_cl <- read.csv('C:/kannlab/R/csv/roc_total_cl.csv')
data_bch_im <- read.csv('C:/kannlab/R/csv/roc_total_im.csv')
data_bch_imcl <- read.csv('C:/kannlab/R/csv/roc_total_imcl.csv')

# Extract columns from the data
fpr_bch_cl <- as.numeric(data_bch_cl$fpr_t_cl[-1])
tpr_bch_cl <- as.numeric(data_bch_cl$tpr_t_cl[-1])
auc_bch_cl <- as.numeric(data_bch_cl$auc_t_cl[1])

fpr_bch_im <- as.numeric(data_bch_im$fpr_t_im[-1])
tpr_bch_im <- as.numeric(data_bch_im$tpr_t_im[-1])
auc_bch_im <- as.numeric(data_bch_im$auc_t_im[1])

fpr_bch_imcl <- as.numeric(data_bch_imcl$fpr_t_imcl[-1])
tpr_bch_imcl <- as.numeric(data_bch_imcl$tpr_t_imcl[-1])
auc_bch_imcl <- as.numeric(data_bch_imcl$auc_t_imcl[1])

auc_bch_cl <- sprintf("%.2f", auc_bch_cl)
auc_bch_im <- sprintf("%.2f", auc_bch_im)
auc_bch_imcl <- sprintf("%.2f", auc_bch_imcl)



# Create a data frame for plotting
df <- data.frame(
  FPR = c(fpr_bch_cl, fpr_bch_im, fpr_bch_imcl),
  TPR = c(tpr_bch_cl, tpr_bch_im, tpr_bch_imcl),
  Model = c(rep("Clinical", length(fpr_bch_cl)), rep("Image", length(fpr_bch_im)), rep("Image plus clinical", length(fpr_bch_imcl)))
)


# Create the ROC curve plot
roc_plot <- ggplot(df, aes(x = FPR, y = TPR, color = Model)) +
  geom_abline(intercept = 0, slope = 1, linetype = "dashed") +
  #geom_smooth(method = "loess", se = FALSE, level = 0.70) +  # Add smoothing
  geom_line(size = 1.5)+
  labs(
    x = "False Positive Rate",
    y = "True Positive Rate",
    color = "Model"
  ) +
  theme_minimal() +
  scale_color_manual(
    values = c("Clinical" = "violetred", "Image" = "deepskyblue3", "Image plus clinical" = "yellowgreen"),
    labels = c(
      
      "Clinical" = paste("Clinical, AUC =", auc_bch_cl),
      "Image" = paste("Image, AUC =", auc_bch_im),
      "Image plus clinical" = paste("Image+clinical, AUC =", auc_bch_imcl)
    )
  ) +
  theme(legend.position = "bottom")
roc_plot <- roc_plot +
  theme(
    axis.title.x = element_text(size = 14),  # Increase X-axis title size
    axis.title.y = element_text(size = 14),  # Increase Y-axis title size
    axis.text.x = element_text(size = 14),   # Increase X-axis text size
    axis.text.y = element_text(size = 14),   # Increase Y-axis text size
    legend.title = element_text(size = 14),  # Increase Legend title size
    legend.text = element_text(size = 14)    # Increase Legend text size
  )
# Print the final plot
print(roc_plot)
################################################################################
# Load required libraries
library(ggplot2)

#CBTN
# Read data from CSV files
data_bch_scratch <- read.csv('C:/kannlab/R/roc_bch_scratch.csv')
data_cbtn_scratch <- read.csv('C:/kannlab/R/roc_cbtn_scratch.csv')
data_total_scratch <- read.csv('C:/kannlab/R/roc_total_scratch.csv')

# Extract columns from the data
fpr_bch <- as.numeric(data_bch_scratch$fpr[-1])
tpr_bch <- as.numeric(data_bch_scratch$tpr[-1])
auc_bch <- as.numeric(data_bch_scratch$auc[1])

fpr_cbtn <- as.numeric(data_cbtn_scratch$fpr[-1])
tpr_cbtn <- as.numeric(data_cbtn_scratch$tpr[-1])
auc_cbtn <- as.numeric(data_cbtn_scratch$auc[1])

fpr_T <- as.numeric(data_total_scratch$fpr[-1])
tpr_T <- as.numeric(data_total_scratch$tpr[-1])
auc_T <- as.numeric(data_total_scratch$auc[1])

auc_bch <- sprintf("%.2f", auc_bch)
auc_cbtn <- sprintf("%.2f", auc_cbtn)
auc_T <- sprintf("%.2f", auc_T)



# Create a data frame for plotting
df <- data.frame(
  FPR = c(fpr_bch, fpr_cbtn, fpr_T),
  TPR = c(tpr_bch, tpr_cbtn, tpr_T),
  Model = c(rep("BCH", length(fpr_bch)), rep("CBTN", length(fpr_cbtn)), rep("Total", length(fpr_T)))
)


# Create the ROC curve plot
roc_plot <- ggplot(df, aes(x = FPR, y = TPR, color = Model)) +
  geom_abline(intercept = 0, slope = 1, linetype = "dashed") +
  #geom_smooth(method = "loess", se = FALSE, level = 0.70) +  # Add smoothing
  geom_line(size = 1.5)+
  labs(
    x = "False Positive Rate",
    y = "True Positive Rate",
    color = "Data"
  ) +
  theme_minimal() +
  scale_color_manual(
    values = c("BCH" = "darkgray", "CBTN" = "aquamarine", "Total" = "darkorchid"),
    labels = c(
      
      "BCH" = paste("BCH, AUC =", auc_bch),
      "CBTN" = paste("CBTN, AUC =", auc_cbtn),
      "Total" = paste("Total, AUC =", auc_T)
    )
  ) +
  theme(legend.position = "bottom")

roc_plot <- roc_plot +
  theme(
    axis.title.x = element_text(size = 14),  # Increase X-axis title size
    axis.title.y = element_text(size = 14),  # Increase Y-axis title size
    axis.text.x = element_text(size = 14),   # Increase X-axis text size
    axis.text.y = element_text(size = 14),   # Increase Y-axis text size
    legend.title = element_text(size = 14),  # Increase Legend title size
    legend.text = element_text(size = 14)    # Increase Legend text size
  )

# Print the final plot
print(roc_plot)
################################################################################
library(ggplot2)

#CBTN
# Read data from CSV files
data_bch_scratch <- read.csv('C:/kannlab/R/roc_braf_bch.csv')
data_cbtn_scratch <- read.csv('C:/kannlab/R/roc_braf_cbtn.csv')
data_total_scratch <- read.csv('C:/kannlab/R/roc_braf_total.csv')

# Extract columns from the data
fpr_bch <- as.numeric(data_bch_scratch$fpr[-1])
tpr_bch <- as.numeric(data_bch_scratch$tpr[-1])
auc_bch <- as.numeric(data_bch_scratch$auc[1])

fpr_cbtn <- as.numeric(data_cbtn_scratch$fpr[-1])
tpr_cbtn <- as.numeric(data_cbtn_scratch$tpr[-1])
auc_cbtn <- as.numeric(data_cbtn_scratch$auc[1])

fpr_T <- as.numeric(data_total_scratch$fpr[-1])
tpr_T <- as.numeric(data_total_scratch$tpr[-1])
auc_T <- as.numeric(data_total_scratch$auc[1])

auc_bch <- sprintf("%.2f", auc_bch)
auc_cbtn <- sprintf("%.2f", auc_cbtn)
auc_T <- sprintf("%.2f", auc_T)



# Create a data frame for plotting
df <- data.frame(
  FPR = c(fpr_bch, fpr_cbtn, fpr_T),
  TPR = c(tpr_bch, tpr_cbtn, tpr_T),
  Model = c(rep("BCH", length(fpr_bch)), rep("CBTN", length(fpr_cbtn)), rep("Total", length(fpr_T)))
)


# Create the ROC curve plot
roc_plot <- ggplot(df, aes(x = FPR, y = TPR, color = Model)) +
  geom_abline(intercept = 0, slope = 1, linetype = "dashed") +
  #geom_smooth(method = "loess", se = FALSE, level = 0.70) +  # Add smoothing
  geom_line(size = 1.5)+
  labs(
    x = "False Positive Rate",
    y = "True Positive Rate",
    color = "Data"
  ) +
  theme_minimal() +
  scale_color_manual(
    values = c("BCH" = "darkgray", "CBTN" = "aquamarine", "Total" = "darkorchid"),
    labels = c(
      
      "BCH" = paste("BCH, AUC =", auc_bch),
      "CBTN" = paste("CBTN, AUC =", auc_cbtn),
      "Total" = paste("Total, AUC =", auc_T)
    )
  ) +
  theme(legend.position = "bottom")

roc_plot <- roc_plot +
  theme(
    axis.title.x = element_text(size = 14),  # Increase X-axis title size
    axis.title.y = element_text(size = 14),  # Increase Y-axis title size
    axis.text.x = element_text(size = 14),   # Increase X-axis text size
    axis.text.y = element_text(size = 14),   # Increase Y-axis text size
    legend.title = element_text(size = 14),  # Increase Legend title size
    legend.text = element_text(size = 14)    # Increase Legend text size
  )

# Print the final plot
print(roc_plot)