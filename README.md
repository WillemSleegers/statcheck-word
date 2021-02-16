<p align="center">
  <img width="400px" src="https://github.com/WillemSleegers/statcheck-word/raw/master/www/assets/statcheck.png"</img>
</p>

# statcheck: A spellchecker for statistics in Microsoft Word

The statcheck Word add-in is a "spellchecker" for statistics. It allows you to
check your manuscript for statistical reporting inconsistencies as you write!

statcheck searches the text in your Word document for null hypothesis
significance tests, for example, _t_(28) = 2.2, _p_ = .063. After going through your document, statcheck will produce 
an overview of all the tests it found in the text.

Next, it recalculates the p-value based on the test statistic and degrees of
freedom. In the example above, the _p_-value belonging to a _t_-value of 2.2
with 28 degrees of freedom is .036, not .063!

If statcheck detects such an inconsistency, it will flag the result with a
little orange warning sign. To solve the inconsistency, go back to your
statistical software to check which of the numbers in the result needs to be
corrected.

![statcheck screenshot](https://github.com/WillemSleegers/statcheck-word/raw/master/www/assets/screenshot.png)

# Requirements

You need the following to use add-in:

- An internet connection (the add-in is a web app that runs inside of Word)
- A compatible version of Microsoft Word:
  - Word 2016 or later on Windows
  - Word 2016 or later on Mac
  - Word on the web

For more information on the requirements, see [here](https://docs.microsoft.com/en-us/office/dev/add-ins/concepts/requirements-for-running-office-add-ins).

# Getting started

The statcheck Word add-in will be made available in
the Office Add-in Store after testing is complete. You can find the Office Add-in Store in the Insert tab of your
Word document. Once the statcheck add-in is available, you can download the add-in from this store and
immediately use it.

If you want to use the development version of the add-in, please see the
Development section in the Wiki here on Github.

# Questions and comments

We'd love to get your feedback about the statcheck Word add-in! Please send us
your questions and suggestions by creating an Issue here on Github; it's really
easy to do!

You can also contact us on Twitter via
[@willemsleegers](https://twitter.com/willemsleegers) and
[@michelenuijten](https://twitter.com/MicheleNuijten).

# Copyright

The statcheck Word add-in is distributed under the MIT license. See the file
copyright.txt in this repository for more information.

[![DOI](https://zenodo.org/badge/264169562.svg)](https://zenodo.org/badge/latestdoi/264169562)
