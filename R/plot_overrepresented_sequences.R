#' FastQC-viz: Overrepresented Sequences
#'
#' @description
#' Create plot for "Overrepresented Sequences"
#'
#' @details
#' Create plot for "Overrepresented Sequences"
#'
#' @param fastqc_data output from parse_fastqc()
#'
#' @return html character
#'
#' @keywords plot
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
