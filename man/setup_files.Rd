\name{setup_files}
\alias{setup_files}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Sets up the beginning files for a project.
}
\description{
Appends info given by user in dialog box to the starting parts of R markdown files.
}
\usage{
setup_files(path, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{path}{
  Path that is passed to the function by the dialog box. Concatenates the string values from 'Directory name:' and 'Create project as subdirectory of:'.
  }
  \item{...}{
  Additional arguments passed by widgets in the dialog box that is defined by 'PCMP_rstudio_template.dcf'.
  }
}
\details{
The path arg is defined by internal Rstudio project template code.
}
\references{
https://rstudio.github.io/rstudio-extensions/rstudio_project_templates.html
}
\author{
Scott G. Daniel <danielsg@email.chop.edu>
}
