<cfcomponent displayname="lookupB" hint="Lookup function 2" output="true">    

	<cffunction
			name="getclearingdeptgroup"
			returntype="void"
			
	>
	<cftry>
		
		<cfquery name="qrygroup" datasource="IBOSE_GLOBAL">
			SELECT THEGROUP,  count(*)
			  FROM EGLKCLRDEPT
		GROUP BY THEGROUP;  
		</cfquery>
	
	<cfif isdefined("qrygroup") >
		<cfoutput>
		{
		"success": "true",
		"grouplk": [
				<cfset ecounter = 1 >
				<cfset querylen = qrygroup.recordcount >
				<cfloop query="qrygroup">
					{
						"groupcode": #SerializeJSON(THEGROUP)#, 
						"groupname": #SerializeJSON(THEGROUP)#
					}
					<cfif querylen NEQ ecounter> 
						<cfoutput>,</cfoutput>
				    </cfif>
				    <cfset ecounter = ecounter + 1 >
				    
		        </cfloop>
		]
		}
		</cfoutput>
	<cfelse>
		<cfoutput>
		{
		"success": "true",
		"grouplk": [{
						"groupcode": #SerializeJSON("empty")#, 
						"groupname": #SerializeJSON("empty")#
					}]
		}
		</cfoutput>
	</cfif>
		<cfcatch>
			<cfoutput>
				"success": "true",
				"grouplk": [{
						"groupcode":"error", 
						"groupname": #SerializeJson(cfcatch.Detail & ' ' & cfcatch.Message)#
					}]
				}
			</cfoutput>
		</cfcatch>
	</cftry>
	</cffunction>
	
	
	<cffunction
			name="gettemplate"
			returntype="void"
			
	>
	<cftry>
		
		<cfquery name="qrytemplate" datasource="IBOSE_GLOBAL">
			SELECT NAME
			  FROM EGLKEMAILTEMPLATE
		;  
		</cfquery>
	
	<cfif isdefined("qrytemplate") >
		<cfoutput>
		{
		"success": "true",
		"templatelk": [
				<cfset ecounter = 1 >
				<cfset querylen = qrytemplate.recordcount >
				<cfloop query="qrytemplate">
					{
						"templatecode": #SerializeJSON(NAME)#, 
						"templatename": #SerializeJSON(NAME)#
					}
					<cfif querylen NEQ ecounter> 
						<cfoutput>,</cfoutput>
				    </cfif>
				    <cfset ecounter = ecounter + 1 >
				    
		        </cfloop>
		]
		}
		</cfoutput>
	<cfelse>
		<cfoutput>
		{
		"success": "true",
		"templatelk": [{
						"templatecode": #SerializeJSON("empty")#, 
						"templatename": #SerializeJSON("empty")#
					}]
		}
		</cfoutput>
	</cfif>
		<cfcatch>
			<cfoutput>
				"success": "true",
				"templatelk": [{
						"templatecode":"error", 
						"templatename": #SerializeJson(cfcatch.Detail & ' ' & cfcatch.Message)#
					}]
				}
			</cfoutput>
		</cfcatch>
	</cftry>
	</cffunction>
	
</cfcomponent>