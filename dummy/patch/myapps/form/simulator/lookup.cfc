<cfcomponent name="lookup" ExtDirect="true">
	

<cffunction name="getComment" ExtDirect="true">
<cfargument name="limit" >
<cfargument name="page" >
<cfargument name="query" > 
<cfargument name="start" >
<cfargument name="personnelidno" >
<cfargument name="processid" >
<cftry>
	
	<cfset resultArr = ArrayNew(1) >
    <cfset rootstuct = StructNew() >
	
	<cfset formProcessData = EntityLoad("EGINFORMPROCESSDETAILS", #processid#) >
	<cfloop array="#formProcessData#" index="processIndex" >
		<cfset formRouterData = EntityLoad("EGINROUTERDETAILS", {PROCESSIDFK = #processIndex.getPROCESSDETAILSID()#}, "ROUTERORDER ASC") >
		<cfloop array="#formRouterData#" index="routerIndex" >
			<cfset formApproversData = EntityLoad("EGINAPPROVERDETAILS", {ROUTERIDFK =#routerIndex.getROUTERDETAILSID()#}, "APPROVERORDER ASC" ) >
				<cfloop array="#formApproversData#" index="approverIndex" > 
					<cfif trim(approverIndex.getCOMMENTS()) neq "" >
						<cfquery name="getPersonal" datasource="#client.company_dsn#" maxrows="1" >
							SELECT FIRSTNAME,
								   LASTNAME, 
								   MIDDLENAME
							  FROM CMFPA
							 WHERE PERSONNELIDNO = '#approverIndex.getPERSONNELIDNO()#'
						</cfquery>
						<cfset tmpresult = StructNew() >
						<cfset tmpresult['name']  = getPersonal.LASTNAME & ', ' & getPersonal.FIRSTNAME & ' ' & getPersonal.MIDDLENAME >  
						<cfset tmpresult['dateaction']  = dateformat(approverIndex.getDATEACTIONWASDONE(), "MM/DD/YYYY") & ' ' & timeformat(approverIndex.getDATEACTIONWASDONE(), "short") > 
						<cfset tmpresult['comments']  = approverIndex.getCOMMENTS() >
						<cfset tmpresult['action']  = approverIndex.getACTION() >
						<cfset ArrayAppend(resultArr, tmpresult)    >
					<cfelse>
					</cfif>
				</cfloop>
		</cfloop>
	</cfloop>
	
	<cfset getTotalprocessID = ORMExecuteQuery("SELECT count(*) AS TOTPROCESSID
	  								      FROM EGINFORMPROCESSDETAILS A,EGINROUTERDETAILS B,EGINAPPROVERDETAILS C
	 								      WHERE A.PROCESSDETAILSID = B.PROCESSIDFK 
	 								      		AND B.ROUTERDETAILSID = C.ROUTERIDFK
	 								      		AND A.PROCESSDETAILSID = '#processid#'", true) >
	
    <cfset rootstuct['totalCount'] = getTotalprocessID >
	<cfset rootstuct['topics'] = resultArr > 
			
<cfreturn rootstuct />
<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message  >
</cfcatch>
</cftry>
</cffunction> 

<cffunction name="getMaineForm" ExtDirect="true">
<cfargument name="limit" >
<cfargument name="page" >
<cfargument name="query" > 
<cfargument name="start" >
<cftry>

<cfif query NEQ "" >
	<cfset WHERE = "WHERE EFORMNAME LIKE '%#query#%'" >
<cfelse>
	<cfset WHERE = "" >
</cfif>
<cfset processData = ORMExecuteQuery("FROM EGRGEFORMS #WHERE#", false, {offset=#start#, maxResults=#limit#, timeout=60} ) >

<cfset countAll = ORMExecuteQuery("FROM EGRGEFORMS #WHERE#" )>

	     
	<cfset resultArr = ArrayNew(1) >
    <cfset rootstuct = StructNew() >
	
    <cfset rootstuct['totalCount'] = ArrayLen(countAll) >
	  <cfloop array="#processData#" index="calIndex" >
	  	<cfset tmpresult = StructNew() >
		<cfset tmpresult['eformmaincode']  = calIndex.getEFORMID() >
		<cfset tmpresult['eformmainname']  = calIndex.getEFORMNAME() > 
		<cfset tmpresult['eformmaintotalnew']  = len(calIndex.getEFORMNAME()) > 
		<cfset tmpresult['eformmaintotalpending']  = len(calIndex.getEFORMNAME()) >  
		<cfset ArrayAppend(resultArr, tmpresult)    >
	  </cfloop>
	<cfset rootstuct['topics'] = resultArr > 
			
<cfreturn rootstuct />
<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message  >
</cfcatch>
</cftry>
</cffunction>   


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
	SELECT PERSONNELIDNO, FIRSTNAME, LASTNAME
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
		<cfset tmpresult['username']  = FIRSTNAME & ' ' & LASTNAME >  
		<cfset ArrayAppend(resultArr, tmpresult)    >
	  </cfloop>
	<cfset rootstuct['topics'] = resultArr > 
			
<cfreturn rootstuct />
<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message  >
</cfcatch>
</cftry>
</cffunction>
	



<cffunction name="formQueryLookup" ExtDirect="true">
<cfargument name="limit" >
<cfargument name="page" >
<cfargument name="query" > 
<cfargument name="start" >
<cfargument name="tablename" >
<cfargument name="columnDisplay" >
<cfargument name="columnValue" >
<cfargument name="columnDepends" >
<cfargument name="columnDependValues" >
<cftry>
	
 
<cfif trim(columnDepends) neq "" >
	<cfset condArr = ArrayNew(1) >
	<cfloop from="1" to="#ListLen(columnDepends)#" index="counterA">
		<cftry>
			<cfset conditionhere = "#listgetat(columnDepends, counterA)# = '#listgetat(columnDependValues, counterA)#'" >
			<cfset arrayappend(condArr, conditionhere) >
		<cfcatch> <!---columnDependValues may be empty and listgetat will throw an error. This is used because of the 2 lists--->
			<cfset conditionhere = "#listgetat(columnDepends, counterA)# = ''" >
			<cfset arrayappend(condArr, conditionhere) >
		</cfcatch>
		</cftry>
	</cfloop>
	<cfset conditionhere = arraytolist(condArr, " AND ") >
	<cfset conditionhere = "WHERE " & conditionhere >
<cfelse>
	<cfset conditionhere = "" >
</cfif>



<cfif query NEQ "" >
	<cfset queryArr = ArrayNew(1) >
	<cfloop from="1" to="#ListLen(columnDisplay)#" index="counterB">
		<cfset queryhere = "#listgetat(columnDisplay, counterB)# LIKE '%#query#%'" >
		<cfset arrayappend(queryArr, queryhere) >
	</cfloop>
	<cfset extraQuery = arraytolist(queryArr, ' OR ') >
	<cfif trim(columnDepends) eq "" >
		<cfset extraQuery = "WHERE " & extraQuery  >
	<cfelse>
		<cfset extraQuery = "AND (" & extraQuery & ")" > 
	</cfif>
<cfelse>
	<cfset extraQuery = "" > 
</cfif>


<cfset dispArr = ArrayNew(1) >
<cfloop from="1" to="#ListLen(columnDisplay)#" index="counterC">
	<cfset outputLabels = "##qryDynamic.#listgetat(columnDisplay, counterC)###" > 
	<cfset arrayappend(dispArr, outputLabels) >
</cfloop>
<cfset outputLabels = arraytolist(dispArr, " | ") >
<cfset outputLabels = """#outputLabels#""" > 



<cfset tableList = ORMExecuteQuery("SELECT TABLENAME, LEVELID, TABLETYPE
										FROM EGRGIBOSETABLE 
									   WHERE TABLENAME = '#tablename#'") >

<cfset thecolumnValue = ", #columnValue#" >

<cfif ArrayLen(tableList) gt 0 > 
	<cfloop array="#tableList#" index="theTableInd" >
		<cfset thetablelevel = theTableInd[2] >
	</cfloop>
	
	
	<cfif thetablelevel eq 'G' >
		<cfquery name="qryDynamic" datasource="#client.global_dsn#" >
			SELECT #columnDisplay##thecolumnValue#
			  FROM #tablename#
			 #preservesinglequotes(conditionhere)# #preservesinglequotes(extraQuery)#
		</cfquery>
		
	<cfelseif thetablelevel eq 'C' >
		<cfquery name="qryDynamic" datasource="#client.company_dsn#" >
			SELECT #columnDisplay##thecolumnValue#
			  FROM #tablename#
			 		#preservesinglequotes(conditionhere)# #preservesinglequotes(extraQuery)#
		</cfquery>
		
	<cfelseif thetablelevel eq 'S' >
		<cfquery name="qryDynamic" datasource="#client.subco_dsn#" >
			SELECT #columnDisplay##thecolumnValue#
			  FROM #tablename#
			 		#preservesinglequotes(conditionhere)# #preservesinglequotes(extraQuery)#
		</cfquery>
	<cfelse>
		<cfquery name="qryDynamic" datasource="#theTableInd[3]#" >
			SELECT #columnDisplay##thecolumnValue#
			  FROM #tablename#
					#preservesinglequotes(conditionhere)# #preservesinglequotes(extraQuery)#
		</cfquery>
		
	</cfif>
	
<cfelse> <!---assume the table is global--->
	<cfquery name="qryDynamic" datasource="#client.global_dsn#" >
		SELECT #columnDisplay##thecolumnValue#
		  FROM #tablename#
		 		#preservesinglequotes(conditionhere)# #preservesinglequotes(extraQuery)#
	</cfquery>
</cfif>
									 
 
	<cfset resultArr = ArrayNew(1) >
    <cfset rootstuct = StructNew() >
	
    <cfset rootstuct['totalCount'] = qryDynamic.recordcount >
		<cfset thecode = "qryDynamic.#columnValue#" >
	   
		  <cfif start lt 1 >
		  	  <cfset start = 1 >
		  </cfif>
	   
		  <cfloop query="qryDynamic" startrow="#start#" endrow="#start + limit#">
		  	<cfset tmpresult = StructNew() >
			
			<cfset tmpresult['codename']  = evaluate(thecode) >
			<cfset tmpresult['displayname']  = evaluate(outputLabels) > 
			<cfset   arrayappend(resultArr,tmpresult)  > 
		  </cfloop>
	<cfset rootstuct['topics'] = resultArr > 
			
<cfreturn rootstuct />  
<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message  >
</cfcatch>
</cftry>
</cffunction>  


</cfcomponent>