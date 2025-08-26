test_that("check if per_sequence_gc_content plot was created", {
  fastqc_data <- parse_fastqc(system.file(
    "extdata",
    "SRR622457_2_fastqc.txt",
    package = "fastqcviz"
  ))
  my_plot <- plot_per_sequence_gc_content(fastqc_data)

  # test if my_lot is a plot
  expect_true(ggplot2::is_ggplot(my_plot))
})
