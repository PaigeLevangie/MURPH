##########################
##
## Paige Levangie
## Master Thesis Project
## Interactive Tool: MURPH
## 
## General Tool Functions
##
##########################

# Not sure if some functions I create for the tool need to be in a separate script
# or split up more than this yet... 

## ---- Server Set-Up Script Functions ----

# Create function to calculate variable mode
find_variablemode <- function(v) {
  # find all unique values in variable                
  unique_values <- unique(v)
  # determine frequency of unique values and return highest
  unique_values[which.max(tabulate(match(v, unique_values)))]
}

