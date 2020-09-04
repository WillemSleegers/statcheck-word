[![DOI](https://zenodo.org/badge/264169562.svg)](https://zenodo.org/badge/latestdoi/264169562)

# statcheck: a spellchecker for statistics in Microsoft Word
The statcheck Word add-in is a "spellchecker" for statistics. It allows you to 
check your manuscript for statistical reporting inconsistencies as you write!

Statcheck searches the text in your Word document for null hypothesis 
significance tests, for example, *t(28) = 2.2, p = .063*. Statcheck will give
an overview of all the tests it found in the text.

Next, it recalculates the p-value based on the test statistic and degrees of 
freedom. In the example above, the p-value belonging to a t-value of 2.2 with 28
degrees of freedom is .036, not .063!

If statcheck detects such an inconsistency, it will flag the result with a 
little orange warning sign. To solve the inconsistency, go back to your
statistical software to check which of the numbers in the result needs to be
corrected.

# Requirements

# Getting started

# Questions and comments
We'd love to get your feedback about the statcheck Word add-in! Please send us 
your questions and suggestions in the Issues section of this repository.

# Additional resources
* [The statcheck manual](https://rpubs.com/michelenuijten/statcheckmanual) 
<br> Detailed instruction manual with information on what statcheck can and 
    cannot do, information on how to install and use the statcheck R package, 
    and more.
* [The web app](http://statcheck.io)
<br> Upload a paper in one click and get a table of all detected statistics, 
    classified as consistent, an inconsistency or a decision inconsistency.
* [The R package](http://cran.r-project.org/web/packages/statcheck/)
<br> The R package has additional functionality which allows you to change more 
    settings and to scan entire folders of papers.
* [The paper](https://doi.org/10.3758/s13428-015-0664-2)
<br> The seminal paper in which statcheck was introduced. We ran statcheck on 
    over 30,000 psychology papers and report general inconsistency-prevalences 
    over time and per journal.
* [The validity study](https://psyarxiv.com/tcxaj/)
<br> We compared statcheck's performance with manual checks and assessed its 
    accuracy in classifying results as consistent/inconsistent.
* [The GitHub page of statcheck](https://github.com/MicheleNuijten/statcheck)
<br> Here you can find statcheck's latest developments.

# Copyright
The statcheck Word add-in is distributed under the MIT license. See the file
copyright.txt in this repository for more information.