<cfcomponent name="lookup" ExtDirect="true">
	
<cffunction name="getProcessGroup" ExtDirect="true">
<cfargument name="limit" >
<cfargument name="page" >
<cfargument name="query" > 
<cfargument name="start" >
<cftry>

<cfif query NEQ "" >
	<cfset WHERE = "WHERE GROUPNAME LIKE '%#query#%'" >
<cfelse>
	<cfset WHERE = "" >
</cfif>
<cfset processData = ORMExecuteQuery(" SELECT GROUPNAME, count(*) AS TOTAL FROM EGINFORMPROCESS #WHERE# GROUP BY GROUPNAME", false, {offset=#start#, maxResults=#limit#, timeout=60} ) >

<cfset countAll = ORMExecuteQuery("SELECT GROUPNAME, count(*) AS TOTAL FROM EGINFORMPROCESS #WHERE# GROUP BY GROUPNAME" )>
     
	<cfset resultArr = ArrayNew(1) >
    <cfset rootstuct = StructNew() >
	
    <cfset rootstuct['totalCount'] = ArrayLen(countAll) >
	<cfset cnt = 1 >
	  <cfloop array="#processData#" index="calIndex" >
	  	<cfset tmpresult = StructNew() >
		<cfset tmpresult['processgroupcode']  = calIndex[1] >
		<cfset tmpresult['processgroupname']  = calIndex[1] >
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


<cffunction name="getLinkApproversBy" ExtDirect="true">
<cftry>
    <cfset resultArr = ArrayNew(1) >
    <cfset rootstuct = StructNew() >
	
    <cfset rootstuct['totalCount'] = 1 >
	
  	<cfset tmpresult = StructNew() >
	<cfset tmpresult['linkcode']  = 'IS' >
	<cfset tmpresult['linkname']  = 'Immediate Superior' >
	<cfset resultArr[1] = tmpresult    >
	
	<cfset tmpresult = StructNew() >
	<cfset tmpresult['linkcode']  = 'DEPARTMENTCODE' >
	<cfset tmpresult['linkname']  = 'Department Code' >
	<cfset resultArr[2] = tmpresult    >
	
	<cfset tmpresult = StructNew() >
	<cfset tmpresult['linkcode']  = 'BACKTOSENDER' >
	<cfset tmpresult['linkname']  = 'Back to Sender' >
	<cfset resultArr[3] = tmpresult    >
	
	<cfset tmpresult = StructNew() >
	<cfset tmpresult['linkcode']  = 'BACKTOORIGINATOR' >
	<cfset tmpresult['linkname']  = 'Back to Originator' >
	<cfset resultArr[4] = tmpresult    >
	
	<cfset tmpresult = StructNew() >
	<cfset tmpresult['linkcode']  = 'USERROLE' >
	<cfset tmpresult['linkname']  = 'User Role' >
	<cfset resultArr[5] = tmpresult    >
	
	<cfset tmpresult = StructNew() >
	<cfset tmpresult['linkcode']  = 'SPECIFICNAME' >
	<cfset tmpresult['linkname']  = 'Specific Name' >
	<cfset resultArr[6] = tmpresult    >
	
	<cfset rootstuct['topics'] = resultArr > 
			
<cfreturn rootstuct />
<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message >
</cfcatch>
</cftry>
</cffunction> 

<cffunction name="getConditions" ExtDirect="true">
<cftry>
    <cfset resultArr = ArrayNew(1) >
    <cfset rootstuct = StructNew() >
	
    <cfset rootstuct['totalCount'] = 1 >
	
  	<cfset tmpresult = StructNew() >
	<cfset tmpresult['conditioncode']  = 'AND' >
	<cfset tmpresult['conditionname']  = 'AND' >
	<cfset resultArr[1] = tmpresult    >
	
	<cfset tmpresult = StructNew() >
	<cfset tmpresult['conditioncode']  = 'OR' >
	<cfset tmpresult['conditionname']  = 'OR' >
	<cfset resultArr[2] = tmpresult    >
	
	<cfset rootstuct['topics'] = resultArr > 
			
<cfreturn rootstuct />
<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message >
</cfcatch>
</cftry>
</cffunction>

<cffunction name="getActionWExpired" ExtDirect="true">
<cftry>
     

	<cfset resultArr = ArrayNew(1) >
    <cfset rootstuct = StructNew() >
	
    <cfset rootstuct['totalCount'] = 1 >
	
  	<cfset tmpresult = StructNew() >
	<cfset tmpresult['actioncode']  = 'APPROVE' >
	<cfset tmpresult['actionname']  = 'APPROVE' >
	<cfset resultArr[1] = tmpresult    >
	
	<cfset tmpresult = StructNew() >
	<cfset tmpresult['actioncode']  = 'DISAPPROVE' >
	<cfset tmpresult['actionname']  = 'DISAPPROVE' >
	<cfset resultArr[2] = tmpresult    >
	
	<cfset rootstuct['topics'] = resultArr > 
			
<cfreturn rootstuct />
<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message >
</cfcatch>
</cftry>
</cffunction>


<cffunction name="getName" ExtDirect="true">
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
	
<cfquery name="qryLookup" datasource="FBC_CBOSE">
 SELECT PERSONNELIDNO, 
		FIRSTNAME, 
		LASTNAME
   FROM CMFPA
    <cfif query NEQ "" >
	 	WHERE LASTNAME LIKE '%#query#%' OR FIRSTNAME LIKE '%#query#%'
	</cfif>
		ORDER BY FIRSTNAME ASC
	<cfif Ucase(client.DBMS) EQ 'MYSQL'>
	 	LIMIT #start#, #limit#
	<cfelseif Ucase(client.DBMS) EQ 'MSSQL'>
	    OFFSET #start# ROWS
	    FETCH NEXT #limit# ROWS ONLY 
	</cfif>;  
</cfquery>

<cfquery name="qryCount" datasource="FBC_CBOSE">
 SELECT PERSONNELIDNO
   FROM CMFPA
    <cfif query NEQ "" >
	 	WHERE LASTNAME LIKE '%#query#%' OR FIRSTNAME LIKE '%#query#%'
	</cfif>
	;  
</cfquery>

<cfset totalcnt = qryCount.recordcount > 
<cfset resultArr = ArrayNew(1) >
<cfset rootstuct = StructNew() >

<cfset rootstuct['totalCount'] = totalcnt >
<cfset rootstuct['success']    = "true" >
<cfset cnt = 1 >
<cfloop query = "qryLookup" >
	<cfset tmpresult = StructNew() >
<cfset tmpresult['namecode']  = PERSONNELIDNO >
<cfset tmpresult['namename']  = FIRSTNAME & ' ' & LASTNAME & ' (' & PERSONNELIDNO & ')' > 
<cfset resultArr[cnt] = tmpresult    >
<cfset cnt = cnt + 1 >
</cfloop>  
<cfset rootstuct['topics'] = resultArr > 

<cfreturn rootstuct />

<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message >
</cfcatch>
</cftry>
</cffunction> 
	
</cfcomponent>