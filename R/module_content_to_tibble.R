#' FastQC Parse: Module content to tibble
#'
#' @description
#' Convert modules raw content (character vector) to tibble
#'
#' @details
#' Convert modules raw content (character vector) output of separate_modules() to tibble
#'
#' @param modules list, output of separate_modules()
#'
#' @return list of modules with content converted to a tibble
#'
#' @keywords [TODO]
#'
#' @examples
#' lines <- readLines("fastqc_data.txt")
#' modules <- separate_modules(lines)
#' modules <- module_content_to_tibble(modules)
#'
#' @export
module_content_to_tibble <- function(modules) {
  # --- Input Validation ---
  if (!is.list(modules)) {
    stop("Error: Input must be a list.")
  }

  fastq_modules <- c(
    "basic_statistics",
    "per_base_sequence_quality",
    "per_sequence_quality_scores",
    "per_base_sequence_content",
    "per_sequence_gc_content",
    "per_base_n_content",
    "sequence_length_distribution",
    "sequence_duplication_levels",
    "overrepresented_sequences",
    "adapter_content",
    "comments"
  )

  for (fastq_module in fastq_modules) {
    if (!fastq_module %in% names(modules)) {
      stop(paste0(
        "Error: Module '",
        fastq_module,
        "' not found in input list."
      ))
    }
  }

  # --- Core Calculation ---

  new_modules <- list()

  for (module in names(modules)) {
    new_modules[[module]] <- modules[[module]]

    # The 'comments' section  doesn't need to be converted
    if (module != "comments") {
      # Sequence duplication levels has a special attribute
      # of the total of deduplicated percentage;
      if (module == "sequence_duplication_levels") {
        new_modules[[module]][["total_deduplicated_percentage"]] <-
          modules[[module]][['content']][1] |>
          stringr::str_remove(pattern = ".*\t") |>
          as.numeric()

        # Remove the first line (deduplicated percentage)
        new_modules[[module]][["content"]] <- modules[[module]][["content"]][
          2:length(modules[[module]][['content']])
        ]
      }

      # Convert to tibble (separate, remove #, rename, clean names)
      if (!is.null(modules[[module]]['content'][[1]])) {
        new_modules[[module]][["content"]] <-
          new_modules[[module]][["content"]] |>
          tidyr::as_tibble() |>
          tidyr::separate_wider_delim(value, delim = "\t", names_sep = "_") |>
          dplyr::mutate(
            value_1 = stringr::str_remove(value_1, pattern = "^#")
          ) |>
          janitor::row_to_names(1) |>
          janitor::clean_names()
      }
    }
  }

  # --- Return ---
  return(new_modules)
}
