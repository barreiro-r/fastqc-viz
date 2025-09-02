#' FastQC-viz: Add all plots to the replacement list
#'
#' @description
#' When creating the replacement list for fill the HTML template file, use this to add the plot links
#' or embed the resources to the list. It creates keys for "var_plot_" and "var_header_"
#' to each module.
#'
#' @details
#' List of all header and plot variables:
#'
#' NOTE: only var_plot_overrepresented_sequences is not a image.
#'
#'
#' @return list, list with all the "var_" keys for plots and headers.
#'
#' @keywords internal
#'
#' @examples
#' fastqc_data <- parse_fastqc(system.file("extdata", "SRR622457_2_fastqc.txt", package = "fastqcviz"))
#' add_all_help(fastqc_data, output_dir = "fastqcviz")
#'
#' # Need to have plots created for embed resources
#' create_all_plots(fastqc_data, output_dir = "fastqcviz")
#' add_all_help(fastqc_data, output_dir = "fastqcviz", embed_resources = TRUE)
#'
#' @export
#'
#'

add_all_help <- function(add_help) {
  replacements <- list()

  modules <- c(
    "per_sequence_quality_scores",
    "per_base_sequence_quality",
    "per_base_sequence_content",
    "per_base_n_content",
    "per_sequence_gc_content",
    "sequence_length_distribution",
    "sequence_duplication_levels",
    "overrepresented_sequences",
    "adapter_content"
  )

  for (module in modules) {
    help_name <- paste0("help_", module)
    if (add_help) {
      replacements[[help_name]] <- create_help(module)
    } else {
      replacements[[help_name]] <- ""
    }
  }

  return(replacements)
}
