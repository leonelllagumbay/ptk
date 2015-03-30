<cfcomponent name="data" ExtDirect="true">
	
<cffunction name="readsettings" ExtDirect="true">
					
	<cfargument name="page" >
	<cfargument name="start" >
	<cfargument name="limit" >
	<cfargument name="sort" >
	<cfargument name="filter" >
	<cfargument name="departmentcode" >

	  <cfquery name="qryemailtpl" datasource="#session.company_dsn#">
	    SELECT NAME, BODYTPL, SUBJECTTPL
	      FROM ECLKEMAILTEMPLATE
	      
	 <cfset where             = "()" >
	 <cfif isdefined('query')>
	   WHERE NAME LIKE '%#query#%'
	 <cfelse>
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
					<cfif filtervalue EQ 'true' >
						<cfset filtervalue = 'Yes' >
					<cfelse>
						<cfset filtervalue = 'No' >
					</cfif>
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
				WHERE #PreserveSingleQuotes(where)# 
			<cfelse>
				
			</cfif> 
			
     </cfif>
	      
	  ORDER BY 
	  <!--- Order By Arguments/Contents --->
	  <cfset thecnt = 1 >
	  <cfloop array=#sort# index="sortdata">
	  	  #replace(sortdata.property, "_", ".")# #sortdata.direction#
	  	  <cfif thecnt EQ ArrayLen(sort) >
		  <cfelse>
	  	  	,
		  </cfif>
		  <cfset thecnt = thecnt + 1 >
	  </cfloop>
	  <!--- End Order By Arguments/Contents --->
	  	
	  <cfif Ucase(session.DBMS) EQ 'MYSQL'>
     	LIMIT #start#, #limit#
      <cfelseif Ucase(session.DBMS) EQ 'MSSQL'>
         OFFSET #start# ROWS
         FETCH NEXT #limit# ROWS ONLY
      </cfif>
	  
	  </cfquery>

<cfquery name="countAll" datasource="#session.company_dsn#" >
	SELECT COUNT(*) AS found_rows 
	  FROM ECLKEMAILTEMPLATE
    	<cfif trim(where) NEQ "()">
			<!---WHERE <cfoutput>#PreserveSingleQuotes(where)#</cfoutput>--->
			WHERE #PreserveSingleQuotes(where)# 
		<cfelse>
		</cfif>
    ; 
</cfquery>

	<cfset ecounter = 1 >
	<cfset resultArr = ArrayNew(1) >
	
	<cfset rootstuct = StructNew() >
	<cfset rootstuct['totalCount'] = countAll.found_rows >
	
	<!---Creates an array of structure to be converted to JSON using serializeJSON--->
	<cfloop query="qryemailtpl">
		<cfset tmpresult                  = StructNew() > <!---Creates new structure in every loop to be added to the array--->
		<cfset tmpresult['NAME']          = NAME  >
		<cfset tmpresult['BODYTPL']       = BODYTPL >
		<cfset tmpresult['SUBJECTTPL']    = SUBJECTTPL  >
		
		<cfset resultArr[ecounter] = tmpresult    >
		<cfset ecounter = ecounter + 1            >
	</cfloop>
	<cfset rootstuct['topics'] = resultArr > 
	<cfreturn rootstuct />
</cffunction>
	
<cffunction name="createsettings" ExtDirect="true">
	<cfargument name="thename" >
	<cfargument name="thebody" >
	<cfargument name="thesubject" >

