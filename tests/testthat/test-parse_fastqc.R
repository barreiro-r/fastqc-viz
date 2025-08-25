test_that("check all modules", {
  expect_equal(
    names(parse_fastqc(system.file(
      "extdata",
      "SRR622457_2_fastqc.txt",
      package = "fastqcviz"
    ))),
    c(
      "basic_statistics",
      "per_base_sequence_quality",
      "per_sequence_quality_scores",
      "per_base_sequence_content",
      "per_sequence_gc_content",
      "per_base_n_content",
      "sequence_length_distribution",
      "sequence_duplication_levels",
      "overrepresented_sequences",
      "adapter_content",
      "comments"
    )
  )
})
