var tests = [];

Office.onReady(function(info) {
  if (info.host === Office.HostType.Word) {
    document.getElementById("run").onclick = run;
    document.getElementById("cite_in_text").onclick = cite_in_text;
    document.getElementById("cite_reference").onclick = cite_reference;
    document.getElementById("cite_bib").onclick = copy_bib;
    
    // Initialize all tooltips
    $(function () {
      $('[data-toggle="tooltip"]').tooltip()
    })
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
        document.getElementById("run").innerHTML = "Run again";
    });
  });
}

Shiny.addCustomMessageHandler('receive_tests', function(x) {
  console.log(x);
  tests = x;
});

function cite_in_text() {
  console.log("Cite in-text");
  Word.run(function (context) {
    
    var doc = context.document;
    var originalRange = doc.getSelection();
    originalRange.insertText("(Sleegers & Nuijten, 2020)", "End");

    return context.sync();
  })
  .catch(function (error) {
    console.log("Error: " + error);
    if (error instanceof OfficeExtension.Error) {
        console.log("Debug info: " + JSON.stringify(error.debugInfo));
    }
  });
}

function cite_reference() {
  
  Word.run(function (context) {
    
    var doc = context.document;
    var originalRange = doc.getSelection();
    originalRange.insertText("Sleegers, W.W.A. & Nuijten, M.B. (2020) statcheck for Word. Version 0.1. https://doi.org/blabla", "End");

    return context.sync();
  })
  .catch(function (error) {
    console.log("Error: " + error);
    if (error instanceof OfficeExtension.Error) {
        console.log("Debug info: " + JSON.stringify(error.debugInfo));
    }
  });
}

function copy_bib() {
  /* Get the text field */
  var text = `@misc{sleegers2020,
    title = {Statcheck for {{Word}}},
    author = {Sleegers, Willem W. A. and Nuijten, Mich{\`e}le B.},
    year = {2020}
  }`;
 var textArea = document.createElement("textarea");

  // Place in top-left corner of screen regardless of scroll position.
  textArea.style.position = 'fixed';
  textArea.style.top = 0;
  textArea.style.left = 0;

  // Ensure it has a small width and height. Setting to 1px / 1em
  // doesn't work as this gives a negative w/h on some browsers.
  textArea.style.width = '2em';
  textArea.style.height = '2em';

  // We don't need padding, reducing the size if it does flash render.
  textArea.style.padding = 0;

  // Clean up any borders.
  textArea.style.border = 'none';
  textArea.style.outline = 'none';
  textArea.style.boxShadow = 'none';

  // Avoid flash of white box if rendered for any reason.
  textArea.style.background = 'transparent';


  textArea.value = text;

  document.body.appendChild(textArea);
  textArea.focus();
  textArea.select();

  try {
    var successful = document.execCommand('copy');
    var msg = successful ? 'successful' : 'unsuccessful';
    console.log('Copying text command was ' + msg);
    document.getElementById("cite_bib").innerHTML = "BibTeX copied!";
    setTimeout(function() {
      document.getElementById("cite_bib").innerHTML = "Copy BibTeX";
    }, 3000);
  } catch (err) {
    console.log('Oops, unable to copy');
  }

  document.body.removeChild(textArea);
}

async function go_to_test(button) {
  return Word.run(async context => {
    console.log("Go to test");
    
    // Determine which button was clicked and thus which test the user wants to 
    // find
    var test_nr = button.id.match(/[0-9]+/)[0];
    var test = tests[test_nr - 1];

    // Search the document's body for the test
    var results = context.document.body.search(test);
    
    // Load the search results items
    results.load("items");
    
    
    await context.sync(); 
    
    // Grab the first search result (there should be only 1, but this may not
    // always be true)
    // TODO: Add support for when there are multiple search results
    var range = results.getFirst();
    range.select();
  });
}

function showSettings() {
  console.log("Showing settings");
  var settings = document.getElementById("settings-controls");
  
  settings.classList.toggle("settings-active");
}
