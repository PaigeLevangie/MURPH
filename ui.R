shinyUI({
  
  # create navigation bar layout
  navbarPage(
    
    # title
    title = tags$img(src = 'logo.png', height = 150),
    
    tags$style(HTML('.navbar-nav > li > a, .navbar-brand {
                   padding-top:4px !important; 
                   padding-bottom:0 !important;
                   height: 160px;
                 }
                 .navbar {min-height:160px !important;}')),
    
    # ID Conditional Tabs
    id = "tabs",
    
    # Add sections to navigation bar
    tabPanel("Set-Up",
             source("ui_components/ui_setup.R", local = TRUE)$value),
    tabPanel("Darwin Core",
             source("ui_components/ui_darwincore.R", local = TRUE)$value),
    tabPanel("Plotting",
             source("ui_components/ui_plots.R", local = TRUE)$value),
    tabPanel("Tables",
             source("ui_components/ui_tables.R", local = TRUE)$value),
    tabPanel("Maps",
             source("ui_components/ui_maps.R", local = TRUE)$value)
  )
})
