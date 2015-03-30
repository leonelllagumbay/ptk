
<cfif ucase(GetAuthUser() neq "ADMIN") >
	<cfoutput><h2>Authenticated user is not an admin!</h2></cfoutput>
	<cfabort>
</cfif>
<html>
	<head>
	    <title>iBOS/e eGallery</title>
		<link rel="icon" type="image/ico" href="../../resource/image/appicon/diginfologo.ico">
		<link rel="stylesheet" type="text/css" href="../../scripts/extjs/resources/css/ext-all.css">
	    <script type="text/javascript" src="../../scripts/extjs/ext-dev.js"></script>
		<script src="Api.cfm"></script>
	    <script type="text/javascript" src="app.js"> 
	    </script>    
	</head>
	
<body>
	
</body>
</html>

<cfsetting showdebugoutput="false">