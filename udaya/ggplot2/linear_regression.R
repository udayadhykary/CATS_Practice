library(tidyverse)
library(modelr)
sim1

ggplot(sim1, aes(x = x, y = y)) +
  geom_point()

#estimated regression line
ggplot(sim1) +
  geom_point(aes(x, y)) +
  geom_abline(intercept = 4, slope = 2.1)

#regression line using m and c from R
sim1_model <- lm(y ~ x, data = sim1)

sim1_model

#actual regression vs estimated regression
ggplot(sim1) +
  geom_point(aes(x, y)) +
  geom_abline(intercept = 4, slope = 2.1) +
  geom_abline(intercept = 4.221, slope = 2.052, color = "red")

#checking residuals
sim1_w_pred_resids <- sim1 %>%
  add_predictions(sim1_model) %>%
  add_residuals(sim1_model)

sim1_w_pred_resids

#distribution of residuals by plotting histograms
ggplot(sim1_w_pred_resids) +
  geom_histogram(aes(resid), binwidth = 0.3)
