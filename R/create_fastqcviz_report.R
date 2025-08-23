#' FastQC-viz: Create fastqcviz report
#'
#' @description
#' Create HTML header with the Status
#'
#' @details
#' Create a icon and pretiffy name for box headers
#'
#' @param fastqc_path path for the FastQC file
#' @param module_name name of the module
#'
#' @return a HTML header (h1)
#'
#' @keywords html_formater
#'
#' @examples
#' fastqc_data <- parse_fastqc(system.file("extdata", "SRR622457_2_fastqc.txt", package = "fastqcviz"))
#' create_fastqcviz_report(fastqc_data)
#'
#' @export
#'
#'

create_fastqcviz_report <- function(
  fastqc_path,
  output_dir = "fastqcviz_report"
) {
  fastqc_data <- parse_fastqc(fastqc_path)

  dir.create(output_dir, showWarnings = FALSE)

  # --- Create Plots

  # Update theme
  theme_set_fastqcviz()

  plot_per_base_sequence_quality(
    fastqc_data,
    output_path = paste0(output_dir, "/per_base_sequence_quality.png")
  )
  plot_per_base_sequence_content(
    fastqc_data,
    output_path = paste0(output_dir, "/per_base_sequence_content.png")
  )
  plot_per_base_n_content(
    fastqc_data,
    output_path = paste0(output_dir, "/per_base_n_content.png")
  )
  plot_per_sequence_gc_content(
    fastqc_data,
    output_path = paste0(output_dir, "/per_sequence_gc_content.png")
  )
  plot_sequence_length_distribution(
    fastqc_data,
    output_path = paste0(output_dir, "/sequence_length_distribution.png")
  )
  plot_sequence_duplication_levels(
    fastqc_data,
    output_path = paste0(output_dir, "/sequence_duplication_levels.png")
  )
  plot_adapter_content(
    fastqc_data,
    output_path = paste0(output_dir, "/adapter_content.png")
  )
}
