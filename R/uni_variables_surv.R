library(survival)
library(rms)

data_bch <- read.csv("C:/kannlab/R/braf_combined_labeled.csv")

data_bch$time_event <- data_bch$time_event / 30.44

braf_bch <- data.frame(
  braf = data_bch$braf,
  time_event = data_bch$time_event,
  event = data_bch$event
)

braf_bch$braf <- ifelse(braf_bch$braf == 0, "V600E",
                        ifelse(braf_bch$braf == 1, "Fusion",
                               ifelse(braf_bch$braf == 2, "Wild", "unknown")))

braf_bch$braf <- factor(braf_bch$braf, levels = c("V600E", "Fusion", "Wild"))

phmodel <- cph(Surv(time_event, event) ~ braf , 
               data=braf_bch)

survdiff(Surv(time_event, event) ~ braf, data = braf_bch)

km_fit <- survfit(Surv(time_event, event) ~ braf, data = braf_bch)

# Plot the Kaplan-Meier curves
plot(km_fit, col = c("brown2", "seagreen", "royalblue"), lty = 1, lwd = 2, xlab = "Time (months)", ylab = "Recurrence-free survival")
legend("topright", legend = levels(braf_bch$braf), col = c("brown2", "seagreen", "royalblue"), lty = 1, lwd = 2)

##################################################################################

data_bch <- read.csv("C:/kannlab/R/braf_combined_total.csv")

data_bch$time_event <- data_bch$time_event / 30.44

braf_bch <- data.frame(
  braf = data_bch$braf,
  time_event = data_bch$time_event,
  event = data_bch$event
)

braf_bch$braf <- ifelse(braf_bch$braf == 0, "V600E",
                        ifelse(braf_bch$braf == 1, "Fusion",
                               ifelse(braf_bch$braf == 2, "Wild", "unknown")))


braf_bch$braf <- factor(braf_bch$braf, levels = c("V600E", "Fusion", "Wild"))

phmodel <- cph(Surv(time_event, event) ~ braf , 
               data=braf_bch)

survdiff(Surv(time_event, event) ~ braf, data = braf_bch)

km_fit <- survfit(Surv(time_event, event) ~ braf, data = braf_bch)

# Plot the Kaplan-Meier curves
plot(km_fit, col = c("brown2", "seagreen", "royalblue"), lty = 1, lwd = 2, xlab = "Time (months)", ylab = "Recurrence-free survival")
legend("topright", legend = levels(braf_bch$braf), col = c("brown2", "seagreen", "royalblue"), lty = 1, lwd = 2)
