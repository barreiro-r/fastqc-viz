##
## 1. Test with standard, valid input
##
test_that("Function correctly parses a typical FastQC file structure", {
  # Create a mock character vector simulating readLines() output
  mock_lines <- c(
    "##FastQC Report",
    ">>Basic Statistics\tpass",
    "#Measure\tValue",
    "Filename\tfile.fq",
    ">>END_MODULE",
    ">>Per base sequence quality\twarn",
    "#Base\tMean\tMedian",
    "1\t35.1\t36",
    "2\t34.8\t35",
    ">>END_MODULE"
  )

  # Run the function
  modules <- separate_modules(mock_lines)

  # --- Test 1.1: Overall output structure ---
  expect_type(modules, "list")
  expect_named(
    modules,
    c("basic_statistics", "per_base_sequence_quality", "comments")
  )

  # --- Test 1.2: Content of a specific module ('basic_statistics') ---
  basic_stats <- modules$basic_statistics
  expect_type(basic_stats, "list")
  expect_named(basic_stats, c("content", "status"))
  expect_equal(basic_stats$status, "pass")
  expect_equal(
    basic_stats$content,
    c("#Measure\tValue", "Filename\tfile.fq")
  )

  # --- Test 1.3: Content of another module to check name conversion ---
  # 'Per base sequence quality' should become 'per_base_sequence_quality'
  per_base_qual <- modules$per_base_sequence_quality
  expect_type(per_base_qual, "list")
  expect_equal(per_base_qual$status, "warn")
  expect_equal(
    per_base_qual$content,
    c("#Base\tMean\tMedian", "1\t35.1\t36", "2\t34.8\t35")
  )

  # --- Test 1.4: Check 'comments' section ---
  expect_type(modules$comments, "character")
  expect_equal(modules$comments, "##FastQC Report")
})


##
## 2. Test for expected errors with invalid inputs
##
test_that("Function throws an error for non-atomic input", {
  # Error 3.1: Input is a list
  expect_error(
    separate_modules(list("line1", "line2")),
    "Error: Input must be a character vector."
  )

  # Error 3.2: Input is a data frame
  expect_error(
    separate_modules(data.frame(lines = "line1")),
    "Error: Input must be a character vector."
  )
})
