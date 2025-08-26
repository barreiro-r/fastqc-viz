test_that("check if basic statistic table is created", {
  fastqc_data <- parse_fastqc(system.file(
    "extdata",
    "SRR622457_2_fastqc.txt",
    package = "fastqcviz"
  ))
  plot_basic_statistics_output <- plot_basic_statistics(fastqc_data)

  # Convert to tibble
  plot_basic_statistics_output <- tidyr::tibble(
    my_line = (plot_basic_statistics_output |>
      stringr::str_split("\n"))[[1]]
  )

  # Check if every <td> element has a <span> and some text after it
  plot_basic_statistics_output |>
    dplyr::filter(stringr::str_detect(
      string = my_line,
      pattern = ".*<td.*<span.*</span>..*</td>.*"
    )) |>
    nrow() |>
    expect_equal(8)
})
