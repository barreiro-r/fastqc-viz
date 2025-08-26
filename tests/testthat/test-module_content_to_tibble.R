test_that("check if all module content is a tibble", {
  lines <- readLines(system.file(
    "extdata",
    "SRR622457_2_fastqc.txt",
    package = "fastqcviz"
  ))
  modules <- separate_modules(lines)
  modules <- module_content_to_tibble(modules)

  # Remove comments from the list
  modules <- modules[names(modules) != "comments"]

  # Check if for all module content is a tibble
  for (module in names(modules)) {
    expect_true(is.data.frame(modules[[module]]$content))
  }
})
