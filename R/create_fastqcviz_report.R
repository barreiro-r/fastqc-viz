#' FastQC-viz: Create fastqcviz report
#'
#' @description
#' Create a fastqcviz report (HTML page)
#'
#' @details
#' Create a fastqcviz report (HTML page)
#'
#' @param fastqc_path path for the FastQC file
#' @param output_dir output directory
#'
#' @return Directory with HTML report
#'
#' @keywords main
#'
#' @examples
#' create_fastqcviz_report(system.file("extdata", "SRR622457_2_fastqc.txt", package = "fastqcviz"))
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
  dir.create(
    paste0(output_dir, "/images/plots"),
    showWarnings = FALSE,
    recursive = TRUE
  )
  create_all_plots(fastqc_data, output_dir)

  # --- Copy resources to output directory
  file.copy(
    system.file("extdata", "favicon.svg", package = "fastqcviz"),
    output_dir
  )
  file.copy(
    system.file("extdata", "styles.css", package = "fastqcviz"),
    output_dir
  )

  file.copy(
    system.file("extdata", "images/logo-light.svg", package = "fastqcviz"),
    paste0(output_dir, "/images/")
  )

  # --- Read template HTML
  html_template <- readr::read_file(
    system.file("extdata", "report-template.html", package = "fastqcviz")
  )

  # ------ Modify template
  replacements <- list()

  replacements$var_status_summary <- plot_status_summary(fastqc_data)
  replacements$var_basic_statistics <- plot_basic_statistics(fastqc_data)

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
      replacements[[plot_name]] <- htmltools::tags$img(
        src = paste0("images/plots/", module, ".png")
      ) |>
        as.character()
    } else {
      replacements[[plot_name]] <- plot_overrepresented_sequences(fastqc_data)
    }
  }

  final_html <- glue::glue_data(
    replacements,
    html_template,
    .open = "<!--",
    .close = "-->",
  )

  # --- Write HTML
  readr::write_file(
    final_html,
    paste0(output_dir, "/index.html")
  )
}
