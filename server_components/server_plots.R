## Sidebar Inputs
# Plot Type
output$ui_plots_type <- renderUI({
  tagList(
    h1("Plot Customizations"),
    p("Using the select options, create and customize plots to communicate your research data. Throughout the process click Update Plot to see any changes made to your custom plot."),
    selectInput("server_plots_plottype", label = "Select Plot Type",
                choices = c("", 
                            "Scatterplot" = 'geom_point(',
                            "Line Plot" = 'geom_line(',
                            "Jitter Plot" = 'geom_jitter(',
                            "Boxplot" = 'geom_boxplot(',
                            "Violin Plot" = 'geom_violin(',
                            "Bar" = 'geom_bar(',
                            "Histogram" = 'geom_histogram(',
                            "Density Plot" = 'geom_density(',
                            "Dot Plot" = 'geom_dot('),
                multiple = FALSE)
  )
})

# Plot Variables
output$ui_plots_variables <- renderUI({
  tagList(
    varSelectInput("server_plots_selectx", label = "Select X Variable",
                   data = myData$data),
    varSelectInput("server_plots_selecty", label = "Select Y Variable",
                   data = myData$data)
  )
})

# Plot Aesthetics
output$ui_plots_aesthetics <- renderUI({
  selectInput("server_plots_aesthetics", label = "Select Plot Aesthetics",
              choices = c("Fill", "Colour", "Line Type", "Facet"),
              multiple = TRUE)
})

# Plot Theme
output$ui_plots_theme <- renderUI({
  selectInput("server_plots_theme", label = "Select Theme Customizations",
              choices = c("Pre-Set Themes", "Labels"),
              multiple = TRUE)
})

# Plot Annotations
output$ui_plots_annotations <- renderUI({
  selectInput("server_plots_annotations", label = "Select Plot Annotation",
              choices = c("Line Segment", "Horizontal Line", "Vertical Line", 
                          "Sloped Line", "Regression Line"),
              multiple = TRUE)
})

# Update Plot
output$ui_plots_update <- renderUI({
  tagList(
    actionButton("server_plots_updateplot", label = "Update Plot"),
    p(" ")
  )
})

# Save Plot
output$ui_plots_save <- renderUI({
  tagList(
    p("Click the Save Plot button below to save your plot to the downloadable outputs folder."),
    actionButton("server_plots_saveplot", label = "Save Plot")
  )
})

