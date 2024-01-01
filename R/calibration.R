library(ggplot2)

# Read data from CSV files

cal_cl_bch <- read.csv('C:/kannlab/R/csv/calib_cl_bch.csv')
cal_im_bch <- read.csv('C:/kannlab/R/csv/calib_im_bch.csv')
cal_imcl_bch <- read.csv('C:/kannlab/R/csv/calib_imcl_bch.csv')

# Calculate and format ECE values
ece_bch_cl <- unique(cal_cl_bch$ece)
ece_bch_cl <- formatC(ece_bch_cl, format = "f", digits = 2)

ece_im_bch <- unique(cal_im_bch$ece)
ece_im_bch <- formatC(ece_im_bch, format = "f", digits = 2)

ece_imcl_bch <- unique(cal_imcl_bch$ece)
ece_imcl_bch <- formatC(ece_imcl_bch, format = "f", digits = 2)

cal_cl_bch$Model <- 'Clinical'
cal_im_bch$Model <- 'Image'
cal_imcl_bch$Model <- 'Image + Clinical'


p <- ggplot() +
  geom_point(size =2.5, data = cal_cl_bch, aes(x = predicted, y = 1-observed, color = Model)) +
  geom_line(size =1, data = cal_cl_bch, aes(x = predicted, y = 1-observed, color = Model )) +
  geom_point(size =2.5, data = cal_im_bch, aes(x = predicted, y = 1-observed, color = Model)) +
  geom_line(size =1, data = cal_im_bch, aes(x = predicted, y = 1-observed, color = Model)) +
  geom_point(size =2.5, data = cal_imcl_bch, aes(x = predicted, y = 1-observed, color = Model)) +
  geom_line(size =1, data = cal_imcl_bch, aes(x = predicted, y = 1-observed, color = Model)) +
  geom_abline(intercept = 0, slope = 1, linetype = "dashed") +
  # geom_smooth(data = cal_cl_bch, aes(x = predicted, y = observed, color = Model), method = "loess", span = 0.3, se = FALSE) +
  # geom_smooth(data = cal_im_bch, aes(x = predicted, y = observed, color = Model), method = "loess",  span = 0.3, se = FALSE) +
  # geom_smooth(data = cal_imcl_bch, aes(x = predicted, y = observed, color = Model), method = "loess",  span = 0.3, se = FALSE) +
  labs(x = "Predicted survival probability", y = "Observed Non-Recurrence Frequency",
       color = "Model") +
  theme_minimal() +
  scale_y_continuous(limits = c(0, 1)) +
  scale_x_continuous(limits = c(0, 1)) +
  scale_color_manual(
    values = c("Clinical" = "violetred", "Image" = "deepskyblue3", "Image + Clinical" = "yellowgreen"),
    labels = c(
      
      "Clinical" = paste("Clinical, ECE =", ece_bch_cl),
      "Image" = paste("Image, ECE =", ece_im_bch),
      "Image + Clinical" = paste("Image+clinical, ECE =", ece_imcl_bch)
    )
  ) +
  theme(legend.position = "bottom")

p <- p + theme(
  axis.title = element_text(size = 14),   # Increase axis title size
  axis.text = element_text(size = 14),    # Increase axis text size
  legend.title = element_text(size = 14), # Increase legend title size
  legend.text = element_text(size = 14)   # Increase legend text size
)

# Print the final plot with increased font sizes
print(p)
##############################################

cal_cl_cbtn <- read.csv('C:/kannlab/R/csv/calib_cl_cbtn.csv')
cal_im_cbtn <- read.csv('C:/kannlab/R/csv/calib_im_cbtn.csv')
cal_imcl_cbtn <- read.csv('C:/kannlab/R/csv/calib_imcl_cbtn.csv')

# Calculate and format ECE values
ece_cbtn_cl <- unique(cal_cl_cbtn$ece)
ece_cbtn_cl <- formatC(ece_cbtn_cl, format = "f", digits = 2)

ece_im_cbtn <- unique(cal_im_cbtn$ece)
ece_im_cbtn <- formatC(ece_im_cbtn, format = "f", digits = 2)

ece_imcl_cbtn <- unique(cal_imcl_cbtn$ece)
ece_imcl_cbtn <- formatC(ece_imcl_cbtn, format = "f", digits = 2)

cal_cl_cbtn$Model <- 'Clinical'
cal_im_cbtn$Model <- 'Image'
cal_imcl_cbtn$Model <- 'Image + Clinical'


