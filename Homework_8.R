install.packages(c(
  "ggplot2",
  "dplyr",
  "scales",
  "RColorBrewer",
  "ggrepel",
  "ggalt"
))

library(ggplot2)
library(dplyr)
library(scales)
library(RColorBrewer)
library(ggrepel)
library(ggalt)

theme_set(
  theme_minimal() +
    theme(
      plot.title = element_text(face = "bold"),
      axis.title = element_text(face = "bold"),
      legend.position = "top",
      panel.grid.minor = element_blank()
    )
)

ggplot(mpg, aes(cty, hwy)) +
  geom_jitter(width = 0.35, alpha = 0.35) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(
    title = "City vs highway fuel efficiency",
    x = "Fuel efficiency in city driving (mpg)",
    y = "Fuel efficiency on highway (mpg)"
  )

ggplot(mpg, aes(cty, hwy)) +
  geom_count(aes(color = after_stat(n)), alpha = 0.7) +
  scale_color_gradientn(colours = brewer.pal(9, "YlOrRd")) +
  geom_smooth(method = "loess", se = FALSE) +
  labs(
    title = "Density of observations and nonlinear trend",
    x = "Fuel efficiency in city driving (mpg)",
    y = "Fuel efficiency on highway (mpg)",
    color = "Number of\nobservations"
  )

mpg_lab <- mpg %>%
  group_by(manufacturer, model) %>%
  summarise(cty = mean(cty), hwy = mean(hwy), .groups = "drop") %>%
  arrange(desc(hwy)) %>%
  slice(1:10)

ggplot(mpg, aes(cty, hwy)) +
  geom_point(alpha = 0.25) +
  geom_smooth(method = "loess", se = FALSE) +
  geom_text_repel(
    data = mpg_lab,
    aes(label = paste(manufacturer, model)),
    size = 3
  ) +
  labs(
    title = "Top vehicles by highway fuel efficiency",
    x = "Average city fuel efficiency (mpg)",
    y = "Average highway fuel efficiency (mpg)"
  )

sel <- diamonds %>% filter(carat > 2.5, price > 15000)

ggplot(diamonds, aes(carat, price)) +
  geom_point(alpha = 0.15) +
  geom_smooth(method = "loess", se = FALSE) +
  geom_encircle(
    data = sel,
    aes(x = carat, y = price),
    color = "red",
    expand = 0.08,
    size = 1.2
  ) +
  scale_y_continuous(labels = dollar) +
  labs(
    title = "High-value diamonds",
    x = "Carat weight",
    y = "Price (USD)"
  )

set.seed(123)
d_small <- diamonds %>% sample_n(4000)

ggplot(d_small, aes(carat, price)) +
  geom_point(alpha = 0.25) +
  geom_smooth(method = "lm", se = FALSE, linetype = 2) +
  geom_smooth(method = "loess", se = FALSE) +
  scale_y_continuous(labels = dollar) +
  labs(
    title = "Linear vs nonlinear price trend",
    x = "Carat weight",
    y = "Price (USD)"
  )

ggplot(economics, aes(date, unemploy)) +
  geom_line() +
  geom_smooth(method = "loess", se = FALSE) +
  scale_y_continuous(labels = comma) +
  scale_x_date(date_breaks = "5 years", date_labels = "%Y") +
  labs(
    title = "Unemployment over time",
    x = "Year",
    y = "Number of unemployed (thousands)"
  )