## Main Panel Outputs
output$ui_plots_formatting <- renderUI({
  tagList(
    fluidRow(column(width = 3,
                    checkboxInput("server_plots_grouplinetype", label = "Line Type by Variable",
                                  value = FALSE),
                    varSelectInput("server_plots_linetypevariable", label = "Line Type Variable",
                                   data = myData$data, multiple = FALSE),
                    selectInput("server_plots_linetype", label = "Select Line Type",
                                choices = c("solid", "dashed", "dotted", 
                                            "dotdash", "longdash", "twodash"),
                                multiple = FALSE),
                    numericInput("server_plots_hlineintercept", label = "Horizontal Line Y Intercept",
                                 min = -10000000, max = 10000000, value = 0),
                    selectInput("server_plots_hlinetype", label = "Horizontal Line Type",
                                choices = c("solid", "dashed", "dotted", 
                                            "dotdash", "longdash", "twodash"),
                                multiple = FALSE),
                    selectInput("server_plots_hlinecolour", label = "Horizontal Line Colour",
                                choices = colours(), multiple = FALSE),
                    numericInput("server_plots_hlinesize", label = "Horizontal Line Size",
                                 min = 0.1, max = 100, value = 0),
                    numericInput("server_plots_vlineintercept", label = "Vertical Line X Intercept",
                                 min = -10000000, max = 10000000, value = 0),
                    selectInput("server_plots_vlinetype", label = "Vertical Line Type",
                                choices = c("solid", "dashed", "dotted", 
                                            "dotdash", "longdash", "twodash"),
                                multiple = FALSE),
                    selectInput("server_plots_vlinecolour", label = "Vertical Line Colour",
                                choices = colours(), multiple = FALSE),
                    numericInput("server_plots_vlinesize", label = "Vertical Line Size",
                                 min = 0.1, max = 100, value = 0),
                    numericInput("server_plots_slineintercept", label = "Line Intercept",
                                 min = -10000000, max = 10000000, value = 0),
                    numericInput("server_plots_slineslope", label = "Line Slope",
                                 min = -10000000, max = 10000000, value = 0),
                    selectInput("server_plots_slinetype", label = "Sloped Line Type",
                                choices = c("solid", "dashed", "dotted", 
                                            "dotdash", "longdash", "twodash"),
                                multiple = FALSE),
                    selectInput("server_plots_slinecolour", label = "Sloped Line Colour",
                                choices = colours(), multiple = FALSE),
                    numericInput("server_plots_slinesize", label = "Sloped Line Size",
                                 min = 0.1, max = 100, value = 0),
                    checkboxInput("server_plots_rlinelegend", label = "Show Legend",
                                  value = FALSE),
                    checkboxInput("server_plots_rlinegroup", label = "Group Regression",
                                  value = FALSE),
                    varSelectInput("server_plots_rlinegroupvariable", label = "Regression Grouping Variable",
                                   data = myData$data, multiple = FALSE),
                    selectInput("server_plots_rlinetype", label = "Regression Line Type",
                                choices = c("solid", "dashed", "dotted", 
                                            "dotdash", "longdash", "twodash"),
                                multiple = FALSE),
                    selectInput("server_plots_rlinecolour", label = "Regression Line Colour",
                                choices = colours(), multiple = FALSE),
                    numericInput("server_plots_rlinesize", label = "Regression Line Size",
                                 min = 0.1, max = 100, value = 0)),
             column(width = 3,
                    varSelectInput("server_plots_facet", label = "Facet Variable",
                                   data = myData$data, multiple = FALSE, selected = NULL),
                    checkboxInput("server_plots_groupfill", label = "Fill By Variable",
                                  value = FALSE),
                    checkboxInput("server_plots_factorfill", label = "Factor Fill Variable",
                                  value = FALSE),
                    selectInput("server_plots_fillcolour", label = "Select Fill Colour",
                                choices = colours(), multiple = FALSE),
                    varSelectInput("server_plots_fillvariable", label = "Select Fill Variable",
                                   data = myData$data, multiple = FALSE),
                    checkboxInput("server_plots_groupcolour", label = "Colour By Variable",
                                  value = FALSE),
                    checkboxInput("server_plots_factorcolour", label = "Factor Colour Variable",
                                  value = FALSE),
                    selectInput("server_plots_colourcolour", label = "Select Outline Colour",
                                choices = colours(), multiple = FALSE),
                    varSelectInput("server_plots_colourvariable", label = "Select Outline Variable",
                                   data = myData$data, multiple = FALSE),
                    selectInput("server_plots_position", label = "Bar Position",
                                choices = c("stack", "dodge", "fill"),
                                multiple = FALSE, selected = "stack"),
                    selectInput("server_plots_presettheme", label = "Pre-Set Theme",
                                choices = c("Gray" = 'theme_gray()',
                                            "Black/White" = 'theme_bw()',
                                            "Linedraw" = 'theme_linedraw()',
                                            "Dark" = 'theme_dark()',
                                            "Light" = 'theme_light()',
                                            "Minimal" = 'theme_minimal()',
                                            "Classic" = 'theme_classic()',
                                            "Void" = 'theme_void()'),
                                multiple = FALSE)),
             column(width = 3,
                    textInput("server_plots_title", label = "Title"),
                    textInput("server_plots_subtitle", label = "Subtitle"),
                    textInput("server_plots_xlabel", label = "X Axis Title"),
                    textInput("server_plots_ylabel", label = "Y Axis Title")))
  )
})

# Plot
output$ui_plots_myplot <- renderUI({
  plotOutput("server_plots_myplot")
})

## Conditional Inputs

# Initial Input Hide
shinyjs::hide("server_plots_selectx")
shinyjs::hide("server_plots_selecty")
shinyjs::hide("server_plots_position")
shinyjs::hide("server_plots_hlineintercept")
shinyjs::hide("server_plots_hlinetype")
shinyjs::hide("server_plots_hlinecolour")
shinyjs::hide("server_plots_hlinesize")
shinyjs::hide("server_plots_vlineintercept")
shinyjs::hide("server_plots_vlinetype")
shinyjs::hide("server_plots_vlinecolour")
shinyjs::hide("server_plots_vlinesize")
shinyjs::hide("server_plots_slineintercept")
shinyjs::hide("server_plots_slineslope")
shinyjs::hide("server_plots_slinetype")
shinyjs::hide("server_plots_slinecolour")
shinyjs::hide("server_plots_slinesize")
shinyjs::hide("server_plots_rlinelegend")
shinyjs::hide("server_plots_rlinegroup")
shinyjs::hide("server_plots_rlinecolour")
shinyjs::hide("server_plots_rlinetype")
shinyjs::hide("server_plots_rlinesize")
shinyjs::hide("server_plots_rlinegroupvariable")
shinyjs::hide("server_plots_facet")
shinyjs::hide("server_plots_groupfill")
shinyjs::hide("server_plots_fillcolour")
shinyjs::hide("server_plots_fillvariable")
shinyjs::hide("server_plots_groupcolour")
shinyjs::hide("server_plots_factorcolour")
shinyjs::hide("server_plots_colourcolour")
shinyjs::hide("server_plots_colourvariable")
shinyjs::hide("server_plots_groupshape")
shinyjs::hide("server_plots_shape")
shinyjs::hide("server_plots_shapevariable")
shinyjs::hide("server_plots_grouplinetype")
shinyjs::hide("server_plots_linetype")
shinyjs::hide("server_plots_linetypevariable")
shinyjs::hide("server_plots_title")
shinyjs::hide("server_plots_subtitle")
shinyjs::hide("server_plots_xlabel")
shinyjs::hide("server_plots_ylabel")

