test_that("check if header is created properly", {
  fastqc_data <- parse_fastqc(system.file(
    "extdata",
    "SRR622457_2_fastqc.txt",
    package = "fastqcviz"
  ))
  expect_equal(
    create_header(fastqc_data, "per_base_sequence_quality"),
    "<h1><span class=\"pill\" \nstyle=\"\n  background: #afe0b7ff;\n  border: 1px solid #2f6638ff;\n  color: #2f6638ff;\n\">\n  PASS\n</span> Per base sequence quality</h1>"
  )
})
