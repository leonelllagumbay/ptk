<cfcomponent name="Complements" ExtDirect="true"> 

	<cffunction name="getQuickFormStatus" ExtDirect="true" returntype="Array" >  
		<cfargument name="theFormID" type="array" >   
		<cfargument name="theProcessID" type="array" >
		
		<cfset returnArr = ArrayNew(1) >
		
		<cfloop array="#theProcessID#" index="processID" >
			<cfset theStatus = "N" >
			
			<cfset formRouterData = EntityLoad("EGINROUTERDETAILS", {PROCESSIDFK = #processID#}, "ROUTERORDER ASC") >
			
			<cfloop array="#formRouterData#" index="routerIndex" >
				
				<cfset formApproversData = EntityLoad("EGINAPPROVERDETAILS", {ROUTERIDFK =#routerIndex.getROUTERDETAILSID()#}, "APPROVERORDER ASC" ) >
				
				<cfloop array="#formApproversData#" index="approverIndex" > 
					
					<cfset APPROVERORDER = approverIndex.getAPPROVERORDER() >
					<cfset PERSONNELIDNO = approverIndex.getPERSONNELIDNO() >
					<cfset ACTION = approverIndex.getACTION() >
					
					<cfif ACTION eq "CURRENT" AND ucase(PERSONNELIDNO) neq "#ucase(session.chapa)#">
						<cfquery name="getPersonalOrig" datasource="#session.company_dsn#" maxrows="1" >
							SELECT A.FIRSTNAME AS FIRSTNAME
							  FROM #session.maintable# A 
							 WHERE A.#session.mainpk# = '#PERSONNELIDNO#'
						</cfquery> 
						<cfset theStatus = "PENDING TO #getPersonalOrig.FIRSTNAME#" >
						<cfset breakOuter = "yes" >
						
					<cfelseif ACTION eq "CURRENT" AND ucase(PERSONNELIDNO) eq "#ucase(session.chapa)#">
						<cfset theStatus = "S" >
						<cfset breakOuter = "yes" >
						<cfbreak>
				    <cfelse>
				    	<cfset breakOuter = "no" >
					</cfif>
					 
				</cfloop> <!---end formApproversData--->
				
				<cfif breakOuter eq "yes" >
					<cfbreak>
				</cfif>
				
			</cfloop> <!---end formRouterData--->
			
			<cfset ArrayAppend(returnArr, theStatus) >

		</cfloop> <!---end process id's--->
		
		<cfreturn returnArr >
		
	</cffunction>
	
	
	<cffunction name="saveSignature" ExtDirect="true" >
		<cfargument name="sigData" >
		<cfargument name="processid" >
		<cfargument name="actionref" >
		<cftry>
			<cfquery name="qrySignature" datasource="#session.global_dsn#" >
				SELECT PROCESSID
				  FROM EGINSIGNATURE
				 WHERE PROCESSID = '#trim(processid)#' AND ACTIONREFERENCE = '#trim(actionref)#'
			</cfquery>
			
			<cfif qrySignature.recordcount gt 0 >
				<cfquery name="qrySignature" datasource="#session.global_dsn#" >
					UPDATE EGINSIGNATURE
					   SET BASE64SIGNATURE = <cfqueryparam cfsqltype="cf_sql_varchar" value="#sigData#">
					 WHERE PROCESSID = '#trim(processid)#' AND ACTIONREFERENCE = '#trim(actionref)#'
				</cfquery>
			<cfelse>
				<cfquery name="qrySignature" datasource="#session.global_dsn#" >
					INSERT INTO EGINSIGNATURE (PROCESSID,ACTIONREFERENCE,BASE64SIGNATURE)
					   VALUES (
					   		<cfqueryparam cfsqltype="cf_sql_varchar" value="#processid#">,
					   		<cfqueryparam cfsqltype="cf_sql_varchar" value="#actionref#">,
					   		<cfqueryparam cfsqltype="cf_sql_varchar" value="#sigData#">
					   );
				</cfquery>
			</cfif>
        	
			<cfreturn "true" >        
        <cfcatch type="Any" >
        	<cfreturn cfcatch.message & " _ " & cfcatch.detail >
        </cfcatch>
        </cftry>

	</cffunction>  
	
	
	
	
	<cffunction name="getSignature" ExtDirect="true" >
		<cfargument name="processid" >
		<cfargument name="actionref" >
		<cftry>
			<cfquery name="qrySignature" datasource="#session.global_dsn#" maxrows="1">
				SELECT BASE64SIGNATURE
				  FROM EGINSIGNATURE
				 WHERE PROCESSID = '#trim(processid)#' AND ACTIONREFERENCE = '#trim(actionref)#'
			</cfquery>
			<cfif qrySignature.recordcount gt 0 >
				<cfreturn qrySignature.BASE64SIGNATURE >
			<cfelse>
			    <cfreturn "data:image/png;base64" >
			</cfif>
			        
        <cfcatch type="Any" >
        	<cfreturn cfcatch.message & " _ " & cfcatch.detail >
        </cfcatch>
        </cftry>
	</cffunction>
	
</cfcomponent>