#' FastQC-viz: Plot Per Base Sequence Content
#'
#' @description
#' Create plot for "Per Base Sequence Content"
#'
#' @details
#' Create plot for "Per Base Sequence Content"
#'
#' @param NULL
#'
#' @return ggplot
#'
#' @keywords plot
#'
#' @examples
#' plot_per_base_sequence_content(fastqc_data)
#'
#' @export
plot_per_base_sequence_content <- function(fastqc_data) {
  fqcviz_colors <- get_color_palette()

  data2plot <-
    fastqc_data$per_base_sequence_content$content |>
    tidyr::pivot_longer(
      cols = c('a', 'c', 'g', 't'),
      names_to = "nucleotide",
      values_to = "count"
    ) |>
    dplyr::mutate(
      count = as.numeric(count)
    ) |>
    tidyr::separate(base, into = c('start', 'end'), sep = '-', fill = 'left') |>
    dplyr::mutate(dplyr::across(c(start, end), as.numeric)) |>
    dplyr::rowwise() |>
    dplyr::mutate(base_numeric = mean(c(start, end), na.rm = TRUE))

  data2plot |>
    ggplot2::ggplot(ggplot2::aes(x = base_numeric, y = count)) +
    ggplot2::geom_line(ggplot2::aes(color = nucleotide), linewidth = .5) +
    ggplot2::scale_y_continuous(
      labels = format_large_numbers,
      limits = c(0, 100),
      expand = c(0, 0)
    ) +
    ggplot2::scale_x_continuous(
      limits = c(0, max(data2plot$base_numeric)),
      breaks = as.integer(seq(
        min(data2plot$base_numeric) - 1,
        max(data2plot$base_numeric),
        length.out = 5
      )),
      expand = c(0, 0)
    ) +
    ggplot2::labs(
      x = "Position in read (bp)",
      y = "Nucleotide Fraction (%)",
      color = NULL
    ) +
    ggsci::scale_color_lancet(label = toupper) +
    ggplot2::theme(
      legend.position = c(0.5, 1),
      legend.justification = c(0.5, 1),
      legend.direction = "horizontal"
    )
}
