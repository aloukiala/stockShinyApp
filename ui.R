#
# This is the user-interface definition of a Shiny web application. 
# You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

# Antti Loukiala (c) 9.7.2016

library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Stock investment helper"),
  
  # Sidebar with input parameters
  sidebarLayout(
    sidebarPanel(
       dateRangeInput("dates", "Date range", Sys.Date()-7, Sys.Date()),
       sliderInput("return", 
                   "Expected return %", 
                   min=0,
                   max=100,
                   value=4),
       numericInput("cost", "Transaction cost", 1),
       numericInput("amount", "Number of stocks", 1),
       textInput("symb", "Stock symbol (yahoo)", "UPM1V.HE")
    ),
    
    # Show calculated data and plot
    mainPanel(
      plotOutput("stockPlot"),
      textOutput("invesment"),
      textOutput("stockSalePrice")
    )
  )
))
