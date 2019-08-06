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
#library(grid)

function(input, output){
  
  data_d<-read.csv("googleplaystore.csv")
  #str(data_d)
  
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
  
  #View Dataset
  output$dataTable <- renderDT(
    data.clean, # data
    class = "display nowrap compact", # style
    filter = "top",# location of column filters
    options = list(  # options
      scrollX = TRUE, # allow user to scroll wide tables horizontally
      pageLength=14,
      lengthMenu=c(1:100)
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
    
  })
  
  #bar plot for content rating
  output$plot3<-renderPlot({
    boxplot(googleplaystore)
  })#end content rating bar
  
  #bar plot for installs
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
  
  
  output$plot1<-renderPlot({
    if (input$pie=="Genres"){
      slices <- c(842,623,549,43,460,424,7478)
      lbls <- c("August 3, 2018","August 2, 2018","July 31, 2018","August 1, 2018","July 30, 2018"," July 25, 2018","Other")
      pie3D(slices,labels=lbls,explode=0.1)
      
    }else if (input$pie=="Last.Updated"){
      slices <- c(326,304,294,285,211,164,9255)
      lbls <- c("Tools","Entertainment","Education","Medical","Business","Productivity","Other")
      pie3D(slices,labels=lbls,explode=0.1)
      
    }else if (input$pie=="Content.Rating"){
      slices <- c(3,8714,413,499,1208,2)
      lbls <- c("Adults only 18+","Everyone ","Everyone 10+","Mature 17+","Teen","Unrated")
      pie3D(slices,labels=lbls,explode=0.05)
      
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
  
  #box plot for 
  output$plot6 <- renderPlot({
    plot(data.clean$App)
  })
  
  #render users name ,plot and inference
  output$insights<-renderText({
    i=0
    if (i<2){
      print("Name:",input$caption,"\n",
            "Plot:",input$alto,"\n",
            "Inference:",input$infer
      )
      i=i+1
    }else{
      print("Hoooo ask admin for help")
    }
    
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
          
          "Inference: ",input$alto )
    
    
    
    
  })
  
  #3D Scatter Render
  output$sscatter<-renderPlot({
    
    scatterplot3d(data.clean$Category,data.clean$Installs,data.clean$Content.Rating,
                  main="3D Scatter Plot",#title
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
    data1<-na.omit(data)
    #data
    
    ggplot(data1,aes(a,b,color=format(d))) +
      geom_point(alpha=0.5, size=2.5)#+
    #geom_line(aes(d,a,color="A"))
    
  })
  ###############################################Ended here tonight
  ################check the info box code removal effect
  #Histogramsss plotedddd
  output$hist<-renderPlot({
    if(input$histo=="Category"){
      plot(googleplaystore$Category, main="Histogram for App Category")
    }else if (input$histo=="Installs"){
      plot(googleplaystore$Installs)
    }else{
      plot(googleplaystore$Last.Updated)
    }
    
  })
  
}