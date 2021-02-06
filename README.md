[![DOI](https://zenodo.org/badge/264169562.svg)](https://zenodo.org/badge/latestdoi/264169562)

# statcheck: a spellchecker for statistics in Microsoft Word

![statcheck logo](https://github.com/WillemSleegers/statcheck-word/raw/master/www/assets/statcheck.png)

The statcheck Word add-in is a "spellchecker" for statistics. It allows you to
check your manuscript for statistical reporting inconsistencies as you write!

Statcheck searches the text in your Word document for null hypothesis
significance tests, for example, _t_(28) = 2.2, _p_ = .063. Statcheck will give
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

Once testing is complete, the statcheck Word add-in will be made available in
the Office Add-in Store. You can find this store in the Insert tab of your
Word document. Once available, you can download the add-in from this story and
immediately use it.

If you want to use the development version of the add-in, please see the
Development section below.

# Questions and comments

We'd love to get your feedback about the statcheck Word add-in! Please send us
your questions and suggestions by creating an Issue here on Github; it's really
easy to [do](https://docs.github.com/en/github/managing-your-work-on-github/creating-an-issue)!

You can also contact us on Twitter via
[@willemsleegers](https://twitter.com/willemsleegers) and
[@michelenuijten](https://twitter.com/MicheleNuijten).

# Additional resources

- [The statcheck manual](https://rpubs.com/michelenuijten/statcheckmanual):
  Detailed instruction manual with information on what statcheck can and
  cannot do, information on how to install and use the statcheck R package,
  and more.
- [The web app](http://statcheck.io): Upload a paper in one click and get a
  table of all detected statistics, classified as consistent, an inconsistency
  or a decision inconsistency.
- [The R package](http://cran.r-project.org/web/packages/statcheck/):
  The R package has additional functionality which allows you to change more
  settings and to scan entire folders of papers.
- [The paper](https://doi.org/10.3758/s13428-015-0664-2): The seminal paper in
  which statcheck was introduced. We ran statcheck on over 30,000 psychology
  papers and report general inconsistency-prevalences over time and per journal.
- [The validity study](https://psyarxiv.com/tcxaj/): We compared statcheck's
  performance with manual checks and assessed its accuracy in classifying
  results as consistent/inconsistent.
- [The GitHub page of statcheck](https://github.com/MicheleNuijten/statcheck):
  Here you can find statcheck's latest developments.

# Development

Can't wait to take the statcheck add-in out for a spin? Follow these steps to
install and run the add-in:

1. Download the files of this Github repository to your computer
2. Open the statcheck-word.Rproj file and then the app.r script
3. Run the code in the Setup section and then launch the app by clicking 'Run App'
4. Sideload the manifest-local.xml file (for instructions on how to do this, see
   [here](https://docs.microsoft.com/en-us/office/dev/add-ins/testing/sideload-an-office-add-in-on-ipad-and-mac))
5. Open the add-in by clicking on the dropdown arrow next to 'My Add-ins' in the
   Insert tab of your Word document

If you have any questions about this, please don't hesitate to create an Issue
or contact us (see the Questions and comments section)

# Copyright

The statcheck Word add-in is distributed under the MIT license. See the file
copyright.txt in this repository for more information.
