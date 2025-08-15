#' Process GC Content Data
#'
#' This function calculates the weighted mean and standard deviation from a data frame
#' containing values ('gc_content') and their frequencies ('count'). It then generates
#' a new data frame with a normally distributed sample based on these statistics.
#'
#' @param data A data frame with two numeric columns: 'gc_content' and 'count'.
#' @return A list containing three elements:
#'         - `mean`: The calculated weighted mean.
#'         - `sd`: The calculated weighted standard deviation.
#'         - `normal_distribution_df`: A new data frame with two columns: 'gc_content'
#'           (integers from 1 to 100) and 'count' (the frequency of each value
#'           based on the generated normal distribution (mode, sd)).
#' @examples
#' # Create a sample data frame
#' gc_table <- data.frame(
#'   gc_content = c(40, 50, 60),
#'   count = c(200, 500, 300)
#' )
#'
#' # Run the function
#' results <- process_gc_data(gc_table)
#'
#' # View the results
#' print(paste("Calculated Mean:", results$mean))
#' print(paste("Calculated SD:", results$sd))
#'
#' # Check the new data frame
#' print("Head of the new normally distributed data frame:")
#' print(head(results$normal_distribution_df))
#'
#' print(paste("Total sum of counts in new df:", sum(results$normal_distribution_df$count)))

process_gc_data <- function(data) {
  # --- Input Validation ---
  # Check if the input is a data frame
  if (!is.data.frame(data)) {
    stop("Error: Input must be a data frame.")
  }
  # Check for the required column names
  if (!all(c("gc_content", "count") %in% names(data))) {
    stop(
      "Error: Input data frame must have columns named 'gc_content' and 'count'."
    )
  }
  # Check if columns are numeric
  if (!is.numeric(data$gc_content) || !is.numeric(data$count)) {
    stop("Error: Both 'gc_content' and 'count' columns must be numeric.")
  }

  # --- Calculations ---
  # Calculate the total number of observations
  total_count <- sum(data$count)

  if (total_count <= 1) {
    stop(
      "Error: The sum of 'count' must be greater than 1 to calculate standard deviation."
    )
  }

  # 1. Calculate the weighted mean
  # The weighted.mean function is ideal for this.
  mean_val <- stats::weighted.mean(data$gc_content, data$count)
  mode_val <- data$gc_content[data$count == max(data$count)]

  # 2. Calculate the weighted standard deviation
  # We use the formula for an unbiased weighted sample variance and take its square root.
  # Variance = sum(w * (x - mean_w)^2) / (sum(w) - 1)
  variance <- sum(data$count * (data$gc_content - mean_val)^2) /
    (total_count - 1)
  sd_val <- sqrt(variance)

  # 3. Generate continuous data from a normal distribution
  # The rnorm() function generates random deviates.
  # normal_data <- rnorm(n = total_count, mean = mean_val, sd = sd_val)
  normal_data <- rnorm(n = total_count, mean = mode_val, sd = sd_val)
  # Don't know why its calculate with the mode, but it is.
  # https://github.com/s-andrews/FastQC/blob/master/uk/ac/babraham/FastQC/Modules/PerSequenceGCContent.java#L144

  # 4. Process the generated data to fit the desired output format
  # Round the continuous data to the nearest integer
  rounded_data <- round(normal_data)

  # Filter the data to be within the 1-100% GC content range
  filtered_data <- rounded_data[rounded_data >= 1 & rounded_data <= 100]

  # Create a frequency table from the filtered data
  counts_table <- as.data.frame(table(filtered_data))
  names(counts_table) <- c("gc_content", "count")

  # Ensure the gc_content column is numeric for merging
  counts_table$gc_content <- as.numeric(as.character(counts_table$gc_content))

  # Create a template data frame with all GC values from 1 to 100
  full_gc_range <- data.frame(gc_content = 1:100)

  # Merge the calculated counts with the full range. 'all.x = TRUE' ensures
  # that all values from 1-100 are kept.
  new_df <- merge(full_gc_range, counts_table, by = "gc_content", all.x = TRUE)

  # Replace NA values (for GC content with no counts) with 0
  new_df$count[is.na(new_df$count)] <- 0

  # --- Return Results ---
  # Return the calculated statistics and the new data frame in a list
  return(list(
    mean = mean_val,
    sd = sd_val,
    normal_distribution_df = new_df
  ))
}
