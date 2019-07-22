library(shiny)
library(DT)
library(tidyverse)
library(highcharter) 
library(lubridate)
library(stringr)
library(xts)
library("magrittr")
library(ggplot2)
library(plotly)
library(plotrix)
library(RColorBrewer)
library(tweenr)
library(tidyverse)
library(gganimate)


data_d<-read.csv("googleplaystore.csv")
str(data_d)


function(input, output){
  
  output$dataTable <- renderDT(
    data.clean, # data
    class = "display nowrap compact", # style
    filter = "top",# location of column filters
    options = list(  # options
      scrollX = TRUE # allow user to scroll wide tables horizontally
    )
  )
  
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
  #rendering data
  
  #Summary Content Code
  #Prints overall summary
  output$summary <- renderPrint({
    summary(data.clean)
  })
  
  #Print summary by selection of the variable name
  output$summary1<-renderPrint({
    if(input$variable=="Category"){
      print(summary(data.clean$Category)
      )
    }
    if(input$variable=="Rating"){
      print(summary(data.clean$Rating)
      )
    }
    if(input$variable=="Reviews"){
      print(summary(data.clean$Reviews)
      )
    }
    if(input$variable=="Size"){
      print(summary(data.clean$Size)
      )
    }
    if(input$variable=="Installs"){
      print(summary(data.clean$Installs)
      )
    }
    if(input$variable=="Last.Updated"){
      print(summary(data.clean$Last.Updated)
      )
    }
    if(input$variable=="Price"){
      print(summary(data.clean$Price)
      )
    }
    if(input$variable=="Content.Rating"){
      print(summary(data.clean$Content.Rating)
      )
    }
    if(input$variable=="Current.Ver"){
      print(summary(data.clean$Current.Ver)
      )
    }
  })#end of summary staff
  
  #bar plot for content rating
  output$plot3<-renderPlot({
    # 2/ horizontal barplot
    cyl<-data.clean$Content.Rating
    ggplot(data.clean, aes(x=as.factor(cyl), fill=as.factor(cyl) )) +
      geom_bar() + 
      coord_flip()
  })
  
  #bar plot for Apps against downloads
  output$plot4<-renderPlot({
    cyl<-googleplaystore$Installs
    #lm(formula = Genre~Installs)
    ggplot(googleplaystore, aes(x=as.factor(cyl), fill=as.factor(cyl) )) +
      geom_bar() +
      coord_flip()
  })
  
  #bar plot for Apps against downloads
  output$plot5<-renderPlot({
    #barplot(counts)
    cat<-c(1971,1144,843,463,460,424,5534)
    barplot(cat,
            xlab = "Categories",
            ylab = "Installs by Category",
            col="green",
            names.arg = c("FAMILY","GAME","TOOLS","MEDICAL",
                          "BUSINESS","PRODUCTIVITY","OTHER"),
            border = "gold"
    )
  })
  
  #Pie Chart for Type of apps....Whether paid or free
  output$plot1<-renderPlot({
    slices <- c(10039,800)
    lbls <- c("Free","Paid")
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
  
  #Density plot for Genre/Install distribution  
  output$plot<-renderPlot({
    ggplot(data = data.clean[1:200,], aes(x = Genres, y = Installs)) +
      geom_violin(alpha = 0) +
      geom_jitter(alpha = 0.5, color = "tomato")
    #curve(-17.579 + 3.932*x, add=TRUE)
  })
  
  #box plot for 
  output$plot6 <- renderPlot({
    installs <- c(data.clean$Installs)
    app <- (data.clean$Category)
    boxplot(installs ~ app,xlab="Category",
            ylab="Freq in 5's",
            data=data.clean$Installs,
            col="gold")
  })
  
  #box plot for 
  output$plot6<-renderPlot({
    installs<-c(googleplaystore$Installs)
    app<-c(googleplaystore$Category)
    boxplot(installs ~ app,xlab="Category",
            ylab="Freq in 5's",
            data=googleplaystore$Installs,
            col="gold")
  })
}