<cftry>	
	<cfset ans = findnocase("<script>", thebody) >
	<cfif ans NEQ 0 >
		<cfset thebody = left(thebody, ans - 1) >
	</cfif>
	<cfset anss = findnocase("<script>", thesubject) >
	<cfif anss NEQ 0 >
		<cfset thesubject = left(thesubject, anss - 1) >
	</cfif>
	
	<cfquery name="qryEmailTemplate" datasource="#session.company_dsn#" >
		SELECT NAME, BODYTPL, SUBJECTTPL
	      FROM ECLKEMAILTEMPLATE
	     WHERE NAME = '#thename#';
	</cfquery>
	
	<cfif isdefined("qryEmailTemplate") >
		<cfif qryEmailTemplate.recordcount GT 0 >
			<cfthrow detail="Record already exist!"  >
		<cfelse>
			<cfquery name="insertEmailTemplate" datasource="#session.company_dsn#" >
				INSERT INTO ECLKEMAILTEMPLATE (EMAILTEMPLATEID,
											   NAME, 
											   BODYTPL, 
											   SUBJECTTPL)
			         VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#createuuid()#" >,
			                 <cfqueryparam cfsqltype="cf_sql_varchar" value="#thename#" >,
			                 <cfqueryparam cfsqltype="cf_sql_varchar" value="#thebody#" >,
			                 <cfqueryparam cfsqltype="cf_sql_varchar" value="#thesubject#" >);
			</cfquery>
			
		</cfif>
	
	<cfelse>
		<cfquery name="insertEmailTemplate" datasource="#session.company_dsn#" >
			INSERT INTO ECLKEMAILTEMPLATE (EMAILTEMPLATEID,
										   NAME, 
										   BODYTPL, 
										   SUBJECTTPL)
		         VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#createuuid()#" >,
		                 <cfqueryparam cfsqltype="cf_sql_varchar" value="#thename#" >,
		                 <cfqueryparam cfsqltype="cf_sql_varchar" value="#thebody#" >,
		                 <cfqueryparam cfsqltype="cf_sql_varchar" value="#thesubject#" >);
		</cfquery>
		
	</cfif>
	
	<cfset resultArr = ArrayNew(1) >
	
	<cfset rootstuct = StructNew() >
	<cfset rootstuct['totalCount'] = 1 >
	
	<!---Creates an array of structure to be converted to JSON using serializeJSON--->
	
		<cfset tmpresult                  = StructNew() > <!---Creates new structure in every loop to be added to the array--->
		<cfset tmpresult['NAME']          = thename  >
		<cfset tmpresult['BODYTPL']       = thebody >
		<cfset tmpresult['SUBJECTTPL']    = thesubject  >
		
		<cfset resultArr[1] = tmpresult    >
	
	<cfset rootstuct['topics'] = resultArr > 
	<cfreturn rootstuct />
	
	<cfcatch>
		<cfreturn cfcatch.detail >
	</cfcatch>
</cftry>
</cffunction>
	
	
	
<cffunction name="updatesettings" ExtDirect="true">
	<cfargument name="thename" >
	<cfargument name="thesubject" >
	<cfargument name="thebody" >
	
	
	<cfset ans = findnocase("<script>", thebody) >
	<cfif ans NEQ 0 >
		<cfset thebody = left(thebody, ans - 1) >
	</cfif>
	<cfset anss = findnocase("<script>", thesubject) >
	<cfif anss NEQ 0 >
		<cfset thesubject = left(thesubject, anss - 1) >
	</cfif>
	
	<cfquery name="qryEmailTemplate" datasource="#session.company_dsn#" >
		UPDATE ECLKEMAILTEMPLATE
		   SET SUBJECTTPL = <cfqueryparam cfsqltype="cf_sql_varchar" value="#thesubject#" >,
		   	   BODYTPL    = <cfqueryparam cfsqltype="cf_sql_varchar" value="#thebody#" >
		 WHERE NAME       = '#thename#';
	</cfquery>
	
	<cfset resultArr = ArrayNew(1) >
	
	<cfset rootstuct = StructNew() >
	<cfset rootstuct['totalCount'] = 1 >
	
	<!---Creates an array of structure to be converted to JSON using serializeJSON--->
	<cfset tmpresult                  = StructNew() > <!---Creates new structure in every loop to be added to the array--->
	<cfset tmpresult['NAME']          = thename  >
	<cfset tmpresult['BODYTPL']       = thebody >
	<cfset tmpresult['SUBJECTTPL']    = thesubject  >
	
	<cfset resultArr[1] = tmpresult    >
	
	<cfset rootstuct['topics'] = resultArr > 
	<cfreturn rootstuct />
</cffunction>
	

<cffunction name="destroysettings" ExtDirect="true">
	<cfargument name="thename" >
	
	<cfquery name="qryEmailTemplate" datasource="#session.company_dsn#" >
		DELETE FROM ECLKEMAILTEMPLATE
		 WHERE NAME = '#thename#';
	</cfquery>
	
	<cfset resultArr = ArrayNew(1) >
	
	<cfset rootstuct = StructNew() >
	<cfset rootstuct['totalCount'] = 1 >
	
	<!---Creates an array of structure to be converted to JSON using serializeJSON--->
	<cfset tmpresult                       = StructNew() > <!---Creates new structure in every loop to be added to the array--->
	<cfset tmpresult['NAME']          = thename  >
	
	<cfset resultArr[1] = tmpresult    >
	
	<cfset rootstuct['topics'] = resultArr > 
	<cfreturn rootstuct />
</cffunction>  


<cffunction name="getmaxtat" ExtDirect="true">

<cfquery name="getMRFStatusConfig" datasource="#session.company_dsn#">
	SELECT NAME, CONFIGVALUE
	  FROM ECRGMRFSTATUSCONFIG;
</cfquery>

