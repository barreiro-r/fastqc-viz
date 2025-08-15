#' FastQC-viz: Adapter content
#'
#' @description
#' Create plot for "Adapter content"
#'
#' @details
#' Create plot for "Adapter content"
#'
#' @param NULL
#'
#' @return ggplot
#'
#' @keywords plot
#'
#' @examples
#' fastqc_data <- parse_fastqc(system.file("extdata", "SRR622457_2_fastqc.txt", package = "fastqcviz"))
#' plot_adapter_content(fastqc_data)
#'
#' @export
plot_adapter_content <- function(fastqc_data) {
  fqcviz_colors <- get_color_palette()

  data2plot <-
    fastqc_data$adapter_content$content |>
    tidyr::pivot_longer(
      cols = -position,
      names_to = "adapter",
      values_to = "percentage_of_total"
    ) |>
    tidyr::separate(
      position,
      into = c('start', 'end'),
      sep = '-',
      fill = 'left'
    ) |>
    dplyr::mutate(dplyr::across(c(start, end), as.numeric)) |>
    dplyr::rowwise() |>
    dplyr::mutate(position_numeric = mean(c(start, end), na.rm = TRUE)) |>
    dplyr::mutate(
      percentage_of_total = as.numeric(percentage_of_total) / 100,
      position = as.numeric(position_numeric)
    )

  data2plot |>
    ggplot2::ggplot(ggplot2::aes(y = percentage_of_total, x = position)) +
    ggplot2::geom_line(ggplot2::aes(color = adapter), linewidth = .5) +
    ggplot2::labs(
      y = "Adapter Content (%)",
      x = "Position in read (bp)",
      color = NULL
    ) +
    ggplot2::scale_y_continuous(
      expand = ggplot2::expansion(mult = .15),
      limits = c(0, 1),
      label = scales::percent,
    ) +
    ggplot2::scale_x_continuous(
      expand = c(0, 0),
      limits = c(0, max(data2plot$position)),
      breaks = as.integer(seq(0, max(data2plot$position), length.out = 5)),
    ) +
    ggplot2::theme(
      legend.position = c(1, 1),
      legend.justification = c(1, 1),
      legend.key.spacing.y = ggplot2::unit(.1, "cm"),
      legend.key.height = ggplot2::unit(.1, "cm"),
      legend.text = ggplot2::element_text(size = 6),
      axis.text.y = ggplot2::element_text(hjust = 0, size = 6),
    ) +
    ggsci::scale_color_lancet(label = function(x) {
      stringr::str_replace_all(x, "_", " ") |> stringr::str_to_title()
    })
}
