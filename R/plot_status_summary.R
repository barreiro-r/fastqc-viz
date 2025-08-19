#' FastQC-viz: Status Summary
#'
#' @description
#' Generates an HTML summary table of the pass/warn/fail status for each
#' FastQC module.
#'
#' @details
#' This function creates a concise, two-column HTML table that visually
#' summarizes the results of a FastQC analysis. It is designed to work with
#' data parsed by the `parse_fastqc()` function.
#'
#' The function transforms the FastQC data by:
#' 1.  Extracting the `status` ("pass", "warn", or "fail") for each analysis module.
#' 2.  Using the `status_to_pill()` helper function to convert each status string
#'     into a colored HTML badge for easy visual identification.
#' 3.  Cleaning up module names (e.g., "per_base_sequence_quality" becomes
#'     "Per base sequence quality").
#' 4.  Rendering the final output as a clean, headerless HTML table using the
#'     `kableExtra` package.
#'
#' @param fastqc_data output from fastqc parser
#'
#' @return html table;
#'
#' @keywords html_formater
#'
#' @examples
#' fastqc_data <- parse_fastqc(system.file("extdata", "SRR622457_2_fastqc.txt", package = "fastqcviz"))
#' plot_status_summary(fastqc_data)
#'
#' @export
plot_status_summary <- function(fastqc_data) {
  # --- Input Validation ---
  # [TODO]

  # --- Core Calculation ---

  fastqc_data[!names(fastqc_data) %in% "comments"] |>
    purrr::map(~ .x[["status"]]) |>
    tidyr::as_tibble() |>
    tidyr::pivot_longer(
      cols = tidyr::everything(),
      names_to = "module",
      values_to = "status"
    ) |>
    dplyr::mutate(
      module = stringr::str_to_sentence(
        module |> stringr::str_replace_all("_", " ")
      )
    ) |>
    dplyr::rowwise() |>
    dplyr::mutate(
      status = status_to_pill(status),
    ) |>
    dplyr::ungroup() |>
    dplyr::mutate(
      module = glue::glue(
        '<span class = "row-title">{module}</span>'
      )
    ) |>
    dplyr::transmute(
      stringr::str_c(status, " ", module)
    ) |>
    kableExtra::kable(col.names = NULL, format = "html", escape = FALSE)
}
