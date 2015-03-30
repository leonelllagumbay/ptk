<cfif ucase(GetAuthUser() neq "ADMIN") >
	<cfoutput><h2>Authenticated user is not an admin!</h2></cfoutput>
	<cfabort>
</cfif>
<html>  
<head>
    <title>iBOS/e eForms</title>
	<link rel="icon" type="image/ico" href="../../../diginfologo.ico">
	<link rel="stylesheet" type="text/css" href="../../../scripts/extjs/resources/css/ext-all.css"> 
    <script type="text/javascript" src="../../../scripts/extjs/ext-all.js"></script> 
	<script type="text/javascript" src="../../../scripts/extjs/printer/Printer-all.js"></script>
	<script src="../simulator/Api.cfm"></script>
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