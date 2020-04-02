library(shiny)
library(shinythemes)

ui <- fluidPage(theme = shinytheme("darkly"),
                titlePanel("Temperature of Romania 1961 -2010"),
                sidebarLayout(
                  sidebarPanel(
                    selectInput("RegiuneInput", "Regiune",
                                choices = unique(temp$CMR)),
                    selectInput("judetInput", "Judet",
                                choices = unique(temp$NUME))
                    
                  ),
                  mainPanel(
                    plotOutput("coolplot"),
                    br(), br()
                    
                  )
                )
)