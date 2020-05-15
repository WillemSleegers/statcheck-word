
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
        document.getElementById("check_button").innerHTML = "Statcheck me again!"
    });
  });
}