# Plot Type Specific
observe({
  if(is.null(input$server_plots_plottype) || input$server_plots_plottype == "") {
    shinyjs::hide("server_plots_selectx")
    shinyjs::hide("server_plots_selecty")
    shinyjs::hide("server_plots_position")
  } else if(input$server_plots_plottype %in% c("geom_boxplot(", "geom_density(", "geom_dot(", "geom_violin(")) {
    shinyjs::show("server_plots_selectx")
    shinyjs::hide("server_plots_selecty")
    shinyjs::hide("server_plots_position")
  } else if (input$server_plots_plottype %in% c("geom_histogram(", "geom_bar(")) {
    shinyjs::show("server_plots_selectx")
    shinyjs::hide("server_plots_selecty")
    shinyjs::show("server_plots_position")
  } else {
    shinyjs::show("server_plots_selectx")
    shinyjs::show("server_plots_selecty")
    shinyjs::hide("server_plots_position")
  }
})

# Horizontal Line
observe({
  if("Horizontal Line" %in% input$server_plots_annotations) {
    shinyjs::show("server_plots_hlineintercept")
    shinyjs::show("server_plots_hlinetype")
    shinyjs::show("server_plots_hlinecolour")
    shinyjs::show("server_plots_hlinesize")
  } else {
    shinyjs::hide("server_plots_hlineintercept")
    shinyjs::hide("server_plots_hlinetype")
    shinyjs::hide("server_plots_hlinecolour")
    shinyjs::hide("server_plots_hlinesize")
  }
})

# Vertical Line
observe({
  if("Vertical Line" %in% input$server_plots_annotations) {
    shinyjs::show("server_plots_vlineintercept")
    shinyjs::show("server_plots_vlinetype")
    shinyjs::show("server_plots_vlinecolour")
    shinyjs::show("server_plots_vlinesize")
  } else {
    shinyjs::hide("server_plots_vlineintercept")
    shinyjs::hide("server_plots_vlinetype")
    shinyjs::hide("server_plots_vlinecolour")
    shinyjs::hide("server_plots_vlinesize")
  }
})

# Sloped Line
observe({
  if("Sloped Line" %in% input$server_plots_annotations) {
    shinyjs::show("server_plots_slineintercept")
    shinyjs::show("server_plots_slineslope")
    shinyjs::show("server_plots_slinetype")
    shinyjs::show("server_plots_slinecolour")
    shinyjs::show("server_plots_slinesize")
  } else {
    shinyjs::hide("server_plots_slineintercept")
    shinyjs::hide("server_plots_slineslope")
    shinyjs::hide("server_plots_slinetype")
    shinyjs::hide("server_plots_slinecolour")
    shinyjs::hide("server_plots_slinesize")
  }
})

# Regression Line
observe({
  if("Regression Line" %in% input$server_plots_annotations) {
    shinyjs::show("server_plots_rlinelegend")
    shinyjs::show("server_plots_rlinegroup")
    shinyjs::show("server_plots_rlinecolour")
    shinyjs::show("server_plots_rlinetype")
    shinyjs::show("server_plots_rlinesize")
  } else {
    shinyjs::hide("server_plots_rlinelegend")
    shinyjs::hide("server_plots_rlinegroup")
    shinyjs::hide("server_plots_rlinecolour")
    shinyjs::hide("server_plots_rlinetype")
    shinyjs::hide("server_plots_rlinesize")
  }
})

# Regression Line - Grouping
observeEvent(input$server_plots_rlinegroup, {
  if(input$server_plots_rlinegroup) {
    shinyjs::show("server_plots_rlinegroupvariable")
    shinyjs::hide("server_plots_rlinecolour")
  } else {
    shinyjs::hide("server_plots_rlinegroupvariable")
    shinyjs::show("server_plots_rlinecolour")
  }
})

# Facet Wrap
observe({
  if("Facet" %in% input$server_plots_aesthetics) {
    shinyjs::show("server_plots_facet")
  } else {
    shinyjs::hide("server_plots_facet")
  }
})

# Fill
observe({
  if("Fill" %in% input$server_plots_aesthetics) {
    shinyjs::show("server_plots_groupfill")
    shinyjs::show("server_plots_fillcolour")
  } else {
    shinyjs::hide("server_plots_groupfill")
    shinyjs::hide("server_plots_fillcolour")
  }
})

