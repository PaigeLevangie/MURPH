##########################
##
## Paige Levangie
## Master Thesis Project
## Interactive Tool: MURPH
##
##########################

## ---- Load Required Libraries ----

options(shiny.sanitize.errors = FALSE)
# Change the maximum file upload size
options(shiny.maxRequestSize = 100*1024^2)

library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(shinyWidgets)
library(shinyjs)
library(shinyDND)
library(dashboardthemes)
library(tidyverse)
library(rlang)
library(markdown)
library(bslib)
library(DT)
library(sortable)
library(tableHTML)
library(htmlTable)
library(htmlwidgets)
library(sf)
library(ggmap)
library(ggspatial)
library(leaflet)
library(mapview)
library(EML)
library(shinyalert)

# Source Event Core Function Script
source("reformat_event_core.R", local = TRUE)$value

# Empty outputs folder each session
do.call(file.remove, list(list.files("outputs/", full.names = TRUE)))

