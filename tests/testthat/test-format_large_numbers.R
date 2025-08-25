test_that("format_large_numbers() withtout digits", {
  expect_equal(format_large_numbers(1234), "1 K")
})

test_that("format_large_numbers() with digits", {
  expect_equal(format_large_numbers(1234, digits = 2), "1.23 K")
})

test_that("format_large_numbers() with digits, millions", {
  expect_equal(format_large_numbers(1234567, digits = 2), "1.23 M")
})
