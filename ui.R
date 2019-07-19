library(shinydashboard)

dashboardPage(
  skin = "purple",
  dashboardHeader(title="MDA-App"),
  dashboardSidebar(
    sidebarMenu(
    menuItem("Home", tabName="Home"),
    menuItem("Dataset", tabName="Dataset"),
    menuItem("Summary", tabName="Summary"),
    menuItem("Plot", tabName="Plot"),
    menuItem("Inferences", tabName="Inferences"),
    menuItem("Help", tabName="Help")
    
  )
  ),
  dashboardBody(
    tabItems(
    tabItem(tabName = "Home",
            h1("Welcome to MDA- App"),
            h1(""),
            h3("Have you ever wondered why you App is not getting downloads?
                MDA-App is your solution!"),
            h1(""),
               h3("MDA-App is data system that analyzes app details from Google Play Store. 
                It generates insights which are intended to help developers get more people to download their applications.
                This system analyses how different application features affect the download rate of an application on the store.
                The app details can be visualized giving a clear understanding of the data to the users.")
            ),
   
     tabItem(tabName="Dataset",
            h2("Dataset")),
    
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
            h2("Plot contents"),
            fluidRow(
              box(
                title = "Genre Install Density Distribution",
                
                status = "primary",
                solidHeader = TRUE, 
                collapsible = TRUE,
                plotOutput("plot")
              ),
              box(
                title = "Bar Plot for Content Rating",
                status = "primary",
                solidHeader = TRUE, 
                collapsible = TRUE,
                plotOutput("plot3")
              )
              
            ),
            #Row for pie charts
            fluidRow(
              box(
                title = "Pie Chart for Installs",
                status = "primary",
                solidHeader = TRUE, 
                collapsible = TRUE,
                plotOutput("plot2")
              ),
              box(
                title = "Pie Chart for App Categories",
                status = "primary",
                solidHeader = TRUE, 
                collapsible = TRUE,
                plotOutput("plot1")
              )
              
              
            ),
            
            fluidRow(
              box(
                title = "Bar Chart of Installs",
                status = "primary",
                solidHeader = TRUE, 
                collapsible = TRUE,
                plotOutput("plot4")
              ),
              box(
                title = "Bar Chart for Category against Installs",
                status = "primary",
                solidHeader = TRUE, 
                collapsible = TRUE,
                
                plotOutput("plot5")
              )
            )
            
            ),
    
    tabItem(tabName = "Inferences",
            h2("Inferences Contents")),
    
    tabItem(tabName="Help",
            h2("Help contents"))
  
  )
   )
  
)
