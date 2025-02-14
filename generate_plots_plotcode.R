## Reactive Plot Elements
# Facet Wrap
generate_plots_facet <- reactive({
  if("Facet" %in% input$server_plots_aesthetics) {
    paste0('+ facet_wrap(~',
           input$server_plots_facet,
           ')')
  } else {}
})

# Fill
generate_plots_fill <- reactive({
  if("Fill" %in% input$server_plots_aesthetics & input$server_plots_groupfill & input$server_plots_plottype %in% c("geom_histogram(", "geom_bar(", "geom_boxplot(", "geom_violin(", "geom_dot(")) {
    paste0('fill = factor(',
           input$server_plots_fillvariable,
           ')')
  } else if("Fill" %in% input$server_plots_aesthetics & input$server_plots_groupfill & input$server_plots_factorfill & !(input$server_plots_plottype %in% c("geom_histogram(", "geom_bar(", "geom_boxplot(", "geom_violin(", "geom_dot("))) {
    paste0('fill = factor(',
           input$server_plots_fillvariable,
           ')')
  } else if("Fill" %in% input$server_plots_aesthetics & input$server_plots_groupfill & input$server_plots_factorfill == FALSE & !(input$server_plots_plottype %in% c("geom_histogram(", "geom_bar(", "geom_boxplot(", "geom_violin(", "geom_dot("))) {
    paste0('fill = ',
           input$server_plots_fillvariable)
  } else if(!("Fill" %in% input$server_plots_aesthetics)) {
  } else {
    paste0(', fill = "',
           input$server_plots_fillcolour,
           '"')
  }
})

# Colour
generate_plots_colour <- reactive({
  if("Colour" %in% input$server_plots_aesthetics & input$server_plots_groupcolour & input$server_plots_plottype %in% c("geom_histogram(", "geom_bar(", "geom_boxplot(", "geom_violin(", "geom_dot(")) {
    paste0('colour = factor(',
           input$server_plots_colourvariable,
           ')')
  } else if("Colour" %in% input$server_plots_aesthetics & input$server_plots_groupcolour & input$server_plots_factorcolour & !(input$server_plots_plottype %in% c("geom_histogram(", "geom_bar(", "geom_boxplot(", "geom_violin(", "geom_dot("))) {
    paste0('colour = factor(',
           input$server_plots_colourvariable,
           ')')
  } else if("Colour" %in% input$server_plots_aesthetics & input$server_plots_groupcolour & input$server_plots_factorcolour == FALSE & !(input$server_plots_plottype %in% c("geom_histogram(", "geom_bar(", "geom_boxplot(", "geom_violin(", "geom_dot("))) {
    paste0('colour = ',
           input$server_plots_colourvariable)
  } else if(!("Colour" %in% input$server_plots_aesthetics)) {
  } else {
    paste0(', colour = "',
           input$server_plots_colourcolour,
           '"')
  }
})

# Line Type
generate_plots_linetype <- reactive({
  if(input$server_plots_plottype == "geom_line(" & "Line Type" %in% input$server_plots_aethetics & input$server_grouplinetype == FALSE) {
    paste0(', linetype = "',
           input$server_plots_linetype,
           '"')
  } else if(input$server_plots_plottype == "geom_line(" & "Line Type" %in% input$server_plots_aethetics & input$server_grouplinetype) {
    paste0('linetype = factor(',
           input$server_plots_linetypevariable,
           ')')
  } else {}
})


# Plot Variables
generate_plots_variables <- reactive({
  if(input$server_plots_plottype %in% c("geom_histogram(", "geom_bar(")) {
    paste0('x = ',
           input$server_plots_selectx)
  } else if(input$server_plots_plottype %in% c("geom_boxplot(", "geom_violin(", "geom_dot(")) {
    paste0('y = ',
           input$server_plots_selectx)
  } else {
    paste0('x = ',
           input$server_plots_selectx,
           ', y = ',
           input$server_plots_selecty)
  }
})

# Geom Aesthetics
generate_plots_aesthetics <- reactive({
  if(input$server_plots_groupfill & input$server_plots_groupcolour) {
    paste0('aes(',
           generate_plots_variables(),
           ', ',
           generate_plots_fill(),
           ', ',
           generate_plots_colour(),
           ')')
  } else if(input$server_plots_groupfill) {
    paste0('aes(',
           generate_plots_variables(),
           ',',
           generate_plots_fill(),
           ')',
           generate_plots_colour())
  } else if(input$server_plots_groupcolour) {
    paste0('aes(',
           generate_plots_variables(),
           ',',
           generate_plots_colour(),
           ')',
           generate_plots_fill())
  } else {
    paste0('aes(',
           generate_plots_variables(),
           ')',
           generate_plots_fill(),
           generate_plots_colour())
  }
})

