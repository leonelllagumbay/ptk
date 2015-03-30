<!DOCTYPE html>

<html>
	<!---<cfscript>
		appAccess = CreateObject("component","IBOSE.security.Access");
		result = appAccess.hasAccessToApp("APPCODE_FK","EGRGUSERAPPS","EFORMSIMULATOR","USERGRPID_FK");
	</cfscript>--->
	<cfif ucase(GetAuthUser() neq "ADMIN") >
		<cfoutput><h2>Authenticated user is not an admin!</h2></cfoutput>
		<cfabort>
	</cfif>
<head>
    <title>eForm Simulator</title>

	<link rel="stylesheet" type="text/css" href="../../../scripts/extjs/resources/css/ext-all.css">
    <script type="text/javascript" src="../../../scripts/extjs/ext-dev.js"></script>
	<script type="text/javascript" src="../../../scripts/extjs/printer/Printer-all.js"></script>
	<script src="Api.cfm"></script>
    <script type="text/javascript" src="app.js">
    </script>
    <script type="text/javascript">
    	function getURLParameter(name) {
		  return decodeURIComponent((new RegExp('[?|&]' + name + '=' + '([^&;]+?)(&|#|;|$)').exec(location.search)||[,""])[1].replace(/\+/g, '%20'))||null
		}
	</script>

    <style type="text/css">
		.ctextarea {
			resize:both;
		}
		input.x-form-invalid-field {
		   border-color: #cf4c35 !important;
		}
	</style>

</head>
<body>

</body>
</html>


<cfsetting showdebugoutput="false">