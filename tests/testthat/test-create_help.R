test_that("test if all modules can are created", {
  all_modules <- c(
    "per_sequence_quality_scores",
    "per_base_sequence_quality",
    "per_base_sequence_content",
    "per_base_n_content",
    "per_sequence_gc_content",
    "sequence_length_distribution",
    "sequence_duplication_levels",
    "overrepresented_sequences",
    "adapter_content"
  )

  for (module in all_modules) {
    expect_true(create_help(module) != "")
  }

  # return empty if not found
  expect_error(
    create_help("not_a_module"),
    "Error: 'not_a_module' module not found"
  )
})
