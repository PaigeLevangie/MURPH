fluidPage(
  shinyjs::useShinyjs(),
  sidebarLayout(
    sidebarPanel = sidebarPanel(
      uiOutput("ui_maps_variables"),
      width = 3),
    mainPanel = mainPanel(
      # Map output
      plotOutput("ui_maps_mapoutput"))
  )
)