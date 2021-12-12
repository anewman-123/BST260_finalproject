
#### Shiny App to Predict Price of an Uber/Lyft with an xgBoost Regression Model
library(shiny)
library(shinyWidgets)
library(shinydashboard)
library(xgboost)

load("model_lyft_xgb.Rdata") ## Loading in xgBoost regression model for Lyft
load("model_uberX_xgb.Rdata") ## Loading in xgBoost regression model for UberX



ui <- fluidPage(titlePanel(div("How Much Will My Ride Cost in Boston?", style = "color: white")),
                mainPanel(h4("This app will use an xgboost regression model to predict the price of your UberX or Lyft ride in Boston based on the inputs you give it.", style = "color:white")),
                fluidRow(
                    column(width = 3, offset = 1, selectInput("starting_point", ## Creating a column input asking for the user's starting neighborhood
                            "Choose Your Starting Destination", 
                            list("Fenway", 
                                 "Back Bay", 
                                 "North Station",
                                 "Beacon Hill",
                                 "West End",
                                 "Haymarket Square",
                                 "South Station", 
                                 "Northeastern University",
                                 "North End",
                                 "Boston University",
                                 "Theatre District",
                                 "Financial District", 
                                 "North Station",
                                 "North End")), style = "color:white"),
                column(width = 3, offset = 1, selectInput("destination", ## Creating a column input asking for the user's destination neighborhood 
                            "Choose Your Final Destination",
                            list("Fenway", 
                                 "Back Bay", 
                                 "North Station",
                                 "Beacon Hill",
                                 "West End",
                                 "Haymarket Square",
                                 "South Station", 
                                 "Northeastern University",
                                 "North End",
                                 "Boston University",
                                 "Theatre District",
                                 "Financial District", 
                                 "North Station",
                                 "North End")), style = "color:white"),
            
                    column(width = 3, offset = 1, selectInput("appchoice", ## Creating a column input asking for either the user's app choice of either UberX or Lyft
                                "Will you use UberX or Lyft?",
                                list("Uber", "Lyft"))), style = "color:white"),
                fluidRow(
                column(width = 3, offset = 1, numericInput("distance", ## Creating a column where the user inputs their numeric distance
                            "Approximately how far away is your destination from your current location? (in miles)",
                            value = 0), style = "color:white"),
  
                column(width = 3, offset = 1, selectInput("hour",  ## Creating a column where the user inputs their time, in the form of an hour from 0 to 24.
                            "What hour is it (0-24)?", 
                            list(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24)), style = "color:white"),
                column(width = 3, offset = 1, numericInput("temperature", ## Creating a column where the user inputs the current temperature, in the form of fahrenheit
                            "What temperature is it right now? (Fahrenheit)",
                            value = 0)), style = "color:white"),
                fluidRow(
                column(width = 3, offset = 1, selectInput("clear", ## The user inputs whether the skies are clear or not
                            "Is it daytime AND are the skies clear right now?", 
                            list("Yes", "No")), style = "color:white"),
                column(width = 3, offset = 1, selectInput("clear_night", ## Self-explanatory input
                            "Is it nighttime AND are the skies clear right now?",
                            list("Yes", "No")), style = "color:white"),
                column(width = 3, offset = 1, selectInput("cloudy", ## Self-explanatory input
                            "Are the skies cloudy right now?",
                            list("Yes", "No"))), style = "color:white"),
                fluidRow(
                column(width = 3, offset = 1, selectInput("fog", ## Self-explanatory input
                            "Is it foggy out right now?",
                            list("Yes", "No")), style = "color:white"),
                  column(width = 3, offset = 1, selectInput("part_cloud_day", ## Self-explanatory input
                            "If it's not clear nor cloudy AND it's the daytime, is it PARTLY cloudy?",
                            list("Yes", "No")), style = "color:white"),
                column(width = 3, offset = 1, selectInput("part_cloud_night", ## Self-explanatory input
                            "If it's not clear nor cloudy AND it's the nighttime, is it PARTLY cloudy?",
                            list("Yes", "No")), style = "color:white"),
                column(width = 3, offset = 5, selectInput("rain", ## Self-explanatory input
                            "Is it raining??",
                            list("Yes", "No"))), style = "color:white"),
                
                mainPanel(textOutput("price"), style = "color:white"),  ## setting the output color to be white
                setBackgroundImage(src = "https://c4.wallpaperflare.com/wallpaper/181/597/101/boston-chains-city-cityscape-wallpaper-preview.jpg")) ## setting the background image to an image of Boston


