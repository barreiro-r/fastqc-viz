#' FastQC-viz: Status to Pill
#'
#' @description
#' Create HTML header with the Status
#'
#' @details
#' [TODO]
#'
#' @param status character "pass", "warn" or "fail"
#' @param add_color boolean add color
#'
#' @return status
#'
#' @keywords [TODO]
#'
#' @examples
#' create_header()
#'
#' @export
status_to_pill <- function(status) {
  fqcviz_colors <- get_color_palette()

  pill_status <- paste0(
    glue::glue(
      '<span 
      style="
        font-size: 8px;
        display: inline-block;
        padding: 1px;
        background: {fqcviz_colors[stringr::str_c(status,"-light")]};
        width: 40px;
        text-align: center;
        border-radius: 2px;
        border: 1px solid {fqcviz_colors[stringr::str_c(status,"-dark")]};
        color: {fqcviz_colors[stringr::str_c(status,"-dark")]};
        letter-spacing: .75px;
        margin-left: 1px;
      ">
        {toupper(status)}
      </span>'
    )
  )

  return(pill_status)
}
