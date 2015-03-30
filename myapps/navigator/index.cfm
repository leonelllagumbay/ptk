<cfif result eq "true" >
<html>
<head>
    <title>Navigator</title>
	<link rel="icon" type="image/ico" href="../../diginfologo.ico">
	<link rel="stylesheet" type="text/css" href="../../scripts/extjs/resources/css/ext-all-neptune.css">
    <script type="text/javascript" src="../../scripts/extjs/ext-all.js"></script>
	<script src="Api.cfm"></script>
    <script type="text/javascript" src="app.js"> 
    </script>
	
	
	<style type="text/css">
		.field-margin {
			margin: 5px;
		}
		.field-margin-center {
			margin: 5px;
			text-align: center;
		}
	</style>
</head>
<body>
	
	
</body>
</html>

<cfelse>
	<cfthrow message="Access to the application is denied." >
</cfif>

<cfsetting showdebugoutput="false">