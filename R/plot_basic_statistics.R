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
    kableExtra::kable(col.names = NULL)
}
