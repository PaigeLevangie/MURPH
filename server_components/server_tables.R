## Sidebar Outputs
# Table Variables
output$ui_tables_variables <- renderUI({
  tagList(
    h1("Format Table Options"),
    p("Using the options below, create and customize summary tables to communicate your research data. Click Update Table to view your custom table."),
    # Select All Grouping Variables
    varSelectInput("server_tables_groupingvariables", label = "Select Grouping Variables",
                   data = myData$data, multiple = TRUE),
    # Select Summary Variable
    varSelectInput("server_tables_summaryvariable", label = "Select Summary Variable",
                   data = myData$data, multiple = FALSE),
    # Select Summary Function
    selectInput("server_tables_summaryfunction", label = "Select Summary Option",
                choices = c("Sum", "Mean", "Number of Observations", "Unique Observations"),
                multiple = FALSE),
    # Table Title
    textInput("server_tables_caption", label = "Table Caption")
  )
})

# Update Table
output$ui_tables_update <- renderUI({
  tagList(
    actionButton("server_tables_updatetable", label = "Update Table"),
    p(" ")
  )
})

# Save Table
output$ui_tables_savetable <- renderUI({
  tagList(
    p("Click below to save table to downloadable outputs folder."),
    actionButton("server_tables_savetable", label = "Save Table")
  )
})

## Main Panel Outputs
# Table output
output$ui_tables_tableoutput <- renderUI({
  DTOutput("server_tables_mytable")
})

## Generate Table Code
observeEvent(input$server_tables_updatetable, {
  source("generate_tables_tablecode.R", local = TRUE)
  output$server_tables_mytable <- renderDT(
    source("server_components/server_tables_tablecode.R", local = TRUE)$value,
    caption = input$server_tables_caption
  )
})

# Create a counter value for exporting tables
server_tables_tablecounter <- reactiveValues(tablecounter = 0)

## Save Table
observeEvent(input$server_tables_savetable, {
  mytable <- source("server_components/server_tables_tablecode.R", local = TRUE)$value
  
  # Generate File Names
  server_tables_tablecounter$tablecounter <- server_tables_tablecounter$tablecounter + 1
  
  file_name_table <- paste0("outputs/MURPH table - ", server_tables_tablecounter$tablecounter, ".csv")
  file_name_tablecode <- paste0("outputs/MURPH table Code - ", server_tables_tablecounter$tablecounter, ".R")
  
  write.csv(mytable, file_name_table)
  # Export table Code
  file.copy("server_components/server_tables_tablecode.R", file_name_tablecode)
  
})
