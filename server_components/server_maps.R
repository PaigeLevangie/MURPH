## Sidebar Outputs
# output for the map input selection
output$ui_maps_variables <- renderUI({
  tagList(
    # Select Map Options
    h1("Map Format Options"),
    p("Using the select options below, create and customize maps to visualize and communicate your research data. Click the Update Map button to see any changes."),
    # Coordinates
    varSelectInput("server_maps_latitude", label = "Select Latitude",
                   data = myData$data, multiple = FALSE),
    varSelectInput("server_maps_longitude", label = "Select Longitude",
                   data = myData$data, multiple = FALSE),
    # Map Limits
    sliderInput("server_maps_xlimits", label = "Horizontal Map Limits",
                min = -180, max = 180, dragRange = TRUE, value = c(-200,200), step = 0.25),
    sliderInput("server_maps_ylimits", label = "Vertical Limits",
                min = -90, max = 90, dragRange = TRUE, value = c(-100,100), step = 0.25),
    # Map Title
    textInput("server_maps_maptitle", label = "Map Title"),
    # Colour
    checkboxInput("server_maps_colourbyvariable", label = "Colour Points by Variable",
                value = FALSE),
    # Size 
    checkboxInput("server_maps_sizebyvariable", label = "Point Size by Variable",
                  value = FALSE),
    # change points colour
    varSelectInput("server_maps_pointscolour", label = "Colour Variable",
                   data = myData$data, multiple = FALSE),
    # factor colour variable
    checkboxInput("server_maps_factorcolourvariable", label = "Factor Colour Variable",
                  value = FALSE),
    # change point size by variable
    varSelectInput("server_maps_variablepointsize", label = "Point Size Variable",
                   data = myData$data, multiple = FALSE),
    # change point size my value
    numericInput("server_maps_numericpointsize", label = "Input Point Size",
                 min = 0, max = Inf, value = 2),
    # update map
    actionButton("server_maps_updatemap", label = "Update Map"),
    p(" "),
    p("Click the Save Map button below to save your map in the downloadable outputs folder."),
    # Save Map
    actionButton("server_maps_savemap", label = "Save Map"),
    p(" ")
  )
})

## Generate Map Code
observeEvent(input$server_maps_updatemap, {
  if(is.numeric(pull(myData$data, contains(paste(input$server_maps_latitude)))) == FALSE | is.numeric(pull(myData$data, contains(paste(input$server_maps_longitude)))) == FALSE) {
    shinyalert(title = "Hold On!",
               text = "One or both of your coordinate variables are not numeric. Go back and check your coordinates in your dataset. Re - upload your data into the tool and try again!",
               confirmButtonText = "Go Back")
  } else {
  source("generate_maps_mapcode.R", local = TRUE)
  output$ui_maps_mapoutput <- renderPlot({
    source("server_components/server_maps_mapcode.R", local = TRUE)$value
  })
  }
})

# Create a counter value for exporting maps
server_maps_mapcounter <- reactiveValues(mapcounter = 0)

## Save Map
observeEvent(input$server_maps_savemap, {
  
  # Generate Map
  world_map <- map_data("world")
  myMap <- source("server_components/server_maps_mapcode.R", local = TRUE)$value
  
  # Generate File Names
  server_maps_mapcounter$mapcounter <- server_maps_mapcounter$mapcounter + 1
  
  file_name_map <- paste0("MURPH Map - ", server_maps_mapcounter$mapcounter, ".png")
  file_name_mapcode <- paste0("outputs/MURPH Map Code - ", server_maps_mapcounter$mapcounter, ".R")
  
  # Export Map
  ggsave(filename = file_name_map,
         device = "png",
         plot = myMap,
         path = "outputs")
  
  # Export Map Code
  file.copy("server_components/server_maps_mapcode.R", file_name_mapcode)
  
})

## Conditional Inputs

# Initial Input Hide
shinyjs::hide("server_maps_pointscolour")
shinyjs::hide("server_maps_factorcolourvariable")
shinyjs::hide("server_maps_variablepointsize")
shinyjs::hide("server_maps_numericpointsize")

# Point Colour
observeEvent(input$server_maps_colourbyvariable, {
  if(input$server_maps_colourbyvariable) {
    shinyjs::show("server_maps_pointscolour")
    shinyjs::show("server_maps_factorcolourvariable")
  } else {
    shinyjs::hide("server_maps_pointscolour")
    shinyjs::hide("server_maps_factorcolourvariable")
  }
})

# Point Size
observeEvent(input$server_maps_sizebyvariable, {
  if(input$server_maps_sizebyvariable) {
    shinyjs::show("server_maps_variablepointsize")
    shinyjs::hide("server_maps_numericpointsize")
  } else {
    shinyjs::hide("server_maps_variablepointsize")
    shinyjs::show("server_maps_numericpointsize")
  }
})