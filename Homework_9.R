install.packages(c(
  "ggplot2",
  "dplyr",
  "scales",
  "palmerpenguins",
  "ggrepel",
  "ggridges",
  "ggpubr"
))

library(ggplot2)
library(dplyr)
library(scales)
library(palmerpenguins)
library(ggrepel)
library(ggridges)
library(ggpubr)

theme_set(
  theme_minimal() +
    theme(
      plot.title = element_text(face = "bold"),
      axis.title = element_text(face = "bold"),
      legend.position = "top",
      panel.grid.minor = element_blank()
    )
)

data("penguins")

penguins <- penguins %>% drop_na(bill_length_mm, species, sex)

ggplot(penguins, aes(x = bill_length_mm)) +
  geom_histogram(bins = 30, fill = "steelblue", color = "white") +
  labs(
    title = "Distribution of bill length",
    x = "Bill length (mm)",
    y = "Frequency"
  )

ggplot(penguins, aes(x = bill_length_mm, fill = species)) +
  geom_histogram(bins = 30, position = "identity", alpha = 0.5) +
  labs(
    title = "Bill length distribution by species",
    x = "Bill length (mm)",
    y = "Frequency",
    fill = "Species"
  )

ggplot(penguins, aes(x = bill_length_mm, color = species)) +
  geom_density(size = 1.2) +
  labs(
    title = "Kernel density of bill length",
    x = "Bill length (mm)",
    y = "Density",
    color = "Species"
  )

ggplot(penguins, aes(x = species, y = bill_length_mm, fill = species)) +
  geom_boxplot(alpha = 0.7, show.legend = FALSE) +
  labs(
    title = "Boxplot of bill length by species",
    x = "Species",
    y = "Bill length (mm)"
  )

ggplot(penguins, aes(x = species, y = bill_length_mm, fill = species)) +
  geom_violin(alpha = 0.6, show.legend = FALSE) +
  geom_boxplot(width = 0.1, fill = "white") +
  labs(
    title = "Violin and boxplot of bill length",
    x = "Species",
    y = "Bill length (mm)"
  )

ggplot(penguins, aes(x = bill_length_mm, y = species, fill = ..x..)) +
  geom_density_ridges_gradient(scale = 3, rel_min_height = 0.01) +
  scale_fill_viridis_c() +
  labs(
    title = "Ridgeline plot of bill length",
    x = "Bill length (mm)",
    y = "Species",
    fill = "Bill length"
  )

ggplot(penguins, aes(sample = bill_length_mm)) +
  stat_qq() +
  stat_qq_line(color = "red") +
  labs(
    title = "Q-Q plot for bill length",
    x = "Theoretical quantiles",
    y = "Sample quantiles"
  )

ggplot(penguins, aes(x = species, y = bill_length_mm, color = sex)) +
  geom_boxplot(position = position_dodge(0.75)) +
  stat_summary(
    fun = mean,
    geom = "point",
    shape = 18,
    size = 3,
    position = position_dodge(0.75)
  ) +
  labs(
    title = "Bill length by species and sex",
    x = "Species",
    y = "Bill length (mm)",
    color = "Sex"
  )

