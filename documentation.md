Statcheck is a "spellchecker" for statistics. It checks whether your p-values match their accompanying test statistic and degrees of freedom. 

### How does it work?

Statcheck works in roughly 3 steps:

1. It scans the text for null-hypothesis significance test (NHST) results that are reported 1) completely (test statistic, degrees of freedom, and p-value), and 2) in APA style. 
2. Using the reported test statistic and degrees of freedom, statcheck recalculates the p-value. By default, the recalculated p-value is two-sided.
3. Statcheck compares the reported p-value with the recomputed p-value. If these two don't match, statcheck will flag the result as an error.

### Example

Say that you reported the following result: 

"The difference was significant, t(28) = 1.2, p < .05."

If you click *"Run statcheck"*, statcheck will recognize this as a statistical test. It will take the degrees of freedom (28) and test statistic (2.2) and recalculate the p-value: p = .24. This p-value does not match the reported p-value, so statcheck will flag this result as an error.

If you click on a result that statcheck flagged as an error, you can see the recalculated p-value. Click on “Go to test” to jump to the location of the test in your document. 

To fix any errors, go to your statistical software to check which of the three numbers (test statistic, degrees of freedom, and/or p-value) you need to correct.
