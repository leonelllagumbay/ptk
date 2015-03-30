<!---<cfscript>
	appAccess = CreateObject("component","myapps.IBOSE.security.grantApplication");
	result = appAccess.hasAccessToApp("APPCODE_FK","EGRGUSERAPPS","PROCESSESNEW","USERGRPID_FK"); 
</cfscript>--->  

<cfset result = "true" >

<cfif result eq "true" >

<html>
<head>
    <title>eNotes</title>
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

<cfelse>
	<cfthrow message="There is a problem accessing the application." >
</cfif>


<cfsetting showdebugoutput="false">