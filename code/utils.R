# Custom GGplot2 theme
theme_mspp <- function(...) {
  
  ggplot2::theme_minimal(...) %+replace%
    ggplot2::theme(
      
      plot.title.position = "plot",
      plot.title = ggplot2::element_text(
        size = 14,
        face = "bold",
        color = "black",
        hjust = 0,
        margin = ggplot2::margin(0, 0, 10, 0)
      ),
      
      plot.caption.position = "plot",
      plot.caption = ggplot2::element_text(
        size = 9,
        face = "italic",
        color = "grey40",
        hjust = 0,
        margin = ggplot2::margin(10, 0, 0, 0)
      ),
      
      legend.position =      "top",
      legend.justification = "left",
      legend.direction =     "vertical",
      
      panel.grid.minor.y = ggplot2::element_blank(),
      panel.grid.major.x = ggplot2::element_blank(),
      panel.grid.minor.x = ggplot2::element_blank(),
      
      complete = TRUE
    )
}

# Custom GGplot2 theme for maps
theme_mspp_map <- function(...) {
  theme_mspp(...) %+replace%
    ggplot2::theme(
      
      line = ggplot2::element_blank(),
      rect = ggplot2::element_blank(),
      
      panel.border = ggplot2::element_blank(),
      panel.grid = ggplot2::element_blank(),
      panel.grid.major = ggplot2::element_blank(),
      panel.grid.minor = ggplot2::element_blank(),
      
      axis.line = ggplot2::element_blank(),
      axis.title = ggplot2::element_blank(),
      
      axis.text = ggplot2::element_blank(),
      axis.text.x = ggplot2::element_blank(),
      axis.text.y = ggplot2::element_blank(),
      
      axis.ticks = ggplot2::element_blank(),
      axis.ticks.length =  ggplot2::unit(0, "pt"),
      axis.ticks.length.x = NULL,
      axis.ticks.length.x.top = NULL,
      axis.ticks.length.x.bottom = NULL,
      axis.ticks.length.y = NULL,
      axis.ticks.length.y.left = NULL,
      axis.ticks.length.y.right = NULL,
      
      legend.key.size = ggplot2::unit(15, "pt"),
      legend.title = ggplot2::element_text(size = 9),
      legend.text = ggplot2::element_text(size = 7),
      
      
      complete = TRUE
    )
}
