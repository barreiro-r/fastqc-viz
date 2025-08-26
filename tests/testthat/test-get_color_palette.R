test_that("multiplication works", {
  fqcviz_colors <- get_color_palette()

  # Test if all values are color hex codes
  expect_true(all(grepl(
    "^#([a-fA-F0-9]{6}|[a-fA-F0-9]{3}|[a-fA-F0-9]{8})$",
    fqcviz_colors
  )))
})
