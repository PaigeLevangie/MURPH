##

generate_darwincore_arguments <- reactive({
  paste("event_core(data = myData$data,",
        paste(
          paste0(server_inputs()$InputID, "= '", server_inputs()$Value, "'"),
          collapse = ","
        ),
        paste(", measurement_columns = c(",
              paste0("'", names(myData$data)[!names(myData$data) %in% server_inputs()$Value], "'", collapse = ","),
              ')'),
        ')'
  )
})

generate_darwincore_function <- paste0(
  generate_darwincore_arguments()
)

## Save Plot Code
writeChar(paste(generate_darwincore_function, collapse = "\n"), "server_components/server_darwincore_reformatcode.R")