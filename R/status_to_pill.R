#' FastQC-viz: Status to Pill
#'
#' @description
#' Constructs a string containing an HTML `<span>` element with inline CSS to
#' render a status indicator badge.
#'
#' @details
#' This is a helper function that translates a status string ("pass", "warn",
#' or "fail") into a formatted HTML element. The function's primary logic is
#' string interpolation via the `glue` package.
#'
#' The visual appearance of the `<span>` is defined entirely by inline CSS and
#' includes properties for font size, padding, background color, border, text
#' color, and spacing.
#'
#' @param status character "pass", "warn" or "fail"
#' @param add_color boolean add color
#'
#' @return status
#'
#' @keywords html_formater
#' @keywords internal
#'
#' @examples
#' status_to_pill("pass")
#'
#' @export
status_to_pill <- function(status, add_color = TRUE) {
  fqcviz_colors <- get_color_palette()

  pill_status <- paste0(
    glue::glue(
      '<span class="pill" 
      style="
        background: {fqcviz_colors[stringr::str_c(status,"-light")]};
        border: 1px solid {fqcviz_colors[stringr::str_c(status,"-dark")]};
        color: {fqcviz_colors[stringr::str_c(status,"-dark")]};
      ">
        {toupper(status)}
      </span>'
    )
  )

  return(pill_status)
}
