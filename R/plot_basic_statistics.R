#' FastQC-viz: Basic statistics
#'
#' @description
#' [TODO]
#'
#' @details
#' [TODO]
#'
#' @param fastqc_data output from fastqc parser
#'
#' @return [TODO]
#'
#' @keywords [TODO]
#'
#' @examples
#' plot_status_summary(fastqc_data)
#'
#' @export
plot_basic_statistics <- function(fastqc_data) {
  # --- Input Validation ---
  # [TODO]

  # --- Core Calculation ---

  fastqc_data$basic_statistics$content |>
    dplyr::mutate(
      value = dplyr::if_else(
        measure %in% c("Total Sequences", "Sequences flagged as poor quality"),
        as.numeric(value) |> scales::comma(),
        value
      )
    ) |>
    dplyr::mutate(
      measure = glue::glue("<span class = 'row-title above'>{measure}</span>")
    ) |>
    dplyr::transmute(
      glue::glue("{measure}{value}")
    ) |>
    kableExtra::kable(col.names = NULL, format = "html", escape = FALSE)
}
