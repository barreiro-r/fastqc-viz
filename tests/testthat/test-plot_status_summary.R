test_that("check if status summary table is created", {
  fastqc_data <- parse_fastqc(system.file(
    "extdata",
    "SRR622457_2_fastqc.txt",
    package = "fastqcviz"
  ))
  plot_status_summary_output <- plot_status_summary(fastqc_data)

  # Convert to tibble
  plot_status_summary_output <- tidyr::tibble(
    my_line = (plot_status_summary_output |>
      stringr::str_split("\n"))[[1]]
  ) |>
    dplyr::filter(stringr::str_detect(my_line, 'row-title')) |>
    dplyr::mutate(my_line = stringr::str_remove_all(my_line, ' *<[^>]*> *'))

  basic_stats <- c(
    "Basic statistics",
    "Per base sequence quality",
    "Per sequence quality scores",
    "Per base sequence content",
    "Per sequence gc content",
    "Per base n content",
    "Sequence length distribution",
    "Sequence duplication levels",
    "Overrepresented sequences",
    "Adapter content"
  )

  expect_equal(
    plot_status_summary_output$my_line,
    basic_stats
  )
})
