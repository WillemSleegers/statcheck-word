
# Setup -------------------------------------------------------------------

# Load packages
library(shiny)
library(statcheck)

# Set options
options(shiny.port = 7775)

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
        href = paste0("https://cdnjs.cloudflare.com/ajax/libs/font-awesome/",
          "4.7.0/css/font-awesome.min.css")
      ),
    tags$link(
        rel = "stylesheet", 
        type = "text/css", 
        href = "taskpane.css"
      )
  ),
  
  # Include statcheck image
  img(id = "statcheck-logo", src = "assets/statcheck.png"),
  
  tabsetPanel(type = "tabs",
    tabPanel("Home",
      # Output: Display found statistics in a table
      uiOutput(outputId = "results"),
      
      # Input: Check document button
      actionButton("check_button", "Run statcheck"),
      
      # Settings
      h5("Settings"),
      # Input: One-tailed tests?
      checkboxInput("one_tailed", "Try to correct for one-tailed tests?", FALSE)
    ),
    tabPanel("FAQ",
      includeMarkdown("faq.md"),
      includeHTML("contact-michele.html"),
      includeHTML("contact-willem.html")
    ),
    tabPanel("Cite Us",
      includeMarkdown("cite.md"),
      actionButton("cite_in_text", "Cite in text"),
      actionButton("cite_reference", "Cite reference"),
      actionButton("cite_bib", "Copy bib"),
    )
  ),
  
    # Include Word addin JS
  tags$script(src = "taskpane.js")
)

# Server ------------------------------------------------------------------

server <- function(input, output, session) {
  
  output$results <- renderUI({
    req(input$body_text)
    
    # Extract statistics
    statistics <- statcheck(input$body_text, OneTailedTxt = input$one_tailed)
    # statistics <- statcheck("T(21) = 2.12, p < .04, T(15) = 4.3, p < .04")
    
    # Extract the relevant bits we want to display to the user
    tests <- statistics$Raw
    computed_p_values <- statistics$Computed
    errors <- statistics$Error
    
    # Format the computed p-values
    computed_p_values <- ifelse(computed_p_values < .001, "< .001", 
      round(computed_p_values, digits = 3))

    # Recode the error to yes/no
    errors <- ifelse(errors == TRUE, "yes", "no")
    
    # Create UI
    html <- c('<h5>Found tests:</h5>')
    for (i in 1:length(tests)) {
      test <- tests[i]
      error <- errors[i]
      p_value <- computed_p_values[i]
      
      html <- c(html, '<button type="button" class="collapsible" onclick="collapse(this)">')
      if (error == "yes") {
        html <- c(html, '<i class="icon fa fa-warning"></i>')
      } else {
        html <- c(html, '<i class="icon "></i>')
      }
      html <- c(html, test)
      html <- c(html, '</button>')
      html <- c(html, '<div class="test_content">')
      html <- c(html, '<p>Computed p-value: ')
      html <- c(html, p_value)
      html <- c(html, '</p>')
      html <- c(html, paste0('<button class="goto_button" id="goto_button_', i, 
        '" onclick="go_to_test(this)">Go to test</button>'))
      html <- c(html, '</div>')
    }
    
    session$sendCustomMessage("receive_tests", tests)
    
    HTML(html)
  })
  
}

# Run app -----------------------------------------------------------------

shinyApp(ui = ui, server = server)

# Host app ----------------------------------------------------------------

# rsconnect::deployApp()
