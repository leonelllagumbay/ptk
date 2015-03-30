<cfquery name="qryMyPassword" datasource="#session.global_dsn#">
	SELECT USERID, PASSWORD
	  FROM EGRGUSERMASTER
	 WHERE PASSWORD = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.currentpass#">
	       AND USERID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.userid#">;
</cfquery>

<cfif qryMyPassword.RecordCount gt 0 >
	<cfscript>
		try
	    {
	    	theOldHashedPassword = hash(form.currentpass);
			theUsername = session.userid;
			thePassword = form.newpass;
			theConfirmPassword = form.cnewpass;
			if (thePassword == theConfirmPassword) {
				theRes = StructNew();
				authObj = CreateObject("component","IBOSE.login.userauthentication");
				theRes = authObj.changeUserPwdNative(theOldHashedPassword,theUsername,thePassword);
				if(theRes["message"] == "true") {
					WriteOutput("success");
				} else {
					WriteOutput(theRes["message"]);
				}
			} else {
				WriteOutput("Password confirmation is incorrect.");
			}
	    }
	    catch(Any e)
	    {
	    	WriteOutput(e.detail);
	    }
	</cfscript>
<cfelse>
	<cfoutput>Invalid current password.</cfoutput>
</cfif>

<cfsetting showdebugoutput="false" >