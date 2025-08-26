test_that("check if HTML is created", {
  my_temp_dir <- paste0(
    tempdir(),
    "/test-create_fastqcviz_report/fastqcviz_report"
  )

  create_fastqcviz_report(
    system.file(
      "extdata",
      "SRR622457_2_fastqc.txt",
      package = "fastqcviz",
      mustWork = TRUE
    ),
    output_dir = my_temp_dir,
    embed_resources = FALSE
  )

  expected_files <- c("favicon.svg", "images", "index.html", "styles.css")

  expect_equal(list.files(my_temp_dir), expected_files)

  # Remove created directory
  unlink(my_temp_dir, recursive = TRUE)
})

test_that("check if HTML with embedded resources is created", {
  my_temp_dir <- paste0(
    tempdir(),
    "/test-create_fastqcviz_report/fastqcviz_report-embedded"
  )

  fastqc_file <- system.file(
    "extdata",
    "SRR622457_2_fastqc.txt",
    package = "fastqcviz"
  )

  create_fastqcviz_report(
    fastqc_file,
    output_dir = my_temp_dir,
    embed_resources = TRUE
  )

  expected_files <- c("index.html")

  expect_equal(list.files(my_temp_dir), expected_files)

  # Remove created directory
  unlink(my_temp_dir, recursive = TRUE)
})
