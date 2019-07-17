library(shinydashboard)
library(shiny)

dashboardPage(
  skin = "purple",
  dashboardHeader(title="MDA-App"),
  dashboardSidebar(
    sidebarMenu(
    menuItem("Home",icon = icon("home"), tabName="Home"),
    menuItem("View Dataset" ,icon = icon("table"), tabName="ViewDataset"),
    menuItem("Summary",icon = icon("list-alt"), tabName="Summary"),
    menuItem("Plot", icon = icon("bar-chart-o"),tabName="Plot"),
    menuItem("Inferences",icon = icon("user-edit"), tabName="Inferences"),
    menuItem("Help", tabName="Help" ,icon = icon("info-circle"))
    
  )
  ),
  dashboardBody(
    tabItems(
    tabItem(tabName = "Home",
            h1("Welcome to MDA- App"),
            h1(""),
            h4("Have you ever wondered why you App is not getting downloads?
                MDA-App is your solution!"),
            h1(""),
               p("MDA-App is data system that analyzes app details from Google Play Store. 
                It generates insights which are intended to help developers get more people to download their applications.
                This system analyses how different application features affect the download rate of an application on the store.
                The app details can be visualized giving a clear understanding of the data to the users.")),
    tabItem(tabName="ViewDataset",
            h2("Dataset")),
    tabItem(tabName = "Summary",
            h2("Summary Contents")),
    tabItem(tabName="Plot",
          ##start
          ui<-fluidPage(
            
            fluidRow(
              
              tabsetPanel(type="tab",
                          tabPanel("Title 1",
                                   h3("Description"),
                                   p("Page Description."),
                                   fluidRow(
                                     
                                     box(title = "Box Title",status = "primary",solidHeader = T,
                                         sliderInput("bins","Number of Breaks",1,100,50)
                                     ),
                                     box(title = "Box title",status = "primary",solidHeader = T,
                                         "Some text",
                                         selectInput("id","Choose",c("option1","option2"),selected = "option1")
                                     )
                                     
                                     
                                     
                                   ),
                                   fluidRow(
                                     
                                     
                                     plotOutput("id")
                                     
                                     
                                   )
                                   
                                   
                                   
                                   
                          ),
                          tabPanel("Price",
                                   h3("Description"),
                                   p("Page Description"),
                                   ui<-fluidPage(
                                     fluidRow(
                                       plotOutput("id")
                                     ),
                                     fluidRow(
                                       box(title = "Box Title",status = "primary",solidHeader = T,
                                           selectInput("id","select category",c("Option1","option2"),selected = "boxplot_variation")
                                       )
                                       
                                     )
                                   )
                          ),
                          tabPanel("Size",
                                   h3("Description"),
                                   p("Page Description"),
                                   ui<-fluidPage(
                                     fluidRow(
                                       plotOutput("id")
                                     ),
                                     fluidRow(
                                       box(title = "Box Title",status = "primary",solidHeader = T,
                                           selectInput("id","select category",c("plot1","plot2"),selected = "plot1")
                                       )
                                       
                                     )
                                   )
                                   
                          ),
                          tabPanel("Title 4",
                                   h3("Description"),
                                   p("Page description ."),
                                   ui<-fluidPage(
                                     fluidRow(
                                       plotOutput("id")
                                     ),
                                     fluidRow(
                                       box(title = "Box Title",status = "primary",solidHeader = T,
                                           selectInput("id","select category",c("plot1","plot2"),selected = "plot1")
                                       )
                                       
                                     )
                                   )
                                   
                          ),
                          tabPanel("Content rating",
                                   h3("Description"),
                                   p("Page Description "),
                                   ui<-fluidPage(
                                     fluidRow(
                                       plotOutput("id")
                                       
                                     ),
                                     fluidRow(
                                       box(title = "Box Title",status = "primary",solidHeader = T,
                                           selectInput("id","select category",c("plot1","plot2"),selected = "plot1")
                                       )
                                     )
                                   )
                                   
                          ),
                          tabPanel("Title 6",
                                   h3("Description"),
                                   p("Page Description"),
                                   ui<-fluidPage(
                                     fluidRow(
                                       plotOutput("id")
                                     ),
                                     fluidRow(
                                       box(title = "Box Title",status = "primary",solidHeader = T,
                                           selectInput("id","select category",c("plot1","plot2"),selected = "plot1")
                                           
                                       )
                                     )
                                   )
                          ),
                          tabPanel("App Versions",
                                   h3("Description"),
                                   p("Page Description"),
                                   ui<-fluidPage({
                                     plotOutput("id")
                                   })
                                   
                          ),
                          tabPanel("Comparison in Groups",
                                   h3("Description"),
                                   p("Page Description"),                                        
                                   ui<-fluidPage(
                                             fluidRow(
                                               box(title = "Box Title",status = "primary",solidHeader = T,
                                                   "Some text here",
                                                   selectInput("id","select app property",c("option 1","option 2","option 3","option 4","option 5"),selected = "option1")
                                               )
                                               
                                             ),
                                             fluidRow(
                                               plotOutput("id")
                                             )
                                           )
                          )
              )
              
            )
            
            
          ) 
            
          ## end
          ),
    tabItem(tabName = "Inferences",
            h2("Inferences")
            
            
            ),
    tabItem(tabName="Help",
            tabsetPanel( tabPanel("Extras",tableOutput("extras"),
                                  h3("How to view Dataset"),
                                  p("You can view the fields in the dataset used in the MDA-App by clicking on the View Dataset tab."),
                                  p("A page shall open containing the data in table format "),
                                  
                                  h3("How to print Results"),
                                  p(" The MDA-App gives a user capability to print the results of an analysis to a pdf or as an image for storage purposes"),
                                  p("1.	Carry Out an anaylsis "),
                                  p("2.	Go to either Plot or Summary tabs"),
                                  p("3.	Press the print button of the result you want") ,
                                  p("4.	Print window will appear "),
                                  p("5. Select the Name of the document ") ,
                                  p("6. Select the location of the print document. ") ,
                                  p("7.	Press ok to print"),
                                  p("8.	The document will then be downloaded to the choosen location"),
                                  
                                  h3("How to send an E-mail"),
                                  p("The MDA-App gives a user capability to send an E-mail of the results of an analysis straight to their mailbox"),
                                  p("1. Make sure you have a valid E-mail address if not create on first"),
                                  p("2.	Carry out an analysis from Plot or Summary tab"),
                                  p("3. Select the Email Results tab ") ,
                                  p("4. A window shall open "),
                                  p("5. Enter a valid E-mail address"), 
                                  p("6. Press send") ),
            tabPanel("Visualization",
                     h3("How to visualize insights from the andriod apps datasets"),
                     h4("Steps"),
                     p("1- Click on the Plot tab"),
                     p("2- Choose among the displayed navigation tabs i.e. Distribution, price, content rating,Comparison in groups, App versions and size"),
                     p("3- Choose the categories of the distribution graph ou want to be displayed by chooseing from the dropdown list")
        
            ),
            tabPanel("Summary",
                     h3("Using the summary tab"),
                     h4("Steps"),
                     p("1- Click on the summary tab to display the summary options"),
                     p("2- Select the dataset column to display its summary such as mean, min and max")
                   ),
            tabPanel("Inferences",
                     h3("Using Inferences tab"),
                     p("The MDA-App gives users ability to add their own and view already made inferences"),
                     p("1- Click the Inferences tab"),
                     p("2- View existing inferences based on the visualisations"),
                     p("3- Click add inference and text field shall be displayed"),
                     p("4- Submit inference and refresh for it to appear")
                     ),
            tabPanel("Contact Us",
                     h3("Get In Touch With the Developers"),
                     p("The MDA-App has four major developers"),
                     p("1- Kahuma Clare     - clarekahuma@gmail.com"),
                     p("2- Bright Benard    - engbenard123@gmail.com "),
                     p("3- Tusiime Hewwit   - hewitttusiime82@gmail.com "),
                     p("4- Mutegeki Henry   - henrymutegeki117@gmail.com ")
            )
            
            
            )
           
            )
    
  )
  )
  
  
)
