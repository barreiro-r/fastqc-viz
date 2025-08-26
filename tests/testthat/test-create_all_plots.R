test_that("check if all plots were created", {
  fastqc_data <- parse_fastqc(system.file(
    "extdata",
    "SRR622457_2_fastqc.txt",
    package = "fastqcviz"
  ))

  create_all_plots(fastqc_data, 'fastqcviz_report')

  expected_files <- c(
    "adapter_content.png",
    "per_base_n_content.png",
    "per_base_sequence_content.png",
    "per_base_sequence_quality.png",
    "per_sequence_gc_content.png",
    "per_sequence_quality_scores.png",
    "sequence_duplication_levels.png",
    "sequence_length_distribution.png"
  )

  expect_equal(
    list.files('fastqcviz_report/images/plots'),
    expected_files
  )

  unlink("fastqcviz_report", recursive = TRUE)
})
