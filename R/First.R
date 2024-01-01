library(survival)
library(survminer)
library(gridExtra)

risk1 <- read.csv("C:/kannlab/R/csv/risk1_cl_ageresec_train.csv")
risk1$time_months <- risk1$time / 30.44

# Create a Surv object for both groups
surv_data = Surv(risk1$time_months, risk1$event) 
# Fit survival curves
fit = survfit(surv_data ~ group, data = risk1)

p <- ggsurvplot(
  fit,
  conf.int = TRUE,
  risk.table = TRUE,
  pval = TRUE,
  legend.labs = c("low risk", "high risk"),
  ggtheme = theme_minimal()
)

# Increase font size of labels, titles, and other elements
p$plot <- p$plot + 
  theme(
    axis.title = element_text(size = 14),   # Increase axis title size
    axis.text = element_text(size = 14),    # Increase axis text size
    legend.text = element_text(size = 14),  # Increase legend text size
    plot.title = element_text(size = 16)    # Increase plot title size, if you have one
  )

# Change and increase y-axis and x-axis label size
p$plot <- p$plot + ylab("Recurrence-free survival") + xlab("Time (months)")

# Increase size of annotation text
p$plot <- p$plot + ggplot2::annotate("text", x = 3, y = 0.1, label = "CI = 0.72", hjust = 0.5, vjust = 0.5, size = 5)

p$table <- p$table + theme(
  axis.text.x = element_text(size = 14))
# Print the modified plot
print(p)

low_r <- fit[1]
surv_summary <- summary(fit[2], times = 36, extend = TRUE)
three_year_rfs <- surv_summary$surv[which.min(abs(surv_summary$time - 36))]
print(paste("The 3-year RFS rate is:", three_year_rfs))

##########################################
risk1 <- read.csv("C:/kannlab/R/csv/risk1_cl_ageresec_test.csv")

risk1$time_months <- risk1$time / 30.44

# Create a Surv object for both groups
surv_data = Surv(risk1$time_months, risk1$event) 
# Fit survival curves
fit = survfit(surv_data ~ group, data = risk1)

p <- ggsurvplot(
  fit,
  conf.int = TRUE,
  risk.table = TRUE,
  pval = TRUE,
  legend.labs = c("low risk", "high risk"),
  ggtheme = theme_minimal()
)

# Increase font size of labels, titles, and other elements
p$plot <- p$plot + 
  theme(
    axis.title = element_text(size = 14),   # Increase axis title size
    axis.text = element_text(size = 14),    # Increase axis text size
    legend.text = element_text(size = 14),  # Increase legend text size
    plot.title = element_text(size = 16)    # Increase plot title size, if you have one
  )

# Change and increase y-axis and x-axis label size
p$plot <- p$plot + ylab("Recurrence-free survival") + xlab("Time (months)")

# Increase size of annotation text
p$plot <- p$plot + ggplot2::annotate("text", x = 3, y = 0.1, label = "CI = 0.72", hjust = 0.5, vjust = 0.5, size = 5)

p$table <- p$table + theme(
  axis.text.x = element_text(size = 14))
# Print the modified plot
print(p)

low_r <- fit[1]
surv_summary <- summary(fit[2], times = 36, extend = TRUE)
three_year_rfs <- surv_summary$surv[which.min(abs(surv_summary$time - 36))]
print(paste("The 3-year RFS rate is:", three_year_rfs))
##########################################
risk1 <- read.csv("C:/kannlab/R/risk1_im_train.csv")

risk1$time_months <- risk1$time / 30.44

# Create a Surv object for both groups
surv_data = Surv(risk1$time_months, risk1$event) 
# Fit survival curves
fit = survfit(surv_data ~ group, data = risk1)

p <- ggsurvplot(
  fit,
  conf.int = TRUE,
  risk.table = TRUE,
  pval = TRUE,
  legend.labs = c("low risk", "high risk"),
  ggtheme = theme_minimal()
)

