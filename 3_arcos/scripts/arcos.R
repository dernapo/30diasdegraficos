#######################################################
#30diasdegraficos gráfico de arcos
#######################################################

## Load libraries ####

pacman::p_load(tidyverse, ggraph, tidygraph, igraph, here, png, grid)

theme_set(theme_classic())

## Load image ####
img <- readPNG(here("3_arcos", "files", "stern.png"))

## Data ####

familia_nodes <- data.frame(names = c("abuelo", "abuela", "papá", "mamá", "tia", "yo", "primo"),
                            nacio = c(1948, 1948, 1975, 1978, 1981, 2012, 2018))

familia_edges <- data.frame(from = c(1, 2, 1, 2, 3, 4, 5),
                            to = c(3, 3, 5, 5, 6, 6, 7),
                            pais = c("es", "es", "es", "es", "de", "de", "es"))

familia_tbl <- tbl_graph(nodes = familia_nodes, edges = familia_edges)

## Visualize ####

ggraph(familia_tbl, 'linear') +
  geom_edge_arc(aes(alpha = stat(index), color = as.factor(pais)), 
                strength = 0.3,
  ) +
  geom_node_text(aes(label = paste0(names, "\n", nacio)), 
                 repel = FALSE, 
                 size = 4, 
                 color = "#FF00D2", 
                 nudge_y = -0.1) +
  geom_node_point(size= 1.2, color = "black") +
  geom_node_point(size= .7, color = "white") +
  scale_edge_color_viridis(discrete = TRUE, direction = 1, option = "D") +
  theme(
    legend.position="none",
    plot.margin=unit(rep(1,4), "cm"),
    plot.title = element_text(colour = "#FF00D2")
  ) +
  labs(title = "Hijos y padres") +
  annotation_custom(rasterGrob(img,
                               width = unit(1,"npc"), 
                               height = unit(1,"npc")),
                    xmin = 5.9, xmax = 6.4, ymin = -.07, ymax = .02)


## Save image ####
ggsave(filename = here("3_arcos", "output", paste0(format(Sys.time(), "%Y-%m-%d_%H%M"), "_30diasdegraficos_arcos.png")),
       width = 9, height = 6, dpi = 600)