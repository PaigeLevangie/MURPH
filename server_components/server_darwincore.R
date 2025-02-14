## Sidebar Outputs

# Select ID Variables Present
output$ui_darwincore_selectidterms <- renderUI({
  tagList(
    h1("Format Terms"),
    p("If your uploaded dataset contains any of the information below, use the select options to help you format data."),
    checkboxInput("server_darwincore_eventidpresent",
                  label = "Event ID Present in Dataset"),
    checkboxInput("server_darwincore_occurrenceidpresent",
                  label = "Occurrence ID Present in Dataset")
  )
})

# Select Additional Darwin Core Terms
output$ui_darwincore_additionalselect <- renderUI({
  selectInput("server_darwincore_additionalterms",
              label = "Select Terms Included within Dataset",
              choices = c("eventType", "eventRemarks", "fieldNotes", 
                          "fieldNumber", "habitat", "continent", 
                          "coordinatePrecision", "country", 
                          "stateProvince", "waterbody", "locality", 
                          "locationRemarks", "recordedBy", 
                          "institutionCode", "collectionCode", 
                          "catalogNumber", "occurrenceRemarks",
                          "vernacularName", "rightsHolder"),
              multiple = TRUE)
})


# Reformat Data Button
output$ui_darwincore_generate <- renderUI({
  tagList(
    actionButton("server_darwincore_reformat", label = "Reformat Dataset"))
})

## Main Outputs

# output for required term select
output$ui_darwincore_formatrequired <- renderUI({
  tagList(
    h1("Format Variables"),
    p("Select variables from the drop down list for each required term present. Select additional terms to use within the sidebar. Any variable not specified will be placed in the measurement or fact extension."),
    fluidRow(
      column(width = 4,
             varSelectInput("server_darwincore_eventID", label = "Event ID",
                            data = myData$data_darwincore, multiple = FALSE, selected = 'PLACEHOLDER'),
             varSelectInput("server_darwincore_eventDate", label = "Event Date",
                            data = myData$data_darwincore, multiple = FALSE, selected = 'PLACEHOLDER'),
             varSelectInput("server_darwincore_scientificName", label = "Scientific Name",
                            data = myData$data_darwincore, multiple = FALSE, selected = 'PLACEHOLDER')),
      column(width = 4,
             varSelectInput("server_darwincore_decimalLongitude", label = "Select Event Longitude",
                            data = myData$data_darwincore, multiple = FALSE, selected = 'PLACEHOLDER'),
             varSelectInput("server_darwincore_decimalLatitude", label = "Event Latitude",
                            data = myData$data_darwincore, multiple = FALSE, selected = 'PLACEHOLDER')),
      column(width = 4,
             varSelectInput("server_darwincore_occurrenceID", label = "Occurrence ID Variable",
                            data = myData$data_darwincore, multiple = FALSE, selected = 'PLACEHOLDER'),
             selectInput("server_darwincore_basisOfRecord", label = "Basis of Record",
                         choices = c("HumanObservation", 
                                     "FossilSpecimen", 
                                     "LivingSpecimen", 
                                     "PreservedSpecimen", 
                                     "MachineObservation"), 
                         multiple = FALSE),
             selectInput("server_darwincore_occurrenceStatus", label = "Occurrence Status",
                         choices = c("present", "absent"), multiple = FALSE))
    ),
    fluidRow(
      column(width = 4,
             varSelectInput("server_darwincore_fieldNotes", label = "Select fieldNotes Variable", 
                            data = myData$data_darwincore, multiple = FALSE, selected = 'PLACEHOLDER'),
             varSelectInput("server_darwincore_fieldNumber", label = "Select fieldNumber Variable", 
                            data = myData$data_darwincore, multiple = FALSE, selected = 'PLACEHOLDER'),
             varSelectInput("server_darwincore_eventRemarks", label = "Select eventRemarks Variable", 
                            data = myData$data_darwincore, multiple = FALSE, selected = 'PLACEHOLDER'),
             varSelectInput("server_darwincore_eventType", label = "Select eventType Variable", 
                            data = myData$data_darwincore, multiple = FALSE, selected = 'PLACEHOLDER'),
             varSelectInput("server_darwincore_coordinatePrecision", label = "Select coordinatePrecision Variable", 
                            data = myData$data_darwincore, multiple = FALSE, selected = 'PLACEHOLDER'),
             varSelectInput("server_darwincore_continent", label = "Select continent Variable", 
                            data = myData$data_darwincore, multiple = FALSE, selected = 'PLACEHOLDER'),
             varSelectInput("server_darwincore_country", label = "Select country Variable", 
                            data = myData$data_darwincore, multiple = FALSE, selected = 'PLACEHOLDER')),
      column(width = 4,
             varSelectInput("server_darwincore_habitat", label = "Select habitat Variable", 
                            data = myData$data_darwincore, multiple = FALSE, selected = 'PLACEHOLDER'),
             varSelectInput("server_darwincore_locationRemarks", label = "Select locationRemarks Variable", 
                            data = myData$data_darwincore, multiple = FALSE, selected = 'PLACEHOLDER'),
             varSelectInput("server_darwincore_locality", label = "Select locality Variable", 
                            data = myData$data_darwincore, multiple = FALSE, selected = 'PLACEHOLDER'),
             varSelectInput("server_darwincore_waterbody", label = "Select waterbody Variable", 
                            data = myData$data_darwincore, multiple = FALSE, selected = 'PLACEHOLDER'),
             varSelectInput("server_darwincore_recordedBy", label = "Select recordedBy Variable", 
                            data = myData$data_darwincore, multiple = FALSE, selected = 'PLACEHOLDER'),
             varSelectInput("server_darwincore_stateProvince", label = "Select stateProvince Variable", 
                            data = myData$data_darwincore, multiple = FALSE, selected = 'PLACEHOLDER')),
      column(width = 4,
             varSelectInput("server_darwincore_institutionCode", label = "Select institutionCode Variable", 
                            data = myData$data_darwincore, multiple = FALSE, selected = 'PLACEHOLDER'),
             varSelectInput("server_darwincore_collectionCode", label = "Select collectionCode Variable", 
                            data = myData$data_darwincore, multiple = FALSE, selected = 'PLACEHOLDER'),
             varSelectInput("server_darwincore_catalogNumber", label = "Select catalogNumber Variable", 
                            data = myData$data_darwincore, multiple = FALSE, selected = 'PLACEHOLDER'),
             varSelectInput("server_darwincore_occurrenceRemarks", label = "Select occurrenceRemarks Variable", 
                            data = myData$data_darwincore, multiple = FALSE, selected = 'PLACEHOLDER'),
             varSelectInput("server_darwincore_vernacularName", label = "Select vernacularName Variable", 
                            data = myData$data_darwincore, multiple = FALSE, selected = 'PLACEHOLDER'),
             varSelectInput("server_darwincore_rightsHolder", label = "Select rightsHolder Variable", 
                            data = myData$data_darwincore, multiple = FALSE, selected = 'PLACEHOLDER')))
  )
})

