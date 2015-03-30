<cfcomponent name="data" ExtDirect="true">   

<cffunction name="ReadNow" ExtDirect="true"> 
	<cfargument name="page" >
	<cfargument name="start" >
	<cfargument name="limit" >
	<cfargument name="sort" >
	<cfargument name="filter" >
		
 	<cfset where             = "()" >
	 
	 	    <cfset where             = " (" >
            <cfset tmpdatafield      = "" >
            <cfset tmpfilteroperator = "0" >
			
			<cftry>
			<cfset filter = deserializejson(filter) >	<!---Deserialize JSON string coz Router forgets to do the work on filter but not on sort--->
			<cfloop array=#filter# index="filterdata">
            	<cftry>
					<cfset filterdatafield = filterdata.field />
					<cfcatch>
						<cfbreak>
					</cfcatch>
				</cftry>
            
            	<cfset filterdatafield = filterdata.field />
				<cfset filterdatafield = replace(filterdatafield, "_", ".") >
				<cfset filtervalue     = filterdata.value />
				<cfset filtertype      = filterdata.type />
				<cfif tmpdatafield EQ "" >
                <cfset tmpdatafield = filterdatafield >	
                <cfelseif tmpdatafield NEQ filterdatafield >
                	<cfset where = "#where# ) AND ( " >
                <cfelseif tmpdatafield EQ filterdatafield >
                	<cfif tmpfilteroperator EQ 0>
                    	<cfset where = "#where# AND " >
                    <cfelse>
                    	<cfset where = "#where# OR " >
                    </cfif>
				</cfif>
                
                <cfif ucase(filtertype) EQ "STRING" >
					<cfset where = "#where##filterdatafield#  LIKE '%#filtervalue#%'" >
				<cfelseif  ucase(filtertype) EQ "NUMERIC" >
					<cfset filtercondition = filterdata.comparison >
					<cfset expression = "#Ucase(Trim(filtercondition))#" >
               			<cfif expression  EQ "LT">
						   	<cfset where = "#where##filterdatafield#  < #filtervalue#">
						<cfelseif expression EQ "GT"> 	   
							<cfset where = "#where##filterdatafield#  > #filtervalue#">
						<cfelseif expression EQ "EQ"> 	   	
							<cfset where = "#where##filterdatafield#  = #filtervalue#">
						<cfelse>
					</cfif>
				<cfelseif  ucase(filtertype) EQ "DATE" >
					<cfset filtercondition = filterdata.comparison >
					<cfset expression = "#Ucase(Trim(filtercondition))#" >
					
						<cfset filtervalue = CreateODBCDateTime(filtervalue) />
               			<cfif expression  EQ "LT">
	               			<cfset where = "#where##filterdatafield#  < #filtervalue#">
						<cfelseif expression EQ "GT"> 	   
							<cfset where = "#where##filterdatafield#  > #filtervalue#">
						<cfelseif expression EQ "EQ"> 	   	
							<cfset where = "#where##filterdatafield#  = #filtervalue#">
						<cfelse>
							<cfset where = "#where##filterdatafield#  = #filtervalue#">
					    </cfif>
				<cfelse>
					<!---boolean--->
					<cfset where = "#where##filterdatafield#  LIKE '%#filtervalue#%'" >
				</cfif>
                <cfset tmpdatafield      = filterdatafield >
			</cfloop>
            	<cfcatch>
					<!---Do nothing here since filter is not a valid JSON string--->
				</cfcatch>
            </cftry>
            
            <cfset where = "#where#)" >
			<cfset where = Replace(where, "''", "'" , "all") />
			
			<cfif trim(where) NEQ "()">
				<cfset WHERE =  "WHERE #PreserveSingleQuotes(where)#" >
			<cfelse>
				<cfset WHERE = "" >
			</cfif> 
	
	  <!--- Order By Arguments/Contents --->
	  <cfset thecnt = 1 >
	  <cfloop array=#sort# index="sortdata">
	  	  <cfset ORDERBY = "#replace(sortdata.property, '_', '.')# #sortdata.direction#" >
	  	  <cfif thecnt EQ ArrayLen(sort) >
		  <cfelse>
	  	  	<cfset ORDERBY = ORDERBY & ',' >
		  </cfif>
		  <cfset thecnt = thecnt + 1 >
	  </cfloop>
	  <!--- End Order By Arguments/Contents --->



