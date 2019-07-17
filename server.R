
library(tidyverse)
library(highcharter) 
library(lubridate)
library(stringr)
library(xts)
library("magrittr")


data_d <- read.csv("C:/Users/Hewitt/Desktop/recess/googleplaystore.csv")
str(data_d)


data.clean <- data_d %>%
  mutate(
    # Eliminate some characters to transform Installs to numeric
    Installs = gsub("\\+", "", as.character(Installs)),
    
    
    # Eliminate M to transform Size to numeric
    Size = gsub("M", "", Size),
    
    # Replace cells with k to 0 since it is < 1MB
    Size = ifelse(grepl("k", Size), 0, as.numeric(Size)),
    
    # Transform reviews to numeric
    Reviews = as.numeric(Reviews),
    
    # Remove currency symbol from Price, change it to numeric
    Price = as.numeric(gsub("\\$", "", as.character(Price))),
    
    # Remove text in Android version column
    Android.Ver = gsub("and up", "", Android.Ver),
    
    #remove varies with device and make it 0
    Android.Ver = gsub("Varies with device", NA, Android.Ver),
    
    #remove varies with device and make it 0
    Current.Ver = gsub("Varies with device", NA, Current.Ver),
  ) %>%
  filter(
    # Two apps had type as 0 or NA, they will be removed 
    Type %in% c("Free", "Paid")
  )

str(data.clean)

function(input, output){
 
  output$menuItem <-renderMenu({
    menuItem("Home")
    menuItem("View Dataset")
    menuItem("Summary")
    menuItem("Plot")
    menuItem("Inferences")
    menuItem("Help")
    
  })
  
  
  
  
  
}