function(input, output, session) {
  
  # set up app data.frame - needs dummy data initially
  myData <- reactiveValues(data = data.frame(quakes, 'factor' = rep(1:5, 200)),
                           data_darwincore = data.frame(quakes, 'factor' = rep(1:5, 200), 'PLACEHOLDER' = rep("PLACEHOLDER", 1000)))
  # update data when file is uploaded
  observeEvent(input$server_setup_updatedata, {
    # Include fail safe options
    if(is.null(input$server_setup_fileinput$datapath) == TRUE) {
      shinyalert(title = "Hold On!",
                 text = "You need to select a datafile to use.",
                 confirmButtonText = "Go Back")
    } else if(str_detect(input$server_setup_fileinput$datapath, pattern = ".csv") == FALSE) {
      shinyalert(title = "Hold On!",
                 text = "Selected data file is not a .csv. Go back and select another file, or save your data file as a .csv and try again.",
                 confirmButtonText = "Go Back")
    } else{
      myData$data <- read.csv(input$server_setup_fileinput$datapath)
      myData$data_darwincore <- read.csv(input$server_setup_fileinput$datapath) %>% 
        mutate(PLACEHOLDER = " ")
      }
  })

  # Input ID table used to link tool with darwin core reformat function
  server_inputs <- reactive({
    myvalues <- NULL
    newvalues <- NULL
    for(i in 1:length(names(input))){
      newvalues <- paste(names(input)[i], input[[names(input)[i]]], sep=":")
      myvalues <- append(myvalues, newvalues)
    }
    as.data.frame(myvalues) %>% separate(col = myvalues, into = c("InputID", "Value"), sep = ":") %>% 
      filter(InputID %in% paste0("server_darwincore_", formalArgs(event_core))) %>% 
      filter(Value != "PLACEHOLDER") %>% 
      mutate(InputID = str_remove(InputID, pattern = "server_darwincore_"))
  })
  
  # source server files
  source("server_components/server_setup.R", local = TRUE)$value
  source("server_components/server_darwincore.R", local = TRUE)$value
  source("server_components/server_plots.R", local = TRUE)$value
  source("server_components/server_maps.R", local = TRUE)$value
  source("server_components/server_tables.R", local = TRUE)$value
  
  # Hide Interactive Tabs on Start
  hideTab("tabs", target = "Darwin Core")
  hideTab("tabs", target = "Plotting")
  hideTab("tabs", target = "Tables")
  hideTab("tabs", target = "Maps")
  
  # Conditional Tabs
  observeEvent(input$server_setup_begin, {
    # Darwin Core
    if(input$server_setup_enablemap) {
      showTab("tabs", target = "Maps")
    } else {
      hideTab("tabs", target = "Maps")
    }
    
    # Mapping
    if(input$server_setup_enabledarwincore) {
      showTab("tabs", target = "Darwin Core")
    } else {
      hideTab("tabs", target = "Darwin Core")
    }
    
    # Plots
    showTab("tabs", target = "Plotting")
    
    # Tables
    showTab("tabs", target = "Tables")
  })

}
