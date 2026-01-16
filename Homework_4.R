install.packages(c("ggplot2", "dplyr", "scales", "RColorBrewer", "forcats"))

library(ggplot2)
library(dplyr)
library(scales)
library(RColorBrewer)
library(forcats)

data(diamonds)

# =========================
# Theme
# =========================

hw_theme <- theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", size = 15, hjust = 0),
    plot.subtitle = element_text(size = 11),
    axis.title = element_text(face = "bold"),
    legend.title = element_text(face = "bold"),
    legend.position = "top",
    panel.grid.minor = element_blank()
  )

# =========================
# Plot 1 – distribution of cuts
# =========================

ggplot(diamonds, aes(x = cut)) +
  geom_bar(fill = "#1F78B4") +
  labs(
    title = "Distribution of diamond cuts",
    x = "Cut quality",
    y = "Number of diamonds"
  ) +
  hw_theme

# =========================
# Plot 2 – cut by color (stacked)
# =========================

ggplot(diamonds, aes(x = cut, fill = color)) +
  geom_bar(position = "stack") +
  scale_fill_brewer(palette = "Blues", name = "Color grade") +
  labs(
    title = "Diamond cuts by color grade",
    subtitle = "Stacked barplot",
    x = "Cut quality",
    y = "Count"
  ) +
  hw_theme

# =========================
# Plot 3 – average price by cut
# =========================

diamonds_avg <- diamonds %>%
  group_by(cut) %>%
  summarise(mean_price = mean(price))

ggplot(diamonds_avg, aes(x = cut, y = mean_price)) +
  geom_col(fill = "#33A02C", width = 0.6) +
  geom_text(
    aes(label = dollar(round(mean_price, 0))),
    vjust = -0.4,
    size = 3.5
  ) +
  scale_y_continuous(labels = dollar) +
  labs(
    title = "Average diamond price by cut",
    x = "Cut quality",
    y = "Average price (USD)"
  ) +
  hw_theme

# =========================
# Plot 4 – ordered barplot (clarity)
# =========================

diamonds %>%
  count(clarity) %>%
  mutate(clarity = fct_reorder(clarity, n)) %>%
  ggplot(aes(x = clarity, y = n, fill = clarity)) +
  geom_col(show.legend = FALSE) +
  geom_text(aes(label = n), vjust = -0.3, size = 3) +
  scale_fill_brewer(palette = "Set2") +
  labs(
    title = "Number of diamonds by clarity",
    x = "Clarity",
    y = "Count"
  ) +
  hw_theme
