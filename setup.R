
if(!exists("afhweiofhwaoiehfio")) {
            afhweiofhwaoiehfio <- 0

  # code formatting
  # {r CODEID, caption="..."}
  # \ref{code:CODEID}
  # library(readr)
  # suppressMessages(devtools::load_all("../github"))

  knitr::opts_chunk$set(
    `attr.source`='.numberLines',
    collapse = TRUE
  )

  hook_output <- knitr::knit_hooks$get("output")
  hook_warning <- knitr::knit_hooks$get("warning")

  # remove ##, wrap long output lines
  knitr::knit_hooks$set(output = function(x, options) {
    x <- knitr:::split_lines(x)
    # x <- gsub("^## ", "", x)
    if (any(nchar(x) > 70)) x <- strwrap(x, width = 70, prefix = "## ")
    x <- paste(x, collapse = "\n")
    hook_output(x, options)

  }, warning = function(x, options) {
    x <- knitr:::split_lines(x)
    x <- gsub("^## ", "", x)
    if (any(nchar(x) > 70)) x <- strwrap(x, width = 70, prefix = "#! ")
    x <- paste(x, collapse = "\n")
    hook_warning(x, options)
  })

#  oldSource <- knitr::knit_hooks$get("source")
#  knitr::knit_hooks$set(source = function(x, options) {
#    x <- oldSource(x, options)
#
#    if(options$echo == FALSE)
#      return(x)
#
#    message(options)
#
#    paste0(
#      '\n\\begingroup\\begin{center}\\codeblock{code:',options$label,'}{',
#      options$caption,
#      '}\\end{center}',
#      x,
#      '\\endgroup\n\\vspace{-18pt}'
#    )
#  })

  knit_table <- function(df, caption = ""){
    df %>%
      dplyr::mutate_all(kableExtra::linebreak, align = 'l') %>%
      kableExtra::kable("latex", booktabs = T, escape = F, caption = caption)
  }

  prGenerator <- function(P) {
    parts <- partitions::listParts(length(P))
    perms <- permutate(seq_along(parts[[1]]))
    function() {
      if(length(perms) == 0) {
        if(length(parts) <= 1)
          # went through all power relations
          return(NULL)
        parts <<- parts[-1]
        perms <<- permutate(seq_along(parts[[1]]))
      }
      eqs <- rapply(parts[[1]], function(i) P[i], how = "replace")
      perm <- perms[1,]
      perms <<- perms[-1,,drop=FALSE]
      newPowerRelation(equivalenceClasses = eqs[perm])
    }
  }
}
