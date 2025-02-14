## Generate ui code
generate_ui_setup_myvariables <- names(myData$data)
a <- c()

for(i in generate_ui_setup_myvariables) {
  a.next <- paste0('uiOutput("ui_setup_verify', i, '")')
  a <- c(a, a.next)
}

ui_setup_variabledesignation <- paste('tagList(',
                                      paste(a, collapse = ",\n"),
                                      ')')

## Write generated code into R script
writeChar(paste0(ui_setup_variabledesignation, collapse = ",\n"), "ui_components/ui_setup_variableverification.R")