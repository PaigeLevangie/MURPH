fluidPage(
  shinyjs::useShinyjs(),
  useShinyalert(),
  sidebarLayout(
    sidebarPanel = sidebarPanel(
      uiOutput("ui_darwincore_selectidterms"),
      uiOutput("ui_darwincore_additionalselect"),
      uiOutput("ui_darwincore_generate"),
      width = 3),
    mainPanel = mainPanel(
      uiOutput("ui_darwincore_formatrequired"),
      uiOutput("ui_darwincore_formatadditional"),
      uiOutput("ui_darwincore_formatmetadata"))
  )
)
