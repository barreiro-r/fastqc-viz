#' FastQC-viz: Create Header
#'
#' @description
#' In the FastQC-viz report, the header of each module is composed by
#' a pill indicating the status of the module and the name of the module.
#'
#' @param fastqc_data `fastqc_parser()`, output
#' @param module_name character, name of the module
#' @param add_help boolean, add help button to the header
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

create_header <- function(fastqc_data, module_name, add_help = TRUE) {
  status <- fastqc_data[[module_name]]$status

  module_name_pretty <- c(
    "per_base_sequence_quality" = "Per base sequence quality",
    "per_sequence_quality_scores" = "Per sequence quality scores",
    "per_base_sequence_content" = "Per base sequence content",
    "per_sequence_gc_content" = "Per sequence GC content",
    "per_base_n_content" = "Per base N content",
    "sequence_length_distribution" = "Sequence length distribution",
    "sequence_duplication_levels" = "Sequence duplication levels",
    "overrepresented_sequences" = "Overrepresented sequences",
    "adapter_content" = "Adapter content"
  )

  header <- paste0(
    "<h1>",
    status_to_pill(status),
    " ",
    module_name_pretty[module_name],
    "</h1>"
  )

  if (add_help) {
    header <- header |>
      stringr::str_replace(
        "</h1>",
        paste0(
          '\n<label class="info-button" for="card-toggler-',
          module_name,
          '">i</label></h1>\n<input type="checkbox" class="card-toggler" id="card-toggler-',
          module_name,
          '"/>'
        )
      )
  }

  header
}
