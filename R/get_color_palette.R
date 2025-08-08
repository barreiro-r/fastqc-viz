#' FastQC-viz: Get color palette
#'
#' @description
#' [TODO]
#'
#' @details
#' [TODO]
#'
#' @param NULL
#'
#' @return list with colors
#'
#' @keywords [TODO]
#'
#' @examples
#' fqcviz_colors <- get_color_palette()
#'
#' @export
get_color_palette <- function() {
  color <- list(
    "blue0" = "#070C4B",
    "blue1" = "#1d2482",
    "blue2" = "#333dbe",
    "blue3" = "#555cdd",
    "blue4" = "#898de0",
    "blue5" = "#dadcfe",

    "warm_grey0" = "#443e36ff",
    "warm_grey1" = "#65533aff",
    "warm_grey2" = "#8f7a59ff",
    "warm_grey3" = "#ae9878ff",
    "warm_grey4" = "#c4b49fff",
    "warm_grey5" = "#e7e2dbff",

    "pass-light" = "#afe0b7ff",
    "pass" = "#4ba359ff",
    "pass-dark" = "#2f6638ff",
    "warn-light" = "#e8d28fff",
    "warn" = "#eab30dff",
    "warn-dark" = "#8d6c08ff",
    "fail-light" = "#f0c6bcff",
    "fail" = "#d65d3eff",
    "fail-dark" = "#862a13ff"
  )

  return(color)
}
