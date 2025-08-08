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
      status = stringr::str_c(
        status_to_icon(status),
        " ",
        stringr::str_to_sentence(status)
      )
    ) |>
    dplyr::ungroup() |>
    kableExtra::kable(col.names = NULL) |>
    # Need this to fix a wierd space issue
    stringr::str_replace_all(pattern = "   +", "   ") |>
    stringr::str_replace_all(pattern = "---+", "---") |>
    cat(sep = "\n")
}