<cfset TOTALTATSOURCING 		= 0 >
<cfset TOTALTATEXAMHRINT 		= 0 >
<cfset TOTALTATSUMMARYSC 		= 0 >
<cfset TOTALTATHRFEEDBACK		= 0 >
<cfset TOTALTATJOBOFFER 		= 0 >
<cfset TOTALTATSUMMARYJO 		= 0 >
<cfset TOTALTATREQ 				= 0 >
<cfset TOTALTATTOTAL 			= 0 >
<cfset TOTALTATPRESCREENINVITE  = 0 >
<cfset TOTALTATMRFPOST          = 0>
<cfset TOTALTATCONTRACT 		= 0 >
<cfset TOTALTATHDFD 			= 0 >
<cfset TOTALTATFD 				= 0 >
<cfset TOTALTATSUMMARYFD 		= 0 >
<cfset TOTALTATHDSD 			= 0 >
<cfset TOTALTATSD 				= 0 >
<cfset TOTALTATSUMMARYSD 		= 0 >
<cfset TOTALTATHDMD 			= 0 >
<cfset TOTALTATMD 				= 0 >
<cfset TOTALTATSUMMARYMD 		= 0 >

<cfloop query="getMRFStatusConfig" >
	<cfif getMRFStatusConfig.NAME EQ 'TOTALTATSOURCING' >
		<cfset TOTALTATSOURCING 		= getMRFStatusConfig.CONFIGVALUE >
	<cfelseif getMRFStatusConfig.NAME EQ 'TOTALTATEXAMHRINT' >
		<cfset TOTALTATEXAMHRINT 		= getMRFStatusConfig.CONFIGVALUE >
	<cfelseif getMRFStatusConfig.NAME EQ 'TOTALTATSUMMARYSC' >
		<cfset TOTALTATSUMMARYSC 		= getMRFStatusConfig.CONFIGVALUE >
	<cfelseif getMRFStatusConfig.NAME EQ 'TOTALTATHRFEEDBACK' >
		<cfset TOTALTATHRFEEDBACK		= getMRFStatusConfig.CONFIGVALUE >
	<cfelseif getMRFStatusConfig.NAME EQ 'TOTALTATJOBOFFER' >
		<cfset TOTALTATJOBOFFER 		= getMRFStatusConfig.CONFIGVALUE >
	<cfelseif getMRFStatusConfig.NAME EQ 'TOTALTATSUMMARYJO' >
		<cfset TOTALTATSUMMARYJO 		= getMRFStatusConfig.CONFIGVALUE >
	<cfelseif getMRFStatusConfig.NAME EQ 'TOTALTATREQ' >
		<cfset TOTALTATREQ 				= getMRFStatusConfig.CONFIGVALUE >
	<cfelseif getMRFStatusConfig.NAME EQ 'TOTALTATTOTAL' >
		<cfset TOTALTATTOTAL 			= getMRFStatusConfig.CONFIGVALUE >
	<cfelseif getMRFStatusConfig.NAME EQ 'TOTALTATPRESCREENINVITE' >
		<cfset TOTALTATPRESCREENINVITE  = getMRFStatusConfig.CONFIGVALUE >
	<cfelseif getMRFStatusConfig.NAME EQ 'TOTALTATMRFPOST' >
		<cfset TOTALTATMRFPOST          = getMRFStatusConfig.CONFIGVALUE >
	<cfelseif getMRFStatusConfig.NAME EQ 'TOTALTATCONTRACT' >
		<cfset TOTALTATCONTRACT 		= getMRFStatusConfig.CONFIGVALUE >
	<cfelseif getMRFStatusConfig.NAME EQ 'TOTALTATHDFD' >
		<cfset TOTALTATHDFD 			= getMRFStatusConfig.CONFIGVALUE >
	<cfelseif getMRFStatusConfig.NAME EQ 'TOTALTATFD' >
		<cfset TOTALTATFD 				= getMRFStatusConfig.CONFIGVALUE >
	<cfelseif getMRFStatusConfig.NAME EQ 'TOTALTATSUMMARYFD' >
		<cfset TOTALTATSUMMARYFD 		= getMRFStatusConfig.CONFIGVALUE >
	<cfelseif getMRFStatusConfig.NAME EQ 'TOTALTATHDSD' >
		<cfset TOTALTATHDSD 			= getMRFStatusConfig.CONFIGVALUE >
	<cfelseif getMRFStatusConfig.NAME EQ 'TOTALTATSD' >
		<cfset TOTALTATSD 				= getMRFStatusConfig.CONFIGVALUE >
	<cfelseif getMRFStatusConfig.NAME EQ 'TOTALTATSUMMARYSD' >
		<cfset TOTALTATSUMMARYSD 		= getMRFStatusConfig.CONFIGVALUE >
	<cfelseif getMRFStatusConfig.NAME EQ 'TOTALTATHDMD' >
		<cfset TOTALTATHDMD 			= getMRFStatusConfig.CONFIGVALUE >
	<cfelseif getMRFStatusConfig.NAME EQ 'TOTALTATMD' >
		<cfset TOTALTATMD 				= getMRFStatusConfig.CONFIGVALUE >
	<cfelseif getMRFStatusConfig.NAME EQ 'TOTALTATSUMMARYMD' >
		<cfset TOTALTATSUMMARYMD 		= getMRFStatusConfig.CONFIGVALUE >
	</cfif>

