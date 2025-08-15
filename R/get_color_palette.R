#' FastQC-viz: Get color palette
#'
##' @description
#' Fetches the official color palette used for plots and visualizations within
#' the FastQC-viz package.
#'
#' @details
#' This function provides a consistent set of colors for visualizations. The
#' palette includes sequential schemes (blues, warm greys) and a standard set
#' of qualitative colors to represent FastQC status reports:
#' \itemize{
#'   \item **Pass**: Green tones
#'   \item **Warn**: Yellow/Orange tones
#'   \item **Fail**: Red tones
#' }
#' Each status color is available in a standard, `light`, and `dark` variant.
#'
#' @return A named `list` where keys are color names (e.g., `"pass-dark"`) and
#'   values are their corresponding hexadecimal color codes.
#'
#' @keywords internal
#'
#' @examples
#' # Get the entire color palette
#' fqcviz_colors <- get_color_palette()
#'
#' # You can then access specific colors by name
#' my_pass_color <- fqcviz_colors$pass
#' my_fail_color <- fqcviz_colors[["fail-dark"]]
#'
#' print(my_pass_color)
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
