#' FastQC-viz: FastQC parser
#'
#' @description
#' Reads the raw fastqc_data.txt file and create a list with all of the modules.
#' Each module contains a list with content and status.
#'
#' @details
#' These are the modules:
#'
#' - "basic_statistics"
#' - "per_base_sequence_quality"
#' - "per_sequence_quality_scores"
#' - "per_base_sequence_content"
#' - "per_sequence_gc_content"
#' - "per_base_n_content"
#' - "sequence_length_distribution"
#' - "sequence_duplication_levels"
#' - "overrepresented_sequences"
#' - "adapter_content"
#' - "comments"
#'
#' @param fastq_data_file Path for the  fastqc_data.txt
#'
#' @return list, each module has `content` and `status`.
#'
#' @keywords internal
#'
#' @examples
#' fastqc_data <- parse_fastqc(system.file("extdata", "SRR622457_2_fastqc.txt", package = "fastqcviz"))
#' fastqc_data$overrepresented_sequences
#' # > $content
#' # > # A tibble: 1 × 4
#' # >   sequence                                           count percentage possible_source
#' # >   <chr>                                              <chr> <chr>      <chr>
#' # > 1 NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN 15290 0.6116     No Hit
#' # >
#' # > $status
#' # > [1] "warn"
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
