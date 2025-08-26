test_that("check if HTML is created", {
  my_temp_dir <- paste0(
    tempdir(),
    "/test-create_fastqcviz_report/fastqcviz_report"
  )

  create_fastqcviz_report(
    system.file("extdata", "SRR622457_2_fastqc.txt", package = "fastqcviz"),
    output_dir = my_temp_dir,
    embed_resources = FALSE
  )

  expected_files <- c("favicon.svg", "images", "index.html", "styles.css")

  expect_equal(list.files(my_temp_dir), expected_files)
  unlink(my_temp_dir, recursive = TRUE)
})

test_that("check if HTML with embedded resources is created", {
  my_temp_dir <- paste0(
    tempdir(),
    "/test-create_fastqcviz_report_fastqcviz_report-embedded"
  )

  create_fastqcviz_report(
    system.file("extdata", "SRR622457_2_fastqc.txt", package = "fastqcviz"),
    output_dir = my_temp_dir,
    embed_resources = TRUE
  )

  expected_files <- c("images", "index.html")

  expect_equal(list.files(my_temp_dir), expected_files)

  # Remove created directory
  unlink(my_temp_dir, recursive = TRUE)
})