<cfset processData =ORMExecuteQuery("SELECT EFORMID, 
											EFORMNAME, 
											DESCRIPTION,
											EFORMGROUP,
											DATELASTUPDATE
											
										FROM EGRGEFORMS
											#WHERE# 
										ORDER BY #ORDERBY#", false, {offset=#start#, maxResults=#limit#, timeout=60} ) >

<cfset countAll = ORMExecuteQuery("FROM EGRGEFORMS #WHERE#" )> 

	<cfset resultArr = ArrayNew(1) >
	
	<cfset rootstuct = StructNew() >
	<cfset rootstuct['totalCount'] = ArrayLen(countAll) >
	
	<!---query approver details and get an array of process id--->
										   
	<!---Creates an array of structure to be converted to JSON using serializeJSON--->
	<cfloop array="#processData#" index="calIndex" >
		<cfset tmpresult = StructNew() > <!---Creates new structure in every loop to be added to the array--->
		
		<cfset tmpresult['EFORMID']      	= calIndex[1] >
		<cfset tmpresult['EFORMNAME']      	= calIndex[2] >
		<cfset tmpresult['DESCRIPTION']     = calIndex[3] >
		<cfset tmpresult['EFORMGROUP']      = calIndex[4] >
		<cfset tmpresult['DATELASTUPDATE']  = calIndex[5] >
		<cfset ArrayAppend(resultArr, tmpresult) >
		
	</cfloop>
	<cfset rootstuct['topics'] = resultArr > 
	<cfreturn rootstuct />	 
</cffunction>




<cffunction name="ReadNowUser" ExtDirect="true"> 
	<cfargument name="page" >
	<cfargument name="start" >
	<cfargument name="limit" >
	<cfargument name="sort" >
	<cfargument name="filter" >
	<cfargument name="eformid" >   
		
 	<cfset where             = "()" >
	 
	 	    <cfset where             = " (" >
            <cfset tmpdatafield      = "" >
            <cfset tmpfilteroperator = "0" >
			
			<cftry>
			<cfset filter = deserializejson(filter) >	<!---Deserialize JSON string coz Router forgets to do the work on filter but not on sort--->
			<cfloop array=#filter# index="filterdata">
            	<cftry>
					<cfset filterdatafield = filterdata.field />
					<cfcatch>
						<cfbreak>   
					</cfcatch>
				</cftry>
            
            	<cfset filterdatafield = filterdata.field />
				<cfset filterdatafield = replace(filterdatafield, "_", ".") >
				<cfset filtervalue     = filterdata.value />
				<cfset filtertype      = filterdata.type />
				<cfif tmpdatafield EQ "" >
                <cfset tmpdatafield = filterdatafield >	
                <cfelseif tmpdatafield NEQ filterdatafield >
                	<cfset where = "#where# ) AND ( " >
                <cfelseif tmpdatafield EQ filterdatafield >
                	<cfif tmpfilteroperator EQ 0>
                    	<cfset where = "#where# AND " >
                    <cfelse>
                    	<cfset where = "#where# OR " >    
                    </cfif>
				</cfif>
                
                <cfif ucase(filtertype) EQ "STRING" >
					<cfset where = "#where##filterdatafield#  LIKE '%#filtervalue#%'" >   
				<cfelseif  ucase(filtertype) EQ "NUMERIC" >
					<cfset filtercondition = filterdata.comparison >
					<cfset expression = "#Ucase(Trim(filtercondition))#" >
               			<cfif expression  EQ "LT">
						   	<cfset where = "#where##filterdatafield#  < #filtervalue#">
						<cfelseif expression EQ "GT"> 	   
							<cfset where = "#where##filterdatafield#  > #filtervalue#">
						<cfelseif expression EQ "EQ"> 	   	
							<cfset where = "#where##filterdatafield#  = #filtervalue#">
						<cfelse>
					</cfif>
				<cfelseif  ucase(filtertype) EQ "DATE" >
					<cfset filtercondition = filterdata.comparison >
					<cfset expression = "#Ucase(Trim(filtercondition))#" >
					
						<cfset filtervalue = CreateODBCDateTime(filtervalue) />
               			<cfif expression  EQ "LT">
	               			<cfset where = "#where##filterdatafield#  < #filtervalue#">
						<cfelseif expression EQ "GT"> 	   
							<cfset where = "#where##filterdatafield#  > #filtervalue#">
						<cfelseif expression EQ "EQ"> 	   	
							<cfset where = "#where##filterdatafield#  = #filtervalue#">
						<cfelse>
							<cfset where = "#where##filterdatafield#  = #filtervalue#">
					    </cfif>
				<cfelse>
					<!---boolean--->
					<cfset where = "#where##filterdatafield#  LIKE '%#filtervalue#%'" >
				</cfif>
                <cfset tmpdatafield      = filterdatafield >
			</cfloop>
            	<cfcatch>
					<!---Do nothing here since filter is not a valid JSON string--->
				</cfcatch>
            </cftry>
            
            <cfset where = "#where#)" >
			<cfset where = Replace(where, "''", "'" , "all") />
			
			<cfif trim(where) NEQ "()">
				<cfset WHERE =  "AND #PreserveSingleQuotes(where)#" >
			<cfelse>
				<cfset WHERE = "" >
			</cfif> 
	
	  <!--- Order By Arguments/Contents --->
	  <cfset thecnt = 1 >
	  <cfloop array=#sort# index="sortdata">
	  	  <cfset ORDERBY = "#replace(sortdata.property, '_', '.')# #sortdata.direction#" >
	  	  <cfif thecnt EQ ArrayLen(sort) >
		  <cfelse>
	  	  	<cfset ORDERBY = ORDERBY & ',' >
		  </cfif>
		  <cfset thecnt = thecnt + 1 >
	  </cfloop>
	  <!--- End Order By Arguments/Contents --->


 <cfset  processData  =ORMExecuteQuery("SELECT PERSONNELIDNO
   FROM EGRTEFORMS 
  WHERE EFORMID = '#eformid#'", false  ) >									   
<cfset resultArr = ArrayNew(1) >
<cfset rootstuct = StructNew() >
<cftry>
	<cfset countAll = ORMExecuteQuery("FROM EGRTEFORMS WHERE EFORMID = '#eformid#'")> 
<cfcatch>
</cfcatch>
</cftry>

<cfif isdefined('countAll') >
	<cfset rootstuct['totalCount'] = ArrayLen(countAll) > 
<cfelse>
    <cfset rootstuct['totalCount'] = 0 > 
</cfif>

<cfquery name="qryDetails" datasource="#session.company_dsn#" >
    SELECT FIRSTNAME, MIDDLENAME, LASTNAME, PERSONNELIDNO
      FROM #session.maintable#
     WHERE PERSONNELIDNO IN ('#ArrayToList(processData, "','")#') #PreserveSingleQuotes(WHERE)# 
  ORDER BY #ORDERBY#
   <cfif  Ucase(session.DBMS) EQ  'MYSQL'>
LIMIT #start#, #limit#
  <cfelseif  Ucase(session.DBMS) EQ  'MSSQL'>
     OFFSET #start# ROWS
     FETCH NEXT #limit# ROWS ONLY
  <cfelse>
  LIMIT #start#, #limit#
  </cfif>
</cfquery>
 <cfquery  name="qryDetailsCount"  datasource="#session.company_dsn#"  >
    SELECT FIRSTNAME
      FROM #session.maintable#
     WHERE PERSONNELIDNO IN ('#ArrayToList(processData, "','")#') #WHERE# 
</cfquery>

<cfset  rootstuct['totalCount'] = qryDetailsCount.recordcount  >
	
	<!---query approver details and get an array of process id--->
										   
	<!---Creates an array of structure to be converted to JSON using serializeJSON--->
	<cfloop query="qryDetails" >
		<cfset tmpresult = StructNew() > <!---Creates new structure in every loop to be added to the array--->
		
		<cfset tmpresult['PERSONNELIDNO']   = PERSONNELIDNO >
		<cfset tmpresult['FIRSTNAME']      	= FIRSTNAME >
		<cfset tmpresult['MIDDLENAME']      = MIDDLENAME >
		<cfset tmpresult['LASTNAME']        = LASTNAME > 
		
		<cfset ArrayAppend(resultArr, tmpresult) >
		
	</cfloop>
	
	
	<cfset rootstuct['topics'] = resultArr > 
	<cfreturn rootstuct />	 
</cffunction>



<cffunction name="grantAccesseForm" ExtDirect="true" >
<cfargument name="eformid" >
<cfargument name="thepid" >
<cfargument name="theRole" >

<cftry>
	<cfif trim(theRole) eq "" > <!---the individual user is used--->
	<cfquery name="grant" datasource="#session.global_dsn#" >
    	INSERT INTO EGRTEFORMS (EFORMID, PERSONNELIDNO)
            VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#eformid#" >,
            		<cfqueryparam cfsqltype="cf_sql_varchar" value="#thepid#" >
                    );
    </cfquery>
	
	<cfelse> <!--- the user role is used instead --->
		
		<cfquery name="getRoleFromGroup" datasource="#session.global_dsn#"> 
			SELECT A.USERGRPMEMBERSIDX, B.USERID, B.GUID AS GUID  
			  FROM EGRGROLEINDEX A LEFT JOIN EGRGUSERMASTER B ON (A.USERGRPMEMBERSIDX = B.USERID)
			 WHERE USERGRPIDFK = '#theRole#'
		</cfquery>
		<cfif getRoleFromGroup.recordcount GT 0 >
			<cfloop query="getRoleFromGroup" >
				<cfquery name="getPIDfromMainTable" datasource="#session.company_dsn#" maxrows="1"> 
					SELECT #session.mainpk# AS PID 
					  FROM #session.maintable# 
					 WHERE GUID = '#getRoleFromGroup.GUID#' 
				</cfquery> 
				<cfif getPIDfromMainTable.recordcount GT 0 >
					<cftry>
						<cfquery name="grant" datasource="#session.global_dsn#" >
					    	INSERT INTO EGRTEFORMS (EFORMID, PERSONNELIDNO)
					            VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#eformid#" >,
					            		<cfqueryparam cfsqltype="cf_sql_varchar" value="#getPIDfromMainTable.PID#" >
					                    );
					    </cfquery>
				    <cfcatch>
						<cfcontinue>
					</cfcatch>
					</cftry>
				<cfelse>
				</cfif> <!---end getPIDfromMainTable--->
			</cfloop> <!---end getRoleFromGroup--->
		<cfelse> 
		</cfif> <!---end getRoleFromGroup--->  

		
	</cfif>  
	  
	<cfreturn "success" >  
	
<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message >
</cfcatch>
</cftry>	  
</cffunction>




<cffunction name="revokeAccesseForm" ExtDirect="true" >  
<cfargument name="eformid" >
<cfargument name="thepid" >
<cftry>
	<cfset theRights = EntityLoad("EGRTEFORMS", {EFORMID=#eformid#,PERSONNELIDNO=#thepid#}, true ) >
	<cfset EntityDelete(theRights) >
	<cfset ormflush() >
	<cfreturn "success" >
<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message >
</cfcatch>
</cftry>	
</cffunction>


<cffunction name="getThemes" ExtDirect="true" hint="This is used to load the company or user theme">   
<cftry>

<cfset retArr = ArrayNew(1) >

<cfset retArr[1] = '<img src="' & session.root_undb & 'images/' & lcase(session.companycode) & '/' & session.site_bannerlogo & '" width="290" height="60">' >

<cfreturn retArr >
<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message >
</cfcatch>			
</cftry>
</cffunction>


	
</cfcomponent>