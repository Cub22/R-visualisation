install.packages(c("ggplot2", "dplyr", "scales", "RColorBrewer"))

library(ggplot2)
library(dplyr)
library(scales)
library(RColorBrewer)

# =========================
# Data
# =========================

data(diamonds)

diamonds_hw <- diamonds %>%
  mutate(
    cut = factor(cut, levels = c("Fair", "Good", "Very Good", "Premium", "Ideal")),
    color = factor(color)
  )

# =========================
# Theme
# =========================

hw_theme <- theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", size = 15, hjust = 0),
    plot.subtitle = element_text(size = 11),
    axis.title = element_text(face = "bold"),
    legend.title = element_text(face = "bold"),
    legend.background = element_rect(fill = "white", colour = "grey70"),
    panel.grid.minor = element_blank()
  )

# =========================
# Plot 1
# =========================
# Carat vs price

ggplot(diamonds_hw, aes(x = carat, y = price)) +
  geom_point(aes(color = cut), alpha = 0.5) +
  geom_smooth(se = FALSE) +
  scale_x_continuous(breaks = seq(0, 5, by = 0.5)) +
  scale_y_continuous(
    breaks = seq(0, 20000, by = 2000),
    labels = dollar
  ) +
  scale_color_brewer(palette = "Set2", name = "Cut") +
  labs(
    title = "Diamond size vs price",
    subtitle = "Color indicates cut quality",
    x = "Carat",
    y = "Price (USD)"
  ) +
  hw_theme

# =========================
# Plot 2
# =========================
# Depth vs price with warm gradient

ggplot(diamonds_hw, aes(x = depth, y = price)) +
  geom_point(aes(color = carat), alpha = 0.6, size = 2) +
  geom_smooth(se = FALSE) +
  scale_x_continuous(breaks = seq(55, 70, by = 2)) +
  scale_y_continuous(labels = dollar) +
  scale_color_gradientn(
    colours = brewer.pal(9, "YlOrRd"),
    name = "Carat"
  ) +
  guides(
    color = guide_colorbar(
      title.position = "top",
      title.hjust = 0.5,
      barwidth = unit(12, "cm"),
      barheight = unit(0.6, "cm")
    )
  ) +
  labs(
    title = "Diamond depth vs price",
    subtitle = "Warm color scale represents diamond size",
    x = "Depth (%)",
    y = "Price (USD)"
  ) +
  hw_theme

# =========================
# Plot 3
# =========================
# Table vs price, size & color

ggplot(diamonds_hw, aes(x = table, y = price)) +
  geom_point(aes(size = carat, color = color), alpha = 0.6) +
  geom_smooth(se = FALSE) +
  scale_x_continuous(breaks = seq(50, 70, by = 2)) +
  scale_y_continuous(labels = dollar) +
  scale_size(
    name = "Carat",
    breaks = c(0.5, 1, 2),
    range = c(2, 8)
  ) +
  scale_color_brewer(palette = "Dark2", name = "Color grade") +
  labs(
    title = "Diamond table vs price",
    subtitle = "Size indicates carat, color indicates color grade",
    x = "Table (%)",
    y = "Price (USD)"
  ) +
  hw_theme +
  theme(legend.position = "right")
