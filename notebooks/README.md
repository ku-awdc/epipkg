These files are r-scripts that are instrumental in developing this package, but
not necessary for users of the package. E.g. prototype of functions in the package.

Notebooks should generally be named:

```
001_name_of_the_notebook.R
```

Where the number prefix `00N` is there to preserve the order of when certain ideas
came up in relations to others.

Inside the notebook, an initial template could look like:

```r
#' ---
#' title: notebook_name
#' author: your_name
#' output: html_document
#' ---
#'
#'
# Mon May 02 11:48:13 2022 ------------------------------

#+ setup, message=FALSE
devtools::load_all()
```

Note that the date-line can be inserted in RStudio using the snippet `ts`, or:

```r
paste("#", date(), "------------------------------\n")
```