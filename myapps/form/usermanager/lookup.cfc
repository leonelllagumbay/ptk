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

<cfquery name="qryUser" datasource="#session.company_dsn#" >
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


<cffunction name="getRole" ExtDirect="true">  
<cfargument name="inputargs" >

<cftry>
	
<cfset page = inputargs.page />
<cfset limit= inputargs.limit />
<cfset start= inputargs.start />
<cfif isdefined("inputargs.query") >
<cfset query= inputargs.query />
<cfelse>
<cfset query= "" /> 
</cfif>

<cfif query NEQ "" >
	<cfset WHERE = "WHERE DESCRIPTION LIKE '%#query#%'" >
<cfelse>
	<cfset WHERE = "" >
</cfif>
<cfset processData = ORMExecuteQuery(" SELECT USERGRPID, DESCRIPTION, count(*) AS TOTAL FROM EGRGUSERGROUPS #WHERE# GROUP BY USERGRPID, DESCRIPTION", false, {offset=#start#, maxResults=#limit#, timeout=60} ) >

<cfset countAll = ORMExecuteQuery("SELECT USERGRPID, count(*) AS TOTAL FROM EGRGUSERGROUPS #WHERE# GROUP BY USERGRPID" )>
     
	<cfset resultArr = ArrayNew(1) >
    <cfset rootstuct = StructNew() >
	
    <cfset rootstuct['totalCount'] = ArrayLen(countAll) >
	<cfset cnt = 1 >
	  <cfloop array="#processData#" index="calIndex" >
	  	<cfset tmpresult = StructNew() >
		<cfset tmpresult['rolecode']  = calIndex[1] >
		<cfset tmpresult['rolename']  = calIndex[2] >
		<cfset resultArr[cnt] = tmpresult    >
		<cfset cnt = cnt + 1 >
	  </cfloop>
	<cfset rootstuct['topics'] = resultArr >  
			
<cfreturn rootstuct />
<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message  >
</cfcatch>
</cftry>
</cffunction>
	

</cfcomponent>