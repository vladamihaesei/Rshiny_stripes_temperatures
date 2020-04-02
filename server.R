
library(shiny)
library(ggplot2)
library(dplyr)
library(RColorBrewer)
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
