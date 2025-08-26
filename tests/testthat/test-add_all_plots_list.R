test_that("check if all modules are present", {
  fastqc_data <- parse_fastqc(system.file(
    "extdata",
    "SRR622457_2_fastqc.txt",
    package = "fastqcviz"
  ))

  create_all_plots(fastqc_data, output_dir = "fastqcviz_report")

  expect_equal(
    names(add_all_plots_list(fastqc_data, output_dir = "fastqcviz_report")),
    c(
      "var_header_per_sequence_quality_scores",
      "var_plot_per_sequence_quality_scores",
      "var_header_per_base_sequence_quality",
      "var_plot_per_base_sequence_quality",
      "var_header_per_base_sequence_content",
      "var_plot_per_base_sequence_content",
      "var_header_per_base_n_content",
      "var_plot_per_base_n_content",
      "var_header_per_sequence_gc_content",
      "var_plot_per_sequence_gc_content",
      "var_header_sequence_length_distribution",
      "var_plot_sequence_length_distribution",
      "var_header_sequence_duplication_levels",
      "var_plot_sequence_duplication_levels",
      "var_header_overrepresented_sequences",
      "var_plot_overrepresented_sequences",
      "var_header_adapter_content",
      "var_plot_adapter_content"
    )
  )

  unlink("fastqcviz_report", recursive = TRUE)
})

test_that("check if dir existis", {
  fastqc_data <- parse_fastqc(system.file(
    "extdata",
    "SRR622457_2_fastqc.txt",
    package = "fastqcviz"
  ))

  expect_error(
    add_all_plots_list(
      fastqc_data,
      embed_resources = TRUE,
      output_dir = "XXXXXX"
    )
  )
})

test_that("check if dir existis", {
  fastqc_data <- parse_fastqc(system.file(
    "extdata",
    "SRR622457_2_fastqc.txt",
    package = "fastqcviz"
  ))

  create_all_plots(fastqc_data, output_dir = "fastqcviz_report")

  add_all_plots_list_out <- add_all_plots_list(
    fastqc_data,
    embed_resources = TRUE,
    output_dir = "fastqcviz_report"
  )

  # base64encoded png are huge (2000+ chars)
  expect_equal(
    nchar(add_all_plots_list_out$var_plot_per_sequence_quality_scores) > 200,
    TRUE
  )
})
