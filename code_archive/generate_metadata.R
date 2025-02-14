# Load Libraries
library(EML)

# this document right now is me fiddling around with metadata document generation
# check out the package EML on github here https://github.com/ropensci/eml

## ---- Creating parts for the EML ----
# -- creator
creator <- eml$creator(
  individualName = eml$individualName(
    givenName = "Aaron", 
    surName = "Ellison"),
  electronicMailAddress = "fakeaddress@email.com",
  phone = "phone number",
  organizationName = "name of organization",
  onlineUrl = "link to personal website",
  address = eml$address(
    deliveryPoint = "adress line 1",
    city = "city",
    administrativeArea = "province or state",
    postalCode = "postal code",
    country = "country")
)

## Title of dataset
title <- "written as text string"

## Publisher Information
publisher <- list(
  organizationName = "organization name",
  address = list(
    deliveryPoint = "street address",
    city = "city",
    administrativeArea = "province",
    postalCode = "postal code",
    country = "country")
  )

## Date of publication
pubDate <- "written as text string"

## Dataset Keywords (this is an example)
keywordSet <- list(
  list(
    keywordThesaurus = "LTER controlled vocabulary",
    keyword = list("bacteria",
                   "carnivorous plants",
                   "genetics",
                   "thresholds")
  ),
  list(
    keywordThesaurus = "LTER core area",
    keyword =  list("populations", "inorganic nutrients", "disturbance")
  ),
  list(
    keywordThesaurus = "HFR default",
    keyword = list("Harvard Forest", "HFR", "LTER", "USA")
  ))

## Abstract for dataset - description
abstract <- "written as text string"

## Intellectual rights for dataset
intellectualRights <- "written as text string"

# Dataset contact person information
contact <- list(
    individualName = eml$individualName(
      givenName = "first", 
      surName = "last"),
    electronicMailAddress = "email address",
    address = eml$address(
      deliveryPoint = "adress line 1",
      city = "city",
      administrativeArea = "province or state",
      postalCode = "postal code",
      country = "country"),
    organizationName = "organization name",
    phone = "000-000-0000")

# methods
methods <- eml$methods(
  methodStep = eml$methodStep(
    description = "description",
    citation = "citation",
    protocol = "protocol",
    instrumentation = "instrumentation",
    dataSource = "data source"
  ),
  sampling = eml$sampling(),
  qualityControl = eml$qualityControl(),
)

# coverage
coverage <- set_coverage(begin = '2012-06-01', end = '2013-12-31',
               sci_names = "Sarracenia purpurea",
               geographicDescription = "written as text string",
               west = -122.44, east = -117.15, 
               north = 37.38, south = 30.00,
               altitudeMin = 160, altitudeMaximum = 330,
               altitudeUnits = "meter")

# Metadata provider - THIS WOULD BE MURPH
metadata_provider <- eml$metadataProvider(
  individualName = NULL,
  electronicMailAddress = "fakeaddress@email.com",
  phone = NULL,
  organizationName = "MURPH",
  onlineUrl = "link to personal website",
  address = NULL
)

# Associated parties of dataset - this would be if there are other people added on the dataset
associatedParty <- eml$associatedParty()

## ---- THIS IS COMPLICATED SO FAR: ATTRIBUTES ----
# Every column (attribute) in the dataset needs an `attributeName` (column name, as it appears in the CSV file)
# and `attributeDefinition`, a longer description of what the column contains. 
# Additional information required depends on the data type:
  
#   **Strings** (character vectors) data just needs a "definition" value, often the same as the `attributeDefinition` in this case.
# 
# **Numeric** data needs a `numberType` (e.g. "real", "integer"), and a unit. 
# 
# **Dates** need a date format.
# 
# **Factors** (enumerated domains) need to specify definitions for each of the code terms appearing in the data columns.
# This does not fit so nicely in the above table, where each attribute is a single row, so if data uses factors 
# (instead of non-enumerated strings), these definitions must be provided in a separate table.  
# The format expected of this table has three columns: `attributeName` (as before), `code`, and `definition`.  
# Note that `attributeName` is simply repeated for all codes belonging to a common attribute.

