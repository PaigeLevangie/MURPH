# Generate Event Core Data Frame
generate_event <- function(data,
                           eventID = NULL, # Required OBIS Term
                           eventDate = NULL, # Required OBIS Term
                           decimalLongitude = NULL, # Required OBIS Term
                           decimalLatitude = NULL, # Required OBIS Term
                           scientificName = NULL # Required OBIS Term
                           ) {
  
  # List of required terms
  required_terms <- list(eventDate, decimalLongitude, decimalLatitude, scientificName)
  
  # Create return message for missing or incorrectly specified required terms
  if(is.null(required_terms) == TRUE) {
    
    return("A required OBIS term has not been included, and/or incorrectly specified. decimalLongitude, OBIS requires the terms decimalLatitude, scientificName, eventDate, and occurrenceStatus.See the help page for more details and examples.")
    
  }  else
    
    # if dataset doesn't have a unique event identifier
    if(is.null(eventID) == TRUE) {
      
      # Create the event table
      eventdata <- as.data.frame(data) %>%
        select(eventDate = eventDate, decimalLongitude = decimalLongitude, decimalLatitude = decimalLatitude, scientificName = scientificName) %>% 
        unique() %>% 
        mutate(eventID = paste0("event-", eventDate, "-", 1:n())) # generates eventID column
    } 
  
  # if dataset already has a unique event identifier
  else {
    
    # generate the event table
    eventdata <- as.data.frame(data) %>%
      select(eventID = eventID, eventDate = eventDate, decimalLongitude = decimalLongitude, decimalLatitude = decimalLatitude, scientificName = scientificName) %>% 
      unique()
  }
  
  # View the table
  eventdata
}