#' FastQC-viz: Basic statistics
#'
#' @description
#' Create base statistics HTML elements to add to the final report.
#' The final output is a HTML table with a single column, containing
#' the statistics name in a `<span>` element and the value.
#'
#' @param fastqc_data output from parse_fastqc()
#'
#' @return html table
#'
#' @keywords table
#' @keywords internal
#'
#' @examples
#' fastqc_data <- parse_fastqc(system.file("extdata", "SRR622457_2_fastqc.txt", package = "fastqcviz"))
#' plot_status_summary(fastqc_data)
#'
#' @export
plot_basic_statistics <- function(fastqc_data) {
  fastqc_data$basic_statistics$content |>
    dplyr::mutate(
      # ignore warning
      value = suppressWarnings(dplyr::if_else(
        measure %in% c("Total Sequences", "Sequences flagged as poor quality"),
        as.numeric(value) |> scales::comma(),
        value
      ))
    ) |>
    dplyr::mutate(
      measure = glue::glue("<span class = 'row-title above'>{measure}</span>")
    ) |>
    dplyr::transmute(
      glue::glue("{measure}{value}")
    ) |>
    kableExtra::kable(col.names = NULL, format = "html", escape = FALSE)
}
