<!DOCTYPE html> <html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico">
    <title>statcheck // web</title>
    <!-- Bootstrap core CSS -->
    <link href="./bs/css/bootstrap.min.css" rel="stylesheet">
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="./bs/ie10-viewport-bug-workaround.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="starter-template.css" rel="stylesheet">
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
  <body>
	<?php $pageid="documentation"; include 'navbar.php'; ?>
    <div class="container">
      <div class="page-header" style="margin-top: 80px; border-bottom:0px;">
        <h1>MS Word Add-In</h1>
        <p class="lead">Details</p>
			<p>statcheck uses regular expressions to find statistical results in APA format. When a statistical result deviates from APA format, statcheck will not find it. The APA formats that statcheck uses are: t(df) = value, p = value; F(df1,df2) = value, p = value; r(df) = value, p = value; [chi]2 (df, N = value) = value, p = value (N is optional, delta G is also included); Z = value, p = value. All regular expressions take into account that test statistics and p values may be exactly (=) or inexactly (< or >) reported. Different spacing has also been taken into account.</p>
			<p>Note that the conversion from PDF (and sometimes also HTML) to plain text and extraction of statistics can result in errors. Some statistical values can be missed, especially if the notation is unconventional. It is recommended to manually check some of the results.</p>
			<p>Also, note that a seemingly inconsistent p value can still be correct when we take into account that the test statistic might have been rounded after calculating the corresponding p value. For instance, a reported t value of 2.35 could correspond to an actual value of 2.345 to 2.354 with a range of p values that can slightly deviate from the recomputed p value. statcheck will not count cases like this as errors.</p>
			<p>The web implementation of statcheck will return an error if a PDF that does not contain any statistical results in APA format is submitted.</p>
			<p>For more detailed information about statcheck can and cannot do, please see the online manual here: rpubs.com/michelenuijten/statcheckmanual.</p>
		<p class="lead">Output</p>
			<table class="table table-striped">
				<thead>
					<tr>
						<th>Value</th>
						<th>Description</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>Source</td>
						<td>Name of the file of which the statistic is extracted.</td>
					</td>
					<tr>
						<td>Statistical Reference</td>
						<td>Raw string of the statistical reference that is extracted.</td>
					</td>
					<tr>
						<td>Computed p Value</td>
						<td>The recomputed p-value based on the reported degrees of freedom and test statistic.</td>
					</td>
					<tr>
						<td>Consistency</td>
						<td>Does the reported p-value match the recomputed p-value? (Consistency: the reported p-value matches the recomputed p-value. Inconsistency: the reported p-value does not match the recomputed p-value. Decision inconsistency: the reported p-value is statistically significant and the recomputed p-value is not, or vice versa.)</td>
					</td>
			</table>
			<br/>
			<br/>
		
	  </div>
	<?php include 'footer.php'; ?>
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  </body> </html> 