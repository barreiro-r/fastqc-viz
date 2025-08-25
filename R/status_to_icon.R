#' FastQC-viz: Status to Icon
#'
#' @description
#' Create HTML header with the Status
#'
#' @details
#' This function generates an HTML `<span>` element styled to look like a status
#' pill or badge, similar to those used in the FastQC report interface.
#'
#' The appearance of the pill is determined by the `status` argument:
#' - **`"pass"`**: Typically styled in green.
#' - **`"warn"`**: Typically styled in yellow.
#' - **`"fail"`**: Typically styled in red.
#'
#' @param status character "pass", "warn" or "fail"
#' @param add_color boolean add color
#'
#' @return status
#'
#' @keywords html_formater decrepted
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
