## darwin core formatting
## Paige Levangie

#### Notes ####

# Need to incorporate the darwin core variable name matching into the functions
# not sure if this will be done in the function arguments or through fuzzymatch
# possibly make REQUIRED terms for the event/occurrence core function arguments

# EVENT CORE WILL BE A LITTLE MORE COMPLICATED - for measurement of fact tables possibility of multiple

# I added a website for the required dwc terms for uploaded sampling-event datasets to GBIF
# it's bookmarked under MSP sites on my computer for later use.

# EVENT ID NEEDS TO GO IN THE MEASUREMENT OR FACT TABLE

# starting to get more functions created and updated as things get developed
# each function will be contained within its' own R script in this folder


#### Load Libraries ####
library(tidyverse)

#### read in test dataset ####
data <- read.delim("MURPH/skatetestdata.txt")

#### Format test dataset ####

# format the test dataset to help figure out a basic process

# find unique events
unique(data$lot_id)
# there are 590 unique lot_ids

# create occurrence table
occurancedata <- data %>% 
  select(lot_id, year, month, day, hour, minute, time_period, tow, region, species_confirmed, species_dfo, tide_height, cloud_cover, weather, temperature, capture_details, capture_event, collector, lat.ddmm.ss, long.ddmm.ss, northing, easting) %>% 
  mutate(occurance_id = paste0("O-", row_number()))
# create event table
eventdata <- data %>% 
  select(lot_id, record_subtype, contact, depth, bottom_temperature, bottom_salinity) %>% 
  unique()
# create measurement of fact table
measurementdata <-  data %>% 
  select(-lot, -X, -record_subtype, -contact, -depth, -bottom_temperature, -bottom_salinity) %>% 
  left_join(., occurancedata, by = c("lot_id", "year", "month", "day", "hour", "minute", "time_period", "tow", "region", "species_confirmed", "species_dfo", "tide_height", "cloud_cover", "weather", "temperature", "capture_details", "capture_event", "collector", "lat.ddmm.ss", "long.ddmm.ss", "northing", "easting")) %>% 
  select(-lot_id, -year, -month, -day, -hour, -minute, -time_period, -tow, -region, -species_confirmed, -species_dfo, -tide_height, -cloud_cover, -weather, -temperature, -capture_details, -capture_event, -collector, -lat.ddmm.ss, -long.ddmm.ss, -northing, -easting, -length_type, -tlength_type, -width_type, -swidth_type, -clength_type) %>% 
  pivot_longer(cols = c(tag_id, tag_colour, tag_active, tag_applied, tag_recapture, sex, total_length, tail_length, maximum_width, spiracle_width, clasper_length, clasper_development, alar_spines, alar_development, alar_rows, malar_spines, malar_development, midline, pelvic_thorns, eyespots, eyespots_large, eyespots_small, eyespots_number, whip, empty_full, cloaca_extruded, weight_est, weight_note, unadj_weight_kg, weight_kg, unadj_weight_lb, weight_lb, finclip, health_on_capture, health_on_release, notes, error_check, error_note),
               names_to = "measurement_type",
               values_to = "measurement_value",
               values_transform = as.character) %>% 
  filter(is.na(measurement_value) == FALSE)

# Next I need to generalize this process into various functions

#### Occurrence Core ####

# if there are no "events" and each row of the data represents one recorded observation
# you need to follow the occurrence core format

# OBIS currently has 8 required terms (possibly more, need to do some more looking)
# occurrenceID
# eventDate
# decimalLongitude
# decimalLatitude
# scientificName
# scientificNameID
# occurrenceStatus
# basisOfRecord


#### Event Core ####

# you use the event core format if there's a larger event that has its own
# variables and multiple occurrences within that event
# sometimes a parent event is needed if events become "nested"

