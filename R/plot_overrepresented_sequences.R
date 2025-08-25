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
  paste0(
    '<p><span id="overrepresented-sequences-count">',
    length(fastqc_data$overrepresented_sequences$content),
    '</span> sequences</p>'
  )
}
