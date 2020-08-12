
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
      
      # Input: Run statcheck
      div(id = "run_statcheck", 
        # h5("Instructions"),
        #p(id = "instructions_text", "Click the button below to let statcheck 
        #  search for statistical test results, recalculate the p-value, and flag 
        #  potential inconsistencies.")
        
        # Input: Check document button
        actionButton("run", "Run statcheck"),
        HTML('<a data-toggle="tooltip" data-placement="top" 
              title="Click the button to scan your document for statistical inconsistencies.">
              <i class="fa fa-question-circle"></i>
              </a>'
        ),
      ),
      
      # Output: Display found statistics in a table
      uiOutput(outputId = "tests"),
      
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
      includeHTML("cv.html")
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
      html <- c('<h5>Detected tests</h5>')
      html <- c(html, '<div class="panel-group">')
      for (i in 1:length(tests)) {
        test <- tests[i]
        error <- errors[i]
        p_value <- computed_p_values[i]
        
        html <- c(html, '<div class="panel panel-default">
          <div class="panel-heading">
          <h4 class="panel-title">')
        
        html <- c(html, paste0('<a class="test collapsible-link" data-toggle="collapse" 
           href="#collapse', i, '">'))
        html <- c(html, test)
        if (error) {
          html <- c(html, '<a data-toggle="tooltip" data-placement="top" 
              title="Inconsistent results detected; click to see more.">
              <i class="icon fa fa-warning"></i></a>')
        }
        html <- c(html, '</a></h4></div>')
        html <- c(html, paste0('<div id="collapse', i, '" class="panel-collapse collapse">'))
        html <- c(html, '<div class="panel-body">')
        if (error) {
          html <- c(html, '<p>It seems that the reported p-value is inconsistent 
                        with its test statistic and degrees of freedom.</p>')
        } else {
          html <- c(html, '<p>This statistical test is internally consistent.</p>')
        }
        html <- c(html, '<p>Statcheck computed <b>p = ')
        html <- c(html, p_value)
        html <- c(html, '</b></p>')
        html <- c(html, paste0('<a class="goto_button" id="goto_button_', i, 
          '" onclick="go_to_test(this)">Go to test</a>'))
        html <- c(html, '</div></div></div>')
      }
      html <- c(html, '</div>')
      session$sendCustomMessage("receive_tests", tests)
    } else {
      html <- c('<h5>Detected tests</h5>')
      html <- c(html, '<p>No tests were found.</p>')
    }
    
    HTML(html)
  })
}

# Run app -----------------------------------------------------------------

shinyApp(ui = ui, server = server)

# Host app ----------------------------------------------------------------

# rsconnect::deployApp()
