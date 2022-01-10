## app.R ##
library(shinydashboard)
library(plotly)

data <- read.csv("data/df_temperature.csv")
data <- data %>% filter(level == 12)

min_mean_temp <- floor(min(data$MEAN))
max_mean_temp <- ceiling(max(data$MEAN))

min_elapsed <- floor(min(data$elapsed_time))
max_elapsed <- ceiling(max(data$elapsed_time))


machines <- 1:1024
machines <- c("None", machines)
gpu_model <- unique(as.numeric(substr(df_power$gpuSerial, 1, 4))) 
gpu_model <- c("None", gpu_model)

mean_elapsed_time <- mean(data$elapsed_time)

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Temperature", tabName = "dashboard", icon = icon("dashboard")),
    menuItem("GPU Utilization", icon = icon("th"), tabName = "widgets" ),
    menuItem("GPU Memory Utilization", icon = icon("th"), tabName = "widgets" )
)
)

ui <- dashboardPage(
  dashboardHeader(title = "Terapixel dashboard"),
  sidebar,
  dashboardBody(
    fluidRow(
      # A static infoBox
      infoBox("Total Machine", 1024, icon = icon("list")),
      infoBox("Total GPU Model", length(gpu_model)-1, icon = icon("list"),color = "purple"),
      infoBox("Mean Elapsed Time", mean_elapsed_time, icon = icon("list"), color = "yellow"),
    ),
    # Boxes need to be put in a row (or column)
    fluidRow(
      box(plotlyOutput("plot1",  height = 450), width=8),
      
      box(width=4,
        title = "Filter", 
        sliderInput("slider", "Mean Temperature (celcius):", min_mean_temp, max_mean_temp, c(min_mean_temp, max_mean_temp)),
        sliderInput("slider_2", "ElapsedTime (sec):", min_elapsed, max_elapsed, c(min_elapsed,max_elapsed)),
        selectInput("machine_id",
                    "Machine ID:",
                    choices = machines,
                    selected = gpu_model[1]),
        selectInput("gpu_model",
                    "GPU MODEL:",selected = gpu_model[1] ,
                    choices = gpu_model)
      )
    )
  )
)

server <- function(input, output) {
  
  output$plot1 <- renderPlotly({
    message(input$machine_id)
    
    filtered_data <- data %>% 
      filter( MEAN <= input$slider[2] & MEAN >= input$slider[1] ) %>% 
      filter( elapsed_time <= input$slider_2[2] &  elapsed_time >= input$slider_2[1] )
      
    if(input$machine_id != "None"){
      filtered_data <- filtered_data %>% filter(machine_id == as.numeric(input$machine_id))
    }  
    
    if(input$gpu_model != "None"){
      filtered_data <- filtered_data %>% filter(as.numeric(substr(gpuSerial, 1, 4)) == as.numeric(input$gpu_model))
    } 
      
    plot1 <- ggplotly(ggplot(filtered_data, aes(x= y, y = 255- x, color=MEAN)) +  geom_tile(aes(fill = MEAN))  + scale_colour_gradient(
      low = "#1d2671",high = "#dddddd") + labs(title="Average GPU Temperature",
                                               x ="X axis", y = "Y axis")+ ggtitle("Average GPU Temperature") + theme(axis.title.x = element_blank(), axis.title.y = element_blank(),legend.position="none") 

    )
    })
  
  
  
}

shinyApp(ui, server)