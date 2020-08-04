
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
  div(id = "statcheck-tag", "A spellchecker for statistics"),
  
  tabsetPanel(type = "tabs",
    tabPanel("statcheck",
      # Output: Display found statistics in a table
      uiOutput(outputId = "tests"),
      
      # Instructions
      div(id = "instructions", 
        h5("Instructions:"),
        p("Click the button below to let statcheck search for statistical test 
            results, recalculate the p-value, and flag potential 
            inconsistencies.")
      ),
      
      # Input: Check document button
      actionButton("run", "Run statcheck"),
      
      # Settings
      div(id = "settings",
        h5("Settings"),
        # Input: One-tailed tests?
        checkboxInput("one_tailed", "Try to correct for one-tailed tests?", FALSE)
      ),
      
    ),
    tabPanel("FAQ",
      includeHTML("faq.html"),
    ),
    tabPanel("Cite Us",
      includeMarkdown("cite.md"),
      actionButton("cite_in_text", "Cite in text", class = "cite_button"),
      actionButton("cite_reference", "Cite reference", class = "cite_button"),
      actionButton("cite_bib", "Copy bib", class = "cite_button"),
    )
  ),
  
    # Include Word addin JS
  tags$script(src = "taskpane.js")
)

# Server ------------------------------------------------------------------

server <- function(input, output, session) {
  
  output$tests <- renderUI({
    req(input$body_text)
    
    # Extract statistics
    statistics <- statcheck(input$body_text, OneTailedTxt = isolate(input$one_tailed))
    
    # Check if any tests were found
    if (length(statistics) > 0) {
      # Extract the relevant bits we want to display to the user
      tests <- statistics$Raw
      computed_p_values <- statistics$Computed
      errors <- statistics$Error
      
      # Format the computed p-values
      computed_p_values <- ifelse(computed_p_values < .001, "< .001", 
        round(computed_p_values, digits = 3))
      
      # Create UI
      html <- c('<h5>Detected tests:</h5>')
      for (i in 1:length(tests)) {
        test <- tests[i]
        error <- errors[i]
        p_value <- computed_p_values[i]
        
        html <- c(html, '<button type="button" class="collapsible" onclick="collapse(this)">')
        if (error) {
          html <- c(html, '<i class="icon fa fa-warning"></i>')
          html <- c(html, test)
          html <- c(html, '</button>')
          html <- c(html, '<div class="test_content">')
          html <- c(html, '<p>It seems that the reported p-value is inconsistent 
                        with its test statistic and degrees of freedom.</p>')
        } else {
          html <- c(html, '<i class="icon "></i>')
          html <- c(html, test)
          html <- c(html, '</button>')
          html <- c(html, '<div class="test_content">')
          html <- c(html, '<p>This statistical test is internally consistent.</p>')
        }
        
        html <- c(html, '<p>Statcheck computed <b>p = ')
        html <- c(html, p_value)
        html <- c(html, '</b></p>')
        html <- c(html, paste0('<button class="goto_button" id="goto_button_', i, 
          '" onclick="go_to_test(this)">Go to test</button>'))
        html <- c(html, '</div>')
      }
      session$sendCustomMessage("receive_tests", tests)
    } else {
      html <- c('<h5>Detected tests:</h5>')
      html <- c(html, '<p>No tests were found.</p>')
    }
    
    HTML(html)
  })
}

# Run app -----------------------------------------------------------------

shinyApp(ui = ui, server = server)

# Host app ----------------------------------------------------------------

# rsconnect::deployApp()
