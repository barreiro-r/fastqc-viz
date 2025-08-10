#' Format Numbers with Metric Suffixes (K, M, B, T)
#'
#' This function takes a numeric vector and converts it into a character vector,
#' formatting large numbers with appropriate suffixes for thousands (K),
#' millions (M), billions (B), and trillions (T).
#'
#' @param nums A numeric vector of numbers to format.
#' @param digits An integer specifying the number of decimal places to use. Default is 1.
#'
#' @return A character vector of formatted numbers.
#'
#' @examples
#' format_large_numbers(1234)
#' #> [1] "1 K"
#'
#' format_large_numbers(c(100, 5500, 1200000, -2500000000, 3450000000000))
#' #> [1] "100"    "5 K"  "1 M"  "-2 B" "3 T"
#'
#' format_large_numbers(999999, digits = 2)
#' #> [1] "1.00 M"

format_large_numbers <- function(nums, digits = 0) {
  # Use sapply to apply the formatting logic to each number in the input vector.
  # This makes the function work seamlessly for single values and vectors.
  sapply(
    nums,
    function(num) {
      # Immediately return non-numeric, NA, or non-finite inputs as-is.
      if (!is.numeric(num) || is.na(num) || !is.finite(num)) {
        return(as.character(num))
      }

      # Define the suffixes and their corresponding numeric thresholds in descending order.
      # Using a named vector makes the code clean and easy to extend.
      thresholds <- c(T = 1e12, B = 1e9, M = 1e6, K = 1e3)

      # Loop through the thresholds to find the first one the number meets.
      for (i in seq_along(thresholds)) {
        if (abs(num) >= thresholds[i]) {
          # Divide the number by the threshold value.
          value <- num / thresholds[i]
          # Get the corresponding suffix from the vector names.
          suffix <- names(thresholds)[i]

          # Format the number to the specified number of digits and paste the suffix.
          # The 'nsmall' argument ensures the correct number of decimal places is always shown.
          return(paste(format(round(value, digits), nsmall = digits), suffix))
        }
      }

      # If the number is less than 1000, no suffix is needed.
      # We format it with comma separators for readability.
      # 'nsmall = 0' prevents trailing decimals like "123.0".
      return(format(round(num, digits), nsmall = 0, big.mark = ","))
    },
    USE.NAMES = FALSE
  ) # USE.NAMES = FALSE prevents sapply from naming the output vector.
}
