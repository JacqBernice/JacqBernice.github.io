library(shiny)

ui <- fluidPage(
  titlePanel("T-Test Calculator"),
  sidebarLayout(
    sidebarPanel(
      selectInput("variable", "Choose a variable:", choices = c("average_score")),
      selectInput("group", "Choose a grouping variable:", choices = c("gender", "lunch", "test_preparation_course")),
      actionButton("submit", "Run T-Test")
    ),
    mainPanel(
      verbatimTextOutput("result_text"),
      textOutput("interpretation_text")
    )
  )
)

server <- function(input, output) {
  observeEvent(input$submit, {
    # Subset data based on user selection
    data_subset <- subset(study, select = c(input$variable, input$group))
    
    # Perform t-test
    t_test_result <- t.test(data_subset[[input$variable]] ~ data_subset[[input$group]])
    
    # Output result
    output$result_text <- renderPrint({
      t_test_result
    })
    
    # Interpretation of t-test results
    output$interpretation_text <- renderText({
      if (t_test_result$p.value < 0.05) {
        "The difference in means is statistically significant."
      } else {
        "There is no statistically significant difference in means."
      }
    })
  })
}

shinyApp(ui = ui, server = server)
