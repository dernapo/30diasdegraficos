#30diasdegraficos gráfico de barras


## Load libraries ####
pacman::p_load(ggplot2, data.table, dplyr, gganimate, png, grid, here)

## Load image ####
img <- readPNG(here("files", "stern.png"))

## Visualization ####
p <- data.table(nombres = c("anna", "javier", "pablo", "heike", "lisi omma", "luis", "carmen", "edi", "erna",
                       "holger", "maria", "rafa"), 
           edad = c(7, 45, 10, 41, 90, 2.5, 71, 68, 63, 40, 39, 41)) %>%
ggplot(aes(x = reorder(nombres, edad), y = edad, fill = edad)) +
  geom_col() + 
  geom_text(aes(label = edad), hjust = 2, color = "white") +
  #theme_minimal() +
  theme_void() +
  coord_flip() +
  labs(title = "¿Cuántos años tenemos?",
       x = NULL,
       y = NULL) +
  scale_fill_viridis_c(direction = -1) +
  theme(legend.position = "none",
        axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank()) +
  transition_states(edad, wrap = FALSE) +
  shadow_mark() +
  enter_grow() +
  enter_fade() +
  annotation_custom(rasterGrob(img,
                               width = unit(1,"npc"), 
                               height = unit(1,"npc")),
                    xmin = 1.5, xmax = 2.5, ymin = 6.5, ymax = 13.5)


## Save image ####
anim_save(file = here("output", paste0(format(Sys.time(), "%Y-%m-%d_%H%M"), "_30diasdegraficos_bars.gif")))
                    
