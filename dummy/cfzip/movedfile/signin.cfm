<cftry>
	
<cflogin> 
	    <cfif IsDefined("form.password")> 
			<cfif lcase(form.username) eq "admin"> 
	            <cfset roles = "user,admin"> 
	        <cfelse> 
	            <cfset roles = "user"> 
	        </cfif> 
	        <!---Get the user and password
			Validate/Match user and password
			If match perform the following... Else return JSON message invalid or incorrect--->
			<cfscript>
				authObj = CreateObject("component","IBOSE.login.userauthentication");
				theauthtype = authObj.authType(); //what kind of authentication the user selected
				if(theauthtype == 'googleid') 
				{
					//perform authentication using google id oauth 2
				} else 
				if (theauthtype == 'yahooid')
				{
					//perform authentication using yahoo id oauth 2
				} else
				if (theauthtype == 'ldap')
				{
					theUsername = form.username;
					thePassword = form.password;
					//login using ldap services like MS Active Directory, Apache Directory Service, OpenLDAP, etc
				} else //use native
				{
					//login using the same database used by iBOS/e
					//validate username and password
					theUsername = form.username;
					thePassword = form.password;
					validationResult = authObj.validateUserNative(theUsername,thePassword);
					
				}
				
			</cfscript>
			<cfif validationResult eq "true" >
		        <cfloginuser name     = "#theUsername#" 
							 password = "#thePassword#"
		                     roles    = "#roles#"
				/> 
				
				<cfoutput>
				{
				"success": "true",
				"form": [{
						"detail":  "yessuccessdetail", 
						"message": "message"
					}]
				}
				</cfoutput>
			<cfelse>
				<cfoutput>
				{
				"success": "true",
				"form": [{
						"detail":  "#validationResult#", 
						"message": "message"
					}]
				}
				</cfoutput>
			</cfif>
		<cfelse>
			<!---only if the user is logged out--->
			<cfif cgi.SCRIPT_NAME NEQ "/index.cfm" >
				<cfif findnocase("HTTPS",cgi.SERVER_PROTOCOL) >
	    			<cflocation url="https://#CGI.HTTP_HOST#">  
				<cfelse>
					<cflocation url="http://#CGI.HTTP_HOST#"> 
				</cfif>
			</cfif>
			<cfinclude template="login.cfm"> 
		    <cfabort>
		</cfif> 
</cflogin>

	<cfcatch>
		<cfoutput>
		{
		"success": "true",
		"form": [{
				"detail":   "#cfcatch.Detail#", 
				"message":  "#cfcatch.Message#" 
			}]
		}
			
		</cfoutput>
		<cfsetting showdebugoutput="false" >
	</cfcatch>
</cftry>

<cfsetting showdebugoutput="false" >