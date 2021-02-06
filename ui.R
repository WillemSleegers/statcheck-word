ui <- shiny::fluidPage(
  
  # Include JS and CSS files
  shiny::tags$head(
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
      
       # Settings
      div(id = "settings",
        h5(id = "settings-title", "Settings"), 
        # Input: One-tailed tests?
        checkboxInput("one_tailed", "Correct for one-tailed tests", FALSE)
      ),
      
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
              </a>')
      ),
      
      hr(),
      
      # Output: Display found statistics in a table
      uiOutput(outputId = "tests"),
    ),
    tabPanel("FAQ",
      includeHTML("www/faq.html"),
    ),
    tabPanel("Cite Us",
      includeHTML("www/cite.html")
    )
  ),
  
    # Include Word addin JS
  tags$script(src = "taskpane.js")
)