#' FastQC Parse: Separate Modules
#'
#' @description
#' After reading the fastqc_data.txt file, this function separates the modules into a list
#'
#' @param lines array, `readLines(fastqc_data.txt)` output
#'
#' @return list, The list contains modules and each module has "content", "status"; The list also contains comments.
#'
#' @keywords internal
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
