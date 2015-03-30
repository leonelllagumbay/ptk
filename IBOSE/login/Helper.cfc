<cfcomponent>
	<cffunction name="sendResetLink" access="public" returntype="any" >
		<cftry>
			<cfquery name="qryProfileMail" datasource="IBOSE_GLOBAL" maxrows="1">
				SELECT PROFILENAME,GUID
				  FROM EGRGUSERMASTER
				 WHERE USERID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ucase(trim(url.uname))#">
			</cfquery>
			<cfquery name="qryCompanyCode" datasource="IBOSE_GLOBAL" maxrows="1">
				SELECT COMPANYCODE
				  FROM GMFPEOPLE
				 WHERE GUID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#qryProfileMail.GUID#">
			</cfquery>
			<cfset requestcod = CreateUuid() >
			<cfquery name="addRequest" datasource="IBOSE_GLOBAL" >
				INSERT INTO EGINPWDRESETREQUEST(REQUESTCODE, USERID)
				  VALUES (
				  	<cfqueryparam cfsqltype="cf_sql_varchar" value="#requestcod#">,
				  	<cfqueryparam cfsqltype="cf_sql_varchar" value="#ucase(trim(url.uname))#">
				  )
			</cfquery>
			<cfquery name="qryDomain" datasource="IBOSE_GLOBAL" maxrows="1">
				SELECT WEBDOMAIN
				  FROM EGRGCOMPANYSETTINGS
				 WHERE COMPANYCODE  = '#qryCompanyCode.COMPANYCODE#';
			</cfquery>
			<cfmail from="#trim(qryProfileMail.PROFILENAME)#"
				to="#trim(qryProfileMail.PROFILENAME)#"
				subject="My iBOS/e Reset Link"
				type="html"
				>

				<p>Hi,</p>
				<p>This is a request to reset the password for your account.</p>
				<p>For a more secure way of resetting your password, please contact your administrator.</p>
				<p></p>
				<p>Click the link below to continue. Are you sure you want to continue?</p>
				<a href="#qryDomain.WEBDOMAIN#templates/account/resetform/?requestcode=#requestcod#">Continue</a>

			</cfmail>



			<cfcatch type="any" >
				<cfreturn cfcatch.message>
			</cfcatch>
		</cftry>
		<cfreturn "true" >
	</cffunction>

	<cffunction name="loginToGoogle" access="public" returntype="void" hint="This function handles the redirect uri from google to get the token and use this token to access user's email">
		<cfhttp url="https://www.googleapis.com/oauth2/v3/token" method="post" result="res">
			<cfhttpparam name="code" value="#url.code#" type="formfield">
			<cfhttpparam name="client_id" value="561695249357-7tkuphd99v8q1ao3skn35hjgegb52s1f.apps.googleusercontent.com" type="formfield">
			<cfhttpparam name="client_secret" value="KLLm-o-Ni0k-YGYW7KRAeMOO" type="formfield">
			<cfhttpparam name="redirect_uri" value="http://localhost:8500" type="formfield">
			<cfhttpparam name="grant_type" value="authorization_code" type="formfield">
		</cfhttp>

		<cfset dstruct ="#deserializeJSON(res.Filecontent)#">

		<cfhttp url="https://www.googleapis.com/oauth2/v1/tokeninfo?id_token=#dstruct.id_token#" result="resb">
		</cfhttp>
		<cfset dstructb ="#deserializeJSON(resb.Filecontent)#">

		<cfquery name="qryCred" datasource="#session.global_dsn#" maxrows="1">
			SELECT USERID, PASSWORD
			  FROM EGRGUSERMASTER
			 WHERE GOOGLEEMAIL = <cfqueryparam cfsqltype="cf_sql_varchar" value="#dstructb.email#" >
		</cfquery>
		<cfif qryCred.Recordcount gt 0>
			<cfset form.authtype = "native">
			<cfset form.username = qryCred.USERID >
			<cfset form.password = qryCred.PASSWORD >
		<cfelse>
		    <cfthrow detail="Google email is not defined in user master settings.">
		</cfif>
	</cffunction>

</cfcomponent>