test_that("test pill fail", {
  expect_equal(
    status_to_pill("fail"),
    "<span class=\"pill\" \nstyle=\"\n  background: #f0c6bcff;\n  border: 1px solid #862a13ff;\n  color: #862a13ff;\n\">\n  FAIL\n</span>"
  )
})

test_that("test pill pass", {
  expect_equal(
    status_to_pill("pass"),
    "<span class=\"pill\" \nstyle=\"\n  background: #afe0b7ff;\n  border: 1px solid #2f6638ff;\n  color: #2f6638ff;\n\">\n  PASS\n</span>"
  )
})

test_that("test pill warn", {
  expect_equal(
    status_to_pill("warn"),
    "<span class=\"pill\" \nstyle=\"\n  background: #e8d28fff;\n  border: 1px solid #8d6c08ff;\n  color: #8d6c08ff;\n\">\n  WARN\n</span>"
  )
})
