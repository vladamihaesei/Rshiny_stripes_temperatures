
library(shiny)
library(ggplot2)
library(dplyr)
library(RColorBrewer)
shinyServer(function(input, output,session) {
  
  observeEvent(
    
    input$RegiuneInput,
    updateSelectInput(session,"RegiuneInput","Regiune",
                      choices = temp$CMR[temp$NUME==input$RegiuneInput]))
  
  #observeEvent(
  #input$judetInput,
  ##updateSelectInput(session, "judetInput", "Judet", 
  #                choices = temp$NUME[data$NUME==input$judetInput & temp$CMR==input$RegiuneInput]))
  
  
  
  
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
})


