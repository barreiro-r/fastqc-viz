#' FastQC Parse
#'
#' @description
#' Create tibbles out a fastqc_data.txt files
#'
#' @details
#' Read the fastqc_data.txt file and return a list with the modules content and status
#'
#' @param fastq_data_file Path for the  fastqc_data.txt
#'
#' @return list with the modules content and status
#'
#' @keywords [TODO]
#'
#' @examples
#' parse_fastqc(system.file("extdata", "SRR622457_2_fastqc.txt", package = "fastqcviz"))
#'
#' @export
parse_fastqc <- function(fastq_data_file) {
  # --- Input Validation ---
  if (!file.exists(fastq_data_file)) {
    stop("Error:", fastq_data_file, " does not exist.")
  }

  # --- Core Calculation ---
  readLines(fastq_data_file) |>
    separate_modules() |>
    module_content_to_tibble()
}
