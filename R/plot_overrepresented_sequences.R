#' FastQC-viz: Plot Overrepresented Sequences
#'
#' @description
#' Create HTML elements for "Overrepresented Sequences". Note: not actually a plot.
#'
#' @param fastqc_data `parse_fastqc()` output
#'
#' @return character, HTML elements for "Overrepresented Sequences" box.
#'
#' @keywords internal
#' @keywords html_formater
#'
#' @examples
#' fastqc_data <- parse_fastqc(system.file("extdata", "SRR622457_2_fastqc.txt", package = "fastqcviz"))
#' plot_overrepresented_sequences(fastqc_data)
#'
#' @export
plot_overrepresented_sequences <- function(fastqc_data) {
  or_data <- fastqc_data$overrepresented_sequences$content

  if (length(or_data) == 0) {
    return(paste0(
      '<p><span id="overrepresented-sequences-count">',
      length(or_data),
      '</span> sequences</p>'
    ))
  }

  or_data |>
    dplyr::mutate(
      percentage = percentage |>
        as.numeric() |>
        scales::percent(accuracy = .1) |>
        stringr::str_remove("\\%"),
      count = format_large_numbers(as.numeric(count), digits = 1) |>
        stringr::str_replace(" (.)$", "<span class=\"unit\">\\1</span>")
    ) |>
    dplyr::rename(
      Sequence = sequence,
      N = count,
      "%" = percentage,
      "Possible Source" = "possible_source"
    ) |>
    kableExtra::kable(
      format = "html",
      escape = FALSE
    )
}
