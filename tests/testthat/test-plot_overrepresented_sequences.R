test_that("check if its a html element", {
  fastqc_data <- parse_fastqc(system.file(
    "extdata",
    "SRR622457_2_fastqc.txt",
    package = "fastqcviz"
  ))
  plot_overrepresented_sequences(fastqc_data) |>
    # Keep only first and last character
    stringr::str_replace('(.).*(.)', "\\1\\2") |>
    expect_equal("<>")
})
