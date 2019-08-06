library(shinydashboard)

dashboardPage(
  skin = "purple",
  dashboardHeader(title="MDA-App"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Home",icon = icon("home"), tabName="Home"),
      menuItem("View Dataset" ,icon = icon("table"), tabName="ViewDataset"),
      menuItem("Summary",icon = icon("list-alt"), tabName="Summary"),
      menuItem("Visualization", icon = icon("bar-chart-o"),tabName="Plot"),
      menuItem("Technical Insights", tabName="technical" ,icon = icon("info-circle")),
      menuItem("Inferences",icon = icon("user-edit"), tabName="Inferences"),
      menuItem("Help", tabName="Help" ,icon = icon("info-circle"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "Home", 
              
              h1("Welcome to MDA- App"),
              
              h3(
                p("MDA-App is an R Application that analyzes app details from Google Play Store. 
                It generates insights which are intended to help developers optimize their applicatios to enhance their downloads.
                This system analyses how different application features affect the download rate of an application on play store.
                The app details can be visualized giving a clear understanding of the data"),
                p("The Internet is a true gold mine of data. E-commerce and review sites are brimming with a lot of untapped data with a prominent potential to convert into meaningful insights that can help with robust decision making.
              Here, we explore using data science and machine learning techniques on data retrieved from one such avenue on the internet, the Google Play Store.
              Details of Dataset:
                
                The Play Store apps data has enormous potential to drive app-making businesses to success. Actionable insights can be drawn for developers to work on and capture the Android market. The dataset is chosen from Kaggle. It is the web scraped data of 10k Play Store apps for analyzing the Android market.
                  It consists of in total of 10841 rows and 13 columns."),
                
                p("The columns of the dataset are as follows:"),
                
                p("1) App (Name)") ,
                
                p("2) Category (App)"),
                
                p("3) Rating (App)") ,
                
                p("4) Reviews (User)"),
                
                p("5) Size (App)"),
                
                p("6) Installs (App)"),
                
                p("7) Type (Free/Paid)"),
                
                p("8) Price (App)"),
                
                p("9) Content Rating (Everyone/Teenager/Adult)"),
                
                p("10) Genres (Detailed Category)"),
                
                p("11) Last Updated (App)"),
                
                p("12) Current Version (App)"),
                
                p("13) Android Version (Support)")
                
              )),
   
    tabItem(tabName = "ViewDataset",
            h2("Google Play store dataset"),
            
            fluidPage(
              fluidRow(
                column(12,
                       div(
                         dataTableOutput("dataTable")
                       )
                )
              )
            )
    ),
    
    tabItem(tabName = "Summary",
            h2("Overall Summary"),
            #Code for summary
            
            fluidPage(
              fluidRow(
                box(title = "Overall Summary",
                    status = "primary",
                    solidHeader = T,
                    collapsible = TRUE,
                    "App details according to variable name",
                    verbatimTextOutput("summary")
                ),
                box(title = "Summary Description",
                    status = "primary",
                    solidHeader = T,
                    collapsible = TRUE,
                    h3("Description of Summary"),
                    h4("What Information does the summary represent: Summary is a function that produces different summaries
                       of the several model fit functions. Some of these invoke methods
                       which depend on the class. Mean, Median,Min,Max,1st Quartile and 3rd Quartile
                       are some of the values that are displayed along with
                       the indivudual statistics of the data we are analyzing. Some of the sumaries shown in the
                       left of this particular box include the classification stats by content rating, by reviews, 
                       by category and so on as we explore in the boxes below to assess individual column summaries.
                       When you click on plots tab, diffrent statistics of this data are plotted to represent 
                       the statistics graphically. 
                       Example fields used are the category, Installs, Reviews and so many more stats are plotted"))
                    
            
    )
    ),
    
  #summary by column
    fluidRow(
      box(title = "App Data Column",
          status = "primary",
          solidHeader = T,
          collapsible = TRUE,
          "To view summary, select a variable below",
          selectInput("variable","Choose Variable",c("Category","Rating","Reviews","Size",
                                                     "Installs","Type","Content.Rating","Genres",
                                                     "Last.Updated"),selected = "Category")
          
          ),
      #Box for displaying individual column summary
      box(title = "Individual columns",
          status = "primary",
          solidHeader = T,
          collapsible = TRUE,
          verbatimTextOutput("summary1")
      )
    )
    ),
    
  tabItem(tabName="Plot",
          fluidPage(
            
            fluidRow(
              
              tabsetPanel(type="tab",
                          #Dynamic Bar Plots
                          tabPanel("Bar Charts",
                                   selectInput("xs","Choose X-Axis",
                                               label = "Bar Chart Analysis",
                                               choices = c("Category",
                                                           "Rating",
                                                           "Size",
                                                           "Type",
                                                           "Price",
                                                           "Content.Rating",
                                                           "Last.Updated",
                                                           "Android.Ver"
                                               )
                                   ),
                                   box(
                                     title = "Bar Chart of Installs",
                                     status = "primary",
                                     solidHeader = TRUE, 
                                     collapsible = TRUE,
                                     plotOutput("plot4")
                                   ),
                                   box(
                                     title = "Dynamic Bar Plot",
                                     status = "primary",
                                     solidHeader = TRUE, 
                                     collapsible = TRUE,
                                     
                                     plotOutput("plot5")
                                   )
                                   
                          ),# end of Dynamic Bar Plots
                          
                          tabPanel("Histograms",
                                   
                                   selectInput("histo","Histogram selector",
                                               choices = c("Category",
                                                           "Installs",
                                                           "Last.Updated"
                                                           
                                               )),
                                   box(
                                     title = "Histograms...",
                                     status = "primary",
                                     solidHeader = TRUE, 
                                     collapsible = TRUE,
                                     plotOutput("hist")
                                   )
                          ),
                          
                          tabPanel("Scatter Plots",
                                   selectInput("scat","Scatter Selector",
                                               label = "Select Scatter Variable",
                                               choices = c("Category",
                                                           "Rating",
                                                           "Reviews",
                                                           "Size",
                                                           "Installs",
                                                           "Type",
                                                           "Price",
                                                           "Content.Rating",
                                                           "Genres"="Gen",
                                                           "Last.Updated",
                                                           "Current.Ver",
                                                           "Android.Ver"
                                               )),
                                   
                                   box(
                                     title = "3D Scatter Plot",
                                     status = "primary",
                                     solidHeader = TRUE, 
                                     collapsible = TRUE,
                                     
                                     plotOutput("sscatter")
                                   ),
                                   box(
                                     title = "Another Scatter Plot",
                                     status = "primary",
                                     solidHeader = TRUE, 
                                     collapsible = TRUE,
                                     
                                     plotOutput("scatter1")
                                   )
                                   
                                   
                                   
                          ),#end of Scatter plot Analysis
                          
                          #Pie Chart Analysis
                          tabPanel("Pie Charts",
                                   selectInput("pie","Pie Chart Selector",
                                               label = "Select Column to View:",
                                               choices = c("Content.Rating",
                                                           "Last.Updated","Genres"
                                               )
                                   ),
                                   box(
                                     title = "Pie Chart for App Category",
                                     status = "primary",
                                     solidHeader = TRUE, 
                                     collapsible = TRUE,
                                     plotOutput("plot2")
                                   ),
                                   box(
                                     title = "Dynamic Pie Chart",
                                     status = "primary",
                                     solidHeader = TRUE, 
                                     collapsible = TRUE,
                                     plotOutput("plot1")
                                   )     
                                   
                          ),#end of Pie Chart Analysis
                          
                          tabPanel("Box Plots",
                                   selectInput("boxp","box selector",
                                               label = "Select x axis",
                                               choices = c("Category",
                                                           "Rating",
                                                           "Reviews",
                                                           "Size",
                                                           "Installs"        
                                               )
                                   ),
                                   box(
                                     title = "Dynamic Box Plot",
                                     status = "primary",
                                     solidHeader = TRUE, 
                                     collapsible = TRUE,
                                     plotOutput("plot3")
                                     
                                     
                                   )
                          ),
                          
                          tabPanel("Density Plots",
                                   
                                   selectInput("ab","Density Plots X Axis",
                                               label = "Analyze Density ",
                                               choices = c("Rating",
                                                           "Reviews",
                                                           "Size",
                                                           "Type",
                                                           "Price",
                                                           "Content.Rating",
                                                           "Genres",
                                                           "Last.Updated",
                                                           "Current.Ver",
                                                           "Android.Ver"
                                               )),
                                   box(
                                     title = "Genre/Install Density Distribution",
                                     
                                     status = "primary",
                                     solidHeader = TRUE, 
                                     collapsible = TRUE,
                                     plotOutput("plot")
                                   ),
                                   box(
                                     title = "Dynamic Density Distribution",
                                     status = "primary",
                                     solidHeader = TRUE, 
                                     collapsible = TRUE,
                                     plotOutput("plot7")
                                   )
                                   
                          ),
                          
                          tabPanel("App Versions",
                                   selectInput(inputId="x-selector",
                                               label = "Select x axis",
                                               choices = c("Category"="Cat",
                                                           "Rating"="Rat",
                                                           "Reviews"="Rev",
                                                           "Size"="Siz",
                                                           "Installs"="Ins",
                                                           "Type"="Typ",
                                                           "Price"="Pri",
                                                           "Content.Rating"="Cont",
                                                           "Genres"="Gen",
                                                           "Last.Updated"="Las",
                                                           "Current.Ver"="Cur",
                                                           "Android.Ver"="And"
                                               )
                                   )
                                   
                                   
                          ),
                          
                          tabPanel("Comparison in Groups",
                                   h3("Description"),
                                   p("Page Description"),
                                   box(
                                     title = "Comparison in Groups Plot",
                                     status = "primary",
                                     solidHeader = TRUE, 
                                     collapsible = TRUE,
                                     plotOutput("plot6")
                                   )  
                          )       
              ) 
            ))
          
  ),
  
  #Render for technical insights
  tabItem(tabName = "technical",
          p('Genre/Install Density Distribution:'),
          p('From the way the plot is plotted, it is safe to deduce that most Art and Design 
              apps have 10000,100000 and some few with about 50000 installs. Another series of clusters 
              appears in the vehicle category with 1,000,000, 100000 and a few with 50000.
              Those two categories have high density population at 100,000 installs'),
          p('Content Rating Bar Plot:'),
          p('Bar plot represesnts content rating along the y-axis and the counts in that 
              specific content rating category count is plotted on the x-axis.
              It is shown that apps developed with no restriction i.e. Apps developed for everyone 
              have the highest count implying that hubs can emphasize developing apps that
              cut across generations'),
          p('Pie Chart for Installs:'),
          p('Pie chart for installs indicates the significant number of downloads are for 
              apps of 4.0 and above versions. That can act as an indicator of the projected 
              installs over the application versioning.'),
          p('Pie Chart for App Category:'),
          p('Pie chart for Category emphasizes what we shal talk about the bar graph
              for the categories. Family is a category with relatively high installs'),
          p('Scatter Plot:'),
          p('Inference to be made by users.............')
  ),
    
  tabItem(tabName = "Inferences",
          h4(
            p("Instructions of Usage: Enter name,select plot to infer and enter inference then click Submit")),
          
          textAreaInput("caption", "Enter Name Here"),
          selectInput("infer","Choose Graph to Infer",
                      choices = c("Bar Plot","Pie Chart","Density Plot")),
          textAreaInput("alto","Enter inference Here",width = "500px"),
          #####submitButton("Submit"),###################Replace this with another action button
          
          verbatimTextOutput("insights")  
          
  ),
    
    tabItem(tabName="Help",
            h2("Help contents"))
  
  )
   )
  
)
