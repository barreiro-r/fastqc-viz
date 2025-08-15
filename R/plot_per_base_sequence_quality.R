#' FastQC-viz: Theme set fastqcviz
#'
#' @description
#' Update main theme
#'
#' @details
#' [TODO]
#'
#' @param fastqc_data output from parse_fastqc()
#'
#' @return list with colors
#'
#' @keywords [TODO]
#'
#' @examples
#' plot_per_base_sequence_quality()
#'
#' @export
plot_per_base_sequence_quality <- function(fastqc_data) {
  fqcviz_colors <- get_color_palette()

  data2plot <-
    fastqc_data$per_base_sequence_quality$content |>
    tidyr::separate(
      base,
      into = c('start', 'end'),
      sep = '-',
      fill = 'left'
    ) |>
    dplyr::mutate(across(c(start, end), as.numeric)) |>
    dplyr::rowwise() |>
    dplyr::mutate(base_numeric = mean(c(start, end), na.rm = TRUE)) |>
    dplyr::mutate(my_mean = as.numeric(mean), my_median = as.numeric(median))

  annotation_zone_data <-
    tidyr::tibble(
      zone = c("fail", "warn", "pass"),
      my_start = c(0, 20, 28),
      my_end = c(20, 28, Inf),
      base_numeric = 0,
      my_mean = 0
    )

  data2plot |>
    ggplot2::ggplot(aes(x = base_numeric, y = as.numeric(my_mean))) +
    ggpattern::geom_rect_pattern(
      data = subset(annotation_zone_data, zone == "fail"),
      xmin = -Inf,
      xmax = Inf,
      aes(ymin = my_start, ymax = my_end),
      alpha = 0,
      pattern_alpha = .2,
      pattern = "stripe",
      pattern_spacing = .025,
      pattern_angle = 45,
      pattern_color = fqcviz_colors$fail,
    ) +
    ggpattern::geom_rect_pattern(
      data = subset(annotation_zone_data, zone == "warn"),
      xmin = -Inf,
      xmax = Inf,
      aes(ymin = my_start, ymax = my_end),
      alpha = 0,
      pattern_alpha = .15,
      pattern = "stripe",
      pattern_spacing = .025,
      pattern_angle = 45,
      pattern_color = fqcviz_colors$warm_grey2,
    ) +
    # main geometries
    # boxplot whiskers
    ggplot2::geom_ribbon(
      aes(
        x = base_numeric,
        ymin = as.numeric(x10th_percentile),
        ymax = as.numeric(x90th_percentile)
      ),
      fill = fqcviz_colors$warm_grey3,
      alpha = .1
    ) +
    # boxpot box
    ggplot2::geom_ribbon(
      aes(
        x = base_numeric,
        ymin = as.numeric(upper_quartile),
        ymax = as.numeric(lower_quartile)
      ),
      fill = fqcviz_colors$warm_grey3,
      alpha = .2
    ) +
    # boxplot median
    ggplot2::geom_line(
      aes(
        x = base_numeric,
        y = as.numeric(median),
        group = 1
      ),
      color = fqcviz_colors$warm_grey3,
      alpha = .4,
    ) +
    # main distribuition
    ggplot2::geom_line(aes(group = 1), color = fqcviz_colors$blue1) +
    ggplot2::scale_y_continuous(
      limits = c(0, max(as.numeric(data2plot$upper_quartile))),
      expand = expansion(mult = .15)
    ) +
    ggplot2::scale_x_continuous(
      expand = c(0, 0),
      breaks = as.integer(seq(1, max(data2plot$base_numeric), length.out = 5)),
      limits = c(min(data2plot$base_numeric), max(data2plot$base_numeric))
    ) +
    ggplot2::labs(
      x = "Read base position",
      y = "Quality"
    )
}
