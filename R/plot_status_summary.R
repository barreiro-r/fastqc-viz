#' FastQC-viz: Status summary
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
plot_status_summary <- function(fastqc_data) {
  # --- Input Validation ---
  # [TODO]

  # --- Core Calculation ---

  fastqc_data[!names(fastqc_data) %in% "comments"] |>
    purrr::map(~ .x[["status"]]) |>
    tidyr::as_tibble() |>
    tidyr::pivot_longer(
      cols = everything(),
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
