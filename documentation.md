### Details

statcheck uses regular expressions to find statistical results in APA format. When a statistical result deviates from APA format, statcheck will not find it. The APA formats that statcheck uses are: t(df) = value, p = value; F(df1,df2) = value, p = value; r(df) = value, p = value; [chi]2 (df, N = value) = value, p = value (N is optional, delta G is also included); Z = value, p = value. All regular expressions take into account that test statistics and p values may be exactly (=) or inexactly (< or >) reported. Different spacing has also been taken into account.

Note that the conversion from PDF (and sometimes also HTML) to plain text and extraction of statistics can result in errors. Some statistical values can be missed, especially if the notation is unconventional. It is recommended to manually check some of the results.

Also, note that a seemingly inconsistent p value can still be correct when we take into account that the test statistic might have been rounded after calculating the corresponding p value. For instance, a reported t value of 2.35 could correspond to an actual value of 2.345 to 2.354 with a range of p values that can slightly deviate from the recomputed p value. statcheck will not count cases like this as errors.

The web implementation of statcheck will return an error if a PDF that does not contain any statistical results in APA format is submitted.

