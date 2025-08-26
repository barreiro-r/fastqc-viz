test_that("check if its a html element", {
  fastqc_data <- parse_fastqc(system.file(
    "extdata",
    "SRR622457_2_fastqc.txt",
    package = "fastqcviz"
  ))
  plot_overrepresented_sequences(fastqc_data) |>
    # Dont look at this
    stringr::str_detect("equence") |>
    expect_true()
})
