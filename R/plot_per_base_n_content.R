#' FastQC-viz: Plot Per base N content
#'
#' @description
#' Create plot for "Per base N content"
#'
#' @details
#' Create plot for "Per base N content"
#'
#' @param fastqc_data output from parse_fastqc()
#'
#' @return ggplot
#'
#' @keywords plot
#'
#' @examples
#' fastqc_data <- parse_fastqc(system.file("extdata", "SRR622457_2_fastqc.txt", package = "fastqcviz"))
#' plot_per_base_n_content(fastqc_data)
#'
#' @export
plot_per_base_n_content <- function(fastqc_data) {
  fqcviz_colors <- get_color_palette()

  data2plot <-
    fastqc_data$per_base_n_content$content |>
    tidyr::separate(base, into = c('start', 'end'), sep = '-', fill = 'left') |>
    dplyr::mutate(dplyr::across(c(start, end), as.numeric)) |>
    dplyr::rowwise() |>
    dplyr::mutate(base_numeric = mean(c(start, end), na.rm = TRUE)) |>
    dplyr::transmute(
      base_numeric = base_numeric,
      n_count = as.numeric(n_count) / 100
    )

  data2plot |>
    ggplot2::ggplot(ggplot2::aes(x = base_numeric, y = n_count)) +
    ggplot2::geom_line(linewidth = .5, color = fqcviz_colors$blue1) +
    ggplot2::labs(
      x = "Position in read (bp)",
      y = "N Content (%)",
      color = NULL
    ) +
    ggplot2::scale_y_continuous(
      limits = c(0, 1),
      breaks = seq(0, 1, .25),
      label = scales::percent,
      expand = ggplot2::expansion(mult = .15)
    ) +
    ggplot2::theme(
      legend.position = c(1, 1),
      legend.justification = c(1, 1),
      legend.key.spacing.y = unit(.1, "cm"),
      legend.key.height = unit(.1, "cm")
    ) +
    ggplot2::scale_x_continuous(
      limits = c(0, max(data2plot$base_numeric)),
      breaks = as.integer(seq(
        min(data2plot$base_numeric) - 1,
        max(data2plot$base_numeric),
        length.out = 5
      )),
      expand = c(0, 0)
    )
}
