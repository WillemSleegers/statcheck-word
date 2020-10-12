server <- function(input, output, session) {
  
  one_tailed <- eventReactive(input$run, {
  
    input$one_tailed
  })
  
  output$tests <- renderUI({
    if (is.null(input$body_text)) {
      html <- NULL
    } else if (input$body_text == "") {
      html <- c("The document appears to be empty.")
    } else {
      # Extract statistics
      statistics <- statcheck::statcheck(input$body_text, OneTailedTxt = one_tailed())
      
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
             href="#test-collapse', i, '">'))
          if (error) {
            html <- c(html, '<i class="icon fa fa-warning"></i>')
          }
          html <- c(html, test)
          html <- c(html, '</a></h4></div>')
          html <- c(html, paste0('<div id="test-collapse', i, '" class="panel-collapse collapse">'))
          html <- c(html, '<div class="panel-body">')
          if (error) {
            html <- c(html, '<p>The reported p-value seems inconsistent 
                          with its test statistic and degrees of freedom.</p>')
          } else {
            html <- c(html, '<p>This statistical test is internally consistent.</p>')
          }
          html <- c(html, '<p>Statcheck computed <b>p = ')
          html <- c(html, p_value)
          html <- c(html, '</b></p>')
          html <- c(html, paste0('<p><a class="goto_button" id="goto_button_', i, 
            '" onclick="go_to_test(this)">Go to test</a></p>'))
          html <- c(html, '</div></div></div>')
        }
        html <- c(html, '</div>')
        session$sendCustomMessage("receive_tests", tests)
      } else {
        html <- c('<h5>Detected tests</h5>')
        html <- c(html, '<p>No tests were found.<p>
          <p>Did you report statistics completely and in APA style? See the FAQ 
          for more information.</p>')
      }
      
      HTML(html)
    }
  })
}