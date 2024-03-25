# Load necessary libraries
library(shiny)
library(dplyr)
library(tidyr)
library(ggplot2)

# Define UI
ui <- fluidPage(
  titlePanel("Genre Popularity"),
  sidebarLayout(
    sidebarPanel(
      selectInput("variable", "Choose a variable:", 
                  choices = c("popularity", "vote_average", "vote_count", "revenue", "runtime", "budget")),
      actionButton("plotBtn", "Plot")
    ),
    mainPanel(
      plotOutput("plot")
    )
  )
)

# Define server logic
server <- function(input, output) {
  observeEvent(input$plotBtn, {
    # Split genres into multiple rows
    data_split <- data %>%
      separate_rows(genres, sep = ",") %>%
      filter(genres != "")  # Remove empty genres
    
    # Clean up genre names to remove leading and trailing whitespace
    data_split$genres <- trimws(data_split$genres)
    
    # Group data by genre and calculate average of selected variable
    genre_data <- data_split %>%
      group_by(genres) %>%
      summarize(avg_variable = mean(get(input$variable), na.rm = TRUE))
    
    # Plot
    output$plot <- renderPlot({
      ggplot(genre_data, aes(x = reorder(genres, avg_variable), y = avg_variable)) +
        geom_bar(stat = "identity") +
        labs(x = "Genre", y = input$variable, title = paste("Average", input$variable, "by Genre")) +
        theme(axis.text.x = element_text(angle = 45, hjust = 1))
    })
  })
}

# Run the application
shinyApp(ui = ui, server = server)
