library(shiny)
library(DT)
function(input, output){
  
    #-------------------------------------------------------------------------
    
    #rendering Menu
    
    #-------------------------------------------------------------------------    
    output$menuItem <-renderMenu({
      
          menuItem("Home")
          menuItem("View Dataset")
          menuItem("Summary")
          menuItem("Plot")
          menuItem("Inferences")
          menuItem("Help")
          
    })
#Load the csv
data1 <- read.csv('googleplaystore.csv')

#-------------------------------------------------------------------------

#rendering data

#-------------------------------------------------------------------------


output$dataTable <- renderDT(
  data1, # data
  class = "display nowrap compact", # style
  filter = "top", # location of column filters
  options = list(  # options
    scrollX = TRUE # allow user to scroll wide tables horizontally
  )
)


}



