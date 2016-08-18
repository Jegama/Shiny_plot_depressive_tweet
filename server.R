######################################################################### 
#                                                                       #
#                      Script by Jegama                                 #
#                                                                       #
#########################################################################

shinyServer(function(input, output) {
  dataset <- read.csv("time_analysis.csv")
  
  ggvis_plot <- reactive({
    from <- input$dates[1]
    to <- input$dates[2]
    dataset$Date <- as.Date(dataset$Date)
    # filter the days we want
    data <- dataset %>%
      filter(Date >= as.Date(from) & Date <= as.Date(to))
    
    data$long <- as.character(paste0("On ",data$Day,", ",data$Date, "<br>",
                                     "the mean sentiment was: ", data$Mean_Sentiment, "<br>",
                                     "with a max of: ", data$Max_Sentiment, "<br>",
                                     "a min of: ", data$Min_Sentiment, "<br>",
                                     "and were posted ", data$Tweets, " tweets"))
    
    if (input$y_var == "Mean_Sentiment"){
      data <- mutate(data, y_axis = c(data$Mean_Sentiment))
    }
    if (input$y_var == "Tweets"){
      data <- mutate(data, y_axis = c(data$Tweets))
    }
    if (input$y_var == "Max_Sentiment"){
      data <- mutate(data, y_axis = c(data$Max_Sentiment))
    }
    if (input$y_var == "Min_Sentiment"){
      data <- mutate(data, y_axis = c(data$Min_Sentiment))
    }
    if (input$y_var == "Sender_Diversity"){
      data <- mutate(data, y_axis = c(data$Sender_Diversity))
    }
    if (input$y_var == "Word_Diversity"){
      data <- mutate(data, y_axis = c(data$Word_Diversity))
    }
    data
  })
  
  # A simple visualisation. In shiny apps, need to register observers
  # and tell shiny where to put the controls
  ggvis_plot %>%
    ggvis(~Date, ~y_axis, key:= ~long) %>%
    layer_points(fill = ~Mean_Sentiment, size := 100) %>%
    layer_paths() %>%
    add_tooltip(function(data){
      paste0(as.character(data$long))
    }, "hover") %>%
    add_axis("x", properties = axis_props(
      labels = list(angle = 45, align = "left"))) %>%
    bind_shiny("plot", "plot_ui")
  
})