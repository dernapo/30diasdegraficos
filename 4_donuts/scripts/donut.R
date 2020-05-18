#######################################################
#30diasdegraficos gráfico de donut
#######################################################

## Load libraries ####

pacman::p_load(scales, png, ggplot2, dplyr, cowplot, ggimage, magick, patchwork, data.table)

theme_set(theme_minimal())


## Preparea data ####

donut_dt <- data.table(col = as.factor(c(1:12)), val = 1L)

grad <- 2 * pi * (seq(0, 1, by = 1/12) + 1/(2*12))
stern_dt <- data.table(x = sin(grad), y = cos(grad), image = here("4_donuts", "files", "stern.png"))

## Visualize ####

p1 <- ggplot(data = donut_dt,
             mapping = aes(x = 2, y = val, fill = col)) +
  geom_col() +
  theme(legend.position = "none") +
  coord_polar("y", start = 0) +
  xlim(0.5, 2.5)


p2 <- ggplot(data = stern_dt,
             mapping = aes(x = x, y = y, image = image)) +
  geom_image(size = .1) +
  xlim(-1.5, 1.5) +
  ylim(-1.5, 1.5)

p1 + p2

## Save image ####
ggsave(filename = here("4_donuts", "output", paste0(format(Sys.time(), "%Y-%m-%d_%H%M"), "_30diasdegraficos_donut.png")),
       width = 9, height = 6, dpi = 600)