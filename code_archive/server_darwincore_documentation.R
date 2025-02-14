# output for documentation section in the server_darwincore file
output$ui_darwincore_documentation <- renderUI({
  
  server_darwincore_metadata <- tagList()
  
  server_darwincore_metadata <- tagList(
    h1("Dataset Documentation"),
    fluidRow(
      column(width = 6,
             h4("General Information"),
             # Input for project title
             textInput("server_darwincore_projecttitle",
                       label = "Project Title",
                       value = "No Title Provided"),
             # input for funding information
             textInput("server_darwincore_fundinginformation",
                       label = "Funding Information"),
             # Input for dataset title
             textInput("server_darwincore_datasettitle",
                       label = "Dataset Title",
                       value = "No Title Provided"),
             # input for dataset description/abstract
             textInput("server_darwincore_abstract",
                       label = "Description of Dataset",
                       value = "No Description Provided"),
             textInput("server_darwincore_intellectualrights",
                       label = "Description of Intellectual Rights"),
             helpText("here is where i'll have people enter keywords, need to look more at the keyword libraries - might be select input"),
             textInput("server_darwincore_datasetkeywords",
                       label = "Keywords"),
             selectInput("server_darwincore_datasetlanguage",
                         label = "Dataset Language",
                         choices = c("i'll put in ISO names/codes here later")),
             textInput("server_darwincore_additionaldatasetinfo",
                       label = "Additional Information"),
             numericInput("server_darwincore_nassociatedparties", label = "Number of Associated Parties", min = 1, 1)),
      column(width = 3,
             h4("Dataset Creator"),
             textInput("server_darwincore_creatorindividualname",
                       label = "Individual Name"),
             textInput("server_darwincore_creatororganization",
                       label = "Organization"),
             textInput("server_darwincore_creatoraddress",
                       label = "Address"),
             textInput("server_darwincore_creatorcity",
                       label = "City"),
             textInput("server_darwincore_creatorprovince",
                       label = "Province or State"),
             textInput("server_darwincore_creatorpostalcode",
                       label = "Postal Code"),
             textInput("server_darwincore_creatorcountry",
                       label = "Country"),
             textInput("server_darwincore_creatorphone",
                       label = "Phone"),
             textInput("server_darwincore_creatoremail",
                       label = "Email"),
             textInput("server_darwincore_creatorurl",
                       label = "Personal Website")),
      column(width = 3,
             h4("Dataset Contact"),
             textInput("server_darwincore_contactindividualname",
                       label = "Individual Name"),
             textInput("server_darwincore_contactorganization",
                       label = "Organization"),
             textInput("server_darwincore_contactaddress",
                       label = "Address"),
             textInput("server_darwincore_contactcity",
                       label = "City"),
             textInput("server_darwincore_contactprovince",
                       label = "Province or State"),
             textInput("server_darwincore_contactpostalcode",
                       label = "Postal Code"),
             textInput("server_darwincore_contactcountry",
                       label = "Country"),
             textInput("server_darwincore_contactphone",
                       label = "Phone"),
             textInput("server_darwincore_contactemail",
                       label = "Email"),
             textInput("server_darwincore_contacturl",
                       label = "Personal Website"))
    ),
    uiOutput("server_darwincore_associatedparties"),
    br(),
    h2("Methods Documentation"),
    fluidRow(
      column(width = 4,
             textInput("server_darwincore_studyarea",
                       label = "Description of Study Area"),
             textInput("server_darwincore_studydesign",
                       label = "Description of Study Design"),
             selectInput("server_darwincore_coverageselection",
                         label = "Select Coverage Type Required",
                         choices = c("Taxonomic", "Geographical", "Temporal"),
                         multiple = TRUE)),
      column(width = 8,
             p("here is where all of the more detailed steps of the methods will go"))),
    h2("Variable Descriptions")
  )
  
  # This generates the output for the number of associated parties indicated above
  output$server_darwincore_associatedparties <- renderUI({
    
    server_darwincore_associatedinfo <- tagList()
    
    for(i in seq_len(input$server_darwincore_nassociatedparties)) {
      server_darwincore_associatedinfo[[i]] <- tagList(
        h4(paste0("Associated Contact: ", i)),
        fluidRow(column(width = 4,
                        textInput(paste0("server_darwincore_associatedindividualname", i),
                                  label = "Individual Name"),
                        textInput(paste0("server_darwincore_associatedorganization", i),
                                  label = "Organization"),
                        selectInput(paste0("server_darwincore_associatedrole", i),
                                    label = "Role",
                                    choices = c("author", "contentProvider", "custodianSteward",
                                                "distributor", "editor", "originator", 
                                                "pointOfContact", "principalInvestigator", 
                                                "processor", "publisher", "user"),
                                    multiple = FALSE)),
                 column(width = 4,
                        textInput(paste0("server_darwincore_associatedaddress", i),
                                  label = "Address"),
                        textInput(paste0("server_darwincore_associatedcity", i),
                                  label = "City"),
                        textInput(paste0("server_darwincore_creatorprovince", i),
                                  label = "Province or State"),
                        textInput(paste0("server_darwincore_associatedpostalcode", i),
                                  label = "Postal Code"),
                        textInput(paste0("server_darwincore_associatedcountry", i),
                                  label = "Country")),
                 column(width = 4,
                        textInput(paste0("server_darwincore_creatorphone", i),
                                  label = "Phone"),
                        textInput(paste0("server_darwincore_associatedemail", i),
                                  label = "Email"),
                        textInput(paste0("server_darwincore_associatedurl", i),
                                  label = "Personal Website"))
        )
      )
    }
    server_darwincore_associatedinfo
  })
  
  # Put the pieces together
  tagList(server_darwincore_metadata)
})