# Reformat data to event core format
# MISSING MEASUREMENT UNIT FROM MEASUREMENT OR FACT TABLE
event_core <- function(data,
                       eventID = NULL,
                       eventDate = NULL, 
                       decimalLongitude = NULL, 
                       decimalLatitude = NULL,
                       scientificName = NULL, 
                       occurrenceStatus = "present",
                       basisOfRecord = "HumanObservation", 
                       occurrenceID = NULL, 
                       measurement_columns) {
  
  # if any of the required terms are null or incorrectly specified, return error
  if(is.null(decimalLongitude) == TRUE | is.null(decimalLatitude) == TRUE | is.null(scientificName) == TRUE | is.null(occurrenceStatus) == TRUE | is.null(eventDate) == TRUE | !basisOfRecord %in% c("HumanObservation", "PreservedSpecimen", "FossilSpeciman", "LivingSpecimen", "MachineObservation") | !occurrenceStatus %in% c("present", "absent")) {
    
    # create the error message for the required terms
    return("A required term has not been included, and/or incorrectly specified. decimalLongitude, decimalLatitude, scientificName, eventDate, and occurrenceStatus must be provided. basisOfRecord must be one of the following: HumanObservation, FossilSpecimen, LivingSpecimen, PreservedSpecimen, or MachineObservation. See help page for more details and examples.")
  } else
  
  # If dataset doesn't have a unique event or occurrence identifier
  if(is.null(eventID) == TRUE & is.null(occurrenceID) == TRUE) {
    
    # Create the event table
    eventdata <- as.data.frame(data) %>%
      select(eventDate = eventDate, decimalLongitude = decimalLongitude, decimalLatitude = decimalLatitude) %>% 
      unique() %>% 
      mutate(eventID = paste0("event-", eventDate, "-", 1:n())) # generates eventID column
    
    # Create the occurrence table
    occurrencedata <- as.data.frame(data) %>% 
      select(eventDate = eventDate, decimalLongitude = decimalLongitude, decimalLatitude = decimalLatitude, scientificName = scientificName) %>% 
      left_join(., eventdata) %>% # matches occurrences with correct eventID
      select(eventID, scientificName = scientificName) %>% 
      mutate(occurrenceID = paste0("O-", 1:n()), # generates occurrenceID column
             occurrenceStatus = occurrenceStatus,
             basisOfRecord = basisOfRecord)
    
    # Create the measurement or fact table
    measurementdata <- as.data.frame(data) %>% 
      select(eventDate = eventDate, decimalLongitude = decimalLongitude, decimalLatitude = decimalLatitude, scientificName = scientificName, all_of(measurement_columns)) %>% 
      left_join(., occurrencedata) %>% # matches measurement columns with correct occurrenceID
      select(occurrenceID, all_of(measurement_columns)) %>% 
      pivot_longer(cols = all_of(measurement_columns), # reformats data to long format
                   names_to = "measurementType", # renaming columns to match darwin core
                   values_to = "measurementValue",
                   values_transform = as.character) %>% 
      filter(is.na(measurementValue) == FALSE) # removes all NA rows from pivot
  }
  
  # If dataset doesn't have a unique event identifier but HAS a unique occurrence identifier 
  else if(is.null(eventID) == TRUE & is.null(occurrenceID) == FALSE) {
    
    # Create the event table
    eventdata <- as.data.frame(data) %>%
      select(eventDate = eventDate, decimalLongitude = decimalLongitude, decimalLatitude = decimalLatitude) %>% 
      unique() %>% 
      mutate(eventID = paste0("event-", eventDate, "-", 1:n())) # create eventID
    
    # Create the occurrence table
    occurrencedata <- as.data.frame(data) %>% 
      select(eventDate = eventDate, decimalLongitude = decimalLongitude, decimalLatitude = decimalLatitude, scientificName = scientificName) %>% 
      left_join(., eventdata) %>% # matches occurrences with correct eventID
      select(eventID, occurrenceID = occurrenceID, scientificName = scientificName) %>% 
      mutate(occurrenceStatus = occurrenceStatus,
             basisOfRecord = basisOfRecord)

    # Create the measurement or fact table
    measurementdata <- as.data.frame(data) %>% 
      select(occurrenceID = occurrenceID, all_of(measurement_columns)) %>% 
      pivot_longer(cols = all_of(measurement_columns), # reformats data to long format
                   names_to = "measurementType", # renaming columns to match darwin core
                   values_to = "measurementValue",
                   values_transform = as.character) %>% 
      filter(is.na(measurementValue) == FALSE) # removes all NA rows from pivot
  }
  
  # If dataset has a unique event identifier but not a unique occurrence identifier
  else if(is.null(eventID) == FALSE & is.null(occurrenceID) == TRUE) {
    
    # Create the event table
    eventdata <- as.data.frame(data) %>%
      select(eventID = eventID, eventDate = eventDate, decimalLongitude = decimalLongitude, decimalLatitude = decimalLatitude) %>% 
      unique()

    # Create the occurrence table
    occurrencedata <- as.data.frame(data) %>% 
      select(eventID = eventID, eventDate = eventDate, decimalLongitude = decimalLongitude, decimalLatitude = decimalLatitude, scientificName = scientificName) %>% 
      left_join(., eventdata) %>% # matches occurrences with correct eventID
      select(eventID, scientificName = scientificName) %>% 
      mutate(occurrenceID = paste0("O-", 1:n()), # generates occurrenceID column
             occurrenceStatus = occurrenceStatus,
             basisOfRecord = basisOfRecord)
    
    # Create the measurement or fact table
    measurementdata <- as.data.frame(data) %>% 
      select(eventID = eventID, eventDate = eventDate, decimalLongitude = decimalLongitude, decimalLatitude = decimalLatitude, scientificName = scientificName, all_of(measurement_columns)) %>% 
      left_join(., occurrencedata) %>% # matches measurement columns with correct occurrenceID
      select(occurrenceID, all_of(measurement_columns)) %>% 
      pivot_longer(cols = all_of(measurement_columns), # reformats data to long format
                   names_to = "measurementType", # renaming columns to match darwin core
                   values_to = "measurementValue",
                   values_transform = as.character) %>% 
      filter(is.na(measurementValue) == FALSE) # removes all NA rows from pivot
  }
  
  # If dataset has both a unique event and occurence identifier
  else if(is.null(eventID) == FALSE & is.null(occurrenceID) == FALSE) {
    
    # Create the event table
    eventdata <- as.data.frame(data) %>%
      select(eventID = eventID, eventDate = eventDate, decimalLongitude = decimalLongitude, decimalLatitude = decimalLatitude) %>% # select all event columns
      unique()

    # Create the occurrence table
    occurrencedata <- as.data.frame(data) %>% 
      select(eventID = eventID, occurrenceID = occurrenceID, scientificName = scientificName) %>% 
      mutate(occurrenceStatus = occurrenceStatus,
             basisOfRecord = basisOfRecord)

    # Create the measurement or fact table
    measurementdata <- as.data.frame(data) %>% 
      select(occurrenceID = occurrenceID, all_of(measurement_columns)) %>% 
      pivot_longer(cols = all_of(measurement_columns), # reformats data to long format
                   names_to = "measurementType", # renaming columns to match darwin core
                   values_to = "measurementValue",
                   values_transform = as.character) %>% 
      filter(is.na(measurementValue) == FALSE) # removes all NA rows from pivot
  }
  
  # view the three tables
  # i'll make this also write these into csv's or an excel workbook
  return(list(eventdata, occurrencedata, measurementdata))
}


