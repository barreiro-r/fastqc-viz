#' FastQC-viz: Sequence Length Distribution
#'
#' @description
#' Create plot for "Sequence Length Distribution"
#'
#' @details
#' Create plot for "Sequence Length Distribution"
#'
#' @param fastqc_data output from parse_fastqc()
#'
#' @return ggplot
#'
#' @keywords plot
#'
#' @examples
#' fastqc_data <- parse_fastqc(system.file("extdata", "SRR622457_2_fastqc.txt", package = "fastqcviz"))
#' plot_sequence_length_distribution(fastqc_data)
#'
#' @export
plot_sequence_length_distribution <- function(fastqc_data) {
  fqcviz_colors <- get_color_palette()

  data2plot <-
    fastqc_data$sequence_length_distribution$content |>
    dplyr::transmute(
      length = as.numeric(length),
      count = as.numeric(count)
    )

  data2plot |>
    ggplot2::ggplot(ggplot2::aes(x = length, y = count)) +
    ggplot2::geom_col(fill = fqcviz_colors$blue1) +
    ggplot2::labs(
      x = "Sequence Length (bp)",
      y = "Sequences (N)",
      color = NULL
    ) +
    ggplot2::scale_y_continuous(
      label = function(x) {
        format_large_numbers(x, digits = 1)
      },
      expand = c(0, 0)
    ) +
    ggplot2::theme(
      legend.position = c(1, 1),
      legend.justification = c(1, 1),
      legend.key.spacing.y = ggplot2::unit(.1, "cm"),
      legend.key.height = ggplot2::unit(.1, "cm")
    ) +
    ggplot2::scale_x_continuous(
      expand = ggplot2::expansion(add = 3),
      breaks = seq(min(data2plot$length), max(data2plot$length), 1)
    )
}
