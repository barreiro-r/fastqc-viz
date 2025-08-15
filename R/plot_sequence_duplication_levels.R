#' FastQC-viz: Sequence duplication levels
#'
#' @description
#' Create plot for "Sequence duplication levels"
#'
#' @details
#' Create plot for "Sequence duplication levels"
#'
#' @param fastqc_data output from parse_fastqc()
#'
#' @return ggplot
#'
#' @keywords plot
#'
#' @examples
#' fastqc_data <- parse_fastqc(system.file("extdata", "SRR622457_2_fastqc.txt", package = "fastqcviz"))
#' plot_sequence_duplication_levels(fastqc_data)
#'
#' @export
plot_sequence_duplication_levels <- function(fastqc_data) {
  fqcviz_colors <- get_color_palette()

  data2plot <-
    fastqc_data$sequence_duplication_levels$content |>
    dplyr::transmute(
      duplication_level = forcats::fct_reorder(
        duplication_level,
        dplyr::row_number()
      ),
      percentage_of_total = as.numeric(percentage_of_total) / 100
    )

  data2plot |>
    ggplot2::ggplot(ggplot2::aes(
      y = duplication_level,
      x = percentage_of_total
    )) +
    ggplot2::geom_col(fill = fqcviz_colors$blue1) +
    ggplot2::labs(
      y = "Sequence Duplication Level",
      x = "Sequences (%)",
    ) +
    ggplot2::scale_x_continuous(
      expand = c(0, 0),
      limits = c(0, 1),
      label = scales::percent,
    ) +
    ggplot2::geom_text(
      data = subset(data2plot, percentage_of_total == max(percentage_of_total)),
      ggplot2::aes(
        label = scales::percent(percentage_of_total, accuracy = 0.01)
      ),
      hjust = 1.1,
      size = 2,
      color = "white"
    ) +
    ggplot2::geom_text(
      data = subset(
        data2plot,
        percentage_of_total != max(percentage_of_total) &
          percentage_of_total > 0
      ),
      ggplot2::aes(
        label = scales::percent(percentage_of_total, accuracy = 0.01)
      ),
      hjust = -0.1,
      size = 2,
      color = fqcviz_colors$warm_grey2
    ) +
    ggplot2::scale_y_discrete(
      expand = ggplot2::expansion(add = c(1.5, 0))
    ) +
    ggplot2::theme(
      legend.position = c(1, 1),
      legend.justification = c(1, 1),
      legend.key.spacing.y = ggplot2::unit(.1, "cm"),
      legend.key.height = ggplot2::unit(.1, "cm"),
      axis.text.y = ggplot2::element_text(hjust = 0, size = 6),
      panel.grid.major.x = ggplot2::element_line(
        linewidth = .3,
        color = fqcviz_colors[["warm_grey5"]]
      ),
      panel.grid.major.y = ggplot2::element_blank()
    )
}
