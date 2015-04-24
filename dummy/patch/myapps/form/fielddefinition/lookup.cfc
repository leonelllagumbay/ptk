<cfcomponent name="lookup" ExtDirect="true">
	
<cffunction name="getMainGroup" ExtDirect="true">
<cfargument name="limit" >
<cfargument name="page" >
<cfargument name="query" > 
<cfargument name="start" >
<cftry>

<cfif query NEQ "" >
	<cfset WHERE = "WHERE EFORMGROUP LIKE '%#query#%'" >
<cfelse>
	<cfset WHERE = "" >
</cfif>
<cfset processData = ORMExecuteQuery(" SELECT EFORMGROUP, count(*) AS TOTAL FROM EGRGEFORMS #WHERE# GROUP BY EFORMGROUP", false, {offset=#start#, maxResults=#limit#, timeout=60} ) >

<cfset countAll = ORMExecuteQuery("SELECT EFORMGROUP, count(*) AS TOTAL FROM EGRGEFORMS #WHERE# GROUP BY EFORMGROUP" )>	 
    
	<cfset resultArr = ArrayNew(1) >
    <cfset rootstuct = StructNew() >
	
    <cfset rootstuct['totalCount'] = ArrayLen(countAll) >
	<cfset cnt = 1 >
	  <cfloop array="#processData#" index="calIndex" >
	  	<cfset tmpresult = StructNew() >
		<cfset tmpresult['maingroupcode']  = calIndex[1] >
		<cfset tmpresult['maingroupname']  = calIndex[1] >
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





<cffunction name="getColumnGroup" ExtDirect="true">
<cfargument name="limit" >
<cfargument name="page" >
<cfargument name="query" > 
<cfargument name="start" >
<cftry>

<cfif query NEQ "" >
	<cfset WHERE = "WHERE COLUMNGROUP LIKE '%#query#%'" >
<cfelse>
	<cfset WHERE = "" >
</cfif>
<cfset processData = ORMExecuteQuery(" SELECT COLUMNGROUP, count(*) AS TOTAL FROM EGRGIBOSETABLEFIELDS #WHERE# GROUP BY COLUMNGROUP", false, {offset=#start#, maxResults=#limit#, timeout=60} ) >

<cfset countAll = ORMExecuteQuery("SELECT COLUMNGROUP, count(*) AS TOTAL FROM EGRGIBOSETABLEFIELDS #WHERE# GROUP BY COLUMNGROUP" )>	 
    
	<cfset resultArr = ArrayNew(1) >
    <cfset rootstuct = StructNew() >
	
    <cfset rootstuct['totalCount'] = ArrayLen(countAll) >
	<cfset cnt = 1 >
	  <cfloop array="#processData#" index="calIndex" >
	  	<cfset tmpresult = StructNew() >
		<cfset tmpresult['columngroupcode']  = calIndex[1] >
		<cfset tmpresult['columngroupname']  = calIndex[1] >
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



<cffunction name="getProcess" ExtDirect="true">
<cfargument name="limit" >
<cfargument name="page" >
<cfargument name="query" > 
<cfargument name="start" >
<cftry>

<cfif query NEQ "" >
	<cfset WHERE = "WHERE PROCESSNAME LIKE '%#query#%'" >
<cfelse>
	<cfset WHERE = "" >
</cfif>
<cfset processData = ORMExecuteQuery(" SELECT PROCESSNAME, PROCESSID FROM EGINFORMPROCESS #WHERE#", false, {offset=#start#, maxResults=#limit#, timeout=60} ) >

<cfset countAll = ORMExecuteQuery("SELECT PROCESSNAME FROM EGINFORMPROCESS #WHERE#" )>

	     
	<cfset resultArr = ArrayNew(1) >
    <cfset rootstuct = StructNew() >
	
    <cfset rootstuct['totalCount'] = ArrayLen(countAll) >
	<cfset cnt = 1 >
	  <cfloop array="#processData#" index="calIndex" >
	  	<cfset tmpresult = StructNew() >
		<cfset tmpresult['mainprocesscode']  = calIndex[2] >
		<cfset tmpresult['mainprocessname']  = calIndex[1] >  
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

	


<cffunction name="geteFormName" ExtDirect="true">
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
	<cfset cnt = 1 >
	  <cfloop array="#processData#" index="calIndex" >
	  	<cfset tmpresult = StructNew() >
		<cfset tmpresult['eformnamecode']  = calIndex.getEFORMID() >
		<cfset tmpresult['eformnamename']  = calIndex.getEFORMNAME() > 
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

	
<cffunction name="getbeforeload" ExtDirect="true">
<cfargument name="limit" >
<cfargument name="page" >
<cfargument name="query" > 
<cfargument name="start" >
<cftry> 
	
<cfdirectory 
	directory = "#expandpath('./beforeload')#" 
	action    = "list"
	filter    = "*#query#*"
	type      = "file"	
	name      = "theonfile"
	sort      = "NAME ASC"
>
	<cfset resultArr = ArrayNew(1) >
    <cfset rootstuct = StructNew() >
	
    <cfset rootstuct['totalCount'] = theonfile.RecordCount >
	
	  <cfif start LT 1 >
	  	  <cfset start = 1 >
	  </cfif>
	  
	   <cfset tmpresult = StructNew() >
	   <cfset tmpresult['filecode']  = 'NA' >
	   <cfset tmpresult['filename']  = 'None' >
	   <cfset resultArr[1] = tmpresult    >
	      
	  <cfset cnt = 2 >
	  
	  <cfloop query="theonfile" startrow="#start#" endrow="#start + limit#">
	  	<cfset tmpresult = StructNew() >
		<cfset tmpresult['filecode']  = NAME >
		<cfset tmpresult['filename']  = NAME > 
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



<cffunction name="getafterload" ExtDirect="true">
<cfargument name="limit" >
<cfargument name="page" >
<cfargument name="query" > 
<cfargument name="start" >
<cftry> 
	
<cfdirectory 
	directory = "#expandpath('./afterload')#" 
	action    = "list"
	filter    = "*#query#*"
	type      = "file"	
	name      = "theonfile"
	sort      = "NAME ASC"
>
	<cfset resultArr = ArrayNew(1) >
    <cfset rootstuct = StructNew() >
	
    <cfset rootstuct['totalCount'] = theonfile.RecordCount >
	
	  <cfif start LT 1 >
	  	  <cfset start = 1 >
	  </cfif>
	  
	   <cfset tmpresult = StructNew() >
	   <cfset tmpresult['filecode']  = 'NA' >
	   <cfset tmpresult['filename']  = 'None' >
	   <cfset resultArr[1] = tmpresult    >
	      
	  <cfset cnt = 2 >
	  
	  <cfloop query="theonfile" startrow="#start#" endrow="#start + limit#">
	  	<cfset tmpresult = StructNew() >
		<cfset tmpresult['filecode']  = NAME >
		<cfset tmpresult['filename']  = NAME > 
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




<cffunction name="getbeforesubmit" ExtDirect="true">
<cfargument name="limit" >
<cfargument name="page" >
<cfargument name="query" > 
<cfargument name="start" >
<cftry> 
	
<cfdirectory 
	directory = "#expandpath('./beforesubmit')#" 
	action    = "list"
	filter    = "*#query#*"
	type      = "file"	
	name      = "theonfile"
	sort      = "NAME ASC"
>

	<cfset resultArr = ArrayNew(1) >
    <cfset rootstuct = StructNew() >
	
    <cfset rootstuct['totalCount'] = theonfile.RecordCount >
	
	  <cfif start LT 1 >
	  	  <cfset start = 1 >
	  </cfif>
	  
	   <cfset tmpresult = StructNew() >
	   <cfset tmpresult['filecode']  = 'NA' >
	   <cfset tmpresult['filename']  = 'None' >
	   <cfset resultArr[1] = tmpresult    >
	      
	  <cfset cnt = 2 >
	  
	  <cfloop query="theonfile" startrow="#start#" endrow="#start + limit#">
	  	<cfset tmpresult = StructNew() >
		<cfset tmpresult['filecode']  = NAME >
		<cfset tmpresult['filename']  = NAME > 
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




<cffunction name="getaftersubmit" ExtDirect="true">
<cfargument name="limit" >
<cfargument name="page" >
<cfargument name="query" > 
<cfargument name="start" >
<cftry> 
	
<cfdirectory 
	directory = "#expandpath('./aftersubmit')#" 
	action    = "list"
	filter    = "*#query#*"
	type      = "file"	
	name      = "theonfile"
	sort      = "NAME ASC"
>

	<cfset resultArr = ArrayNew(1) >
    <cfset rootstuct = StructNew() >
	
    <cfset rootstuct['totalCount'] = theonfile.RecordCount >
	
	  <cfif start LT 1 >
	  	  <cfset start = 1 >
	  </cfif>
	  
	   <cfset tmpresult = StructNew() >
	   <cfset tmpresult['filecode']  = 'NA' >
	   <cfset tmpresult['filename']  = 'None' >
	   <cfset resultArr[1] = tmpresult    >
	      
	  <cfset cnt = 2 >
	  
	  <cfloop query="theonfile" startrow="#start#" endrow="#start + limit#">
	  	<cfset tmpresult = StructNew() >
		<cfset tmpresult['filecode']  = NAME >
		<cfset tmpresult['filename']  = NAME > 
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





<cffunction name="getbeforeapprove" ExtDirect="true">
<cfargument name="limit" >
<cfargument name="page" >
<cfargument name="query" > 
<cfargument name="start" >
<cftry> 
	
<cfdirectory 
	directory = "#expandpath('./beforeapprove')#" 
	action    = "list"
	filter    = "*#query#*"
	type      = "file"	
	name      = "theonfile"
	sort      = "NAME ASC"
>

	<cfset resultArr = ArrayNew(1) >
    <cfset rootstuct = StructNew() >
	
    <cfset rootstuct['totalCount'] = theonfile.RecordCount >
	
	  <cfif start LT 1 >
	  	  <cfset start = 1 >
	  </cfif>
	  
	   <cfset tmpresult = StructNew() >
	   <cfset tmpresult['filecode']  = 'NA' >
	   <cfset tmpresult['filename']  = 'None' >
	   <cfset resultArr[1] = tmpresult    >
	      
	  <cfset cnt = 2 >
	  
	  <cfloop query="theonfile" startrow="#start#" endrow="#start + limit#">
	  	<cfset tmpresult = StructNew() >
		<cfset tmpresult['filecode']  = NAME >
		<cfset tmpresult['filename']  = NAME > 
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




<cffunction name="getafterapprove" ExtDirect="true">
<cfargument name="limit" >
<cfargument name="page" >
<cfargument name="query" > 
<cfargument name="start" >
<cftry> 
	
<cfdirectory 
	directory = "#expandpath('./afterapprove')#" 
	action    = "list"
	filter    = "*#query#*"
	type      = "file"	
	name      = "theonfile"
	sort      = "NAME ASC"
>

	     
	<cfset resultArr = ArrayNew(1) >
    <cfset rootstuct = StructNew() >
	
    <cfset rootstuct['totalCount'] = theonfile.RecordCount >
	
	  <cfif start LT 1 >
	  	  <cfset start = 1 >
	  </cfif>
	  
	   <cfset tmpresult = StructNew() >
	   <cfset tmpresult['filecode']  = 'NA' >
	   <cfset tmpresult['filename']  = 'None' >
	   <cfset resultArr[1] = tmpresult    >
	      
	  <cfset cnt = 2 >
	  
	  <cfloop query="theonfile" startrow="#start#" endrow="#start + limit#">
	  	<cfset tmpresult = StructNew() >
		<cfset tmpresult['filecode']  = NAME >
		<cfset tmpresult['filename']  = NAME > 
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




<cffunction name="getoncomplete" ExtDirect="true">
<cfargument name="limit" >
<cfargument name="page" >
<cfargument name="query" > 
<cfargument name="start" >
<cftry> 
	
<cfdirectory 
	directory = "#expandpath('./oncomplete')#" 
	action    = "list"
	filter    = "*#query#*"
	type      = "file"	
	name      = "theonfile"
	sort      = "NAME ASC"
>
	     
	<cfset resultArr = ArrayNew(1) >
    <cfset rootstuct = StructNew() >
	
    <cfset rootstuct['totalCount'] = theonfile.RecordCount >
	
	  <cfif start LT 1 >
	  	  <cfset start = 1 >
	  </cfif>
	  
	   <cfset tmpresult = StructNew() >
	   <cfset tmpresult['filecode']  = 'NA' >
	   <cfset tmpresult['filename']  = 'None' >
	   <cfset resultArr[1] = tmpresult    >
	      
	  <cfset cnt = 2 >
	  
	  <cfloop query="theonfile" startrow="#start#" endrow="#start + limit#">
	  	<cfset tmpresult = StructNew() >
		<cfset tmpresult['filecode']  = NAME >
		<cfset tmpresult['filename']  = NAME > 
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