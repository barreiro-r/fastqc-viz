##
## 1. Test with color enabled (default behavior)
##
test_that("Function generates correct HTML with color by default", {
  # Test "pass" status
  expected_pass <- '<span style="color:#4ba359ff">{{< iconify material-symbols:check-circle-rounded >}}</span>'
  expect_equal(status_to_icon("pass"), expected_pass)
  expect_equal(status_to_icon("pass", add_color = TRUE), expected_pass)

  # Test "warn" status
  expected_warn <- '<span style="color:#eab30dff">{{< iconify material-symbols:error >}}</span>'
  expect_equal(status_to_icon("warn"), expected_warn)

  # Test "fail" status
  expected_fail <- '<span style="color:#d65d3eff">{{< iconify material-symbols:cancel >}}</span>'
  expect_equal(status_to_icon("fail"), expected_fail)
})


##
## 2. Test with color disabled
##
test_that("Function generates correct shortcode when add_color is FALSE", {
  # Test "pass" status without color
  expected_pass_no_color <- "{{< iconify material-symbols:check-circle-rounded >}}"
  expect_equal(
    status_to_icon("pass", add_color = FALSE),
    expected_pass_no_color
  )

  # Test "warn" status without color
  expected_warn_no_color <- "{{< iconify material-symbols:error >}}"
  expect_equal(
    status_to_icon("warn", add_color = FALSE),
    expected_warn_no_color
  )

  # Test "fail" status without color
  expected_fail_no_color <- "{{< iconify material-symbols:cancel >}}"
  expect_equal(
    status_to_icon("fail", add_color = FALSE),
    expected_fail_no_color
  )
})
