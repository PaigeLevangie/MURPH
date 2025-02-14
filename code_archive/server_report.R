##########################
##
## Paige Levangie
## Master Thesis Project
## Interactive Tool: MURPH
## 
## Server Script: Report
##
##########################

# generate the basic statistics table for the report
server_report_generalstatistics <- reactive({
  myData$data %>% 
    summarise_all(.funs = list(noe = compose(sum, compose('!', is.na)), 
                               sum = sum, 
                               min = min, 
                               mean = mean, 
                               median = median, 
                               mode = find_variablemode, 
                               max = max, 
                               sd = sd, 
                               variance = var, 
                               iqr = IQR)) %>% 
    gather(vars, vals) %>% 
    separate(vars, c("Variable", "stat")) %>% 
    spread(stat, vals) %>% 
    as.data.frame() %>% 
    mutate_if(is.numeric, round, digits = 4) %>% 
    # Add table style options (e.g. left aligned)
    addHtmlTableStyle(align = "l") %>%
    # Render as HTML table (e.g. row names not included)
    htmlTable(rnames = FALSE, css.cell = "width: 110px")
})


# Generates and downloads report created by MURPH  
output$ui_main_downloadreport <- downloadHandler(
  filename = "report.html",
  content = function(file) {
    
    # Set up parameters to pass to Rmd document (e.g. user provided inputs from MURPH)
    params <- list(datasettitle = input$server_setup_datasettitle,
                   projecttitle = input$server_setup_projecttitle,
                   datasetdescription = input$server_setup_abstract)
    
    # Export various report content as .txt files (will be rendered to report later)
    write_file(server_report_generalstatistics(), file = "report_statistics_generalstats.txt")
    
    # Knit the document, passing in the `params` list,
    # and eval it in a child of the global environment
    rmarkdown::render("report.Rmd", output_file = file,
                      params = params,
                      envir = new.env(parent = globalenv())
    )}
)