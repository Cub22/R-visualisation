install.packages(c("ggplot2","dplyr","scales"))
library(ggplot2)
library(dplyr)
library(scales)

data(economics)

hw_theme <- theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", size = 15),
    plot.subtitle = element_text(size = 11),
    axis.title = element_text(face = "bold"),
    legend.position = "top",
    panel.grid.minor = element_blank()
  )

# 1) Line plot: unemployment (unemploy)
ggplot(economics, aes(x = date, y = unemploy)) +
  geom_line(color = "steelblue", size = 1.2) +
  labs(
    title = "Unemployment in the US",
    subtitle = "Monthly series from the economics dataset",
    x = "Year",
    y = "Unemployed (thousands)"
  ) +
  scale_y_continuous(labels = comma) +
  scale_x_date(date_breaks = "4 years", date_labels = "%Y") +
  hw_theme

# 2) Line plot: personal savings rate (psavert)
ggplot(economics, aes(x = date, y = psavert)) +
  geom_line(color = "darkgreen", linetype = "longdash", size = 1.2) +
  labs(
    title = "Personal savings rate in the US",
    subtitle = "Percent values formatted as % on the y-axis",
    x = "Year",
    y = "Savings rate (%)"
  ) +
  scale_y_continuous(labels = percent_format(scale = 1)) +
  scale_x_date(date_breaks = "4 years", date_labels = "%Y") +
  hw_theme

# 3) Line plot: median unemployment duration (uempmed) with yearly markers
years <- seq(as.Date("1970-01-01"), max(economics$date), by = "1 year")

ggplot(economics, aes(x = date, y = uempmed)) +
  geom_line(color = "black", size = 1.15) +
  geom_vline(xintercept = as.numeric(years), color = "grey70", linewidth = 0.4) +
  labs(
    title = "Median unemployment duration in the US",
    subtitle = "Vertical lines mark the start of each year",
    x = "Year",
    y = "Weeks"
  ) +
  scale_x_date(date_breaks = "4 years", date_labels = "%Y") +
  hw_theme

# 4) Line plot: unemployment with recession shading (geom_rect)
recessions <- data.frame(
  start = as.Date(c(
    "1969-12-01","1973-11-01","1980-01-01","1981-07-01",
    "1990-07-01","2001-03-01","2007-12-01"
  )),
  end = as.Date(c(
    "1970-11-01","1975-03-01","1980-07-01","1982-11-01",
    "1991-03-01","2001-11-01","2009-06-01"
  ))
)

ggplot(economics, aes(x = date, y = unemploy)) +
  geom_rect(
    data = recessions,
    aes(xmin = start, xmax = end, ymin = -Inf, ymax = Inf),
    inherit.aes = FALSE,
    fill = "firebrick",
    alpha = 0.12
  ) +
  geom_line(color = "steelblue4", size = 1.2) +
  labs(
    title = "Unemployment with recession periods highlighted",
    subtitle = "Shaded areas are recession periods (manual intervals)",
    x = "Year",
    y = "Unemployed (thousands)"
  ) +
  scale_y_continuous(labels = comma) +
  scale_x_date(date_breaks = "4 years", date_labels = "%Y") +
  hw_theme

