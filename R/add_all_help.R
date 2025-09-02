#' FastQC-viz: Creat all help
#'
#' @description
#' When creating the replacement list for fill the HTML template file, use this to add help sections.
#' It creates keys for "help_" to each module.
#'
#' @return list, list with all the "help_" keys for plots and headers.
#'
#' @keywords internal
#'
#' @examples
#' add_all_help(add_help = TRUE)
#'
#' @export
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
