# Libraries
library(tidyverse)
library(janitor)
library(skimr)
library(naniar)
library(here)
library(gtools)
library(RColorBrewer)
library(paletteer)
library(ggthemes)
library(shiny)
library(shinydashboard)
library(ggmap)


# Loading the data

solar_eclipse <- read_csv(here("NASA lunar and solar eclipses", "solar.csv")) %>% 
  clean_names()

lunar_eclipse <- read_csv(here("NASA lunar and solar eclipses", "lunar.csv"), na=("-")) %>% 
  clean_names()



# Converting Dates: to date type data format, individual year, month, day variables

solar_dates <- solar_eclipse %>% 
  filter(!grepl("^-", calendar_date)) %>% 
  mutate(date = as.Date(calendar_date, format = "%Y %B %e")) %>% 
  select(!c(calendar_date)) %>% 
  mutate(year = lubridate::year(date),
         month = lubridate::month(date),
         day = lubridate::day(date))

lunar_dates <- lunar_eclipse %>% 
  filter(!grepl("^-", calendar_date)) %>% 
  mutate(date = as.Date(calendar_date, format = "%Y %B %e")) %>% 
  select(!c(calendar_date)) %>% 
  mutate(year = lubridate::year(date),
         month = lubridate::month(date),
         day = lubridate::day(date))


# Converting Latitude and Longitude Coords

lunar <- lunar_dates %>% 
  separate(latitude, into=c("lat", "NS"), sep="(?<=[0-9])(?=[A-Za-z])") %>% 
  separate(longitude, into=c("long", "EW"), sep="(?<=[0-9])(?=[A-Za-z])") %>% 
  mutate(lat_num = as.numeric(lat)) %>% 
  mutate(long_num = as.numeric(long)) %>% 
  mutate(latitude_value = ifelse(NS=="N", lat_num, -lat_num)) %>% 
  mutate(longitude_value = ifelse(EW=="E", long_num, -long_num)) 

solar <- solar_dates %>% 
  separate(latitude, into=c("lat", "NS"), sep="(?<=[0-9])(?=[A-Za-z])") %>% 
  separate(longitude, into=c("long", "EW"), sep="(?<=[0-9])(?=[A-Za-z])") %>% 
  mutate(lat_num = as.numeric(lat)) %>% 
  mutate(long_num = as.numeric(long)) %>% 
  mutate(latitude_value = ifelse(NS=="N", lat_num, -lat_num)) %>% 
  mutate(longitude_value = ifelse(EW=="E", long_num, -long_num))


# Making the map

lat <- c(-80, 80)
long <- c(-180, 180)
bbox <- make_bbox(long, lat, f=0.05)
map <- get_map(bbox, maptype = "toner-lite", source = "stamen")


# Bare bones Dashboard shiny app

library(shiny)

