fluidPage(
  shinyjs::useShinyjs(),
  sidebarLayout(
    sidebarPanel = sidebarPanel(
      # determine stat table variables
      uiOutput("ui_statistics_variables"),
      uiOutput("ui_statistics_tests"),
      actionButton("ui_statistics_savestats", label = "Save Statistics"),
      width = 3),
    mainPanel = mainPanel(
      # statistics table output
      tableOutput("ui_statistics_table"),
      uiOutput("ui_statistics_stattests"))
  )
)

