# --- Assuming 'theme_set_fastqcviz' is in a file that's been sourced ---
# For a standalone test file, you would uncomment the line below:
# source("path/to/your/theme_set_fastqcviz.R")

# --- Test Suite for theme_set_fastqcviz() ---

test_that("theme_set_fastqcviz correctly updates the global ggplot2 theme", {
  # --- Setup: Save the current theme to restore it later ---
  # This is crucial for testing a function with global side effects.
  # 'on.exit()' ensures the original theme is restored when the test finishes,
  # regardless of whether it passes or fails.
  original_theme <- ggplot2::theme_get()
  on.exit(ggplot2::theme_set(original_theme), add = TRUE)

  # --- Action: Run the function to be tested ---
  theme_set_fastqcviz()

  # --- Verification: Get the new theme and check specific elements ---
  # It's better to check key properties rather than the entire complex object.
  new_theme <- ggplot2::theme_get()

  # Check 1: A simple property change
  expect_equal(new_theme$legend.position, "inside")

  # Check 2: A text property with multiple attributes
  expect_equal(new_theme$plot.title$size, 18)
  expect_equal(new_theme$plot.title$face, "bold")

  # Check 3: The custom font family
  expect_equal(new_theme$text$family, "DM Sans")

  # Check 4: A property that uses a class from ggtext
  expect_s3_class(new_theme$axis.title.x, "element_markdown")

  # Check 5: A property that was explicitly blanked
  expect_s3_class(new_theme$panel.grid.major, "element_blank")
})
