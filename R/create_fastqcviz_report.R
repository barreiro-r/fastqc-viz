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

  # Update theme
  theme_set_fastqcviz()

  dir.create(
    paste0(output_dir, "/images/plots"),
    showWarnings = FALSE,
    recursive = TRUE
  )
  plot_per_base_sequence_quality(
    fastqc_data,
    output_path = paste0(
      output_dir,
      "/images/plots/per_base_sequence_quality.png"
    )
  )
  plot_per_base_sequence_content(
    fastqc_data,
    output_path = paste0(
      output_dir,
      "/images/plots/per_base_sequence_content.png"
    )
  )
  plot_per_sequence_quality_scores(
    fastqc_data,
    output_path = paste0(
      output_dir,
      "/images/plots/per_sequence_quality_scores.png"
    )
  )
  plot_per_base_n_content(
    fastqc_data,
    output_path = paste0(output_dir, "/images/plots/per_base_n_content.png")
  )
  plot_per_sequence_gc_content(
    fastqc_data,
    output_path = paste0(
      output_dir,
      "/images/plots/per_sequence_gc_content.png"
    )
  )
  plot_sequence_length_distribution(
    fastqc_data,
    output_path = paste0(
      output_dir,
      "/images/plots/sequence_length_distribution.png"
    )
  )
  plot_sequence_duplication_levels(
    fastqc_data,
    output_path = paste0(
      output_dir,
      "/images/plots/sequence_duplication_levels.png"
    )
  )
  plot_adapter_content(
    fastqc_data,
    output_path = paste0(output_dir, "/images/plots/adapter_content.png")
  )

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
  template <- readr::read_file(
    system.file("extdata", "report-template.html", package = "fastqcviz")
  )

  # --- Add status summary
  var_status_summary <- plot_status_summary(fastqc_data)
  template <- stringr::str_replace(
    template,
    "<!-- var_status_summary -->",
    var_status_summary
  )

  # --- Add Basic Statistics
  var_basic_statistics <- plot_basic_statistics(fastqc_data)
  template <- stringr::str_replace(
    template,
    "<!-- var_basic_statistics -->",
    var_basic_statistics
  )

  # --- Add Headings and plots
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
    var_header <- create_header(
      fastqc_data,
      module
    )
    template <- stringr::str_replace(
      template,
      paste0("<!-- var_header_", module, " -->"),
      var_header
    )

    if (module != "overrepresented_sequences") {
      var_plot <- htmltools::tags$img(
        src = paste0(
          "images/plots/",
          module,
          ".png"
        )
      ) |>
        as.character()
    } else {
      var_plot <- plot_overrepresented_sequences(fastqc_data)
    }

    template <- stringr::str_replace(
      template,
      paste0("<!-- var_plot_", module, " -->"),
      var_plot
    )
  }

  # Write HTML
  readr::write_file(
    template,
    paste0(output_dir, "/index.html")
  )
}
