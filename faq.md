#### Table of contents

1. [Which results does `statcheck` detect?](#par1)
2. [Why doesn't `statcheck` detect my statistics?](#par2)
3. [Why does `statcheck` flag a result as an error?](#par3)
4. [Where can I find more information about `statcheck`?](#par4)
5. [Who do I contact if I have additional questions?](#par5)

### Which results does `statcheck` detect? <a name="par1"></a>

`statcheck` searches for specific patterns and recognizes statistical results from correlations and t, F, $\chi^2$, Z tests and Q tests. `statcheck` can only read these results if the results are reported exactly according to the APA guidelines:

* t(df) = value, p = value
* F(df1, df2) = value, p = value
* r(df) = value, p = value
* $\chi^2$ (df, N = value) = value, p = value *(N is optional, $\Delta$G is also included, since it follows a $\chi^2$ distribution)*
* Z = value, p = value 
* Q (df) = value, p = value *(`statcheck` can read and distinguishes between Q, Qw / Q-within, and Qb / Q-between)*

`statcheck` takes into account that test statistics and p values may be exactly (=) or inexactly (< or >) reported. Different spacing has also been taken into account.

### Why doesn't `statcheck` detect my statistics? <a name="par2"></a>

Some common reasons why `statcheck` doesn't detect some results:

* the result was not reported according to APA style. This includes minor deviations such as square brackets instead of parentheses, or a semi-colon instead of a comma.
* the result was not reported completely. `statcheck` needs three ingredients to detect a result and recalculate the p-value: the reported test statistic, degrees of freedom, and p-value. If one or more of these are missing, `statcheck` will not pick it up.
* the result is reported in a table. 


### Why does `statcheck` flag a result as an error? <a name="par3"></a>

As a general rule: `statcheck` flags result as an error when the reported *p*-value does not match the recalculated *p*-value. That means that the following situation may result in a `statcheck`-error:

* one-tailed tests.
* Bonferroni adjusted *p*-values
* corrections for violations of assumptions


### Where can I find more information about `statcheck`?<a name="par4"></a>

* The manual: <https://rpubs.com/michelenuijten/statcheckmanual>
* The web app: <http://statcheck.io>
* The R package: <http://cran.r-project.org/web/packages/statcheck/>
* The paper: <https://link.springer.com/article/10.3758/s13428-015-0664-2>
* The GitHub page: <https://github.com/MicheleNuijten/statcheck>


### Who do I contact if I have additional questions?<a name="par5"></a>
For questions about using `statcheck` in Word, contact Willem Sleegers (w.w.a.sleegers@uvt.nl).

For questions about `statcheck` in general, contact Michèle Nuijten (m.b.nuijten@uvt.nl).

