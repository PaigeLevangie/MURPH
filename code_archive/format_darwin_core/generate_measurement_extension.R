# Generate Measurement or Fact Data Frame
generate_measurementfact <- function(data, 
                                     occurrenceID = NULL, 
                                     institutionCode = NULL,
                                     collectionCode = NULL,
                                     catalogNumber = NULL,
                                     measurement_columns) {
  if(is.null(occurrenceID) == TRUE) {
    
    measurementdata <- as.data.frame(data) %>% 
      mutate(institutionCode = institutionCode,
             collectionCode = collectionCode,
             catalogNumber = catalogNumber,
             occurrenceID = case_when(is.null(institutionCode) == TRUE & is.null(collectionCode) == TRUE & is.null(catalogNumber) == TRUE ~ paste0("Institution_Dataset_", 1:n()),
                                      is.null(institutionCode) == TRUE & is.null(catalogNumber) == TRUE ~ paste0("Institution_", collectionCode, "_", 1:n()),
                                      is.null(collectionCode) == TRUE & is.null(catalogNumber) == TRUE ~ paste0(institutionCode, "_Dataset_", 1:n()),
                                      is.null(institutionCode) == TRUE ~ paste0("Institution_", collectionCode, "_", catalogNumber),
                                      is.null(collectionCode) == TRUE ~ paste0(institutionCode, "_Dataset_", catalogNumber),
                                      is.null(catalogNumber) == TRUE ~ paste0(institutionCode, "_", collectionCode, "_", 1:n()),
                                      TRUE ~ paste0(institutionCode, "_", collectionCode, "_", catalogNumber))) %>%  # generates id column
    select(occurrenceID, all_of(measurement_columns)) %>% # select all measurement or fact columns
      pivot_longer(cols = all_of(measurement_columns), # formats the data to long format
                   names_to = "measurementType", # changes the column name to measurementType
                   values_to = "measurementValue", # changes the value column name
                   values_transform = as.character) %>% # allows different types of variables to be in the same column
      filter(is.na(measurementValue) == FALSE) # removes all of the additional rows added after pivoting data
  } else {
    
    measurementdata <- as.data.frame(data) %>% 
      select(occurrenceID = occurrenceID, all_of(measurement_columns)) %>% # select all measurement or fact columns
      pivot_longer(cols = all_of(measurement_columns), # formats the data to long format
                   names_to = "measurementType", # changes the column name to measurementType
                   values_to = "measurementValue", # changes the value column name
                   values_transform = as.character) %>% # allows different types of variables to be in the same column
      filter(is.na(measurementValue) == FALSE) # removes all of the additional rows added after pivoting data
  }
  
  # View Measurement Data Frame
  measurementdata
}
