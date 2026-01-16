library(ggplot2)
library(dplyr)
library(scales)
data(mtcars)

cars <- mtcars %>%
  mutate(
    cyl = factor(cyl),
    gear = factor(gear),
    am = factor(am, labels = c("Automatic", "Manual"))
  )

base_theme <- theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", size = 16, hjust = 0),
    plot.subtitle = element_text(size = 11, hjust = 0),
    axis.title = element_text(face = "bold"),
    panel.grid.minor = element_blank(),
    legend.position = "top",
    legend.title = element_text(face = "bold"),
    plot.caption = element_text(size = 9, hjust = 0),
    plot.margin = unit(c(1, 1, 1, 1), "cm")
  )

ggplot(cars, aes(x = wt, y = mpg)) +
  geom_point(aes(color = cyl, size = hp), alpha = 0.7) +
  geom_smooth(se = FALSE) +
  labs(
    title = "Masa pojazdu a zużycie paliwa",
    subtitle = "Dane mtcars",
    caption = "Źródło: wbudowany zbiór danych R (mtcars)",
    x = "Masa pojazdu (1000 lbs)",
    y = "Miles per gallon",
    color = "Liczba cylindrów",
    size = "Moc silnika"
  ) +
  base_theme

ggplot(cars, aes(x = hp, y = mpg)) +
  geom_point(aes(color = am), alpha = 0.7) +
  geom_smooth(aes(color = am), se = FALSE) +
  labs(
    title = "Moc silnika a zużycie paliwa",
    subtitle = "Porównanie skrzyni biegów",
    caption = "Źródło: mtcars",
    x = "Moc silnika",
    y = "Miles per gallon",
    color = "Skrzynia biegów"
  ) +
  base_theme

ggplot(cars, aes(x = disp, y = mpg)) +
  geom_point(aes(color = gear), alpha = 0.7) +
  geom_smooth(se = FALSE) +
  labs(
    title = "Pojemność silnika a zużycie paliwa",
    subtitle = "Zróżnicowanie względem liczby biegów",
    caption = "Źródło: mtcars",
    x = "Pojemność silnika",
    y = "Miles per gallon",
    color = "Liczba biegów"
  ) +
  base_theme +
  theme(legend.position = "right")
