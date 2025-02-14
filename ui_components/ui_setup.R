fluidPage(
  # Upload data file into MURPH
  uiOutput("ui_setup_upload"),
  # Tool Set-up Options
  uiOutput("ui_setup_toolsetup"),
  # Initiate Tool Functionality
  uiOutput("ui_setup_begin"),
  # Download Outputs
  uiOutput("ui_setup_download")
)