# > only major-x-grid, font adjusted
load_grey <- function(
    font = "Fira Sans",
    color = "white"
) {
  ggplot2::theme_set(
    ggplot2::theme_grey() +
      ggplot2::theme(
        text = ggplot2::element_text(
          color = color,
          family = font
        ),
        legend.background = ggplot2::element_blank(),
        panel.grid.major.y = ggplot2::element_blank(),
        panel.grid.minor.y = ggplot2::element_blank(),
        panel.grid.minor.x = ggplot2::element_blank()
      )
  )
}
