# Reformat data to event core format
# MISSING MEASUREMENT UNIT FROM MEASUREMENT OR FACT TABLE - NOT REQUIRED BUT RECOMMENDED
event_core <- function(data,
                       eventID = NULL, # Required OBIS Term
                       eventDate = NULL, # Required OBIS Term
                       decimalLongitude = NULL, # Required OBIS Term
                       decimalLatitude = NULL, # Required OBIS Term
                       scientificName = NULL, # Required OBIS Term
                       occurrenceStatus = "present", # Required OBIS Term
                       basisOfRecord = "HumanObservation", # Required OBIS Term
                       occurrenceID = NULL, # Required OBIS Term
                       measurement_columns,
                       # The Following Terms are Not Required But can be used
                       eventType = NULL, # Optional Term for Event Table
                       eventRemarks = NULL, # Optional Term for Event Table
                       eventTime = NULL, # Optional Term for Event Table
                       fieldNotes = NULL, # Optional Term for Event Table
                       fieldNumber = NULL, # Optional Term for Event Table
                       habitat = NULL, # Optional Term for Event Table
                       continent = NULL, # Optional Term for Occurrence Table
                       coordinatePrecision = NULL, # Optional Term for Occurrence Table
                       country = NULL, # Optional Term for Occurrence Table
                       stateProvince = NULL, # Optional Term for Occurrence Table
                       waterbody = NULL, # Optional Term for Occurrence Table
                       locality = NULL, # Optional Term for Occurrence Table
                       locationRemarks = NULL, # Optional Term for Occurrence Table
                       recordedBy = NULL, # Optional Term for Occurrence Table
                       institutionCode = NULL, # Optional Term for Occurrence Table
                       collectionCode = NULL, # Optional Term for Occurrence Table
                       catalogNumber = NULL, # Optional Term for Occurrence Table
                       occurrenceRemarks = NULL, # Optional Term for Occurrence Table
                       vernacularName = NULL, # Optional Term for Occurrence Table
                       rightsHolder = NULL # Optional Term for Occurrence Table
                       ) {
  
  # Rename all variables in dataset
  function_dataset <- data %>% 
    rename(any_of(c(eventID = eventID,
           eventDate = eventDate,
           decimalLongitude = decimalLongitude, 
           decimalLatitude = decimalLatitude, 
           scientificName = scientificName, 
           occurrenceStatus = occurrenceStatus, 
           basisOfRecord = basisOfRecord,
           occurrenceID = occurrenceID,
           eventType = eventType,
           eventRemarks = eventRemarks,
           eventTime = eventTime, 
           fieldNotes = fieldNotes, 
           fieldNumber = fieldNumber,
           habitat = habitat,
           continent = continent, 
           coordinatePrecision = coordinatePrecision ,
           country = country, 
           stateProvince = stateProvince,
           waterbody = waterbody,
           locality = locality, 
           locationRemarks = locationRemarks,
           recordedBy = recordedBy, 
           institutionCode = institutionCode, 
           collectionCode = collectionCode, 
           catalogNumber = catalogNumber, 
           occurrenceRemarks = occurrenceRemarks,
           vernacularName = vernacularName,
           rightsHolder = rightsHolder)))
  
  # if any of the required terms are null or incorrectly specified, return error
  if(is.null(decimalLongitude) == TRUE | is.null(decimalLatitude) == TRUE | is.null(scientificName) == TRUE | is.null(occurrenceStatus) == TRUE | is.null(eventDate) == TRUE | !basisOfRecord %in% c("HumanObservation", "PreservedSpecimen", "FossilSpeciman", "LivingSpecimen", "MachineObservation") | !occurrenceStatus %in% c("present", "absent")) {
    
    # create the error message for the required terms
    return("A required term has not been included, and/or incorrectly specified. decimalLongitude, decimalLatitude, scientificName, eventDate, and occurrenceStatus must be provided. basisOfRecord must be one of the following: HumanObservation, FossilSpecimen, LivingSpecimen, PreservedSpecimen, or MachineObservation. See help page for more details and examples.")
  } else
    
    # If dataset doesn't have a unique event or occurrence identifier
    if(is.null(eventID) == TRUE & is.null(occurrenceID) == TRUE) {
      
      # Create the event table
      eventdata <- as.data.frame(function_dataset) %>%
        select(eventDate, decimalLongitude, decimalLatitude, any_of(c('eventType','eventRemarks','eventTime','fieldNotes','fieldNumber','habitat'))) %>% 
        unique() %>% 
        mutate(eventID = paste0("event-", eventDate, "-", 1:n())) # generates eventID column
      
      # Create the occurrence table
      occurrencedata <- as.data.frame(function_dataset) %>% 
        select(eventDate, decimalLongitude, decimalLatitude, scientificName, any_of(c('continent','coordinatePrecision','country','stateProvince',
                                                                                      'waterbody','locality','locationRemarks','recordedBy','institutionCode',
                                                                                      'collectionCode','catalogNumber','occurrenceRemarks','vernacularName','rightsHolder',
                                                                                      'eventType','eventRemarks','eventTime','fieldNotes','fieldNumber','habitat'))) %>% 
        left_join(., eventdata) %>% # matches occurrences with correct eventID - double checking
        select(eventID, scientificName, any_of(c('continent','coordinatePrecision','country','stateProvince',
                                                 'waterbody','locality','locationRemarks','recordedBy','institutionCode',
                                                 'collectionCode','catalogNumber','occurrenceRemarks','vernacularName','rightsHolder'))) %>% 
        mutate(occurrenceID = paste0(eventID,"-O-", 1:n()), # generates occurrenceID column
               occurrenceStatus = occurrenceStatus,
               basisOfRecord = basisOfRecord)
               
      # Create the measurement or fact table
      measurementdata <- as.data.frame(function_dataset) %>% 
        select(eventDate, decimalLongitude, decimalLatitude, scientificName, all_of(measurement_columns)) %>% 
        left_join(., occurrencedata) %>% # matches measurement columns with correct occurrenceID
        select(occurrenceID, scientificName, all_of(measurement_columns)) %>% 
        pivot_longer(cols = all_of(measurement_columns), # reformats data to long format
                     names_to = "measurementType", # renaming columns to match darwin core
                     values_to = "measurementValue",
                     values_transform = as.character) %>% 
        filter(is.na(measurementValue) == FALSE) # removes all NA rows from pivot
    }
  
  # If dataset doesn't have a unique event identifier but HAS a unique occurrence identifier 
  else if(is.null(eventID) == TRUE & is.null(occurrenceID) == FALSE) {
    
    # Create the event table
    eventdata <- as.data.frame(function_dataset) %>%
      select(eventDate, decimalLongitude, decimalLatitude, any_of(c('eventType','eventRemarks','eventTime','fieldNotes','fieldNumber','habitat'))) %>% 
      unique() %>% 
      mutate(eventID = paste0("event-", eventDate, "-", 1:n())) # generates eventID column
    
    # Create the occurrence table
    occurrencedata <- as.data.frame(function_dataset) %>% 
      select(eventDate, occurrenceID, decimalLongitude, decimalLatitude, scientificName, any_of(c('continent','coordinatePrecision','country','stateProvince',
                                                                                                  'waterbody','locality','locationRemarks','recordedBy','institutionCode',
                                                                                                  'collectionCode','catalogNumber','occurrenceRemarks','vernacularName','rightsHolder',
                                                                                                  'eventType','eventRemarks','eventTime','fieldNotes','fieldNumber','habitat'))) %>% 
      left_join(., eventdata) %>% # matches occurrences with correct eventID
      select(eventID, occurrenceID, scientificName, any_of(c('continent','coordinatePrecision','country','stateProvince',
                                                             'waterbody','locality','locationRemarks','recordedBy','institutionCode',
                                                             'collectionCode','catalogNumber','occurrenceRemarks','vernacularName','rightsHolder'))) %>% 
      mutate(occurrenceStatus = occurrenceStatus,
             basisOfRecord = basisOfRecord)
    
    # Create the measurement or fact table
    measurementdata <- as.data.frame(function_dataset) %>% 
      select(occurrenceID, scientificName, all_of(measurement_columns)) %>% 
      pivot_longer(cols = all_of(measurement_columns), # reformats data to long format
                   names_to = "measurementType", # renaming columns to match darwin core
                   values_to = "measurementValue",
                   values_transform = as.character) %>% 
      filter(is.na(measurementValue) == FALSE) # removes all NA rows from pivot
  }
  
  # If dataset has a unique event identifier but not a unique occurrence identifier
  else if(is.null(eventID) == FALSE & is.null(occurrenceID) == TRUE) {
    
    # Create the event table
    eventdata <- as.data.frame(function_dataset) %>%
      select(eventID, eventDate, decimalLongitude, decimalLatitude, any_of(c('eventType','eventRemarks','eventTime','fieldNotes','fieldNumber','habitat'))) %>% 
      unique()
    
    # Create the occurrence table
    occurrencedata <- as.data.frame(function_dataset) %>% 
      select(eventID, eventDate, decimalLongitude, decimalLatitude, scientificName, any_of(c('continent','coordinatePrecision','country','stateProvince',
                                                                                             'waterbody','locality','locationRemarks','recordedBy','institutionCode',
                                                                                             'collectionCode','catalogNumber','occurrenceRemarks','vernacularName','rightsHolder',
                                                                                             'eventType','eventRemarks','eventTime','fieldNotes','fieldNumber','habitat'))) %>% 
      left_join(., eventdata) %>% # matches occurrences with correct eventID
      select(eventID, scientificName, any_of(c('continent','coordinatePrecision','country','stateProvince',
                                               'waterbody','locality','locationRemarks','recordedBy','institutionCode',
                                               'collectionCode','catalogNumber','occurrenceRemarks','vernacularName','rightsHolder'))) %>% 
      mutate(occurrenceID = paste0(eventID,"-O-", 1:n()), # generates occurrenceID column
             occurrenceStatus = occurrenceStatus,
             basisOfRecord = basisOfRecord)
    
    # Create the measurement or fact table
    measurementdata <- as.data.frame(function_dataset) %>% 
      select(eventID, eventDate, decimalLongitude, decimalLatitude, scientificName, all_of(measurement_columns)) %>% 
      left_join(., occurrencedata) %>% # matches measurement columns with correct occurrenceID
      select(occurrenceID, scientificName, all_of(measurement_columns)) %>% 
      pivot_longer(cols = all_of(measurement_columns), # reformats data to long format
                   names_to = "measurementType", # renaming columns to match darwin core
                   values_to = "measurementValue",
                   values_transform = as.character) %>% 
      filter(is.na(measurementValue) == FALSE) # removes all NA rows from pivot
  }
  
  # If dataset has both a unique event and occurence identifier
  else if(is.null(eventID) == FALSE & is.null(occurrenceID) == FALSE) {
    
    # Create the event table
    eventdata <- as.data.frame(function_dataset) %>%
      select(eventID, eventDate, decimalLongitude, decimalLatitude, any_of(c('eventType','eventRemarks','eventTime','fieldNotes','fieldNumber','habitat'))) %>% # select all event columns
      unique()
    
    # Create the occurrence table
    occurrencedata <- as.data.frame(function_dataset) %>% 
      select(eventID, occurrenceID, scientificName, any_of(c('continent','coordinatePrecision','country','stateProvince',
                                                             'waterbody','locality','locationRemarks','recordedBy','institutionCode',
                                                             'collectionCode','catalogNumber','occurrenceRemarks','vernacularName','rightsHolder'))) %>% 
      mutate(occurrenceStatus = occurrenceStatus,
             basisOfRecord = basisOfRecord)
    
    # Create the measurement or fact table
    measurementdata <- as.data.frame(function_dataset) %>% 
      select(occurrenceID, scientificName, all_of(measurement_columns)) %>% 
      pivot_longer(cols = all_of(measurement_columns), # reformats data to long format
                   names_to = "measurementType", # renaming columns to match darwin core
                   values_to = "measurementValue",
                   values_transform = as.character) %>% 
      filter(is.na(measurementValue) == FALSE) # removes all NA rows from pivot
  }
  
  # Export dataframes into .csv's
  write.csv(eventdata, "outputs/report_darwincore_eventdata.csv")
  write.csv(occurrencedata, "outputs/report_darwincore_occurrencedata.csv")
  write.csv(measurementdata, "outputs/report_darwincore_measurementdata.csv")
  
}