# Increase font size of labels, titles, and other elements
p$plot <- p$plot + 
  theme(
    axis.title = element_text(size = 14),   # Increase axis title size
    axis.text = element_text(size = 14),    # Increase axis text size
    legend.text = element_text(size = 14),  # Increase legend text size
    plot.title = element_text(size = 16)    # Increase plot title size, if you have one
  )

# Change and increase y-axis and x-axis label size
p$plot <- p$plot + ylab("Recurrence-free survival") + xlab("Time (months)")

# Increase size of annotation text
p$plot <- p$plot + ggplot2::annotate("text", x = 3, y = 0.1, label = "CI = 0.93", hjust = 0.5, vjust = 0.5, size = 5)

p$table <- p$table + theme(
  axis.text.x = element_text(size = 14))
# Print the modified plot
print(p)

surv_summary <- summary(fit[2], times = 36, extend = TRUE)
three_year_rfs <- surv_summary$surv[which.min(abs(surv_summary$time - 36))]
print(paste("The 3-year RFS rate is:", three_year_rfs))
#########################################
risk1 <- read.csv("C:/kannlab/R/risk1_im_test.csv")

risk1$time_months <- risk1$time / 30.44

# Create a Surv object for both groups
surv_data = Surv(risk1$time_months, risk1$event) 
# Fit survival curves
fit = survfit(surv_data ~ group, data = risk1)
p <- ggsurvplot(
  fit,
  conf.int = TRUE,
  risk.table = TRUE,
  pval = TRUE,
  legend.labs = c("low risk", "high risk"),
  ggtheme = theme_minimal()
)

# Increase font size of labels, titles, and other elements
p$plot <- p$plot + 
  theme(
    axis.title = element_text(size = 14),   # Increase axis title size
    axis.text = element_text(size = 14),    # Increase axis text size
    legend.text = element_text(size = 14),  # Increase legend text size
    plot.title = element_text(size = 16)    # Increase plot title size, if you have one
  )

# Change and increase y-axis and x-axis label size
p$plot <- p$plot + ylab("Recurrence-free survival") + xlab("Time (months)")

# Increase size of annotation text
p$plot <- p$plot + ggplot2::annotate("text", x = 3, y = 0.1, label = "CI = 0.79", hjust = 0.5, vjust = 0.5, size = 5)

p$table <- p$table + theme(
  axis.text.x = element_text(size = 14))
# Print the modified plot
print(p)

surv_summary <- summary(fit[2], times = 36, extend = TRUE)
three_year_rfs <- surv_summary$surv[which.min(abs(surv_summary$time - 36))]
print(paste("The 3-year RFS rate is:", three_year_rfs))
###########################################
risk1 <- read.csv("C:/kannlab/R/csv/risk1_imcl_ageresec_train.csv")

risk1$time_months <- risk1$time / 30.44

# Create a Surv object for both groups
surv_data = Surv(risk1$time_months, risk1$event) 
# Fit survival curves
fit = survfit(surv_data ~ group, data = risk1)

p <- ggsurvplot(
  fit,
  conf.int = TRUE,
  risk.table = TRUE,
  pval = TRUE,
  legend.labs = c("low risk", "high risk"),
  ggtheme = theme_minimal()
)

# Increase font size of labels, titles, and other elements
p$plot <- p$plot + 
  theme(
    axis.title = element_text(size = 14),   # Increase axis title size
    axis.text = element_text(size = 14),    # Increase axis text size
    legend.text = element_text(size = 14),  # Increase legend text size
    plot.title = element_text(size = 16)    # Increase plot title size, if you have one
  )

# Change and increase y-axis and x-axis label size
p$plot <- p$plot + ylab("Recurrence-free survival") + xlab("Time (months)")

# Increase size of annotation text
p$plot <- p$plot + ggplot2::annotate("text", x = 3, y = 0.1, label = "CI = 0.98", hjust = 0.5, vjust = 0.5, size = 5)

p$table <- p$table + theme(
  axis.text.x = element_text(size = 14))
# Print the modified plot
print(p)

