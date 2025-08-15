#' FastQC-viz: Status to Icon
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
#' status_to_icon("pass")
#'
#' @export
status_to_icon <- function(status, add_color = TRUE) {
  fqcviz_colors <- get_color_palette()

  icon_status <- dplyr::case_when(
    status == "pass" ~ "material-symbols:check-circle-rounded",
    status == "warn" ~ "material-symbols:error",
    status == "fail" ~ "material-symbols:cancel"
  )

  icon_status <- paste0("{{< iconify ", icon_status, " >}}")
  if (add_color) {
    icon_status <- paste0(
      '<span style="color:',
      fqcviz_colors[[status]],
      '">',
      icon_status,
      "</span>"
    )
  }
  return(icon_status)
}
