#' FastQC-viz: Theme set fastqcviz
#'
#' @description
#' Update ggplot theme settings for all plots.
#'
#' @keywords internal
#'
#' @examples
#' fastqc_data <- parse_fastqc(system.file("extdata", "SRR622457_2_fastqc.txt", package = "fastqcviz"))
#' # Before
#' plot_per_sequence_gc_content(fastqc_data)
#'
#' # After
#' theme_set_fastqcviz()
#' plot_per_sequence_gc_content(fastqc_data)
#'
#' @export
theme_set_fastqcviz <- function() {
  fqcviz_colors <- get_color_palette()

  ggplot2::theme_set(
    ggplot2::theme_minimal() +
      ggplot2::theme(
        axis.line.x.bottom = ggplot2::element_line(
          color = 'grey20',
          linewidth = .3
        ),
        axis.ticks.x = ggplot2::element_line(color = 'grey20', linewidth = .3),
        # axis.line.y.left = ggplot2::element_line(color = 'grey20', linewidth = .3),
        # axis.ticks.y= ggplot2::element_line(color = 'grey20', linewidth = .3),
        # panel.grid = ggplot2::element_line(linewidth = .3, color = 'grey90'),
        panel.grid.major.y = ggplot2::element_line(
          linewidth = .3,
          color = fqcviz_colors[["warm_grey5"]]
        ),
        text = ggplot2::element_text(family = "DM Sans"),
        panel.grid.major = ggplot2::element_blank(),
        panel.grid.minor = ggplot2::element_blank(),
        axis.ticks.length = ggplot2::unit(-0.15, "cm"),
        plot.background = ggplot2::element_blank(),
        plot.title.position = "plot",
        plot.title = ggplot2::element_text(size = 18, face = 'bold'),
        plot.caption = ggplot2::element_text(
          size = 8,
          color = 'grey60',
          margin = ggplot2::margin(20, 0, 0, 0)
        ),
        plot.subtitle = ggplot2::element_text(
          size = 9,
          lineheight = 1.15,
          margin = ggplot2::margin(5, 0, 15, 0)
        ),
        axis.title.x = ggtext::element_markdown(
          hjust = .5,
          size = 8,
          color = "grey40"
        ),
        axis.title.y = ggtext::element_markdown(
          hjust = .5,
          size = 8,
          color = "grey40"
        ),
        axis.text = ggplot2::element_text(
          hjust = .5,
          size = 8,
          color = "grey40"
        ),
        legend.position = "inside",
        plot.margin = ggplot2::margin(15, 15, 15, 15),
      )
  )
}