surv_summary <- summary(fit[2], times = 36, extend = TRUE)
three_year_rfs <- surv_summary$surv[which.min(abs(surv_summary$time - 36))]
print(paste("The 3-year RFS rate is:", three_year_rfs))

###########################################
risk1 <- read.csv("C:/kannlab/R/csv/risk1_imcl_ageresec_test.csv")

risk1$time_months <- risk1$time / 30.44

# Create a Surv object for both groups
surv_data = Surv(risk1$time_months, risk1$event) 
# Fit survival curves
fit = survfit(surv_data ~ group, data = risk1)

p <- ggsurvplot(
  fit,
  conf.int = TRUE,
  risk.table = TRUE,
  pval = TRUE,
  legend.labs = c("low risk", "high risk"),
  ggtheme = theme_minimal()
)

# Increase font size of labels, titles, and other elements
p$plot <- p$plot + 
  theme(
    axis.title = element_text(size = 14),   # Increase axis title size
    axis.text = element_text(size = 14),    # Increase axis text size
    legend.text = element_text(size = 14),  # Increase legend text size
    plot.title = element_text(size = 16)    # Increase plot title size, if you have one
  )

# Change and increase y-axis and x-axis label size
p$plot <- p$plot + ylab("Recurrence-free survival") + xlab("Time (months)")

# Increase size of annotation text
p$plot <- p$plot + ggplot2::annotate("text", x = 3, y = 0.1, label = "CI = 0.85", hjust = 0.5, vjust = 0.5, size = 5)

p$table <- p$table + theme(
  axis.text.x = element_text(size = 14))
# Print the modified plot
print(p)

surv_summary <- summary(fit[1], times = 36, extend = TRUE)
three_year_rfs <- surv_summary$surv[which.min(abs(surv_summary$time - 36))]
print(paste("The 3-year RFS rate is:", three_year_rfs))

############################################
risk1 <- read.csv("C:/kannlab/R/risk1_scratch_test.csv")

risk1$time_months <- risk1$time / 30.44

# Create a Surv object for both groups
surv_data = Surv(risk1$time_months, risk1$event) 
# Fit survival curves
fit = survfit(surv_data ~ group, data = risk1)

p <- ggsurvplot(
  fit,
  conf.int = TRUE,
  risk.table = FALSE,
  pval = TRUE,
  legend.labs = c("low risk", "high risk"),
  ggtheme = theme_minimal()
)

# Increase font size of labels, titles, and other elements
p$plot <- p$plot + 
  theme(
    axis.title = element_text(size = 14),   # Increase axis title size
    axis.text = element_text(size = 14),    # Increase axis text size
    legend.text = element_text(size = 14),  # Increase legend text size
    plot.title = element_text(size = 16)    # Increase plot title size, if you have one
  )

# Change and increase y-axis and x-axis label size
p$plot <- p$plot + ylab("Recurrence-free survival") + xlab("Time (months)")

# Increase size of annotation text
p$plot <- p$plot + ggplot2::annotate("text", x = 2.8, y = 0.1, label = "CI = 0.64", hjust = 0.5, vjust = 0.5, size = 5)

p$table <- p$table + theme(
  axis.text.x = element_text(size = 14))
# Print the modified plot
print(p)

surv_summary <- summary(fit[1], times = 36, extend = TRUE)
three_year_rfs <- surv_summary$surv[which.min(abs(surv_summary$time - 36))]
print(paste("The 3-year RFS rate is:", three_year_rfs))
###########################################

# Plot
ggsurvplot(fit, conf.int = TRUE,
           risk.table = TRUE, 
           pval = TRUE,
           # size of title, axis labels, and tick labels
           #fontsize = c(3, 2, 1), 
           legend.labs = c("Low Risk", "High Risk"),
           ggtheme = theme_minimal())
grid.arrange(p1$plot + theme(legend.position="none"), 
             p2$plot + annotate("text", x = max(risk2$time_risk_2) - 100, y = 0.2, label = "Risk Group 2", color="red"),
             ncol = 1)
