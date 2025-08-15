#' FastQC-viz: Plot Per sequence GC content
#'
#' @description
#' Create plot for "Per sequence GC content"
#'
#' @details
#' Create plot for "Per sequence GC content"
#'
#' @param fastqc_data output from parse_fastqc()
#'
#' @return ggplot
#'
#' @keywords plot
#'
#' @examples
#' plot_per_sequence_gc_content(fastqc_data)
#'
#' @export
plot_per_sequence_gc_content <- function(fastqc_data) {
  fqcviz_colors <- get_color_palette()

  data2plot <-
    fastqc_data$per_sequence_gc_content$content |>
    dplyr::mutate(
      gc_content = as.numeric(gc_content),
      count = as.numeric(count)
    )

  theoretical_data <-
    process_gc_data(data2plot)

  data2plot <-
    data2plot |>
    dplyr::mutate(group = 'Observed') |>
    dplyr::bind_rows(
      theoretical_data$normal_distribution_df |>
        mutate(group = 'Theoretical')
    ) |>
    dplyr::mutate(group = factor(group, levels = c('Theoretical', 'Observed')))

  data2plot |>
    ggplot2::ggplot(ggplot2::aes(x = gc_content, y = count)) +
    ggplot2::geom_line(ggplot2::aes(color = group), linewidth = .5) +
    labs(
      x = "Mean GC content (%)",
      y = "Count (n)",
      color = NULL
    ) +
    ggplot2::scale_y_continuous(
      labels = format_large_numbers,
      expand = expansion(mult = .15)
    ) +
    ggplot2::scale_color_manual(
      values = c(
        "Observed" = fqcviz_colors$blue1,
        "Theoretical" = fqcviz_colors$warm_grey4
      )
    ) +
    ggplot2::scale_x_continuous(expand = c(0, 0)) +
    ggplot2::theme(
      legend.position = c(1, 1),
      legend.justification = c(1, 1),
      legend.key.spacing.y = unit(.1, "cm"),
      legend.key.height = unit(.1, "cm")
    )
}
