test_that("check if all plots were created", {
  fastqc_data <- parse_fastqc(system.file(
    "extdata",
    "SRR622457_2_fastqc.txt",
    package = "fastqcviz"
  ))

  my_temp_dir = paste0(tempdir(), "/test-create_all_plots/fastqcviz_report")
  create_all_plots(fastqc_data, my_temp_dir)

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
    list.files(paste0(my_temp_dir, '/images/plots')),
    expected_files
  )

  unlink(my_temp_dir, recursive = TRUE)
})
