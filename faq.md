#### Table of contents

1. [What is `statcheck`?](#whatis)
2. [How does it work?](#workings)
3. [Which results does `statcheck` detect?](#which)
4. [What does the correction for one-tailed tests do?](#1tail)
5. [Why doesn't `statcheck` detect my statistics?](#ynodetect)
6. [Why does `statcheck` flag a result as an error?](#whyerror)
7. [Where can I find more information about `statcheck`?](#moreinfo)
8. [Who do I contact if I have additional questions?](#contact)


### What is `statcheck`? <a name="whatis"></a>
`statcheck` is a "spellchecker" for statistics. It checks whether your *p*-values match their accompanying test statistic and degrees of freedom. 

### How does it work? <a name="workings"></a>

`statcheck` works in roughly 3 steps:

1. It scans the text for null-hypothesis significance test (NHST) results that are reported 1) completely (test statistic, degrees of freedom, and *p*-value), and 2) in APA style. 
2. Using the reported test statistic and degrees of freedom, `statcheck` recalculates the *p*-value. By default, the recalculated *p*-value is two-sided.
3. `statcheck` compares the reported *p*-value with the recomputed *p*-value. If these two don't match, `statcheck` will flag the result as an error.

For example, say that you reported the following result: 

"The difference was significant, *t*(28) = 1.2, *p* < .05."

If you click "Run `statcheck`", `statcheck` will recognize this as a statistical test. It will take the degrees of freedom (28) and test statistic (2.2) and recalculate the p-value: *p* = .24. This p-value does not match the reported p-value, so `statcheck` will flag this result as an error.

If you click on a result that `statcheck` flagged as an error, you can see the recalculated *p*-value. Click on "Go to test"" to jump to the location of the test in your document. 

To fix any errors, go to your statistical software to check which of the three numbers (test statistic, degrees of freedom, and/or *p*-value) you need to correct.

### What does the correction for one-tailed tests do? <a name = "1tail"></a>

By default, `statcheck` treats all tests as two-tailed. If you want to take into account one-tailed tests, you can check the box "Try to correct for one-tailed tests?". 

When this box is ticked, `statcheck` will search the entire text for the keywords "one-tailed", "one-sided", and "directional" (taking spacing issues etc. into account). When statcheck finds at least one of those keywords AND an initially inconsistent result would be consistent if it was a one-tailed test, then statcheck treats this case as a one-tailed test and counts it as consistent.

Note that this correction for one-tailed tests only works if the one-tailed tests are explicitly identified as such in the text, with one of the keywords mentioned above. 

### Which results does `statcheck` detect? <a name="which"></a>

`statcheck` searches for specific patterns and recognizes statistical results from correlations and t, F, &chi;&sup2;, Z tests and Q tests. `statcheck` can only read these results if the results are reported exactly according to the APA guidelines:

* t(df) = value, p = value
* F(df1, df2) = value, p = value
* r(df) = value, p = value
* &chi;&sup2; (df, N = value) = value, p = value *(N is optional, &Delta;G is also included, since it follows a &chi;&sup2; distribution)*
* Z = value, p = value 
* Q (df) = value, p = value *(`statcheck` can read and distinguishes between Q, Qw / Q-within, and Qb / Q-between)*

`statcheck` takes into account that test statistics and p values may be exactly (=) or inexactly (< or >) reported. Different spacing has also been taken into account.

### Why doesn't `statcheck` detect my statistics? <a name="ynodetect"></a>

Some common reasons why `statcheck` doesn't detect some results:

* the result was not reported according to APA style. This includes minor deviations such as square brackets instead of parentheses, or a semi-colon instead of a comma.
* the result was not reported completely. `statcheck` needs three ingredients to detect a result and recalculate the p-value: the reported test statistic, degrees of freedom, and p-value. If one or more of these are missing, `statcheck` will not pick it up.
* the result is reported in a table. 


### Why does `statcheck` say it's an error when I think it's not? <a name="whyerror"></a>

As a general rule: `statcheck` flags result as an error when the reported *p*-value does not match the recalculated *p*-value. However, there may be cases in which you deliberately reported an inconsistent result. For example:

1. you conducted a one-tailed test, but you did not explicitly state it was a one-tailed test using one of the keywords mentioned above
2. you used a Bonferroni correction on your p-value (i.e., multiplied your p-value by the number of tests) to correct for multiple testing
3. you corrected the degrees of freedom for a violation of an assumption (e.g., sphericity), but reported the unadjusted test statistic and p-value

In all these cases, the reported p-value does not match the accompanying test statistic and degrees of freedom anymore, and causes statcheck to flag the result as a potential error.

We would like to argue that in these cases, there is no reason to report a result as internally inconsistent. We would advise the following in the  scenarios above, respectively:

1. explicitly identify which tests are one-tailed and which are two-tailed. This will increase the transparency and reproducibility of your text.
2. when using a Bonferroni correction, correct your *alpha level* by dividing it by the number of tests, instead of multiplying the p-value. The latter results in internal inconsistencies, but could also result in impossible p-values larger than 1.
3. when adjusting results for violations of assumptions, report the entire adjusted result, instead of only adjusting one element in the result (i.e., only the test statistic, degrees of freedom, or the p-value).

### Where can I find more information about `statcheck`?<a name="moreinfo"></a>

* [The manual](https://rpubs.com/michelenuijten/statcheckmanual)
* [The web app](http://statcheck.io)
* [The R package](http://cran.r-project.org/web/packages/statcheck/)
* [The paper](https://link.springer.com/article/10.3758/s13428-015-0664-2)
* [The GitHub page](https://github.com/MicheleNuijten/statcheck)


### Who do I contact if I have additional questions?<a name="contact"></a>
Trouble with `statcheck`? Contact Michèle. Trouble with the Word add-in? Contact Willem.

<!-- links to social media icons -->
[1.1]: http://i.imgur.com/tXSoThF.png (twitter icon with padding)

<i class="icon fa fa-twitter"></i>

||Michèle Nuijten|
-|----------------
|@icn-twitter | <https://mbnuijten.com>
|![alt text][1.1]| [\@MicheleNuijten](http://twitter.com/MicheleNuijten/)
| | <https://github.com/MicheleNuijten>

||Willem Sleegers|
-|----------------
| | <https://www.willemsleegers.com/>
|![alt text][1.1] | [\@willemsleegers](https://twitter.com/willemsleegers)
| | <https://github.com/WillemSleegers>