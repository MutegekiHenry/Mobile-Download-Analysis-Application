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
library(scatterplot3d)
library(grid)

data_d<-read.csv("googleplaystore.csv")
#str(data_d)

function(input, output){
  output$infoBox <- renderInfoBox({
    infoBox("Progress", 
            paste0(25 , "%"), 
            icon = icon("list"),
            color = "purple", 
            fill = TRUE
    )
  })
  output$progressbar <- renderInfoBox({
    x <- runif(1, 0, 10)
    color <- 'green'
    if(x < 5) color <- 'red'
    infoBox(value = x, title = 'Infobox example', color = color)
  })
  output$infoBox3 <- renderInfoBox({
    x <- runif(1, 0, 10)
    color <- 'green'
    if(x < 5) color <- 'red'
    infoBox(value = x, title = 'Infobox example', color = color)
  })
  
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
    menuItem("Technical Insights")
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
  
  #str(data.clean)
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
    if(input$variable=="Type"){
      print(summary(data.clean$Type)
      )
    }
    if(input$variable=="Content.Rating"){
      print(summary(data.clean$Content.Rating)
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
    if(input$variable=="Genres"){
      print(summary(data.clean$Genres)
      )
    }
    if(input$variable=="Last.Updated"){
      print(summary(data.clean$Last.Updated)
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
    cyl<-data.clean$Installs
    #lm(formula = Genre~Installs)
    ggplot(data.clean, aes(x=as.factor(cyl), fill=as.factor(cyl) )) +
      geom_bar() #+
      #coord_flip()
  })
  
  #bar plot dynamic render
  output$plot5<-renderPlot({
      if(input$xs=="Size"){
        cyl<-data.clean$Size
        #lm(formula = Genre~Installs)
        ggplot(data.clean, aes(x=as.factor(cyl), fill=as.factor(cyl) )) +
          geom_bar()
      }
    else if(input$xs=="Rating"){
      cyl<-data.clean$Rating
      #lm(formula = Genre~Installs)
      ggplot(data.clean, aes(x=as.factor(cyl), fill=as.factor(cyl) )) +
        geom_bar()
    }
    else if(input$xs=="Content.Rating"){
      cyl<-data.clean$Content.Rating
      #lm(formula = Genre~Installs)
      ggplot(data.clean, aes(x=as.factor(cyl), fill=as.factor(cyl) )) +
        geom_bar()
    }
    else if(input$xs=="Category"){
      cyl<-data.clean$Category
      #lm(formula = Genre~Installs)
      ggplot(data.clean, aes(x=as.factor(cyl), fill=as.factor(cyl) )) +
        geom_bar()
    }
    else if(input$xs=="Last.Updated"){
      cyl<-data.clean$Last.Updated
      #lm(formula = Genre~Installs)
      ggplot(data.clean, aes(x=as.factor(cyl), fill=as.factor(cyl) )) +
        geom_bar()
    }
    else if(input$xs=="Android.Ver"){
      cyl<-data.clean$Android.Ver
      #lm(formula = Genre~Installs)
      ggplot(data.clean, aes(x=as.factor(cyl), fill=as.factor(cyl) )) +
        geom_bar()
    }
    else if(input$xs=="Type"){
      cyl<-data.clean$Type
      #lm(formula = Genre~Installs)
      ggplot(data.clean, aes(x=as.factor(cyl), fill=as.factor(cyl) )) +
        geom_bar()
    }
    else if(input$xs=="Price"){
      cyl<-data.clean$Price
      #lm(formula = Genre~Installs)
      ggplot(data.clean, aes(x=as.factor(cyl), fill=as.factor(cyl) )) +
        geom_bar()
    }
  })#end of plot 5
  
  
  
  
  
  
  
  
  
  #######################################################end of tonight
  ##########if refuses remove if....else and repeat
  #Pie Chart for Type of apps....Whether paid or free
  output$plot1<-renderPlot({
    if (input$pie=="Genres"){
      slices <- c(842,623,549,43,460,424,7478)
      lbls <- c("Tools","Entertainment","Education","Medical","Business","Productivity","Other")
      pie3D(slices,labels=lbls,explode=0.1,
            main="Dynamic Pie Chart")
    }else{
      print("Hey hey")
    }
    
  })
  
  #Pie Chart for Installs
  output$plot2<-renderPlot({
    ver_count<-c(1971,1144,843,463,460,424,5534)
    version<-c("Family","Game","Tools","Medical","Business","Productivity","Other")
    pie3D(ver_count,labels=version,explode=0.05,
          main="Pie Chart for App Category")
  })
  
  #Density plot for Genre,Install distribution  
  output$plot<-renderPlot({
    ggplot(data = data.clean[1:200,], aes(x = Genres, y = Installs)) +
      geom_violin(alpha = 0) +
      geom_jitter(alpha = 0.8, color = "tomato")
    #curve(-17.579 + 3.932*x, add=TRUE)
  })
  
  #Another Density Plot
  output$plot7<-renderPlot({
    if(input$ab=="Size"){
      ggplot(data = data.clean[1:10000,], aes(x = Size, y = Installs )) +
        geom_violin(alpha = 0) +
        geom_jitter(alpha = 0.8, color = "tomato")
      #curve(-17.579 + 3.932*x, add=TRUE)
    }
    else if(input$ab=="Rating"){
      ggplot(data = data.clean[1:10000,], aes(x = Rating, y = Installs )) +
        geom_violin(alpha = 0) +
        geom_jitter(alpha = 0.8, color = "tomato")
      #curve(-17.579 + 3.932*x, add=TRUE)
    }
    else if(input$ab=="Reviews"){
      ggplot(data = data.clean[1:10000,], aes(x = Reviews, y = Installs )) +
        geom_violin(alpha = 0) +
        geom_jitter(alpha = 0.8, color = "tomato")
      #curve(-17.579 + 3.932*x, add=TRUE)
    }
    else if(input$ab=="Type"){
      ggplot(data = data.clean[1:10000,], aes(x = Type, y = Installs )) +
        geom_violin(alpha = 0) +
        geom_jitter(alpha = 0.8, color = "tomato")
      #curve(-17.579 + 3.932*x, add=TRUE)
    }
    else if(input$ab=="Content.Rating"){
      ggplot(data = data.clean[1:10000,], aes(x = Content.Rating, y = Installs )) +
        geom_violin(alpha = 0) +
        geom_jitter(alpha = 0.8, color = "tomato")
      #curve(-17.579 + 3.932*x, add=TRUE)
    }
    else if(input$ab=="Price"){
      ggplot(data = data.clean[1:10000,], aes(x = Price, y = Installs )) +
        geom_violin(alpha = 0) +
        geom_jitter(alpha = 0.8, color = "tomato")
      #curve(-17.579 + 3.932*x, add=TRUE)
    }
    else if(input$ab=="Genres"){
      ggplot(data = data.clean[1:10000,], aes(x = Genres, y = Installs )) +
        geom_violin(alpha = 0) +
        geom_jitter(alpha = 0.8, color = "tomato")
      #curve(-17.579 + 3.932*x, add=TRUE)
    }
    else if(input$ab=="Current.Ver"){
      ggplot(data = data.clean[1:10000,], aes(x = Current.Ver, y = Installs )) +
        geom_violin(alpha = 0) +
        geom_jitter(alpha = 0.8, color = "tomato")
      #curve(-17.579 + 3.932*x, add=TRUE)
    }
    else if(input$ab=="Last.Updated"){
      ggplot(data = data.clean[1:10000,], aes(x = Last.Updated, y = Installs )) +
        geom_violin(alpha = 0) +
        geom_jitter(alpha = 0.8, color = "tomato")
      #curve(-17.579 + 3.932*x, add=TRUE)
    }
    else if(input$ab=="Android.Ver"){
      ggplot(data = data.clean[1:10000,], aes(x = Genres, y = Installs )) +
        geom_violin(alpha = 0) +
        geom_jitter(alpha = 0.8, color = "tomato")
      #curve(-17.579 + 3.932*x, add=TRUE)
    }
   
  })
  
  #box plot for Installs
  output$plot6 <- renderPlot({
    installs <- data.clean$Installs
    app <- data.clean$Rating
    boxplot(installs ~ app,xlab="Category",
            ylab="Freq in 5's",
            data=data.clean$Installs,
            col="gold")
  })
  
  #render user name 
  output$insights<-renderText({
    paste( input$caption)
  })
  
  #choose plot to infer
  output$insights<-renderText({
    if(input$infer=="Bar Plot"){
      input$infer <- "Bar Plot"
    }
    else if(input$infer=="Pie Chart"){
      input$infer <- "Pie Chart"
    }
    else if(input$infer=="Density Plot"){
      input$infer <- "Density Plot"
    }
    
  })
  
  #input text
  output$insights<-renderText({
   
      paste("Name: ",input$caption,sep = '\n',
            
            "Plot Infered: ",input$infer,
            
            "Inference: ",input$xyz )
    
  })
  
  #3D Scatter Render
  output$sscatter<-renderPlot({
    
    scatterplot3d(data.clean$Category,data.clean$Installs,data.clean$Content.Rating,
                  main="3D Scatter Plot",#title
                  pch = 18,
                  theta=40,
                  phi=122,
                  xlab = "Category",
                  ylab="Installs",
                  zlab="Content.Rating",
                  #Patch=data$x4,
                  color = data.clean$Size,
                  angle = 45
    )
  })
  
  #Another scater
  
  #3D Scatter Render
  output$scatter1<-renderPlot({
    
    data<-data.frame(d=data.clean$Content.Rating,#keeping changing this to see differnet aspects
                     a=data.clean$Rating,
                     b=data.clean$Category)
    data<-na.omit(data)
    #data
    
    ggplot(data,aes(a,b,color=format(d))) +
      geom_point(alpha=0.5, size=2.5)#+
    #geom_line(aes(d,a,color="A"))
    
  })
}