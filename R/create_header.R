#' FastQC-viz: Create Header
#'
#' @description
#' In the FastQC-viz report, the header of each module is composed by
#' a pill indicating the status of the module and the name of the module.
#'
#' @param fastqc_data `fastqc_parser()`, output
#' @param module_name character, name of the module
#'
#' @return character, The HTML elements that compose the header
#'
#' @keywords html_formater
#' @keywords internal
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

  # icon_status <- dplyr::case_when(
  #   status == "pass" ~ "material-symbols:check-circle-rounded",
  #   status == "warn" ~ "material-symbols:error",
  #   status == "fail" ~ "material-symbols:cancel"
  # )

  module_name_sentence <- stringr::str_replace_all(
    string = module_name,
    pattern = "_",
    replacement = " "
  ) |>
    stringr::str_to_sentence()

  header <- paste0(
    "<h1>",
    status_to_pill(status),
    " ",
    module_name_sentence,
    "</h1>"
  )

  header
}
