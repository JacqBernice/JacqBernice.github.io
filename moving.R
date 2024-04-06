library(shiny)

ui <- fluidPage(
  tags$div(id = "moving-text", "Welcome to My Website :)"),
  tags$style('
    @keyframes move {
      0%   { transform: translateX(0); }
      100% { transform: translateX(100%); }
    }
    #moving-text {
      position: relative;
      animation: move 5s linear infinite;
      font-weight: bold;
      background-color: black;
      color: white;
      padding: 5px;
    }
  ')
)

server <- function(input, output, session) {
}

shinyApp(ui = ui, server = server)
