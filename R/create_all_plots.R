#' FastQC-viz: Create all plots
#'
#' @description
#' First, creates the directory for all files (/images/plots) and
#' run the plot function for all the plots that create .png files.
#'
#' Plot functions that not create .png files:
#' * plot_basic_statistics()
#' * plot_overrepresented_sequences()
#' * plot_status_summary()
#'
#' @param fastqc_data output from fastqc parser
#' @param output_dir output directory
#'
#' @return NULL
#'
#' @keywords html_formater
#' @keywords internal
#'
#' @examples
#' fastqc_data <- parse_fastqc(system.file("extdata", "SRR622457_2_fastqc.txt", package = "fastqcviz"))
#' \dontrun{
#' create_all_plots(fastqc_data, output_dir = "fastqcviz")
#' }
#' @export
#'
#'

create_all_plots <- function(fastqc_data, output_dir) {
  theme_set_fastqcviz()

  # Add DM Sans font
  sysfonts::font_add_google("DM Sans", "DM Sans")
  showtext::showtext_auto()

  dir.create(
    paste0(output_dir, "/images/plots"),
    showWarnings = FALSE,
    recursive = TRUE
  )

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
