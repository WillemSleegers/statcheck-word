# Which results does statcheck detect?
statcheck searches for specific patterns and recognizes statistical results from correlations and t, F, $\chi^2$, Z tests and Q tests. statcheck can only read these results if the results are reported exactly according to the APA guidelines:

* t(df) = value, p = value
* F(df1, df2) = value, p = value
* r(df) = value, p = value
* $\chi^2$ (df, N = value) = value, p = value *(N is optional, $\Delta$G is also included, since it follows a $\chi^2$ distribution)*
* Z = value, p = value 
* Q (df) = value, p = value *(statcheck can read and distinguishes between Q, Qw / Q-within, and Qb / Q-between)*

Statcheck takes into account that test statistics and p values may be exactly (=) or inexactly (< or >) reported. Different spacing has also been taken into account.

# Why doesn't statcheck detect my statistics?
Some common reasons why statcheck doesn't detect some results:

- the result was not reported according to APA style. This includes minor deviations such as square brackets instead of parentheses, or a semi-colon instead of a comma.
- the result was not reported completely. Statcheck needs three ingredients to detect a result and recalculate the p-value: the reported test statistic, degrees of freedom, and p-value. If one or more of these are missing, statcheck will not pick it up.
- the result is reported in a table. 

# I thought I copied the correct result to my document. Why does statcheck still flag it as an error?
Some common reasons why statcheck flags a result as an error:

- 

# Who do I contact if I have additional questions?
For questions about using statcheck in Word, contact Willem Sleegers.
For questions about statcheck in general, contact Michèle Nuijten.