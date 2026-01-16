install.packages(c("ggplot2","dplyr","gapminder","scales"))

install.packages("tidyverse")
install.packages("tidygeocoder")


library(ggplot2)
library(dplyr)
library(gapminder)
library(scales)

df <- gapminder

ggplot(df, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent, size = pop), alpha = 0.6) +
  geom_smooth(se = FALSE) +
  scale_x_log10(labels = label_number()) +
  scale_size_continuous(labels = label_number()) +
  labs(
    title = "GDP per capita a oczekiwana długość życia",
    subtitle = "Zależność dla krajów świata (dane Gapminder)",
    caption = "Źródło: Gapminder",
    x = "PKB per capita (skala logarytmiczna)",
    y = "Oczekiwana długość życia",
    color = "Kontynent",
    size = "Populacja"
  ) +
  theme_minimal()

df2 <- df %>% mutate(pop_scaled = rescale(pop, to = c(0.2, 0.9)))

ggplot(df2, aes(x = year, y = lifeExp)) +
  geom_point(aes(color = continent, alpha = pop_scaled), size = 2) +
  geom_smooth(aes(color = continent), se = FALSE) +
  labs(
    title = "Zmiany długości życia w czasie",
    subtitle = "Różnice między kontynentami",
    caption = "Źródło: Gapminder",
    x = "Rok",
    y = "Oczekiwana długość życia",
    color = "Kontynent",
    alpha = "Populacja"
  ) +
  theme_minimal()

df3 <- df %>% mutate(era = ifelse(year < 1980, "Przed 1980", "1980 i później"))

ggplot(df3, aes(x = pop, y = gdpPercap)) +
  geom_point(aes(color = continent, shape = era), alpha = 0.7) +
  geom_smooth(se = FALSE) +
  scale_x_log10(labels = label_number()) +
  labs(
    title = "Populacja a PKB per capita",
    subtitle = "Porównanie dwóch okresów",
    caption = "Źródło: Gapminder",
    x = "Populacja (skala logarytmiczna)",
    y = "PKB per capita",
    color = "Kontynent",
    shape = "Okres"
  ) +
  theme_minimal()

