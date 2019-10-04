# This function will be called when the user invokes
# the New Project wizard using the project template defined in the template file
# at:
#
#   inst/rstudio/templates/project/PCMP_rstudio_template.dcf

setup_files <- function(path, ...) {

  # ensure path exists
  dir.create(path, recursive = TRUE, showWarnings = FALSE)

  # generate header
  header <- c(
    "---"
  )

  title: "Basic Bioinformatics Overview"
  author: "PennCHOP Microbiome Program"
  # collect inputs
  dots <- list(...)
  text <- lapply(seq_along(dots), function(i) {
    key <- names(dots)[[i]]
    val <- dots[[i]]
    paste0(key, ": ", val)
  })

  title <- dots["title"]
  author <- dots["author"]
  prj_type <- dots["prj_type"]

  # collect into single text string
  contents <- paste(
    paste(header, collapse = "\n"),
    paste(text, collapse = "\n"),
    sep = "\n"
  )

  # write to log file
  writeLines(dots, con = file.path(path, "creation_log"))

  rmarkdown::draft(paste0(title,".Rmd"), template = "boilerplate", package = "basicTemplate", edit = F, create_dir = T)

  if(prj_type == "16S") {
    temp <- readLines(con = file.path(title,"mother_qiime2_TagSequencingReport.Rmd"))
    actual_report <- paste(
      paste(contents, collapse = "\n"),
      paste(temp, collapse = "\n"),
      sep = "\n"
    )
    writeLines(actual_report, con = file.path(path, paste0(title,".Rmd")))
  }

  if(prj_type == "WGS") {
    temp <- readLines(con = file.path(title,"mother_shotgun_report.Rmd"))
    actual_report <- paste(
      paste(contents, collapse = "\n"),
      paste(temp, collapse = "\n"),
      sep = "\n"
    )
    writeLines(actual_report, con = file.path(path, paste0(title,".Rmd")))
  }

  #copy all the supporting files from the template
  system(paste0("cp -R -n ", file.path(title), "/* ", file.path(path)), wait = T)
  #file.copy(from = file.path(title), to = file.path(path),
  #          recursive = T, overwrite = F)

  #remove the originals (unless you want a lot of unnecessary clutter!)
  #system(paste0("rm -rf ", file.path(title)))
  unlink(file.path(title), recursive = T, force = T)

  #apologies for using a mix of base R and a system command for these two
  #couldn't get the file.copy to work nicely for me

}
