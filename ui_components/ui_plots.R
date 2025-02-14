fluidPage(
  shinyjs::useShinyjs(),
  sidebarLayout(
    sidebarPanel = sidebarPanel(
      # Determine plot inputs
      uiOutput("ui_plots_type"),
      uiOutput("ui_plots_variables"),
      uiOutput("ui_plots_aesthetics"),
      uiOutput("ui_plots_theme"),
      uiOutput("ui_plots_annotations"),
      # Update Plot
      uiOutput("ui_plots_update"),
      # Save Plot
      uiOutput("ui_plots_save"),
      width = 4),
    mainPanel = mainPanel(
      # Additional Plot Specifications
      uiOutput("ui_plots_formatting"),
      # Plot Output
      uiOutput("ui_plots_myplot"))
  )
)