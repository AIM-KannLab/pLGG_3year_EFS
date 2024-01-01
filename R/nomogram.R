library(survival)
library(rms)

data_bch <- read.csv("C:/kannlab/R/nomog_cbtn.csv")
data_bch$gender <- factor(data_bch$gender, levels = c("Male", "Female"))
data_bch$resection <- factor(data_bch$resection, levels = c("biopsy", "partial", "gross_total"))


phmodel <- cph(Surv(event_time, event) ~ age + resection+DLModel_Image , 
               data=data_bch)

var_labels <- c("age" = "age (days)", 
                "gender" = "gender",
                "resection" = "resection",
                "DLModel_Image" = "survival model")

dd = datadist(data_bch)
options(datadist='dd')
nom <- nomogram(phmodel, fun = function(x) 1- plogis(x),
              funlabel='3 year survival rate' )

# nom$labels <- var_labels
plot(nom)
