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