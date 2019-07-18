#library(plotly)
function(input, output){
  googleplaystore <- read.csv("D:/BEN/R Data Analysis/Software and sample data/googleplaystore.csv")
  df<-data.frame(googleplaystore) 
  
  #Renders the menu in the sidebar
  output$menuItem <-renderMenu({
    menuItem("Home")
    menuItem("View Dataset")
    menuItem("Summary")
    menuItem("Plot")
    menuItem("Inferences")
    menuItem("Help")
    })
  
  #Prints overall summary
  output$summary <- renderPrint({
    summary(googleplaystore)
  })
  
  #Print summary by selection of the variable name
  output$summary1<-renderPrint({
    if(input$variable=="Category"){
     print(summary(googleplaystore$Category)
     )
    }
    if(input$variable=="Rating"){
      print(summary(googleplaystore$Rating)
      )
    }
    if(input$variable=="Reviews"){
      print(summary(googleplaystore$Reviews)
      )
    }
    if(input$variable=="Size"){
      print(summary(googleplaystore$Size)
      )
    }
    if(input$variable=="Installs"){
      print(summary(googleplaystore$Installs)
      )
    }
    if(input$variable=="Last.Updated"){
      print(summary(googleplaystore$Last.Updated)
      )
    }
    if(input$variable=="Price"){
      print(summary(googleplaystore$Price)
      )
    }
    if(input$variable=="Content.Rating"){
      print(summary(googleplaystore$Content.Rating)
      )
    }
    if(input$variable=="Current.Ver"){
      print(summary(googleplaystore$Current.Ver)
      )
    }
    
  })
  
  #Bar Plot
  output$plot<-renderPlot({
    plot(googleplaystore$Price)
  })
  
  
  
}


  