# Metadata Output
output$ui_darwincore_formatmetadata <- renderUI({
  tagList(
    hr(),
    h1("Format Metadata"),
    p("Fill in the required metadata information."),
    fluidRow(
      column(width = 4,
             textInput("server_darwincore_firstname", label = "First Name"),
             textInput("server_darwincore_lastname", label = "Last Name"),
             textInput("server_darwincore_email", label = "Email Address")),
      column(width = 4,
             textInput("server_darwincore_datasettitle", label = "Dataset Title")),
      column(width = 4,
             textInput("server_darwincore_abstract", label = "Abstract"))
    ),
    p(" "),
    hr()
  )
})

## Reformat Dataset

# Reformat Data
observeEvent(input$server_darwincore_reformat, {
  if(any(table(server_inputs()$Value)>1)) {
    shinyalert(title = "Hold On!",
               text = "One of your variables is selected more than once. Go back and ensure any variables selected are only selected once.",
               confirmButtonText = "Go Back")
  } else if(any(c(input$server_darwincore_eventDate, input$server_darwincore_decimalLatitude, input$server_darwincore_decimalLongitude, input$server_darwincore_scientificName) == "PLACEHOLDER")){
    shinyalert(title = "Hold On!",
               text = "One of the required terms are not specified. Go back and ensure all required terms are assigned a variable.",
               confirmButtonText = "Go Back")
  } else if(is.numeric(pull(myData$data, contains(paste(input$server_darwincore_decimalLatitude)))) == FALSE) {
    shinyalert(title = "Hold On!",
               text = "lat numeric",
               confirmButtonText = "Go Back")
  } else {
    # Generate Function Code
    source("generate_darwincore_reformatcode.R", local = TRUE)
    
    source("server_components/server_darwincore_reformatcode.R", local = TRUE)$value
    
    
    # Format Metadata Portion
    me <- list(individualName = list(givenName = input$server_darwincore_firstname, surName = input$server_darwincore_lastname),
               electronicMailAddress = input$server_darwincore_email)
    my_eml <- eml$eml(
      packageId = uuid::UUIDgenerate(),  
      system = "uuid",
      dataset = eml$dataset(
        title = input$server_darwincore_datasettitle,
        contact = me,
        abstract = input$server_darwincore_abstract)
    )
    # Export Metadata File
    write_eml(my_eml, "outputs/report_darwincore_eml.xml")
  }
})

## Conditional Options

# Event ID Present
observeEvent(input$server_darwincore_eventidpresent, {
  if(input$server_darwincore_eventidpresent) {
    shinyjs::show("server_darwincore_eventID")
  } else {
    shinyjs::hide("server_darwincore_eventID")
  }
})

