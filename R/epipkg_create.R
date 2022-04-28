## IGNORE THIS FILE FOR NOW

# These are the old functions from tidypkg, which Matt will clean up for epipkg once we are happy with the basic structure

tidy_pkg <- function(package, data=FALSE, R6=FALSE, cpp=c("no","simple","class")[1],
                   makefile=cpp %in% c("simple","class"),
                   license=c("GPL3","CC0","CCBY","MIT","APL")[1],
                   logo=NULL, depends = NULL, imports = NULL,
                   suggests = NULL) {

  startwd <- getwd()
  on.exit( setwd(startwd) )

  descr <- getOption("usethis.description")
  aut <- eval(parse(text=descr$`Authors@R`))

  cat("Creating a package called '", package, "' for ", format(aut, c("given","family","email")), "\n", sep="")
  
  # TODO: package description doesn't have date
  
  # TODO: if we are in a folder called package then setwd("../")
  if(dir.exists(package)){
    # Check this folder (just) contains .git
  }else{
    dir.create(package)
  }
  output <- tmpkg(package)
  cat(output, sep='\n')

  # TODO:  set up the .Rproj the way we like it i.e. spaces for tabs, XeLateX etc

  setwd(package)

  for(pkg in depends)
    use_package(pkg, type="Depends")
  for(pkg in imports)
    use_package(pkg, type="Imports")
  for(pkg in suggests)
    use_package(pkg, type="Suggests")

  # Standard stuff:
  use_package_doc()
  use_roxygen_md()
  use_testthat()
  use_test("example")
  use_vignette(package)

  # TODO: manually add NEWS.md as it won't let us do it with non-committed changes

  # Need to create WORDLIST otherwise we get input needed:
  use_directory("inst")
  cat("gh\n", file="inst/WORDLIST", append=TRUE)
  use_spell_check(lang = "en-GB")

  # Create directories we like to have:
  use_directory("notebooks")
  use_directory("reports")
  # TODO: add example .R and .Rmd files to these
  
  # TODO: change/add rmarkdown to markdown in suggests (https://github.com/yihui/knitr/issues/1864)

  if(data)
    use_data_raw()
  if(!is.null(logo))
    use_logo()


  if(license == "GPL3"){
    use_gpl3_license()
  }else if(license == "CC0"){
    use_cc0_license()
  }else if(license == "CCBY"){
    use_ccby_license()
  }else if(license == "MIT"){
    use_mit_license()
  }else if(license == "APL"){
    use_apl2_license()
  }else{
    stop("Unrecognised license type")
  }

  # TODO: Add example .R file, test file, vignette

  if(R6){
    stop("R6 support is not yet implemented")

    use_package("R6", type="Imports")
  }

  if(cpp != "no"){
    stop("Rcpp support not yet implemented")

    use_rcpp()
    # And change importFrom Rcpp to import Rcpp

    if(makefile)
      use_make()

    # TODO: copy files based on what kind of Rcpp

  }

  # Things to document but not use:
  if(FALSE){
    use_citation()
    use_build_ignore()
    use_package(pkg, type="Suggests")
  }

  # TODO:  suppress all the output above but give instructions
  # Maybe open a vignette?

  # At the end launch the new project:
  proj_activate(getwd())

}


# A separate function just to create the basic structure in a temporary directory:
tmpkg <- function(package){

  td <- tempdir(check=TRUE)
  tf <- tempfile("tf", tmpdir=td)
  dir.create(file.path(td,tf), recursive=TRUE)
  oldwd <- getwd()

  on.exit({ setwd(oldwd); unlink(file.path(td,tf),recursive=TRUE) })
  print(file.path(td,tf))

  setwd(file.path(td,tf))
  output <- capture.output(create_package(package, fields=list(Version = "0.1.0-1"), rstudio=TRUE, open=FALSE))

  ftm <- list.files(file.path(td,tf,package), all.files=TRUE, recursive=TRUE, include.dirs=TRUE)

  if(dir.exists(file.path(oldwd,package)) && any(ftm %in% list.files(file.path(oldwd,package)))){
    stop("Unable to copy package contents without overwriting existing files")
  }

  success <- file.copy(file.path(td,tf,package), oldwd, recursive=TRUE, overwrite=FALSE)

  if(any(!success))
    warning("Failed to copy file(s) from tempdir")

  return(output)
}


#.onAttach <- function(lib, pkg)
#{
#    packageStartupMessage("Welcome to tidypkg!\nTo get started see ?tidy_pkg - and remember fortunes::fortune(52) :")
#	packageStartupMessage("
#> Can one be a good data analyst without being a half-good programmer?
#> The short answer to that is, 'No.'
#> The long answer to that is, 'No.'
#>   -- Frank Harrell
#>      1999 S-PLUS User Conference, New Orleans (October 1999)
#")
#}
