#' FastQC-viz: Plot Per Sequence Quality Scores
#'
#' @description
#' Create plot for "Per Sequence Quality Scores"
#'
#' @details
#' Create plot for "Per Sequence Quality Scores"
#'
#' @param fastqc_data output from parse_fastqc()
#' @param output_path path to save png file
#'
#' @return ggplot
#'
#' @keywords plot
#'
#' @examples
#' fastqc_data <- parse_fastqc(system.file("extdata", "SRR622457_2_fastqc.txt", package = "fastqcviz"))
#' plot_per_sequence_quality_scores(fastqc_data)
#'
#' @export
plot_per_sequence_quality_scores <- function(fastqc_data, output_path = NULL) {
  fqcviz_colors <- get_color_palette()

  data2plot <-
    fastqc_data$per_sequence_quality_scores$content |>
    dplyr::mutate(
      quality = as.numeric(quality),
      count = as.numeric(count)
    )

  plot <-
    data2plot |>
    ggplot2::ggplot(ggplot2::aes(x = quality, y = count)) +
    ggplot2::geom_line(ggplot2::aes(group = 1), color = fqcviz_colors$blue1) +
    ggplot2::scale_y_continuous(
      labels = format_large_numbers,
      expand = ggplot2::expansion(mult = .15)
    ) +
    ggplot2::labs(
      x = "Average Quality per Read (Phred score)",
      y = "Number of Reads"
    )

  if (!is.null(output_path)) {
    ggplot2::ggsave(output_path, plot, width = 3 * 1.3, height = 1.75 * 1.3)
  }

  return(plot)
}