## ---- Darwin core terms ----

# this list of DARWIN CORE terms and definitions was taken from Canadensys
# https://community.canadensys.net/publication/data-publication-guide
dwc_terms <- readxl::read_xlsx("C:/users/paige/Downloads/Darwin Core - List of terms.xlsx") %>% 
  select(category = Category, term = 'Term name', definition = 'Term definition', example = 'Term examples') %>% 
  mutate(term = str_remove(term, pattern = "dcterms:"),
         category = str_remove(category, pattern = "dcterms:"))

## ---- OBIS Approved formats ----

# these formats follow darwin core with extensions 
# this is how I think i will format data - following the ENV-DATA approach
# because when uploading data to OBIS they hold more than just occurance data

# First create the event core table, and link things together with an eventID and parentEventID.
# then you are able to create extension tables:
#   occurrance table and extended occurance, and measurement or fact tables.
# 
# use event core when: data contains abiotic measurements, or measurements related to the entire sample not just the speciman, or if SPECIFIC details about how it was sampled are there.
# use occurance core when: no information about how the sample was taken are present, no abiotic measurements, each speciman is a single occurance record.
# 
# if the event core is used, the measurement of fact table is linked to the occurance extension table with the occurance id:
# occuranceID
# measurementTypeID
# measurementFactID
# measurementUnitID

