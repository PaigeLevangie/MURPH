## Reactive Map Elements

# Base Map
world_map <- map_data("world")
generate_maps_basemap <- reactive({
  paste0('ggplot() + geom_polygon(data = world_map, aes(x = long, y = lat, group = group), fill = "gray80", color = "white")')
})

# Map Limits
generate_maps_maplimits <- reactive({
  paste0(' + coord_quickmap(xlim = c(', input$server_maps_xlimits[1], ', ', input$server_maps_xlimits[2], '), ylim = c(', input$server_maps_ylimits[1], ', ', input$server_maps_ylimits[2], '))')
})

# Map Labels
generate_maps_labels <- reactive({
  paste0(' + labs(title = "', input$server_maps_maptitle, '", x = "Longitude", y = "Latitide") + theme(legend.position = "bottom")')
})


generate_maps_aesthetics <- reactive({
  if(input$server_maps_colourbyvariable == TRUE & input$server_maps_sizebyvariable == TRUE & input$server_maps_factorcolourvariable == TRUE) {
    paste0(' + geom_point(data = myData$data, aes(x = ', input$server_maps_longitude, ', y = ', input$server_maps_latitude, ', color = factor(', input$server_maps_pointscolour, '), size = ', input$server_maps_variablepointsize, '))')
  } else if(input$server_maps_colourbyvariable == TRUE & input$server_maps_sizebyvariable == TRUE) {
    paste0(' + geom_point(data = myData$data, aes(x = ', input$server_maps_longitude, ', y = ', input$server_maps_latitude, ', color = ', input$server_maps_pointscolour, ', size = ', input$server_maps_variablepointsize, '))')
  } else if(input$server_maps_colourbyvariable & input$server_maps_factorcolourvariable == TRUE) {
    paste0(' + geom_point(data = myData$data, aes(x = ', input$server_maps_longitude, ', y = ', input$server_maps_latitude, ', color = factor(', input$server_maps_pointscolour, ')), size = ', input$server_maps_numericpointsize, ')')
  } else if(input$server_maps_colourbyvariable) {
    paste0(' + geom_point(data = myData$data, aes(x = ', input$server_maps_longitude, ', y = ', input$server_maps_latitude, ', color = ', input$server_maps_pointscolour, '), size = ', input$server_maps_numericpointsize, ')')
  }else if(input$server_maps_sizebyvariable) {
    paste0(' + geom_point(data = myData$data, aes(x = ', input$server_maps_longitude, ', y = ', input$server_maps_latitude, ', size = ', input$server_maps_variablepointsize, '), color = "red")')
  } else {
    paste0(' + geom_point(data = myData$data, aes(x = ', input$server_maps_longitude, ', y = ', input$server_maps_latitude, '), color = "red", size = ', input$server_maps_numericpointsize, ')')
  }
})

## Generate Map Code
generate_maps_mapcode <- paste0(
  generate_maps_basemap(),
  generate_maps_maplimits(),
  generate_maps_aesthetics(),
  generate_maps_labels()
)

## Save Map Code
writeChar(paste(generate_maps_mapcode, collapse = "\n"), "server_components/server_maps_mapcode.R")