﻿<cfif ucase(GetAuthUser() neq "ADMIN") >
	<cfoutput><h2>Authenticated user is not an admin!</h2></cfoutput>
	<cfabort>
</cfif>


<html>
<head>
    <title>eForm User Manager</title>
	<link rel="icon" type="image/ico" href="../../../diginfologo.ico">
	<link rel="stylesheet" type="text/css" href="../../../scripts/extjs/resources/css/ext-all.css">
    <script type="text/javascript" src="../../../scripts/extjs/ext-all.js"></script> 
	<script src="Api.cfm"></script>
    <script type="text/javascript" src="app.js">
    </script>
</head>
<body>
	
</body>
</html>


<cfsetting showdebugoutput="false">