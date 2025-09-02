test_that("check if list has only empty elements if add_help is false", {
  all_modules <- c(
    "help_per_sequence_quality_scores",
    "help_per_base_sequence_quality",
    "help_per_base_sequence_content",
    "help_per_base_n_content",
    "help_per_sequence_gc_content",
    "help_sequence_length_distribution",
    "help_sequence_duplication_levels",
    "help_overrepresented_sequences",
    "help_adapter_content"
  )

  add_help_false = add_all_help(add_help = FALSE)

  expect_equal(names(add_help_false), all_modules)

  for (i in all_modules) {
    expect_equal(add_help_false[[i]], "")
  }
})


test_that("check if list has all elements if add_help is true", {
  all_modules <- c(
    "help_per_sequence_quality_scores",
    "help_per_base_sequence_quality",
    "help_per_base_sequence_content",
    "help_per_base_n_content",
    "help_per_sequence_gc_content",
    "help_sequence_length_distribution",
    "help_sequence_duplication_levels",
    "help_overrepresented_sequences",
    "help_adapter_content"
  )

  add_help_false = add_all_help(add_help = TRUE)

  expect_equal(names(add_help_false), all_modules)
})
