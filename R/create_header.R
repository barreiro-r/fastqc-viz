#' FastQC-viz: create_header
#'
#' @description
#' Create HTML header with the Status
#'
#' @details
#' Create a icon and pretiffy name for box headers
#'
#' @param fastqc_data output from fastqc parser
#' @param module_name name of the module
#'
#' @return a HTML header (h1)
#'
#' @keywords [TODO]
#'
#' @examples
#' fastqc_data <- parse_fastqc(system.file("extdata", "SRR622457_2_fastqc.txt", package = "fastqcviz"))
#' create_header(fastqc_data, "per_base_sequence_quality")
#'
#' @export
#'
#'

create_header <- function(fastqc_data, module_name) {
  status <- fastqc_data[[module_name]]$status

  icon_status <- dplyr::case_when(
    status == "pass" ~ "material-symbols:check-circle-rounded",
    status == "warn" ~ "material-symbols:error",
    status == "fail" ~ "material-symbols:cancel"
  )

  module_name_sentence <- stringr::str_replace_all(
    string = module_name,
    pattern = "_",
    replacement = " "
  ) |>
    stringr::str_to_sentence()

  header <- paste0(
    "<h1>",
    status_to_icon(status),
    " ",
    module_name_sentence,
    "</h1>"
  )

  cat(header)
}
