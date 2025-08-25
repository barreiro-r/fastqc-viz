#' FastQC-viz: add_all_plots_list
#'
#' @description
#' Add all plots elements to the replacement list
#'
#' @details
#' Add all plots elements to the replacement list
#'
#' @param fastqc_data output from fastqc parser
#' @param output_dir output directory
#'
#' @return list
#'
#' @keywords internal
#'
#' @examples
#' fastqc_data <- parse_fastqc(system.file("extdata", "SRR622457_2_fastqc.txt", package = "fastqcviz"))
#' create_all_plots(fastqc_data, output_dir = "fastqcviz")
#' add_all_plots_list(fastqc_data, output_dir = "fastqcviz")
#'
#' @export
#'
#'

add_all_plots_list <- function(
  fastqc_data,
  output_dir,
  embed_resources = FALSE
) {
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
    replacements[[header_name]] <- create_header(fastqc_data, module)

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