# Fill - Grouping
observeEvent(input$server_plots_groupfill, {
  if(input$server_plots_groupfill) {
    shinyjs::show("server_plots_factorfill")
    shinyjs::show("server_plots_fillvariable")
    shinyjs::hide("server_plots_fillcolour")
  } else {
    shinyjs::hide("server_plots_factorfill")
    shinyjs::hide("server_plots_fillvariable")
    shinyjs::show("server_plots_fillcolour")
  }
})

# Colour
observe({
  if("Colour" %in% input$server_plots_aesthetics) {
    shinyjs::show("server_plots_groupcolour")
    shinyjs::show("server_plots_colourcolour")
  } else {
    shinyjs::hide("server_plots_groupcolour")
    shinyjs::hide("server_plots_colourcolour")
  }
})

# Colour - Grouping
observeEvent(input$server_plots_groupcolour, {
  if(input$server_plots_groupcolour) {
    shinyjs::show("server_plots_factorcolour")
    shinyjs::show("server_plots_colourvariable")
    shinyjs::hide("server_plots_colourcolour")
  } else {
    shinyjs::hide("server_plots_factorcolour")
    shinyjs::hide("server_plots_colourvariable")
    shinyjs::show("server_plots_colourcolour")
  }
})

# Shape
observe({
  if("Shape" %in% input$server_plots_aesthetics) {
    shinyjs::show("server_plots_groupshape")
    shinyjs::show("server_plots_shape")
  } else {
    shinyjs::hide("server_plots_groupshape")
    shinyjs::hide("server_plots_shape")
  }
})

# Shape - Grouping
observeEvent(input$server_plots_groupshape, {
  if(input$server_plots_groupshape) {
    shinyjs::show("server_plots_shapevariable")
    shinyjs::hide("server_plots_shape")
  } else {
    shinyjs::hide("server_plots_shapevariable")
    shinyjs::show("server_plots_shape")
  }
})

# Line Type
observe({
  if("Line Type" %in% input$server_plots_aesthetics) {
    shinyjs::show("server_plots_grouplinetype")
    shinyjs::show("server_plots_linetype")
  } else {
    shinyjs::hide("server_plots_grouplinetype")
    shinyjs::hide("server_plots_linetype")
  }
})

# Line Type - Grouping
observeEvent(input$server_plots_grouplinetype, {
  if(input$server_plots_grouplinetype) {
    shinyjs::show("server_plots_linetypevariable")
    shinyjs::hide("server_plots_linetype")
  } else {
    shinyjs::hide("server_plots_linetypevariable")
    shinyjs::show("server_plots_linetype")
  }
})

# Labels
observe({
  if("Labels" %in% input$server_plots_theme) {
    shinyjs::show("server_plots_title")
    shinyjs::show("server_plots_subtitle")
    shinyjs::show("server_plots_xlabel")
    shinyjs::show("server_plots_ylabel")
  } else {
    shinyjs::hide("server_plots_title")
    shinyjs::hide("server_plots_subtitle")
    shinyjs::hide("server_plots_xlabel")
    shinyjs::hide("server_plots_ylabel")
  }
})

# Pre-Set Theme
observe({
  if("Pre-Set Themes" %in% input$server_plots_theme) {
    shinyjs::show("server_plots_presettheme")
  } else {
    shinyjs::hide("server_plots_presettheme")
  }
})

## Generate Plot Code
observeEvent(input$server_plots_updateplot, {
  if(input$server_plots_plottype == "") {
    shinyalert(title = "Hold On!",
               text = "You must select a plot type to proceed. Go back and ensure the required options are selected.",
               confirmButtonText = "Go Back")
  } else {
    source("generate_plots_plotcode.R", local = TRUE)
    output$server_plots_myplot <- renderPlot({
      source("server_components/server_plots_plotcode.R", local = TRUE)$value
    })
  }
})

# Create a counter value for exporting plots
server_plots_plotcounter <- reactiveValues(plotcounter = 0)

## Save Plot
observeEvent(input$server_plots_saveplot, {
  
  # Generate Plot
  myPlot <- source("server_components/server_plots_plotcode.R", local = TRUE)$value
  
  # Generate File Names
  server_plots_plotcounter$plotcounter <- server_plots_plotcounter$plotcounter + 1
  
  file_name_plot <- paste0("MURPH Plot - ", server_plots_plotcounter$plotcounter, ".png")
  file_name_plotcode <- paste0("outputs/MURPH Plot Code - ", server_plots_plotcounter$plotcounter, ".R")
  
  # Export Plot
  ggsave(filename = file_name_plot,
         device = "png",
         plot = myPlot,
         path = "outputs")
  
  # Export Plot Code
  file.copy("server_components/server_plots_plotcode.R", file_name_plotcode)
  
  
})