## Now defining a new function called "xgboost" that utilizes the models that are loaded earlier 
xgboost <- function(starting_input, destination_input, distance_input, app_input, hour_input, temp_input, clear_day_input, clear_night_input, cloudy_input, fog_input, part_cloud_day_input, part_cloud_night_input, rain_input){
  hour = as.numeric(hour_input) ## Cleaning up the variables so that they're in numeric form 
  sin_time = sin(2*pi*hour/24)
  cos_time = cos(2*pi*hour/24)
  distance = as.numeric(distance_input)
  temperature = as.numeric(temp_input)
  Back_Bay_destination = ifelse(destination_input == "Back Bay", 1, 0) ## Transforming variables so that if the user picks a certain neighborhood, that neighborhood takes the value of "1", while the others take the value of "0"
  Beacon_Hill_destination = ifelse(destination_input == "Beacon Hill", 1, 0)
  BU_destination = ifelse(destination_input == "Boston University", 1, 0)
  Fenway_destination = ifelse(destination_input == "Fenway", 1, 0)
  FiDi_destination = ifelse(destination_input == "Financial District", 1, 0)
  Haymarket_Square_destination = ifelse(destination_input == "Haymarket Square", 1, 0)
  North_End_destination = ifelse(destination_input == "North End", 1, 0)
  North_Station_destination = ifelse(destination_input == "North Station", 1, 0)
  NEU_destination = ifelse(destination_input == "Northeastern University", 1, 0)
  SouthStation_destination = ifelse(destination_input == "South Station", 1, 0)
  TheaterDistrict_destination = ifelse(destination_input == "Theatre District", 1, 0)
  WestEnd_destination = ifelse(destination_input == "West End", 1, 0)
  BackBay_source = ifelse(starting_input == "Back Bay", 1, 0)
  Beacon_Hill_source = ifelse(starting_input == "Beacon Hill", 1, 0)
  BU_source = ifelse(starting_input == "Boston University", 1, 0)
  Fenway_source = ifelse(starting_input == "Fenway", 1, 0)
  FiDi_source = ifelse(starting_input == "Financial District", 1, 0)
  Haymarket_source = ifelse(starting_input == "Haymarket Square", 1, 0)
  NorthEnd_source = ifelse(starting_input == "North End", 1, 0)
  NorthStation_source = ifelse(starting_input == "North Station", 1, 0)
  NEU_source = ifelse(starting_input == "Northeastern University", 1, 0)
  SouthStation_source = ifelse(starting_input == "South Station", 1, 0)
  TheatreDistrict_source = ifelse(starting_input == "Theatre District", 1, 0)
  WestEnd_source = ifelse(starting_input == "West End", 1, 0)
  clear_day = ifelse(clear_day_input == "Yes", 1, 0)
  clear_night = ifelse(clear_night_input == "Yes", 1,0)
  cloudy = ifelse(cloudy_input == "Yes", 1,0)
  fog = ifelse(fog_input == "Yes", 1, 0)
  partly_cloudy_day = ifelse(part_cloud_day_input == "Yes", 1, 0)
  partly_cloudy_night = ifelse(part_cloud_night_input == "Yes", 1, 0)
  rain = ifelse(rain_input == "Yes", 1, 0)
  input_list = c(hour, sin_time, cos_time, distance, temperature, Back_Bay_destination, Beacon_Hill_destination, ## Organizing all of the inputs into a list in order of which they appear in the models
                 BU_destination, Fenway_destination, FiDi_destination, Haymarket_Square_destination, North_End_destination,
                 North_Station_destination, NEU_destination, SouthStation_destination, TheaterDistrict_destination, 
                 WestEnd_destination, BackBay_source, Beacon_Hill_source, BU_source, Fenway_source, FiDi_source,
                 Haymarket_source, NorthEnd_source, NorthStation_source, NEU_source, SouthStation_source, TheatreDistrict_source,
                 WestEnd_source, clear_day, clear_night, cloudy, fog, partly_cloudy_day, partly_cloudy_night, rain
                  )
  input_list_matrix = as.matrix(input_list) ## Transforming into a matrix; xgboost can only take a matrix
  if(app_input == "Uber"){ ## If the user selects Uber, their inputs get put into model "bst2"
    price = predict(bst2, t(input_list_matrix))[[1]] ## Predicting the price based on their transposed input matrix and taking the first value of the predict output 
  }
  else{ ## ## If the user selects Lyft, their inputs get put into model "bst"
    price = predict(bst, t(input_list_matrix))[[1]]
  }
  return(price)
}

server <- function(input, output){
 x1 <- reactive(paste0("YOUR RIDE PRICE WILL BE: $", format(round(xgboost(input$starting_point, input$destination, input$distance, input$appchoice, input$hour, input$temperature,input$clear, input$clear_night, ## Putting the users input into the function xgboost and rounding it to 2 decimal points
                                            input$cloudy, input$fog, input$part_cloud_day, input$part_cloud_night, input$rain), 2), nsmall = 2))) ## Also making sure to make the input reactive, so that the output changes based on the input
   output$price = renderText(x1())  ## The output is text that is rendered based on our reactive inputs 
}

shinyApp(ui = ui, server = server)