ui <- dashboardPage(
  skin = "blue",
  dashboardHeader(title = "Peak Viewing Locations", 
                  titleWidth = 400,
                  tags$li(class="dropdown",
                          tags$style(".skin-blue .main-header .logo {
          background-color: #211212;
          font-family: trebuchet ms;
          font-size: 20px;
          border-style: double;
          border-color: #fadaa2;
          border-width: 6px 6px 1px 6px;
          border-radius: 10px;
          } 
          
          .skin-blue .main-header .logo:hover {background-color: #4a4040;
          
          }
          
          .skin-blue .main-header .navbar {
          background-color: #241c1c;
          }
          ")
                          )),
  dashboardSidebar(title="Eclipse Selections",
                   width = 400,
                   textInput("x", "Year", placeholder = "Enter a Year from 0 to 3000"),
                   selectInput("y", "Solar or Lunar Eclipses:", choices=c("Solar", "Lunar"), selected = "Solar"),
                   conditionalPanel(condition = "input.y == 'Solar'", radioButtons(
                     "z", label = "Which Type of Solar Eclipse", choices = c("Total", "Partial", "Annular", "Hybrid", "All Types"), selected = "All Types")
                   ),
                   conditionalPanel(condition = "input.y == 'Lunar'", radioButtons(
                     "a", label="Which Type of Lunar Eclipse", choices = c("Total", "Penumbral", "Partial", "All Types"), selected = "All Types")
                   ),
                   tags$aside(class="sidebar",
                              tags$style(".skin-blue .main-sidebar {
                    background-color: #211212;
                    font-family: trebuchet ms;
                    font-size: 20px;
                    color: #969696;
                    border-style: double;
                    border-color: #fadaa2;
                    border-width: 0px 6px 6px 4px; 
                    border-radius: 10px;
                    }
                     
                    .skin-blue .main-sidebar .sidebar a:active{
                    background-color: coral;
                    }           
                                         
                                         "))
  ),
  dashboardBody(plotOutput("map", width = "900px", height = "1000px"), style="background-image: linear-gradient(#4a4040, #fadaa2);")
  
)

server <- function(input, output, session) {
  session$onSessionEnded(stopApp)
  output$map <- renderPlot({
    app_lunar <- lunar %>%
      filter(year == input$x)
    app_solar <- solar %>%
      filter(year==input$x)
    # Defining Solar Eclipse Sub-types 
    annular_solar <- app_solar %>% filter(grepl("A", eclipse_type))
    partial_solar <- app_solar %>% filter(grepl("P", eclipse_type))
    total_solar <- app_solar %>% filter(eclipse_type=="T" | eclipse_type=="Ts" |eclipse_type=="Tm" | eclipse_type=="Tn" | eclipse_type=="T-" | eclipse_type=="T+")
    hybrid_solar <- app_solar %>% filter(grepl("H", eclipse_type))
    # Defining Lunar Eclipse Sub-types
    total_lunar <- app_lunar %>% filter(eclipse_type=="T" | eclipse_type=="T+" | eclipse_type=="T-")
    penumbral_lunar <- app_lunar %>% filter(grepl("N", eclipse_type))
    partial_lunar <- app_lunar %>% filter(grepl("P", eclipse_type))
    if (input$y == "Lunar") {
      if (input$a == "Total") {
        ggmap(map) + 
          geom_point(data=total_lunar, aes(longitude_value, latitude_value, color=month), size=4) +
          labs(x= "Longitude", y= "Latitude", title="Total Lunar Eclipse Locations")+
          theme(plot.title = element_text (size = rel(2), hjust = 0.5))+
          theme(axis.title = element_text(size=rel(1.5)))
      }
      else if (input$a == "Partial") {
        ggmap(map) + 
          geom_point(data=partial_lunar, aes(longitude_value, latitude_value, color=month), size=4) +
          labs(x= "Longitude", y= "Latitude", title="Partial Lunar Eclipse Locations")+
          theme(plot.title = element_text (size = rel(2), hjust = 0.5))+
          theme(axis.title = element_text(size=rel(1.5)))
      }
      else if (input$a == "Penumbral") {
        ggmap(map) + 
          geom_point(data=penumbral_lunar, aes(longitude_value, latitude_value, color=month), size=4) +
          labs(x= "Longitude", y= "Latitude", title="Penumbral Lunar Eclipse Locations")+
          theme(plot.title = element_text (size = rel(2), hjust = 0.5))+
          theme(axis.title = element_text(size=rel(1.5)))
      } else {
        ggmap(map) + 
          geom_point(data=app_lunar, aes(longitude_value, latitude_value, color=month), size=4) +
          labs(x= "Longitude", y= "Latitude", title="All Lunar Eclipse Locations")+
          theme(plot.title = element_text (size = rel(2), hjust = 0.5))+
          theme(axis.title = element_text(size=rel(1.5)))
      }
    } else {
      if (input$z == "Annular") {
        ggmap(map) +
          geom_point(data=annular_solar, aes(longitude_value, latitude_value, color=month), size=4) +
          labs(x="Longitude", y="Latitude", title="Annular Solar Eclipse Locations")+
          theme(plot.title = element_text (size = rel(2), hjust = 0.5))+
          theme(axis.title = element_text(size=rel(1.5)))
      }
      else if (input$z == "Total") {
        ggmap(map) + 
          geom_point(data=total_solar, aes(longitude_value, latitude_value, color=month), size=4) +
          labs(x= "Longitude", y= "Latitude", title="Total Solar Eclipse Locations")+
          theme(plot.title = element_text (size = rel(2), hjust = 0.5))+
          theme(axis.title = element_text(size=rel(1.5)))
      }
      else if (input$z == "Partial") {
        ggmap(map) + 
          geom_point(data=partial_solar, aes(longitude_value, latitude_value, color=month), size=4) +
          labs(x= "Longitude", y= "Latitude", title="Partial Solar Eclipse Locations")+
          theme(plot.title = element_text (size = rel(2), hjust = 0.5))+
          theme(axis.title = element_text(size=rel(1.5)))
      }
      else if (input$z == "Hybrid") {
        ggmap(map) + 
          geom_point(data=hybrid_solar, aes(longitude_value, latitude_value, color=month), size=4) +
          labs(x= "Longitude", y= "Latitude", title="Hybrid Solar Eclipse Locations")+
          theme(plot.title = element_text (size = rel(2), hjust = 0.5))+
          theme(axis.title = element_text(size=rel(1.5)))
      } else {
        ggmap(map) + 
          geom_point(data=app_solar, aes(longitude_value, latitude_value, color=month), size=4) +
          labs(x= "Longitude", y= "Latitude", title="All Solar Eclipse Locations")+
          theme(plot.title = element_text (size = rel(2), hjust = 0.5))+
          theme(axis.title = element_text(size=rel(1.5)))
      }
      
    }
  })
}
shinyApp(ui, server)

