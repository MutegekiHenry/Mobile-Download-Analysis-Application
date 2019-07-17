library(shinydashboard)

dashboardPage(
  skin = "purple",
  dashboardHeader(title="MDA-App"),
  dashboardSidebar(
    sidebarMenu(
    menuItem("Home", tabName="Home"),
    menuItem("View Dataset", tabName="View Dataset"),
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
                The app details can be visualized giving a clear understanding of the data to the users.")),
    
    tabItem(tabName="View Dataset",
            h2("Google Play Store Dataset"),
          # fluidPage(fluidRow(column(12,
                                      div(dataTableOutput("dataTable")
            )
           #)))
            
            
            ),
    tabItem(tabName = "Summary",
            h2("Summary Contents")),
    tabItem(tabName="Plot",
            h2("Plot contents")),
    tabItem(tabName = "Inferences",
            h2("Inferences Contents")),
    tabItem(tabName="Help",
            h2("Help contents"))
    
  )
  )
  
  
)
