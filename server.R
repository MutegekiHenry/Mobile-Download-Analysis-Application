library(plotly)
library(plotrix)
library(ggplot2)
library(RColorBrewer)
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
  
  #Density plot for Genre/Install distribution  
  output$plot<-renderPlot({
    ggplot(data = googleplaystore[1:200,], aes(x = Genres, y = Installs)) +
      geom_violin(alpha = 0) +
      geom_jitter(alpha = 0.5, color = "tomato")
  })
  
  #Pie Chart for category
  output$plot1<-renderPlot({
    slices <- c(5535,1972,1144,843,463,460,424)
    lbls <- c("Other","Family", "Game", "Tools", "Medical",
              "Business","Productivity")
    pie3D(slices,labels=lbls,explode=0.1,
          main="Pie Chart for App Category")
  })
  
  #Pie Chart for Installs
  output$plot2<-renderPlot({
    ver_count<-c(2451,1501,1375,1362,980,652,2520)
    version<-c("4.1+","4.0.3+","4.0+","Varies","4.4+","2.3+","Other")
    pie3D(ver_count,labels=version,explode=1,
          main="Pie Chart for App Versions")
  })
  
  #bar plot for.....
  output$plot3<-renderPlot({
    # 2/ horizontal barplot
    cyl<-googleplaystore$Content.Rating
    ggplot(googleplaystore, aes(x=as.factor(cyl), fill=as.factor(cyl) )) +
      geom_bar() + 
      coord_flip()
  })
  
  #bar plot for Apps against downloads
  output$plot4<-renderPlot({
    
    #horizontal barplot
    cyl<-googleplaystore$Installs
    
    ggplot(googleplaystore, aes(x=as.factor(cyl), fill=as.factor(cyl) )) +
      geom_bar() 
      #+ coord_flip()
  })
  
  #bar plot for Apps against downloads
  output$plot5<-renderPlot({
    #barplot(counts)
    cat<-c(1972,1144,843,463,460,424,5535)
    barplot(cat,
            xlab = "Categories",
            ylab = "Installs by Category",
            col="green",
            names.arg = c("FAMILY","GAME","TOOLS","MEDICAL",
                          "BUSINESS","PRODUCTIVITY","OTHER"),
            border = "gold"
    )
      })
}