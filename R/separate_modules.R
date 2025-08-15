#' FastQC Parse: Separate Modules
#'
#' @description
#' Separate modules of fastqc_data.txt
#'
#' @details
#' From a readLines output of a fastqc_data.txt separate the modules
#' into a list with the content, status and comments
#'
#' @param lines collection from readLines(fastqc_data.txt)
#'
#' @return list with modules, each module has content, status; The list also contains comments
#'
#' @keywords [TODO]
#'
#' @examples
#' lines <- readLines(system.file("extdata", "SRR622457_2_fastqc.txt", package = "fastqcviz"))
#' modules <- separate_modules(lines)
#'
#' @export
separate_modules <- function(lines) {
  # --- Input Validation ---
  if (!is.atomic(lines)) {
    stop("Error: Input must be a character vector.")
  }

  # --- Core Calculation ---

  # Initialize variables
  module_list <- list()
  comments <- c()
  current_module_content <- c()

  # Loop through each line to parse the modules
  for (line in lines) {
    if (
      stringr::str_detect(string = line, pattern = "^>>") &
        line != ">>END_MODULE"
    ) {
      current_status <- stringr::str_remove(string = line, pattern = ".*\t")
      current_module_name <-
        stringr::str_remove(string = line, pattern = "\t.*") |>
        stringr::str_remove(pattern = ">>") |>
        stringr::str_to_lower() |>
        stringr::str_replace_all(pattern = " ", replacement = "_")
    } else if (stringr::str_detect(string = line, pattern = "^##")) {
      comments <- c(comments, line)
    } else if (line == ">>END_MODULE") {
      # Add module to the list
      module <- list(
        content = current_module_content,
        status = current_status
      )
      module_list[[current_module_name]] <- module

      # Reset content for the new module
      current_module_content <- c()
    } else {
      current_module_content <- c(current_module_content, line)
    }
  }
  module_list[['comments']] <- comments

  # --- Return ---
  return(module_list)
}
