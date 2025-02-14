# Output for "Upload" section
output$ui_setup_upload <- renderUI({
  tagList(
    h1("Upload"),
    p("Using the upload File option below, upload your research data as a .csv file to use within MURPH. Once finished, click the Update Data button."),
    fileInput("server_setup_fileinput", label = "Upload Data File"),
    actionButton("server_setup_updatedata", label = "Update Data"),
    hr()
  )
})

# enable/disable options for tabs
output$ui_setup_toolsetup <- renderUI({
  tagList(
    h1("Data Set-Up"),
    p("Does the uploaded dataset include coordinates? Do you require help reformatting data to comply with OBIS data standards?"),
    fluidRow(
      column(width = 4,
             switchInput("server_setup_enablemap", label = "Coordinate Data", handleWidth = 75),
             switchInput("server_setup_enabledarwincore", label = "Restructure Data", handleWidth = 75)),
    )
  )
})


# Begin button
output$ui_setup_begin <- renderUI({
  tagList(
    p("Ready to create outputs, click Begin!"),
    actionButton("server_setup_begin", label = "Ready")
  )
})

# Download Report Button
output$ui_setup_download <- renderUI({
  tagList(
    hr(),
    h1("Download MURPH Outputs"),
    p("After you are finished using MURPH to creat outputs, click the Download Ouputs button below to receive a .zip file containing everything you have created in this session."),
    downloadButton("server_setup_download", label = "Download Outputs"),
    p(" "),
    hr()
  )
})

# Download Report
output$server_setup_download <- downloadHandler(
  filename = 'files.zip',
  content = function(file) {
    
    zip(zipfile = file, files = file.path("outputs", list.files("outputs/")))
  },
  
  contentType = "application/zip"
)


