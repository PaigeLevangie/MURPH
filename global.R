##########################
##
## Paige Levangie
## Master Thesis Project
## Interactive Tool: MURPH
##
##########################

## ---- To Dos ----

# move code to github
# figure out why export tables won't work
# figure out why i cant see if variables are numeric for fail safes

## ---- Load Required Libraries ----

# double check these to make sure i'm actually using the package
library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(shinyWidgets)
library(shinyjs)
library(shinyDND)
library(dashboardthemes)
library(tidyverse)
library(lubridate)
library(rlang)
library(markdown)
library(bslib)
library(DT)
library(sortable)
library(tableHTML)
library(htmlTable)
library(htmlwidgets)
library(outliers)
library(sf)
library(ggmap)
library(ggspatial)
library(leaflet)
library(mapview)
library(htmlwidgets)
library(EML)
library(shinyalert)

# Source Event Core Function Script
source("reformat_event_core.R", local = TRUE)$value