# Plot Geom
generate_plots_geom <- reactive({
  if(input$server_plots_plottype %in% c("geom_histogram(", "geom_bar(")) {
    paste0(input$server_plots_plottype,
           generate_plots_aesthetics(),
           ', position = "',
           input$server_plots_position,
           '")')
  } else {
    paste0(input$server_plots_plottype,
           generate_plots_aesthetics(),
           ')')
  }
})

# Horizontal Line
generate_plots_hline <- reactive({
  if("Horizontal Line" %in% input$server_plots_annotations) {
    paste0('+ geom_hline(yintercept = ',
           input$server_plots_hlineintercept,
           ', linetype = "',
           input$server_plots_hlinetype,
           '", colour = "',
           input$server_plots_hlinecolour,
           '", linewidth = ',
           input$server_plots_hlinesize,
           ')')
  } else {}
})

# Vertical Line
generate_plots_vline <- reactive({
  if("Vertical Line" %in% input$server_plots_annotations) {
    paste0('+ geom_vline(xintercept = ',
           input$server_plots_vlineintercept,
           ', linetype = "',
           input$server_plots_vlinetype,
           '", colour = "',
           input$server_plots_vlinecolour,
           '", linewidth = ',
           input$server_plots_vlinesize,
           ')')
  } else {}
})

# Sloped Line
generate_plots_sline <- reactive({
  if("Sloped Line" %in% input$server_plots_annotations) {
    paste0('+ geom_abline(intercept = ',
           input$server_plots_slineintercept,
           ', slope = ',
           input$server_plots_slineslope,
           ', linetype = "',
           input$server_plots_slinetype,
           '", colour = "',
           input$server_plots_slinecolour,
           '", linewidth = ',
           input$server_plots_slinesize,
           ')')
  } else {}
})

# Regression Line - Multiple Regressions
generate_plots_rlinegroup <- reactive({
  if(input$server_plots_rlinegroup) {
    paste0(', group = factor(',
           input$server_plots_rlinegroupvariable,
           '), fill = factor(',
           input$server_plots_rlinegroupvariable,
           '), colour = factor(',
           input$server_plots_rlinegroupvariable,
           '))')
  } else {
    paste0('), colour = "',
           input$server_plots_rlinecolour,
           '"')
  }
})

# Regression Line
generate_plots_rline <- reactive({
  if("Regression Line" %in% input$server_plots_annotations) {
    paste0('+ geom_smooth(aes(x = ',
           input$server_plots_selectx,
           ', y = ',
           input$server_plots_selecty,
           generate_plots_rlinegroup(),
           ', linetype = "',
           input$server_plots_rlinetype,
           '", linewidth = ',
           input$server_plots_rlinesize,
           ', method = "lm", show.legend =',
           input$server_plots_rlinelegend,
           ')')
  } else {}
})

# Theme
generate_plots_theme <- reactive({
  if("Pre-Set Themes" %in% input$server_plots_theme) {
    paste0('+ ',
           input$server_plots_presettheme,
           '+ theme(legend.position = "bottom")')
  } else {
    # Maintain legend position = "bottom"
    paste0('+ theme(legend.position = "bottom")')
  }
})

# Labels
generate_plots_labels <- reactive({
  if("Labels" %in% input$server_plots_theme) {
    paste0('+ xlab("',
           input$server_plots_xlabel,
           '") + ylab("',
           input$server_plots_ylabel,
           '") + labs(title = "',
           input$server_plots_title,
           '", subtitle = "',
           input$server_plots_subtitle,
           '")')
  } else {}
})

## Generate Plot Code
generate_plots_plotcode <- paste0('ggplot(data = myData$data) + ',
               generate_plots_geom(),
               generate_plots_theme(),
               generate_plots_hline(),
               generate_plots_vline(),
               generate_plots_sline(),
               generate_plots_rline(),
               generate_plots_labels(),
               generate_plots_facet())

## Save Plot Code
writeChar(paste(generate_plots_plotcode, collapse = "\n"), "server_components/server_plots_plotcode.R")