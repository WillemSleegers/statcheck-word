var tests = [];

Office.onReady(function(info) {
  if (info.host === Office.HostType.Word) {
    document.getElementById("check_button").onclick = run;
  }
});

async function run() {
  return Word.run(async context => {
     // Create a proxy object for the document body.
    var body = context.document.body;

    // Queue a command to load the text in document body.
    context.load(body, 'text');

    // Synchronize the document state by executing the queued commands,
    // and return a promise to indicate task completion.
    return context.sync().then(function () {
        // Send Word document content to Shiny
        Shiny.onInputChange("body_text", body.text);
        document.getElementById("check_button").innerHTML = "Run again"
    });
  });
}

Shiny.addCustomMessageHandler('receive_tests', function(x) {
  tests.push(x);
});

async function go_to_test(button) {
  return Word.run(async context => {
    // Determine which button was clicked and thus which test the user wants to 
    // find
    var test_nr = button.id.match(/[0-9]+/)[0];
  
    // Search the document's body for the test
    let results = context.document.body.search(tests[test_nr - 1]);
    
    // Load the search results items
    results.load("items");
    await context.sync();
    
    // Grab the first search result (there should be only 1, but this may not
    // always be true
    // TODO: Add support for when there are multiple search results
    var range = results.getFirst();
    range.select();
  });
}

function collapse(button) {
  button.classList.toggle("clicked");
  var content = button.nextElementSibling;
  if (content.style.display === "block") {
    content.style.display = "none";
  } else {
    content.style.display = "block";
  }
}
