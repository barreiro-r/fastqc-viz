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
#' * var_header_per_sequence_quality_scores
#' * var_plot_per_sequence_quality_scores
#' * var_header_per_base_sequence_quality
#' * var_plot_per_base_sequence_quality
#' * var_header_per_base_sequence_content
#' * var_plot_per_base_sequence_content
#' * var_header_per_base_n_content
#' * var_plot_per_base_n_content
#' * var_header_per_sequence_gc_content
#' * var_plot_per_sequence_gc_content
#' * var_header_sequence_length_distribution
#' * var_plot_sequence_length_distribution
#' * var_header_sequence_duplication_levels
#' * var_plot_sequence_duplication_levels
#' * var_header_overrepresented_sequences
#' * var_plot_overrepresented_sequences
#' * var_header_adapter_content
#' * var_plot_adapter_content
#'
#' NOTE: only var_plot_overrepresented_sequences is not a image.
#'
#' @param fastqc_data `fastqc_parser()` output
#' @param output_dir character, output directory
#' @param embed_resources boolean, TRUE if HTML resources should be embedded
#'
#' @return list, list with all the "var_" keys for plots and headers.
#'
#' @keywords internal
#'
#' @examples
#' fastqc_data <- parse_fastqc(system.file("extdata", "SRR622457_2_fastqc.txt", package = "fastqcviz"))
#' add_all_plots_list(fastqc_data, output_dir = "fastqcviz")
#'
#' # Need to have plots created for embed resources
#' create_all_plots(fastqc_data, output_dir = "fastqcviz")
#' add_all_plots_list(fastqc_data, output_dir = "fastqcviz", embed_resources = TRUE)
#'
#' @export
#'
#'

add_all_plots_list <- function(
  fastqc_data,
  output_dir,
  embed_resources = FALSE,
  add_help
) {
  # Raise Error if output dir dont exist
  if (!dir.exists(output_dir)) {
    stop("Error:", output_dir, " does not exist.")
  }

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
    header_name <- paste0("var_header_", module)
    replacements[[header_name]] <- create_header(fastqc_data, module, add_help)

    plot_name <- paste0("var_plot_", module)
    if (module != "overrepresented_sequences") {
      if (embed_resources) {
        src <- paste0(
          "data:image/png;base64,",
          base64enc::base64encode(
            paste0(output_dir, '/images/plots/', module, ".png")
          )
        )
      } else {
        src <- paste0("images/plots/", module, ".png")
      }

      replacements[[plot_name]] <- htmltools::tags$img(src = src) |>
        as.character()
    } else {
      # plot_overrepresented_sequences is not a png.
      replacements[[plot_name]] <- plot_overrepresented_sequences(fastqc_data)
    }
  }

  return(replacements)
}