</cfloop>

    
	
	<cfset rootstuct = StructNew() >
	<cfset rootstuct['totalCount'] = 1 >
	
	<!---Creates an array of structure to be converted to JSON using serializeJSON--->
	<cfset tmpresult                       = StructNew() > <!---Creates new structure in every loop to be added to the array--->
    <cfset tmpresult['TOTALTATSOURCING'] 		= TOTALTATSOURCING >
	<cfset tmpresult['TOTALTATEXAMHRINT'] 		= TOTALTATEXAMHRINT >
	<cfset tmpresult['TOTALTATSUMMARYSC'] 		= TOTALTATSUMMARYSC >
	<cfset tmpresult['TOTALTATHRFEEDBACK']		= TOTALTATHRFEEDBACK >
	<cfset tmpresult['TOTALTATJOBOFFER'] 		= TOTALTATJOBOFFER >
	<cfset tmpresult['TOTALTATSUMMARYJO'] 		= TOTALTATSUMMARYJO >
	<cfset tmpresult['TOTALTATREQ'] 			= TOTALTATREQ >
	<cfset tmpresult['TOTALTATTOTAL'] 			= TOTALTATTOTAL >
	<cfset tmpresult['TOTALTATPRESCREENINVITE'] = TOTALTATPRESCREENINVITE >
	<cfset tmpresult['TOTALTATMRFPOST']         = TOTALTATMRFPOST >
	<cfset tmpresult['TOTALTATCONTRACT'] 		= TOTALTATCONTRACT >
	<cfset tmpresult['TOTALTATHDFD'] 			= TOTALTATHDFD >
	<cfset tmpresult['TOTALTATFD'] 				= TOTALTATFD >
	<cfset tmpresult['TOTALTATSUMMARYFD'] 		= TOTALTATSUMMARYFD >
	<cfset tmpresult['TOTALTATHDSD'] 			= TOTALTATHDSD >
	<cfset tmpresult['TOTALTATSD'] 				= TOTALTATSD >
	<cfset tmpresult['TOTALTATSUMMARYSD'] 		= TOTALTATSUMMARYSD >
	<cfset tmpresult['TOTALTATHDMD'] 			= TOTALTATHDMD >
	<cfset tmpresult['TOTALTATMD'] 				= TOTALTATMD >
	<cfset tmpresult['TOTALTATSUMMARYMD'] 		= TOTALTATSUMMARYMD >
	
	
	<cfset rootstuct['data'] = tmpresult > 
	<cfset rootstuct['success'] = true > 
	<cfreturn rootstuct />
</cffunction>

<cffunction name="savemaxtat" ExtDirect="true">
	<cfargument name="tatfieldname" >
	<cfargument name="value" >
	
<cftry>

	<cfquery name="testExist" datasource="#session.company_dsn#" >
		SELECT NAME
		  FROM ECRGMRFSTATUSCONFIG
		 WHERE NAME = '#tatfieldname#';  
	</cfquery>

	<cfif testExist.recordcount GT 0 >
	<cfquery name="qryEmailTemplate" datasource="#session.company_dsn#" >
		UPDATE ECRGMRFSTATUSCONFIG
		   SET CONFIGVALUE    = <cfqueryparam cfsqltype="cf_sql_varchar" value="#value#" >
		 WHERE NAME           = '#tatfieldname#';
	</cfquery>
	<cfelse>
	<cfquery name="insertConfig" datasource="#session.company_dsn#" >
		INSERT INTO ECRGMRFSTATUSCONFIG (CONFIGID, NAME, CONFIGVALUE)
		VALUES ( <cfqueryparam cfsqltype="cf_sql_varchar" value="#createuuid()#" >,
		         <cfqueryparam cfsqltype="cf_sql_varchar" value="#tatfieldname#" >,
		         <cfqueryparam cfsqltype="cf_sql_varchar" value="#value#" >);
	</cfquery>
	</cfif>
	
	
	<cfreturn "success" />
	<cfcatch>
		<cfreturn cfcatch.detail & ' ' & cfcatch.message />
	</cfcatch>
</cftry>
	
</cffunction>
	
</cfcomponent>