## ---- EML ----

# OBIS and GBIF uses EML for their metadata format
# https://manual.obis.org/eml/
# NOT SURE IF THE INFO IN METADATA NEEDS TO BE REPEATED IN THE DATASET
# EXAMPLE: RIGHTS HOLDER AND INSTITUTION CODE
# - maybe only if multiple datasets

# must include the following terms:
# title, citation, contact, abstract

# FOR METADATA PROVIDER - IT WOULD BE WHOEVER GENERATED THE METADATA I.E MURPH

# not sure if these are also required:
# description, publishing organisation, type, license, creator(s), metadata provider(s)

## ---- Event Core Set-up ----

# use event core when: data contains abiotic measurements, or measurements related to the entire sample not just the speciman, or if SPECIFIC details about how it was sampled are there.

## First, set-up event core possible terms
# list of terms to include
eventcore_terms <- c("eventID", "parentEventID", "samplingProtocol",
                     "samplingEffort", "eventDate", "eventTime",
                     "startDayOfYear", "endDayOfYear", "year", "month",
                     "day", "verbatimEventDate", "habitat", "fieldNumber",
                     "fieldNotes", "eventRemarks", "type", "modified", 
                     "language", "license", "rightsHolder", "accessRights", 
                     "bibliographicCitation", "references", "institutionID", 
                     "collectionID", "datasetID", "institutionCode")  

# the event core csv MUST have the following:
# eventID, eventDate, samplingProtocol


## Second, set up occurrence table possible terms
occuranceextension_terms <- dwc_terms %>% 
  filter(category %in% c("Occurrence", "Location", "Taxon", "Identification", 
                         "GeologicalContext", "ResourceRelationship")) %>% 
  select(term) %>% 
  rbind(., "id")

# must include the following terms:
# occurenceID, basisOfRecord, scientificName, eventDate

## third, set up measurement or fact extension table possible terms
measurementextension_terms <- c("id", "occurenceID", "measurementType", 
                                "measurementTypeID", "measurementValue", 
                                "measurementValueID", "measurementUnit", 
                                "measurementUnitID")

## ---- Other Shit ----

# All the below terms are downloaded from the NERC vocab server (NVS)
# the collections were determined from OBIS manual for data formats
# https://obis.org/manual/dataformat/


# these are general terms that standardize aspects of data that usually have 
# many different formats, so if variable names match them or are similar
# they should be changed to them

# read in all the cvs's with the reccommended terms to use for OBIS formatting
bodc <- read.csv("approvedterms/bodc.csv") # not used for now
obis <- read.csv("approvedterms/obis.csv")
sex <- read.csv("approvedterms/sex.csv")
seadatanet <- read.csv("approvedterms/seadatanet.csv")
lifestage <- read.csv("approvedterms/lifestage.csv")
ices <- read.csv("approvedterms/ices.csv")

# measurementType
measurementType <- obis
# measurementValue
measurementValue <- rbind(sex, seadatanet, lifestage, ices)
# measurementUnit
measurementUnit <- read.csv("approvedterms/units.csv")
