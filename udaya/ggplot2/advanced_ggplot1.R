install.packages("car")
library(car)
library(tidyverse)

theme_set(theme_classic())

head(Salaries)

Salaries %>% ggplot(aes(x = yrs.since.phd,
                        y = salary,
                        color = rank)) +
  geom_point()

Salaries %>% 
  ggplot(aes(yrs.since.phd, salary)) +
  geom_jitter(aes(color = rank, shape = discipline)) +
  geom_smooth(method = lm) +
  facet_wrap(~sex) +
  labs(title = "Salary vs years since PhD",
  x = "Years sinc PhD",
  y = "Income",
  color = "Position",
  shape = "Research area")

Salaries %>% 
  #filter(salary < 150000) %>% 
  ggplot(aes(x = rank, y = salary, fill = sex)) +
  geom_boxplot(alpha = 0.75) +
  scale_x_discrete(breaks = c("AsstProf", "AssocProf", "Prof"),
                   labels = c("Assistant\n Professor",
                              "Associate\n Professor",
                              "Full-time\n Professor")) +
  scale_y_continuous(breaks = c(50000, 100000, 150000, 200000),
                     labels = c("$50K", "$100K", "$150K", "$200K")) +
  labs(title = "Faculty salary by rank and gender",
       x = "",
       y = "",
       fill = "Gender")
