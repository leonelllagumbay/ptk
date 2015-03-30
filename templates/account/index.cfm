<html>
	<head>
	    <title>iBOS/e Password Reset</title>
	    <style type="text/css">
			.field-margin {
				margin: 10px;
			}
		</style>
		<link rel="icon" type="image/ico" href="../../resource/image/appicon/diginfologo.ico">
	</head>
	<body>
		
		
		
		<cfif IsDefined("form.cbtnpwd") >
			<cfinvoke method="sendResetLink" component="IBOSE.login.Helper" returnvariable="retV" > 
			<cfif retV eq "true" >
				<p>Your request has been sent.</p>
			<cfelse>
				<p>There is a problem in your request.</p>
				<cfdump var="#retV#" >
			</cfif>
		<cfelse>
			<cfform name="emailchangerequestpassword" action="./?uname=#url.uname#" method="post" >
				<cfinput type="hidden" name="notused" > 
				<cfinput type="submit" name="cbtnpwd" tooltip="Send me a link" value="Send me a link" style="margin: 20px;" > 
			</cfform>
		</cfif>
		
	</body>
</html>
	
<cfsetting showdebugoutput="false" >