p <- ggplot() +
  geom_point(size =2.5, data = cal_cl_cbtn, aes(x = predicted, y = 1-observed, color = Model)) +
  geom_line(size =1, data = cal_cl_cbtn, aes(x = predicted, y = 1-observed, color = Model )) +
  geom_point(size =2.5, data = cal_im_cbtn, aes(x = predicted, y = 1-observed, color = Model)) +
  geom_line(size =1, data = cal_im_cbtn, aes(x = predicted, y = 1-observed, color = Model)) +
  geom_point(size =2.5, data = cal_imcl_cbtn, aes(x = predicted, y = 1-observed, color = Model)) +
  geom_line(size =1, data = cal_imcl_cbtn, aes(x = predicted, y = 1-observed, color = Model)) +
  geom_abline(intercept = 0, slope = 1, linetype = "dashed") +
  # geom_smooth(data = cal_cl_cbtn, aes(x = predicted, y = observed, color = Model), method = "loess", span = 0.2, se = FALSE) +
  # geom_smooth(data = cal_im_cbtn, aes(x = predicted, y = observed, color = Model), method = "loess",  span = 0.3, se = FALSE) +
  # geom_smooth(data = cal_imcl_cbtn, aes(x = predicted, y = observed, color = Model), method = "loess",  span = 0.3, se = FALSE) +
  labs(x = "Predicted survival probability", y = "Observed Non-Recurrence Frequency",
       color = "Model") +
  theme_minimal() +
  scale_y_continuous(limits = c(0, 1)) +
  scale_x_continuous(limits = c(0, 1)) +
  scale_color_manual(
    values = c("Clinical" = "violetred", "Image" = "deepskyblue3", "Image + Clinical" = "yellowgreen"),
    labels = c(
      
      "Clinical" = paste("Clinical, ECE =", ece_cbtn_cl),
      "Image" = paste("Image, ECE =", ece_im_cbtn),
      "Image + Clinical" = paste("Image+clinical, ECE =", ece_imcl_cbtn)
    )
  ) +
  theme(legend.position = "bottom")


p <- p + theme(
  axis.title = element_text(size = 14),   # Increase axis title size
  axis.text = element_text(size = 14),    # Increase axis text size
  legend.title = element_text(size = 14), # Increase legend title size
  legend.text = element_text(size = 14)   # Increase legend text size
)

# Print the final plot with increased font sizes
print(p)

##############################################################################
cal_cl_cbtn <- read.csv('C:/kannlab/R/csv/calib_cl_total.csv')
cal_im_cbtn <- read.csv('C:/kannlab/R/csv/calib_im_total.csv')
cal_imcl_cbtn <- read.csv('C:/kannlab/R/csv/calib_imcl_total.csv')

# Calculate and format ECE values
ece_cbtn_cl <- unique(cal_cl_cbtn$ece)
ece_cbtn_cl <- formatC(ece_cbtn_cl, format = "f", digits = 2)

ece_im_cbtn <- unique(cal_im_cbtn$ece)
ece_im_cbtn <- formatC(ece_im_cbtn, format = "f", digits = 2)

ece_imcl_cbtn <- unique(cal_imcl_cbtn$ece)
ece_imcl_cbtn <- formatC(ece_imcl_cbtn, format = "f", digits = 2)

cal_cl_cbtn$Model <- 'Clinical'
cal_im_cbtn$Model <- 'Image'
cal_imcl_cbtn$Model <- 'Image + Clinical'


p <- ggplot() +
  geom_point(size =2.5, data = cal_cl_cbtn, aes(x = predicted, y = 1-observed, color = Model)) +
  geom_line(size =1, data = cal_cl_cbtn, aes(x = predicted, y = 1-observed, color = Model )) +
  geom_point(size =2.5, data = cal_im_cbtn, aes(x = predicted, y = 1-observed, color = Model)) +
  geom_line(size =1, data = cal_im_cbtn, aes(x = predicted, y = 1-observed, color = Model)) +
  geom_point(size =2.5, data = cal_imcl_cbtn, aes(x = predicted, y = 1-observed, color = Model)) +
  geom_line(size =1, data = cal_imcl_cbtn, aes(x = predicted, y = 1-observed, color = Model)) +
  geom_abline(intercept = 0, slope = 1, linetype = "dashed") +
  # geom_smooth(data = cal_cl_cbtn, aes(x = predicted, y = observed, color = Model), method = "loess", span = 0.2, se = FALSE) +
  # geom_smooth(data = cal_im_cbtn, aes(x = predicted, y = observed, color = Model), method = "loess",  span = 0.3, se = FALSE) +
  # geom_smooth(data = cal_imcl_cbtn, aes(x = predicted, y = observed, color = Model), method = "loess",  span = 0.3, se = FALSE) +
  labs(x = "Predicted survival probability", y = "Observed Non-Recurrence Frequency",
       color = "Model") +
  theme_minimal() +
  scale_y_continuous(limits = c(0, 1)) +
  scale_x_continuous(limits = c(0, 1)) +
  scale_color_manual(
    values = c("Clinical" = "violetred", "Image" = "deepskyblue3", "Image + Clinical" = "yellowgreen"),
    labels = c(
      
      "Clinical" = paste("Clinical, ECE =", ece_cbtn_cl),
      "Image" = paste("Image, ECE =", ece_im_cbtn),
      "Image + Clinical" = paste("Image+clinical, ECE =", ece_imcl_cbtn)
    )
  ) +
  theme(legend.position = "bottom")
  

p <- p + theme(
  axis.title = element_text(size = 14),   # Increase axis title size
  axis.text = element_text(size = 14),    # Increase axis text size
  legend.title = element_text(size = 14), # Increase legend title size
  legend.text = element_text(size = 14)   # Increase legend text size
)

# Print the final plot with increased font sizes
print(p)