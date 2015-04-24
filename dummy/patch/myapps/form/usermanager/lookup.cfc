<cfcomponent name="lookup" ExtDirect="true">
	

<cffunction name="getUser" ExtDirect="true">
<cfargument name="limit" >
<cfargument name="page" >
<cfargument name="query" > 
<cfargument name="start" >
<cftry>

<cfif query NEQ "" >
	<cfset WHERE = "WHERE FIRSTNAME LIKE '%#query#%' OR LASTNAME LIKE '%#query#%'" >
<cfelse>
	<cfset WHERE = "" >
</cfif>

<cfquery name="qryUser" datasource="#client.company_dsn#" >
	SELECT PERSONNELIDNO, FIRSTNAME, LASTNAME, MIDDLENAME
	  FROM CMFPA
	  #preservesinglequotes(WHERE)#
</cfquery>
	     
	<cfset resultArr = ArrayNew(1) >
    <cfset rootstuct = StructNew() >
	
    <cfset rootstuct['totalCount'] = qryUser.recordcount >
		<cfif start lt 1 >
			<cfset start = 1>
		</cfif>
	  <cfloop query="qryUser" startrow="#start#" endrow="#start + limit#">
	  	<cfset tmpresult = StructNew() >
		<cfset tmpresult['usercode']  = PERSONNELIDNO >
		<cfset tmpresult['username']  = FIRSTNAME & ' ' & MIDDLENAME & ' ' & LASTNAME >  
		<cfset ArrayAppend(resultArr, tmpresult)    >
	  </cfloop>
	<cfset rootstuct['topics'] = resultArr > 
			
<cfreturn rootstuct />
<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message  >
</cfcatch>
</cftry>
</cffunction>
	

</cfcomponent>