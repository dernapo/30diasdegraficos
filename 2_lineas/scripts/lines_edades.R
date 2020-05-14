#30diasdegraficos gráfico de líneas


## Load libraries ####
pacman::p_load(ggplot2, data.table, dplyr, gganimate, png, grid, here)

## Load image ####
img <- readPNG(here("2_lineas","files", "stern.png"))

## Create data ####

# Hoy
edades_dt <- data.table(nombres = c("yo", "papá", "tato", "mamá", "bisabuela", "primo", "abuela", "opa", "oma",
                            "onkel", "tía", "tío"), 
                edad = c(7, 45, 10, 41, 90, 2, 71, 68, 63, 40, 39, 41),
                año = 2020)

# Función para viajar en el tiempo
resto_años_function <- function(resto, dt) {
  copy(dt)[,`:=` (edad = edad - resto, año = año - resto)][edad>=0]
}

# Creo dt con el histórico
dt_list <- lapply(0:max(edades_dt$edad), resto_años_function, dt = edades_dt)

edades_extended_dt <- rbindlist(dt_list)

## Visualizo ####

anim <- edades_extended_dt %>%
  arrange(año) %>%
  ggplot(aes(x = año, 
             y = edad, 
             color = nombres, 
             group = nombres)) +
  geom_line(colour = "grey") +
  geom_point(size = 3) +
  geom_text(aes(x = max(año) + 5, label = paste0(nombres, " : ", edad)), color = "black", hjust = "left", check_overlap = TRUE) +
  transition_reveal(año) +
  coord_cartesian(clip = "off") +
  theme_void() +
  labs(title = "¿Cuántos años teníamos en {substr(frame_along, 0,4)}?") +
  scale_color_viridis_d(direction = -1) +
  theme(legend.position = "none",
        plot.title = element_text(size=22)) +
  expand_limits(x = c(min(edades_extended_dt$año), (max(edades_extended_dt$año) + 20))) +
  annotation_custom(rasterGrob(img,
                               width = unit(1,"npc"), 
                               height = unit(1,"npc")),
                    xmin = 2020, xmax = 2025, ymin = 4, ymax = 11)


# Make the animation pause at the end and then rewind
animate(anim, fps = 5, end_pause = 30, rewind = FALSE, width = 900, height = 600)



## Save image ####
anim_save(file = here("2_lineas", "output", paste0(format(Sys.time(), "%Y-%m-%d_%H%M"), "_30diasdegraficos_line.gif")))