# Occurrence ID Present
observeEvent(input$server_darwincore_occurrenceidpresent, {
  if(input$server_darwincore_occurrenceidpresent) {
    shinyjs::show("server_darwincore_occurrenceID")
  } else {
    shinyjs::hide("server_darwincore_occurrenceID")
  }
})

# Event Type
observe({
  if("eventType" %in% input$server_darwincore_additionalterms) {
    shinyjs::show("server_darwincore_eventType")
  } else {
    shinyjs::hide("server_darwincore_eventType")
  }
})

# Event Remarks
observe({
  if("eventRemarks" %in% input$server_darwincore_additionalterms) {
    shinyjs::show("server_darwincore_eventRemarks")
  } else {
    shinyjs::hide("server_darwincore_eventRemarks")
  }
})

# Field Notes
observe({
  if("fieldNotes" %in% input$server_darwincore_additionalterms) {
    shinyjs::show("server_darwincore_fieldNotes")
  } else {
    shinyjs::hide("server_darwincore_fieldNotes")
  }
})

# Field Number
observe({
  if("fieldNumber" %in% input$server_darwincore_additionalterms) {
    shinyjs::show("server_darwincore_fieldNumber")
  } else {
    shinyjs::hide("server_darwincore_fieldNumber")
  }
})

# Habitat
observe({
  if("habitat" %in% input$server_darwincore_additionalterms) {
    shinyjs::show("server_darwincore_habitat")
  } else {
    shinyjs::hide("server_darwincore_habitat")
  }
})

# Continent
observe({
  if("continent" %in% input$server_darwincore_additionalterms) {
    shinyjs::show("server_darwincore_continent")
  } else {
    shinyjs::hide("server_darwincore_continent")
  }
})

# Coordinate Precision
observe({
  if("coordinatePrecision" %in% input$server_darwincore_additionalterms) {
    shinyjs::show("server_darwincore_coordinatePrecision")
  } else {
    shinyjs::hide("server_darwincore_coordinatePrecision")
  }
})

# Country
observe({
  if("country" %in% input$server_darwincore_additionalterms) {
    shinyjs::show("server_darwincore_country")
  } else {
    shinyjs::hide("server_darwincore_country")
  }
})

# State Province
observe({
  if("stateProvince" %in% input$server_darwincore_additionalterms) {
    shinyjs::show("server_darwincore_stateProvince")
  } else {
    shinyjs::hide("server_darwincore_stateProvince")
  }
})

# Waterbody
observe({
  if("waterbody" %in% input$server_darwincore_additionalterms) {
    shinyjs::show("server_darwincore_waterbody")
  } else {
    shinyjs::hide("server_darwincore_waterbody")
  }
})

# Locality
observe({
  if("locality" %in% input$server_darwincore_additionalterms) {
    shinyjs::show("server_darwincore_locality")
  } else {
    shinyjs::hide("server_darwincore_locality")
  }
})

# Location Remarks
observe({
  if("locationRemarks" %in% input$server_darwincore_additionalterms) {
    shinyjs::show("server_darwincore_locationRemarks")
  } else {
    shinyjs::hide("server_darwincore_locationRemarks")
  }
})

# Recorded By
observe({
  if("recordedBy" %in% input$server_darwincore_additionalterms) {
    shinyjs::show("server_darwincore_recordedBy")
  } else {
    shinyjs::hide("server_darwincore_recordedBy")
  }
})

# Institution Code
observe({
  if("institutionCode" %in% input$server_darwincore_additionalterms) {
    shinyjs::show("server_darwincore_institutionCode")
  } else {
    shinyjs::hide("server_darwincore_institutionCode")
  }
})

# Collection Code
observe({
  if("collectionCode" %in% input$server_darwincore_additionalterms) {
    shinyjs::show("server_darwincore_collectionCode")
  } else {
    shinyjs::hide("server_darwincore_collectionCode")
  }
})

# Catalog Number
observe({
  if("catalogNumber" %in% input$server_darwincore_additionalterms) {
    shinyjs::show("server_darwincore_catalogNumber")
  } else {
    shinyjs::hide("server_darwincore_catalogNumber")
  }
})

# Occurrence Remarks
observe({
  if("occurrenceRemarks" %in% input$server_darwincore_additionalterms) {
    shinyjs::show("server_darwincore_occurrenceRemarks")
  } else {
    shinyjs::hide("server_darwincore_occurrenceRemarks")
  }
})

# Vernacular Name
observe({
  if("vernacularName" %in% input$server_darwincore_additionalterms) {
    shinyjs::show("server_darwincore_vernacularName")
  } else {
    shinyjs::hide("server_darwincore_vernacularName")
  }
})

# Rights Holder
observe({
  if("rightsHolder" %in% input$server_darwincore_additionalterms) {
    shinyjs::show("server_darwincore_rightsHolder")
  } else {
    shinyjs::hide("server_darwincore_rightsHolder")
  }
})
