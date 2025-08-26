test_that("check if sequence_duplication_levels plot was created", {
  fastqc_data <- parse_fastqc(system.file(
    "extdata",
    "SRR622457_2_fastqc.txt",
    package = "fastqcviz"
  ))
  my_plot <- plot_sequence_duplication_levels(fastqc_data)

  # test if my_lot is a plot
  expect_true(ggplot2::is_ggplot(my_plot))
})
