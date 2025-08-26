##
## 1. Test with a standard, valid input
##
test_that("Function works correctly with valid input", {
  # Create a sample data frame
  gc_table <- data.frame(
    gc_content = c(40, 50, 60),
    count = c(200, 500, 300)
  )
  total_count <- sum(gc_table$count)

  # Set a seed for reproducible random number generation
  set.seed(123)
  results <- process_gc_data(gc_table)

  # --- Test 1.1: Output structure and types ---
  expect_type(results, "list")
  expect_named(results, c("mean", "sd", "normal_distribution_df"))
  expect_s3_class(results$normal_distribution_df, "data.frame")

  # --- Test 1.2: Correctness of calculated statistics ---
  # Expected weighted mean: (40*200 + 50*500 + 60*300) / 1000 = 51
  # Expected weighted variance: sum(w * (x - mean)^2) / (n-1)
  # (200*(40-51)^2 + 500*(50-51)^2 + 300*(60-51)^2) / 999 = 49000 / 999
  expected_mean <- 51
  expected_sd <- sqrt(49000 / 999)

  expect_equal(results$mean, expected_mean)
  expect_equal(results$sd, expected_sd)

  # --- Test 1.3: Structure and content of the output data frame ---
  df <- results$normal_distribution_df
  expect_equal(nrow(df), 100)
  expect_named(df, c("gc_content", "count"))
  expect_equal(df$gc_content, 1:100)
  expect_true(is.numeric(df$count))
  expect_false(any(is.na(df$count))) # No NAs should be present

  # The sum of counts in the new df should be <= the original total count,
  # as some generated values might fall outside the 1-100 range.
  expect_lte(sum(df$count), total_count)
})

##
## 2. Test edge cases
##
test_that("Function handles edge cases gracefully", {
  # Edge Case 2.1: Data frame with only two observations
  gc_table_small <- data.frame(
    gc_content = c(50, 60),
    count = c(1, 1)
  )

  set.seed(42)
  results_small <- process_gc_data(gc_table_small)
  expect_equal(results_small$mean, 55)
  expect_equal(results_small$sd, sqrt(50))
  expect_equal(nrow(results_small$normal_distribution_df), 100)
  expect_lte(sum(results_small$normal_distribution_df$count), 2)
})

##
## 3. Test for expected errors with invalid inputs
##
test_that("Function throws correct errors for invalid inputs", {
  # Error 3.1: Input is not a data frame
  expect_error(
    process_gc_data(list(gc_content = 50, count = 100)),
    "Error: Input must be a data frame."
  )

  # Error 3.2: Missing required columns
  expect_error(
    process_gc_data(data.frame(a = 1, b = 2)),
    "Error: Input data frame must have columns named 'gc_content' and 'count'."
  )

  # Error 3.3: Columns are not numeric
  expect_error(
    process_gc_data(data.frame(gc_content = "50", count = 100)),
    "Error: Both 'gc_content' and 'count' columns must be numeric."
  )

  expect_error(
    process_gc_data(data.frame(gc_content = 50, count = "100")),
    "Error: Both 'gc_content' and 'count' columns must be numeric."
  )

  # Error 3.4: Total count is too small to calculate SD
  expect_error(
    process_gc_data(data.frame(gc_content = 50, count = 1)),
    "Error: The sum of 'count' must be greater than 1 to calculate standard deviation."
  )

  expect_error(
    process_gc_data(data.frame(gc_content = c(50, 60), count = c(0.5, 0.5))),
    "Error: The sum of 'count' must be greater than 1 to calculate standard deviation."
  )
})
