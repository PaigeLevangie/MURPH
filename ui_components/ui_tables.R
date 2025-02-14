fluidPage(
  shinyjs::useShinyjs(),
  sidebarLayout(
    sidebarPanel = sidebarPanel(
      # Table Specifications
      uiOutput("ui_tables_variables"),
      # Update Table
      uiOutput("ui_tables_update"),
      # Save Table
      uiOutput("ui_tables_savetable")
    ),
    mainPanel = mainPanel(
      # Overall table output
      uiOutput("ui_tables_tableoutput")
    )
  )
)