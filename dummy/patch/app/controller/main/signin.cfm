<cftry>
	
<cflogin idletimeout = "30"> 
	    <cfif IsDefined("form.password")> 
			<cfif lcase(form.username) eq "admin"> 
	            <cfset roles = "user,admin"> 
	        <cfelse> 
	            <cfset roles = "user"> 
	        </cfif> 
	        <!---Get the user and password
			Validate/Match user and password
			If match perform the following... Else return JSON message invalid or incorrect--->
	        <cfloginuser name     = "#form.username#" 
						 password = "#form.password#"
	                     roles    = "#roles#"
			/> 
		</cfif> 
</cflogin>
<cfoutput>
{
"success": "true",
"form": [{
		"detail":  "yessuccessdetail", 
		"message": "message"
	}]
}
	
</cfoutput>

	<cfcatch type="any">
		<cfoutput>
		{
		"form": [{
				"detail":   "<b>#cfcatch.Detail#</b>", 
				"message":  "#cfcatch.Message#"
			}]
		}
			
		</cfoutput>
		<cfsetting showdebugoutput="no" >
	</cfcatch>
</cftry>

<cfsetting showdebugoutput="no" >