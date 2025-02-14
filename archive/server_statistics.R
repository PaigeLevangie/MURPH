# select general statistics table variables
output$ui_statistics_variables <- renderUI({
  
  varSelectInput("server_statistics_tablevariables", label = "Select Variables",
                 data = myData$data, multiple = TRUE, selected = NULL)
})

# hide table if no variables are selected
observe({
  if(length(input$server_statistics_tablevariables) == 0) {
    shinyjs::hide("ui_statistics_table")
  } else {
    shinyjs::show("ui_statistics_table")
  }
})

# select additional statistics
output$ui_statistics_tests <- renderUI({
  selectInput("server_statistics_selecttests", label = "Select Statistical Tests",
              choices = c("choice a", "choice b", "choice c"),
              multiple = TRUE, selected = FALSE)
})

# show/hide additional page display based on selected tests
observe({
  if(length(input$server_statistics_selecttests) == 0) {
    shinyjs::hide("ui_statistics_stattests")
  } else {
    shinyjs::show("ui_statistics_stattests")
  }
})

# generate general statistics table
output$ui_statistics_table <- renderTable({
  if(length(input$server_statistics_tablevariables) > 1) {
    myData$data %>% 
      select(!!!input$server_statistics_tablevariables) %>% 
      summarise_all(.funs = list(noe = compose(sum, compose('!', is.na)), 
                                 sum = sum,
                                 min = min,
                                 mean = mean,
                                 median = median,
                                 # mode = find_variablemode,
                                 max = max,
                                 sd = sd,
                                 variance = var,
                                 iqr = IQR)) %>%
      gather(vars, vals) %>%
      separate(vars, c("Variable", "stat")) %>%
      spread(stat, vals) %>%
      as.data.frame() %>%
      mutate_if(is.numeric, round, digits = 4)
  } else {
    myData$data %>% 
      select(!!!input$server_statistics_tablevariables) %>% 
      summarise_all(.funs = list(noe = compose(sum, compose('!', is.na)), 
                                 sum = sum,
                                 min = min,
                                 mean = mean,
                                 median = median,
                                 # mode = find_variablemode,
                                 max = max,
                                 sd = sd,
                                 variance = var,
                                 iqr = IQR)) %>% 
      as.data.frame() %>% 
      mutate(variable = paste0(input$server_statistics_tablevariables))
  }
})

# additional statistical tests
output$ui_statistics_stattests <- renderUI({
  tagList(
    h3("Statistical Tests"),
    p("i'll put this stuff in here as I get to it")
  )
})
