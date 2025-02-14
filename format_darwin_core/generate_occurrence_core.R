# Generate Occurrence Data Frame
generate_occurrence <- function(data, 
                                occurrenceID = NULL, # Required OBIS Term
                                eventDate = NULL, # Required OBIS Term
                                decimalLongitude = NULL, # Required OBIS Term
                                decimalLatitude = NULL, # Required OBIS Term
                                scientificName = NULL, # Required OBIS Term
                                occurrenceStatus = "present", # Required OBIS Term
                                basisOfRecord = "HumanObservation", # Required OBIS Term
                                institutionCode = NULL,
                                collectionCode = NULL,
                                catalogNumber = NULL) {
  
  # List of required terms
  required_terms <- list(eventDate, decimalLongitude, decimalLatitude, scientificName, scientificNameID, occurrenceStatus, basisOfRecord)
  
  # Create return message for missing or incorrectly specified required terms
  if(is.null(required_terms) == TRUE) {
    
    return("A required OBIS term has not been included, and/or incorrectly specified. decimalLongitude, OBIS requires the terms decimalLatitude, scientificName, eventDate, and occurrenceStatus.See the help page for more details and examples.")
    
  } else if(is.null(occurrenceID) == TRUE) {
    
    # generate the occurrence table
    occurrencedata <- as.data.frame(data) %>% 
      mutate(institutionCode = institutionCode,
             collectionCode = collectionCode,
             catalogNumber = catalogNumber,
             occurrenceID = case_when(is.null(institutionCode) == TRUE & is.null(collectionCode) == TRUE & is.null(catalogNumber) == TRUE ~ paste0("Institution_Dataset_", 1:n()),
                                      is.null(institutionCode) == TRUE & is.null(catalogNumber) == TRUE ~ paste0("Institution_", collectionCode, "_", 1:n()),
                                      is.null(collectionCode) == TRUE & is.null(catalogNumber) == TRUE ~ paste0(institutionCode, "_Dataset_", 1:n()),
                                      is.null(institutionCode) == TRUE ~ paste0("Institution_", collectionCode, "_", catalogNumber),
                                      is.null(collectionCode) == TRUE ~ paste0(institutionCode, "_Dataset_", catalogNumber),
                                      is.null(catalogNumber) == TRUE ~ paste0(institutionCode, "_", collectionCode, "_", 1:n()),
                                      TRUE ~ paste0(institutionCode, "_", collectionCode, "_", catalogNumber)), # generates id column
             occurrenceStatus = occurrenceStatus,
             basisOfRecord = basisOfRecord) %>% 
      select(occurrenceID, institutionCode, collectionCode, catalogNumber, eventDate = eventDate, decimalLongitude = decimalLongitude, decimalLatitude = decimalLatitude, scientificName = scientificName, occurrenceStatus, basisOfRecord)
  } else {
    
    # generate the occurrence table
    occurrencedata <- as.data.frame(data) %>% 
      mutate(institutionCode = institutionCode,
             collectionCode = collectionCode,
             catalogNumber = catalogNumber,
             occurrenceID = occurrenceID,
             occurrenceStatus = occurrenceStatus,
             basisOfRecord = basisOfRecord) %>% 
      select(occurrenceID, institutionCode, collectionCode, catalogNumber, eventDate = eventDate, decimalLongitude = decimalLongitude, decimalLatitude = decimalLatitude, scientificName = scientificName, occurrenceStatus, basisOfRecord)
  }
  
  # View the table
  occurrencedata
}
