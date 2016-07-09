#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

# Antti Loukiala (c) 9.7.2016

library(shiny)
library(quantmod)

# Create stock graph and calculate all needed data
shinyServer(function(input, output) {
  
  output$stockPlot <- renderPlot({
    data <- getSymbols(input$symb, src = "yahoo",
                       from = input$dates[1],
                       to = input$dates[2],
                       auto.assign = FALSE)
    # Get the latest price from the loaded data
    currentPrice <- as.numeric(tail(data[,4],1))
    # Calculate sale price for the wanted return
    salePrice <- ((currentPrice * input$amount + 
                     (input$cost*2)) * (1+(input$return)/100)) / input$amount
    plot(data[,4], 
         ylim=c(min(data[,4]), max(c(salePrice, max(data[,4]) ))),
         main="Stock price development",
         xlab = "date",
         ylab = "stock price")
    abline(salePrice, 0, col="red")
    
    # Print the investment need in header
    output$invesment <- renderText({
      paste("Investment needed is: ", 
            currentPrice * input$amount + (input$cost*2))
    })
    
    # Print the sale price in header
    output$stockSalePrice <- renderText({
        paste("Stock sale price needs to be: ", salePrice, " (red line in graph)")
    })
  
  })

})


