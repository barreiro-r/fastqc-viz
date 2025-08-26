test_that("check if HTML is created", {
  create_fastqcviz_report(
    system.file("extdata", "SRR622457_2_fastqc.txt", package = "fastqcviz"),
    output_dir = "fastqcviz_report",
    embed_resources = FALSE
  )

  expected_files <- c("favicon.svg", "images", "index.html", "styles.css")

  expect_equal(list.files('fastqcviz_report'), expected_files)
  unlink("fastqcviz_report", recursive = TRUE)
})

test_that("check if HTML with embedded resources is created", {
  create_fastqcviz_report(
    system.file("extdata", "SRR622457_2_fastqc.txt", package = "fastqcviz"),
    output_dir = "fastqcviz_report_embedded",
    embed_resources = TRUE
  )

  expected_files <- c("images", "index.html")

  expect_equal(list.files('fastqcviz_report_embedded'), expected_files)

  # Remove created directory
  unlink("fastqcviz_report_embedded", recursive = TRUE)
})
