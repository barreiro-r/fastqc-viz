#' FastQC-viz: Create FastQC-viz report
#'
#' @description
#' Create the FastQC-viz report. FastQC-viz contain all FastQC plots and basic statistics
#' but with some design improvements.
#'
#' @param fastqc_path character, path to fastqc_data.txt file
#' @param output_dir character, output directory
#' @param embed_resources boolean, TRUE to embed resources into the HTML
#'
#' @return NULL, create `output_dir` with the report (`index.html`)
#'
#'
#' @examples
#' my_temp_dir <- paste0(tempdir(),"/fastqcviz_report")
#' create_fastqcviz_report(
#'     fs::path_package("extdata", "SRR622457_2_fastqc.txt", package = "fastqcviz"),
#'     output_dir = "fastqcviz_report",
#'     embed_resources = FALSE)
#' }
#' cat("Files created in", my_temp_dir)
#' @export
#'
#'

create_fastqcviz_report <- function(
  fastqc_path,
  output_dir = "fastqcviz_report",
  embed_resources = FALSE
) {
  fastqc_data <- parse_fastqc(fastqc_path)

  dir.create(output_dir, showWarnings = FALSE)

  # --- Create Plots
  create_all_plots(fastqc_data, output_dir)

  # --- Copy resources to output directory
  if (!embed_resources) {
    file.copy(
      fs::path_package(
        "extdata",
        "favicon.svg",
        package = "fastqcviz"
      ),
      output_dir
    )
    file.copy(
      fs::path_package(
        "extdata",
        "styles.css",
        package = "fastqcviz"
      ),
      output_dir
    )

    file.copy(
      fs::path_package(
        "extdata",
        "images/logo-light.svg",
        package = "fastqcviz"
      ),
      paste0(output_dir, "/images/")
    )
  }

  # --- Read template HTML
  html_template <- readr::read_file(
    fs::path_package(
      "extdata",
      "report-template.html",
      package = "fastqcviz"
    )
  )

  # ------ Modify template
  replacements <- list()

  replacements$var_status_summary <- plot_status_summary(fastqc_data)
  replacements$var_basic_statistics <- plot_basic_statistics(fastqc_data)
  replacements <- c(
    replacements,
    add_all_plots_list(fastqc_data, output_dir, embed_resources)
  )

  # --- Add CSS
  if (embed_resources) {
    replacements[["var_css"]] <- paste0(
      "<style>",
      readr::read_file(
        fs::path_package(
          "extdata",
          "styles.css",
          package = "fastqcviz"
        )
      ),
      "</style>"
    )
  } else {
    replacements[["var_css"]] <- "<link rel=\"stylesheet\" href=\"styles.css\">"
  }

  # --- Add logo
  if (embed_resources) {
    replacements[["var_logo"]] <- paste0(
      "<img src=\"data:image/svg+xml;base64,",
      base64enc::base64encode(
        fs::path_package(
          "extdata",
          "images/logo-light.svg",
          package = "fastqcviz"
        )
      ),
      "\" id=\"logo\" class=\"img-fluid\">"
    )
  } else {
    replacements[["var_logo"]] <-
      "<img src=\"images/logo-light.svg\" id=\"logo\" class=\"img-fluid\">"
  }

  # --- Add favicon
  if (embed_resources) {
    replacements[["var_favicon"]] <- paste0(
      "<link rel=\"icon\" type=\"image/svg+xml\" href=\"data:image/svg+xml;base64,",
      base64enc::base64encode(
        fs::path_package(
          "extdata",
          "favicon.svg",
          package = "fastqcviz"
        )
      ),
      "\">"
    )
  } else {
    replacements[["var_favicon"]] <-
      "<link rel=\"icon\" type=\"image/svg+xml\" href=\"favicon.svg\">"
  }

  # --- Replace all
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

  if (embed_resources) {
    unlink(paste0(output_dir, "/images"), recursive = TRUE)
  }
}
