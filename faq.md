#### Table of contents

1. [What is `statcheck`?](#whatis)
2. [How does it work?](#workings)
3. [Example](#ex)
3. [Which results does `statcheck` detect?](#which)
4. [Why doesn't `statcheck` detect my statistics?](#ynodetect)
5. [Why does `statcheck` flag a result as an error?](#whyerror)
6. [Where can I find more information about `statcheck`?](#moreinfo)
7. [Who do I contact if I have additional questions?](#contact)


### What is `statcheck`? <a name="whatis"></a>
`statcheck` is a "spellchecker" for statistics. It checks whether your *p*-values match their accompanying test statistic and degrees of freedom. 

### How does it work? <a name="workings"></a>

`statcheck` works in roughly 3 steps:

1. It scans the text for null-hypothesis significance test (NHST) results that are reported 1) completely (test statistic, degrees of freedom, and *p*-value), and 2) in APA style. 
2. Using the reported test statistic and degrees of freedom, `statcheck` recalculates the *p*-value. By default, the recalculated *p*-value is two-sided.
3. `statcheck` compares the reported *p*-value with the recomputed *p*-value. If these two don't match, `statcheck` will flag the result as an error.

### Example <a name="ex"></a>

Say that you reported the following result: 

"The difference was significant, *t*(28) = 1.2, *p* < .05."

If you click *"Run `statcheck`"*, `statcheck` will recognize this as a statistical test. It will take the degrees of freedom (28) and test statistic (2.2) and recalculate the p-value: *p* = .24. This p-value does not match the reported p-value, so `statcheck` will flag this result as an error.

If you click on a result that `statcheck` flagged as an error, you can see the recalculated *p*-value. Click on "Go to test"" to jump to the location of the test in your document. 

To fix any errors, go to your statistical software to check which of the three numbers (test statistic, degrees of freedom, and/or *p*-value) you need to correct.


### Which results does `statcheck` detect? <a name="which"></a>

`statcheck` searches for specific patterns and recognizes statistical results from correlations and t, F, $\chi^2$, Z tests and Q tests. `statcheck` can only read these results if the results are reported exactly according to the APA guidelines:

* t(df) = value, p = value
* F(df1, df2) = value, p = value
* r(df) = value, p = value
* $\chi^2$ (df, N = value) = value, p = value *(N is optional, $\Delta$G is also included, since it follows a $\chi^2$ distribution)*
* Z = value, p = value 
* Q (df) = value, p = value *(`statcheck` can read and distinguishes between Q, Qw / Q-within, and Qb / Q-between)*

`statcheck` takes into account that test statistics and p values may be exactly (=) or inexactly (< or >) reported. Different spacing has also been taken into account.

### Why doesn't `statcheck` detect my statistics? <a name="ynodetect"></a>

Some common reasons why `statcheck` doesn't detect some results:

* the result was not reported according to APA style. This includes minor deviations such as square brackets instead of parentheses, or a semi-colon instead of a comma.
* the result was not reported completely. `statcheck` needs three ingredients to detect a result and recalculate the p-value: the reported test statistic, degrees of freedom, and p-value. If one or more of these are missing, `statcheck` will not pick it up.
* the result is reported in a table. 


### Why does `statcheck` flag a result as an error? <a name="whyerror"></a>

As a general rule: `statcheck` flags result as an error when the reported *p*-value does not match the recalculated *p*-value. That means that the following situation may result in a `statcheck`-error:

* one-tailed tests.
* Bonferroni adjusted *p*-values
* corrections for violations of assumptions


### Where can I find more information about `statcheck`?<a name="moreinfo"></a>

* The manual: <https://rpubs.com/michelenuijten/statcheckmanual>
* The web app: <http://statcheck.io>
* The R package: <http://cran.r-project.org/web/packages/statcheck/>
* The paper: <https://link.springer.com/article/10.3758/s13428-015-0664-2>
* The GitHub page: <https://github.com/MicheleNuijten/statcheck>


### Who do I contact if I have additional questions?<a name="contact"></a>
For questions about using `statcheck` in Word, contact Willem Sleegers (w.w.a.sleegers@uvt.nl).

For questions about `statcheck` in general, contact Michèle Nuijten (m.b.nuijten@uvt.nl).

