## generate server code for variable stuff
aa <- paste0('output$ui_setup_verify',
             generate_ui_setup_myvariables,
             '<- renderUI({
                  tagList(
                      h4(paste0("Variable: ", "',
             generate_ui_setup_myvariables,
             '")),
                      fluidRow(
                        column(width = 4,
                               selectInput(paste0("server_setup_classdes", "',
             generate_ui_setup_myvariables,
             '"),
                                           label = "Variable Type", 
                                           choices = c("Character", "Numeric", "Integer", "Logical", "Factor", "Date"),
                                           selected = "Character",
                                           multiple = FALSE)),
                        column(width = 8, 
                               textInput(paste0("server_setup_attributedescription", "',
             generate_ui_setup_myvariables,
             '"), 
                                         label = "Detailed Description of Variable"))
                    )
                  )
             })')

## Write generated server code into R script
writeChar(paste(aa, collapse = "\n"), "server_components/server_setup_variableverification.R")