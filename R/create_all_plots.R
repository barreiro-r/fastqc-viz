#' FastQC-viz: create_all_plots
#'
#' @description
#' Create all plots
#'
#' @details
#' Create all plots
#'
#' @param fastqc_data output from fastqc parser
#' @param output_dir output directory
#'
#' @return NULL
#'
#' @keywords html_formater
#'
#' @examples
#' fastqc_data <- parse_fastqc(system.file("extdata", "SRR622457_2_fastqc.txt", package = "fastqcviz"))
#' create_all_plots(fastqc_data, output_path = "fastqcviz")
#'
#' @export
#'
#'

create_all_plots <- function(fastqc_data, output_dir) {
  theme_set_fastqcviz()

  plots <- c(
    "per_base_sequence_quality",
    "per_base_sequence_content",
    "per_sequence_quality_scores",
    "per_base_n_content",
    "per_sequence_gc_content",
    "sequence_length_distribution",
    "sequence_duplication_levels",
    "adapter_content"
  )
  purrr::walk(
    .x = plots,
    .f = ~ {
      output_path <- paste0(output_dir, "/images/plots/", .x, ".png")
      plot_function_name <- paste0("plot_", .x)
      do.call(plot_function_name, list(fastqc_data, output_path = output_path))
    }
  )
}
