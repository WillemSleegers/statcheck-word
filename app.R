
# Setup -------------------------------------------------------------------

# Load packages
library(shiny)
library(statcheck)
library(DT)

# Set options
options(shiny.port = 7775, shiny.host = "127.0.0.1")

# UI ----------------------------------------------------------------------

ui <- fluidPage(
  
  # Include JS and CSS files
  tags$head(
    tags$script(
        src = "https://appsforoffice.microsoft.com/lib/1.1/hosted/office.js"
      ),
    tags$link(
        rel = "stylesheet", 
        type = "text/css", 
        href = paste0("https://static2.sharepointonline.com/files/fabric/", 
          "office-ui-fabric-core/9.6.1/css/fabric.min.css")
      ),
    tags$link(
        rel = "stylesheet", 
        type = "text/css", 
        href = "taskpane.css"
      )
  ),
  
  # Include Word addin JS
  tags$script(src = "taskpane.js"),
  
  # Include statcheck image
  img(id = "statcheck-logo", src = "assets/statcheck.png"),
  
  tabsetPanel(type = "tabs",
    tabPanel("Home",
      # Output: Display found statistics in a table
      dataTableOutput(outputId = "results"),
      
      # Input: One-tailed tests?
      checkboxInput("one_tailed", 
        "Try to identify and correct for one-tailed tests?", FALSE),
      
      # Input: Check document button
      actionLink("check_button", "Statcheck me!")
    ),
    tabPanel("Documentation",
      includeMarkdown("documentation.md")
    ),
    tabPanel("Contact",
      p("Contact")
    )
  )
)

# Server ------------------------------------------------------------------

server <- function(input, output) {
  
  output$results <- renderDataTable({
    req(input$body_text)
    
    # Extract statistics
    statistics <- statcheck(input$body_text, OneTailedTxt = input$one_tailed)
    
    # Create the data for the output table
    data <- data.frame(
      test = statistics$Raw,
      computed = statistics$Computed,
      error = statistics$Error
    )
    
    # Clean up the table
    # Format the computed p-values
    data$computed <- ifelse(data$computed < .001, "< .001", 
      round(data$computed, digits = 3))
    
    print(data$computed)
    
    # Recode the error to yes/no
    data$error <- ifelse(data$error == TRUE, "yes", "no")
    
    datatable(data, 
        colnames = c("Statistical test", "Computed", "Error"),
        options = list(dom = "t")
      )
  })
  
}

# Run app -----------------------------------------------------------------

shinyApp(ui = ui, server = server,  )

# Host app ----------------------------------------------------------------

# rsconnect::deployApp()
