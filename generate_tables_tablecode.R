## Reactive Table Elements

# Grouping Variables
generate_tables_groupingvariables <- reactiveValues(grouping_variables = input$server_tables_groupingvariables)

# Summary Elements
generate_tables_table <- reactive({
  if(input$server_tables_summaryfunction == "Sum") {
    paste0('myData$data %>% group_by(',
           paste(generate_tables_groupingvariables$grouping_variables, collapse = ","),
           ') %>% summarise(',
           input$server_tables_summaryvariable, 
           ' = sum(',
           input$server_tables_summaryvariable,
           ', na.rm = TRUE))')
  } else if(input$server_tables_summaryfunction == "Mean") {
    paste0('myData$data %>% group_by(',
           paste(generate_tables_groupingvariables$grouping_variables, collapse = ","),
           ') %>% summarise(',
           input$server_tables_summaryvariable, 
           ' = mean(',
           input$server_tables_summaryvariable,
           ', na.rm = TRUE))')
  } else if(input$server_tables_summaryfunction == "Number of Observations") {
    paste0('myData$data %>% group_by(',
           paste(generate_tables_groupingvariables$grouping_variables, collapse = ","),
           ') %>% summarise(',
           input$server_tables_summaryvariable, 
           ' = n())')
  } else if(input$server_tables_summaryfunction == "Unique Observations") {
    paste0('myData$data %>% group_by(',
           paste(generate_tables_groupingvariables$grouping_variables, collapse = ","),
           ') %>% distinct(',
           input$server_tables_summaryvariable,
           ')')
  } else {}
})

# Generate Table
generate_tables_tablecode <- paste0(
  generate_tables_table()
)

## Save Table Code
writeChar(paste(generate_tables_tablecode, collapse = "\n"), "server_components/server_tables_tablecode.R")