# example of factor variables where there are three attributes that are factors
# To make the code below more readable (aligning code and definitions side by side), we define these first as 
# named character vectors, and convert that to a `data.frame`. (The `dplyr::frame_data` function also permits 
# this more readable way to define data.frames inline).

i.flag <- c(R = "real",
            I = "interpolated",
            B = "bad")
variable <- c(
  control  = "no prey added",
  low      = "0.125 mg prey added ml-1 d-1",
  med.low  = "0,25 mg prey added ml-1 d-1",
  med.high = "0.5 mg prey added ml-1 d-1",
  high     = "1.0 mg prey added ml-1 d-1",
  air.temp = "air temperature measured just above all plants (1 thermocouple)",
  water.temp = "water temperature measured within each pitcher",
  par       = "photosynthetic active radiation (PAR) measured just above all plants (1 sensor)"
)
value.i <- c(
  control  = "% dissolved oxygen",
  low      = "% dissolved oxygen",
  med.low  = "% dissolved oxygen",
  med.high = "% dissolved oxygen",
  high     = "% dissolved oxygen",
  air.temp = "degrees C",
  water.temp = "degrees C",
  par      = "micromoles m-1 s-1"
)
## Write these into the data.frame format
factors <- rbind(
  data.frame(
    attributeName = "i.flag",
    code = names(i.flag),
    definition = unname(i.flag)
  ),
  data.frame(
    attributeName = "variable",
    code = names(variable),
    definition = unname(variable)
  ),
  data.frame(
    attributeName = "value.i",
    code = names(value.i),
    definition = unname(value.i)
  )
)
attributes <-
  tibble::tribble(
    ~attributeName, ~attributeDefinition,                                                 ~formatString, ~definition,        ~unit,   ~numberType,
    "run.num",    "which run number (=block). Range: 1 - 6. (integer)",                 NA,            "which run number", NA,       NA,
    "year",       "year, 2012",                                                         "YYYY",        NA,                 NA,       NA,
    "day",        "Julian day. Range: 170 - 209.",                                      "DDD",         NA,                 NA,       NA,
    "hour.min",   "hour and minute of observation. Range 1 - 2400 (integer)",           "hhmm",        NA,                 NA,       NA,
    "i.flag",     "is variable Real, Interpolated or Bad (character/factor)",           NA,            NA,                 NA,       NA,
    "variable",   "what variable being measured in what treatment (character/factor).", NA,            NA,                 NA,       NA,
    "value.i",    "value of measured variable for run.num on year/day/hour.min.",       NA,            NA,                 NA,       NA,
    "length",    "length of the species in meters (dummy example of numeric data)",     NA,            NA,                 "meter",  "real")
attributeList <- set_attributes(attributes, factors, col_classes = c("character", "Date", "Date", "Date", "factor", "factor", "factor", "numeric"))
dataTable <- list(
  entityName = "entity name",
  entityDescription = "entity description",
  physical = "physical",
  attributeList = attributeList)

## ---- Combine EML elements ----

dataset <- list(
  title = title,
  creator = creator,
  pubDate = pubDate,
  intellectualRights = intellectualRights,
  abstract = abstract,
  metadata_provider = metadata_provider,
  associatedParty = associatedParty,
  keywordSet = keywordSet,
  coverage = coverage,
  contact = contact,
  methods = methods,
  dataTable = dataTable)

## ---- Generate EML File ----

# generate file
my_eml <- list(
  packageId = uuid::UUIDgenerate(),
  system = "uuid", # type of identifier
  dataset = dataset)

# Write the metadata document
write_eml(my_eml, "MURPH/ex.xml")
