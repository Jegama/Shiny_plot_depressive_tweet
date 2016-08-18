#########################################################################
#                                                                       #
#                      Script by Jegama                                 #
#                                                                       #
#########################################################################

library(shiny)
library(dplyr)
library(ggplot2)
library(ggvis)

shinyUI(fluidPage(
  
  title = "Data Visualization from Depression DataSet",
  
  fluidRow(
    column(4,
           h4("Y Axis"),
           selectInput("y_var", 
                       label = "Choose a variable to display",
                       choices = c("Mean_Sentiment", "Tweets", "Max_Sentiment", "Min_Sentiment",
                                   "Sender_Diversity", "Word_Diversity"),
                       selected = "Mean_Sentiment")
    ),
    column(4,
           h4("Date Range"),
           dateRangeInput("dates", "Choose",
                             start = "2015-07-02", 
                             end = "2015-08-03"),
           uiOutput("plot_ui")
    )
  ),
  
  hr(),
  
  ggvisOutput("plot")

))