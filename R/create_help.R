#' FastQC-viz: Create Header
#'
#' @description
#' In the FastQC-viz report, the header of each module is composed by
#' a pill indicating the status of the module and the name of the module.
#'
#' @param module_name character, name of the module
#'
#' @return character, The HTML elements that compose the header
#'
#' @keywords html_formater
#' @keywords internal
#'
#' @examples
#' fastqc_data <- parse_fastqc(system.file("extdata", "SRR622457_2_fastqc.txt", package = "fastqcviz"))
#' create_help(fastqc_data, "per_base_sequence_quality")
#'
#' @export
#'
#'

create_help <- function(module_name) {
  module_help_content <- list(
    "per_base_sequence_quality" = list(
      summary = "Shows an overview of the range of quality values across all bases at each position in the FastQ file.",
      pass = "Quality scores are within acceptable limits.",
      warn = "The lower quartile for any base is < 10, or the median is < 25.",
      fail = "The lower quartile for any base is < 5, or the median is < 20.",
      link = "https://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/3%20Analysis%20Modules/2%20Per%20Base%20Sequence%20Quality.html"
    ),

    "per_sequence_quality_scores" = list(
      summary = "Allows you to see if a subset of your sequences have universally low quality values.",
      pass = "The most frequently observed mean quality is >= 27.",
      warn = "The most frequently observed mean quality is < 27.",
      fail = "The most frequently observed mean quality is < 20.",
      link = "https://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/3%20Analysis%20Modules/3%20Per%20Sequence%20Quality%20Scores.html"
    ),

    "per_base_sequence_content" = list(
      summary = "Plots out the proportion of each of the four normal DNA bases for each base position.",
      pass = "The difference between A/T and G/C is <= 10% at all positions.",
      warn = "The difference between A/T or G/C is > 10% at any position.",
      fail = "The difference between A/T or G/C is > 20% at any position.",
      link = "https://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/3%20Analysis%20Modules/4%20Per%20Base%20Sequence%20Content.html"
    ),

    "per_sequence_gc_content" = list(
      summary = "Measures the GC content across the whole length of each sequence and compares it to a modelled normal distribution.",
      pass = "Deviations from the normal distribution are <= 15% of reads.",
      warn = "The sum of deviations from the normal distribution is > 15% of reads.",
      fail = "The sum of deviations from the normal distribution is > 30% of reads.",
      link = "https://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/3%20Analysis%20Modules/5%20Per%20Sequence%20GC%20Content.html"
    ),

    "per_base_n_content" = list(
      summary = "Plots the percentage of base calls at each position for which an N was called.",
      pass = "N content is <= 5% at all positions.",
      warn = "Any position shows an N content of > 5%.",
      fail = "Any position shows an N content of > 20%.",
      link = "https://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/3%20Analysis%20Modules/6%20Per%20Base%20N%20Content.html"
    ),

    "sequence_length_distribution" = list(
      summary = "Generates a graph showing the distribution of fragment sizes.",
      pass = "All sequences have the same, non-zero length.",
      warn = "Sequences are not all the same length.",
      fail = "Any sequence has zero length.",
      link = "https://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/3%20Analysis%20Modules/7%20Sequence%20Length%20Distribution.html"
    ),

    "sequence_duplication_levels" = list(
      summary = "Counts the degree of duplication for every sequence in a library.",
      pass = "Non-unique sequences are <= 20% of the total.",
      warn = "Non-unique sequences make up > 20% of the total.",
      fail = "Non-unique sequences make up > 50% of the total.",
      link = "https://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/3%20Analysis%20Modules/8%20Duplicate%20Sequences.html"
    ),

    "overrepresented_sequences" = list(
      summary = "Lists all of the sequences which make up more than 0.1% of the total.",
      pass = "No sequence represents > 0.1% of the total.",
      warn = "A sequence represents > 0.1% of the total.",
      fail = "A sequence represents > 1% of the total.",
      link = "https://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/3%20Analysis%20Modules/9%20Overrepresented%20Sequences.html"
    ),

    "adapter_content" = list(
      summary = "Finds sequences (k-mers) which do not have even coverage, which can indicate adapter contamination.",
      pass = "Adapter presence is <= 5% of all reads.",
      warn = "An adapter is present in > 5% of all reads.",
      fail = "An adapter is present in > 10% of all reads.",
      link = "https://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/3%20Analysis%20Modules/10%20Adapter%20Content.html"
    )
  )

  help_html_content <- glue::glue(
    '<div class="card-face card-back" id="help-{module_name}">
    <h2>Surprise!</h2>
    <p>.</p>
    </div>'
  )

  main_help <- module_help_content[[module_name]]$summary
  status <- c("pass", "warn", "fail")
  pills <- c(status_to_pill(status))
  help <- module_help_content[[module_name]][status]
  table_html <- tibble::tibble(pills = pills, help = help) |>
    kableExtra::kable(format = "html", escape = FALSE, col.names = NULL)

  help_html_content <- glue::glue(
    '<div class="card-face card-back" id="help-{module_name}">
      <p>{main_help}</p>
      {table_html}
      <p><a href="{module_help_content[[module_name]]$link}" target="_blank">See more ></a></p>
    </div>',
  )
  return(help_html_content)
}
