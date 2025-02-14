output$ui_darwincore_verifylat<- renderUI({
                  tagList(
                      h4(paste0("Variable: ", "lat")),
                      fluidRow(
                        column(width = 4,
                               selectInput(paste0("server_darwincore_classdes", "lat"),
                                           label = "Variable Type", 
                                           choices = c("Character", "Numeric", "Integer", "Logical", "Factor", "Date"),
                                           selected = "Character",
                                           multiple = FALSE)),
                        column(width = 8, 
                               textInput(paste0("server_darwincore_attributedescription", "lat"), 
                                         label = "Detailed Description of Variable"))
                    )
                  )
             })
output$ui_darwincore_verifylong<- renderUI({
                  tagList(
                      h4(paste0("Variable: ", "long")),
                      fluidRow(
                        column(width = 4,
                               selectInput(paste0("server_darwincore_classdes", "long"),
                                           label = "Variable Type", 
                                           choices = c("Character", "Numeric", "Integer", "Logical", "Factor", "Date"),
                                           selected = "Character",
                                           multiple = FALSE)),
                        column(width = 8, 
                               textInput(paste0("server_darwincore_attributedescription", "long"), 
                                         label = "Detailed Description of Variable"))
                    )
                  )
             })
output$ui_darwincore_verifydepth<- renderUI({
                  tagList(
                      h4(paste0("Variable: ", "depth")),
                      fluidRow(
                        column(width = 4,
                               selectInput(paste0("server_darwincore_classdes", "depth"),
                                           label = "Variable Type", 
                                           choices = c("Character", "Numeric", "Integer", "Logical", "Factor", "Date"),
                                           selected = "Character",
                                           multiple = FALSE)),
                        column(width = 8, 
                               textInput(paste0("server_darwincore_attributedescription", "depth"), 
                                         label = "Detailed Description of Variable"))
                    )
                  )
             })
output$ui_darwincore_verifymag<- renderUI({
                  tagList(
                      h4(paste0("Variable: ", "mag")),
                      fluidRow(
                        column(width = 4,
                               selectInput(paste0("server_darwincore_classdes", "mag"),
                                           label = "Variable Type", 
                                           choices = c("Character", "Numeric", "Integer", "Logical", "Factor", "Date"),
                                           selected = "Character",
                                           multiple = FALSE)),
                        column(width = 8, 
                               textInput(paste0("server_darwincore_attributedescription", "mag"), 
                                         label = "Detailed Description of Variable"))
                    )
                  )
             })
output$ui_darwincore_verifystations<- renderUI({
                  tagList(
                      h4(paste0("Variable: ", "stations")),
                      fluidRow(
                        column(width = 4,
                               selectInput(paste0("server_darwincore_classdes", "stations"),
                                           label = "Variable Type", 
                                           choices = c("Character", "Numeric", "Integer", "Logical", "Factor", "Date"),
                                           selected = "Character",
                                           multiple = FALSE)),
                        column(width = 8, 
                               textInput(paste0("server_darwincore_attributedescription", "stations"), 
                                         label = "Detailed Description of Variable"))
                    )
                  )
             })
output$ui_darwincore_verifymulticlass<- renderUI({
                  tagList(
                      h4(paste0("Variable: ", "multiclass")),
                      fluidRow(
                        column(width = 4,
                               selectInput(paste0("server_darwincore_classdes", "multiclass"),
                                           label = "Variable Type", 
                                           choices = c("Character", "Numeric", "Integer", "Logical", "Factor", "Date"),
                                           selected = "Character",
                                           multiple = FALSE)),
                        column(width = 8, 
                               textInput(paste0("server_darwincore_attributedescription", "multiclass"), 
                                         label = "Detailed Description of Variable"))
                    )
                  )
             })