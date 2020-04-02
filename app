
library(shiny)
library(shinythemes)
library(ggplot2)
library(dplyr)
library(RColorBrewer)

temp <- read.csv("Temperature_1961-2010.csv", stringsAsFactors = FALSE)


col_strip <- brewer.pal(11, "RdBu")


ui <- fluidPage(theme = shinytheme("darkly"),
                titlePanel("Temperature of Romania 1961-2010"),
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
server <- function(input, output,session) {
  
  observeEvent(
    { 
      input$RegiuneInput 
    },{
      input$judetInput
      temp <- temp %>% filter(CMR%in%input$RegiuneInput)
      updateSelectInput(session,"judetInput",choices = unique(temp$NUME))
    }
  )
  output$coolplot <- renderPlot({
    filtered1 <-
      temp  %>%
      filter(
        CMR == input$RegiuneInput,
        NUME == input$judetInput
        
      )
  
    ggplot(filtered1,
           aes(x = Data, y = 1, fill = Temp))+
      geom_tile() +
      scale_fill_gradientn(colors = rev(col_strip)) +
      guides(fill = guide_colorbar(barwidth = 1)) +
      theme_void()
    
  })
}

shinyApp(ui = ui, server = server)



