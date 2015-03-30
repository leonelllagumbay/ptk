<cfcomponent name="data" ExtDirect="true">

<cffunction name="getInitForms" ExtDirect="true">   
<cftry>

<cfset retArr[1] = " ">
<cfset retArr[2] = " ">


<cfset retArr[3] = '<img src="' & session.root_undb & 'images/' & lcase(session.companycode) & '/' & session.site_bannerlogo & '" width="290" height="60">' >

<cfreturn retArr >
<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message >
</cfcatch>			
</cftry>
</cffunction> 





<cffunction name="getTheFormsFromeFormid" ExtDirect="true"> 
<cfargument name="eformid" >
<cfargument name="actiontype" > 
<cftry>
<cfif actiontype eq "getmyeforms" >
	<cfset processData = ORMExecuteQuery("SELECT GRIDSCRIPT FROM EGRGEFORMS WHERE EFORMID = '#eformid#'", true ) >
	<cfset processData = replace(processData,"action: 'approveformnow',hidden: false,","action: 'approveformnow',hidden: true,") > 
	<cfset processData = replace(processData,"action: 'disapproveformnow',hidden: false,","action: 'disapproveformnow',hidden: true,") > 
	<cfset processData = replace(processData,"action: 'openformnow',hidden: false,","action: 'openformnow',hidden: true,") > 
<cfelseif actiontype eq "getneweforms" >
	<cfset processData = ORMExecuteQuery("SELECT GRIDSCRIPT FROM EGRGEFORMS WHERE EFORMID = '#eformid#'", true ) >
	<cfset processData = replace(processData,"isnew: false,ispending: false","isnew: true,ispending: false") >
	<cfset processData = replace(processData,"action: 'addeform',hidden: false,","action: 'addeform',hidden: true,") >
	<cfset processData = replace(processData,"action: 'copyeform',hidden: false,","action: 'copyeform',hidden: true,") >
	<cfset processData = replace(processData,"action: 'editeform',hidden: false,","action: 'editeform',hidden: true,") > 
	<cfset processData = replace(processData,"action: 'deleteeform',hidden: false,","action: 'deleteeform',hidden: true,") > 
	<cfset processData = replace(processData,"action: 'routeeform',hidden: false,","action: 'routeeform',hidden: true,") > 
<cfelseif actiontype eq "getpendingeforms" >
	<cfset processData = ORMExecuteQuery("SELECT GRIDSCRIPT FROM EGRGEFORMS WHERE EFORMID = '#eformid#'", true ) >
	<cfset processData = replace(processData,"isnew: false,ispending: false","isnew: false,ispending: true") >
	<cfset processData = replace(processData,"action: 'addeform',hidden: false,","action: 'addeform',hidden: true,") >
	<cfset processData = replace(processData,"action: 'copyeform',hidden: false,","action: 'copyeform',hidden: true,") >
	<cfset processData = replace(processData,"action: 'editeform',hidden: false,","action: 'editeform',hidden: true,") > 
	<cfset processData = replace(processData,"action: 'deleteeform',hidden: false,","action: 'deleteeform',hidden: true,") > 
	<cfset processData = replace(processData,"action: 'routeeform',hidden: false,","action: 'routeeform',hidden: true,") > 
</cfif>




<cfreturn processData >
<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message >
</cfcatch>			
</cftry>
</cffunction>




<cffunction name="setIsreadTrue" ExtDirect="true" >
<cfargument name="eformid" >
<cfargument name="processid" >
<cfargument name="formOwner" >  
<!---make the form isread as being read isread : true--->
<cftry>
	<cfset formRouterData = EntityLoad("EGINROUTERDETAILS", {PROCESSIDFK = #processid#}) >
	<cfloop array="#formRouterData#" index="routerIndex" > 
		<cfset formApproversData = EntityLoad("EGINAPPROVERDETAILS", {ROUTERIDFK =#routerIndex.getROUTERDETAILSID()#}) >
		<cfloop array="#formApproversData#" index="approverIndex" > 
			<cfset updateAction = EntityLoad("EGINAPPROVERDETAILS", {APPROVERDETAILSID =#approverIndex.getAPPROVERDETAILSID()#,ACTION='CURRENT',PERSONNELIDNO='#session.chapa#'}, true ) >
			<cfif isdefined("updateAction") >
				<cfset updateAction.setISREAD("true") >  
				<cfset EntitySave(updateAction) >
				<cfset ormflush() >
				<cfset updateCount = EntityLoad("EGINEFORMCOUNT", { EFORMID =#eformid#, PERSONNELIDNO = #session.chapa#}, true ) >
				<cfif isdefined("updateCount") >
					<cfif updateCount.getNEW() gt 0 >	
						<cfset currentCount = updateCount.getNEW() - 1 >
						<cfset updateCount.setNEW(currentCount) >
						<cfset currentCount = updateCount.getPENDING() + 1 >
						<cfset updateCount.setPENDING(currentCount) >
						<cfset EntitySave(updateCount) > 
						<cfset ormflush()>   
					</cfif> 
				</cfif>	
			</cfif>
			 
			
		</cfloop>
	</cfloop>
	
<cfset returnStruct = StructNew() >	
<!---execute after load process--->	
<cfset afterloadprocess = ORMExecuteQuery("SELECT AFTERLOAD
	  								       FROM EGRGEFORMS
	  								      WHERE EFORMID = '#eformid#'", true) >
<cfif afterloadprocess neq "NA" AND afterloadprocess neq "">
	<cfinclude template="../fielddefinition/afterload/#afterloadprocess#" > 
</cfif>	 
<!---end after load process, beforeload is found in actionform.cfc--->
						

<cfreturn returnStruct >
<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message >
</cfcatch>			
</cftry>	
</cffunction>



<cffunction name="zeroapproveDisapprove" ExtDirect="true" > 
<cfargument name="eformid" >
<cftry>
	<cfset updateCount = EntityLoad("EGINEFORMCOUNT", { EFORMID =#eformid#, PERSONNELIDNO = #session.chapa#}, true ) >
	<cfif isdefined("updateCount") >	
		<cfset updateCount.setAPPROVED("0") >
		<cfset updateCount.setDISAPPROVED("0") >
		<cfset updateCount.setRETURNED("0") >    
		<cfset EntitySave(updateCount) >  
		<cfset ormflush()> 
	<cfelse>
	</cfif> 	
	
	
<cfreturn "successZero" >
<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message >
</cfcatch>
</cftry>
</cffunction>


<cffunction name="deleteForm" ExtDirect="true" >
<cfargument name="eformid" >
<cfargument name="processid" > 
<cfargument name="level" >
<cfargument name="table" >
<cftry>
	
	<!---select the form data to be deleted and insert it to audit--->
	<cfset getMainTableID = ORMExecuteQuery("SELECT B.TABLENAME AS TABLENAME, 
												B.LEVELID AS LEVELID, 
												C.COLUMNNAME AS COLUMNNAME, 
												A.ISENCRYPTED AS ISENCRYPTED,
												A.BEFORESUBMIT AS BEFORESUBMIT,
												A.AFTERSUBMIT AS AFTERSUBMIT,
												A.AUDITTDSOURCE AS AUDITTDSOURCE,
												A.AUDITTNAME AS AUDITTNAME,
												A.LOGDBSOURCE AS LOGDBSOURCE,
												A.LOGTABLENAME AS LOGTABLENAME,
												A.LOGFILENAME AS LOGFILENAME,
												A.ONBEFOREDELETE AS ONBEFOREDELETE,
												A.ONAFTERDELETE AS ONAFTERDELETE
	  								       FROM EGRGEFORMS A,
	  								       		EGRGIBOSETABLE B,
	  								       		EGRGIBOSETABLEFIELDS C
	 								      WHERE EFORMID = '#eformid#' 
	 								      		AND A.EFORMID = B.EFORMIDFK 
	 								      		AND B.TABLEID = C.TABLEIDFK 
	 								      		AND C.XTYPE = 'id'
	 								         ", true) >	
		
	<!---execute before deleting single form--->
	<cftry>
		<cfset ONBEFOREDELETE = getMainTableID[12] >
	<cfcatch>
		<cfset ONBEFOREDELETE = "NA" >
	</cfcatch>
	</cftry>
	
	<cfif ONBEFOREDELETE neq "NA" AND trim(ONBEFOREDELETE) neq "">
		<cfinclude template="../fielddefinition/oncomplete/#getMainTableID[12]#" > 
	</cfif>
	<!---end before delete--->	
	
	<!---delete corrresponding process--->
	<cfquery name="rollbackProcessDetails" datasource="#session.global_dsn#" >
		DELETE FROM EGINFORMPROCESSDETAILS
		      WHERE PROCESSDETAILSID = '#processid#'
	</cfquery>
	
	<cftry>
		<cfset processDataB = EntityLoad("EGINROUTERDETAILS", {PROCESSIDFK=#processid#}, false ) >
		<cfloop array='#processDataB#' index='routerI' >
			
			<cfquery name="rollbackApproversDetails" datasource="#session.global_dsn#" >
				DELETE FROM EGINAPPROVERDETAILS
				      WHERE ROUTERIDFK = '#routerI.getROUTERDETAILSID()#'
			</cfquery>     
			
		</cfloop>
		
	
	<cfcatch>
	</cfcatch>
	</cftry>
	
	<cfquery name="rollbackRouterDetails" datasource="#session.global_dsn#" >
		DELETE FROM EGINROUTERDETAILS
		      WHERE PROCESSIDFK = '#processid#'
	</cfquery>
	<!---end delete corrresponding process--->
	
	<!---delete Main table item , this item--->
	<cfif level eq "G" >
		<cfset level = "#session.global_dsn#" >
	<cfelseif level eq "C" >
		<cfset level = "#session.company_dsn#" >			
	<cfelseif level eq "S" >
		<cfset level = "#session.subco_dsn#" >
	<cfelseif level eq "Q" >
		<cfset level = "#session.query_dsn#" >
	<cfelseif level eq "T" >
		<cfset level = "#session.transact_dsn#" >
	<cfelseif level eq "SD" >
		<cfset level = "#session.site_dsn#" >
	<cfelse>
		
	</cfif>
	
	
		
	<cfif trim(getMainTableID[1]) neq "" >
		<cfset firsttable  = getMainTableID[1] >
		<cfset firstlevel  = getMainTableID[2] >
		<cfset firstcolumn = getMainTableID[3] >
		<cfset isencrypted = getMainTableID[4] >
		<cfif arrayIsDefined(getMainTableID,7) >
			<cfset auditdatasource = getMainTableID[7] >
		<cfelse>
			<cfset auditdatasource = "NA" >
		</cfif>
		<cfif arrayIsDefined(getMainTableID,8) >
			<cfset audittablename  = getMainTableID[8] >
		<cfelse>
			<cfset audittablename = "NA" >
		</cfif>
		<cfif arrayIsDefined(getMainTableID,9) >
			<cfset logdatasource   = getMainTableID[9] >
		<cfelse>
			<cfset logdatasource = "NA" >
		</cfif>
		<cfif arrayIsDefined(getMainTableID,10) >
			<cfset logtablename    = getMainTableID[10] >
		<cfelse>
			<cfset logtablename = "NA" >
		</cfif>
		<cfif arrayIsDefined(getMainTableID,11) >
			<cfset logthefilename  = getMainTableID[11] >
		<cfelse>
			<cfset logthefilename = "NA" >
		</cfif>
		
	<cfelse>
		<cfthrow detail="Table has no id specified in table fields. At least one field type is an id type." >
	</cfif>
	
	

	<cfset allowAudit = ucase(auditdatasource) neq "NA" and trim(auditdatasource) neq "" and ucase(audittablename) neq "NA" and trim(audittablename) neq "" >
	<cfif allowAudit >
		<cfdbinfo datasource="#level#" 
				  name="theColumns"
				  type="columns"
				  table="#table#"
		>
		<cfset colArr = ArrayNew(1) >
		
		<cfloop query="theColumns" >
			<cfset ArrayAppend(colArr, COLUMN_NAME) >
		</cfloop>
		<cfset columnList = ArrayToList(colArr, ',') >
		
		<cfquery name="insertSelect" datasource="#auditdatasource#" >
			INSERT INTO  #audittablename# (#columnList#)
			      SELECT #columnList#
			        FROM #level#.#table#
			       WHERE EFORMID = '#eformid#' AND PROCESSID = '#processid#';
		</cfquery> 
		<cfquery name="updatePrev" datasource="#auditdatasource#" >
			UPDATE  #audittablename#
			   SET OPERATION = <cfqueryparam value="DELETED" cfsqltype="CF_SQL_VARCHAR">,
			       PERSONNELIDNO = <cfqueryparam value="#session.chapa#" cfsqltype="CF_SQL_VARCHAR">,
			       DATELASTUPDATE = <cfqueryparam value="#dateformat(now(), 'YYYY-MM-DD') & ' ' & timeformat(now(), 'HH:MM:SS')#" cfsqltype="CF_SQL_TIMESTAMP" >
			 WHERE EFORMID = '#eformid#' AND PROCESSID = '#processid#';
		</cfquery> 
	</cfif>


	<cfquery name="deleteForm" datasource="#level#" >
		DELETE FROM #table#
		      WHERE EFORMID = '#eformid#' AND PROCESSID = '#processid#'
	</cfquery> 
	
	<cfset allowLogDB = ucase(logdatasource) neq "NA" and trim(logdatasource) neq "" and ucase(logtablename) neq "NA" and trim(logtablename) neq "" >
	<cfif allowLogDB >
		<cfquery name='dynamicLog' datasource='#logdatasource#' >
			INSERT INTO #logtablename# ( 
									PERSONNELIDNO,
									DATELASTUPDATE,
									OPERATION
									) 
									
							VALUES ('#session.chapa#',
									'#dateformat(now(), "YYYY-MM-DD") & ' ' & timeformat(now(), "HH:MM:SS")#',
									'Deleted an eForm Object with an eForm id: #eformid# and process id: #processid#' )
		</cfquery>
	</cfif>
	
	<cfset allowLogToFile = ucase(logthefilename) neq "NA" and trim(logthefilename) neq "">
	<cfif allowLogToFile>
		<cflog file="#logthefilename#" text="Deleted an eForm Object with an eForm id: #eformid# and process id: #processid#"  >
	</cfif>
	
	<!---delete scheduled task assigned to the form if any--->
	<cftry>
		<cfschedule action="delete" task="process#processid#" >
	<cfcatch>
		<cftry>
			<cfschedule action="delete" task="process#processid#" >
			<cfcatch>
			</cfcatch>
		</cftry>
	</cfcatch>
	</cftry>
	
	<cftry>
		<cfschedule action="delete" task="router#processid#" >
	<cfcatch>
		<cftry>
			<cfschedule action="delete" task="router#processid#" >   
			<cfcatch>
			</cfcatch>
		</cftry>
	</cfcatch>
	</cftry> 

	<!---execute after deleting single form--->
	<cftry>
		<cfset ONAFTERDELETE = getMainTableID[13] >
	<cfcatch>
		<cfset ONAFTERDELETE = "NA" >
	</cfcatch>
	</cftry>
	
	<cfif ONAFTERDELETE neq "NA" AND trim(ONAFTERDELETE) neq "">
		<cfinclude template="../fielddefinition/oncomplete/#getMainTableID[13]#" > 
	</cfif>
	<!---end after delete---> 
	
<cfreturn "success" >
<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message >
</cfcatch>
</cftry>	
</cffunction>



<cffunction name="ReadNowDynamicApprover" ExtDirect="true"> 
	<cfargument name="page" >
	<cfargument name="start" >
	<cfargument name="limit" >
	<cfargument name="sort" >
	<cfargument name="filter" >
	<cfargument name="eformid" >   
	<cfargument name="routerid" >
		
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


<cfset processData =ORMExecuteQuery("SELECT PERSONNELIDNO
									   FROM EGINDYNAMICAPPROVERS 
									   WHERE EFORMIDFK = '#eformid#' AND ROUTERIDFK = '#routerid#' AND OWNER='#session.chapa#'", false, {offset=#start#, maxResults=#limit#, timeout=60} ) >

<cfset resultArr = ArrayNew(1) >
<cfset rootstuct = StructNew() >

<cftry>
	<cfset countAll = ORMExecuteQuery("SELECT PERSONNELIDNO
									   FROM EGINDYNAMICAPPROVERS 
									   WHERE EFORMIDFK = '#eformid#' AND ROUTERIDFK = '#routerid#'")> 
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
     WHERE PERSONNELIDNO IN ('#ArrayToList(processData, "','")#') #WHERE# 
  ORDER BY #ORDERBY#
</cfquery>


	
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

	
<cffunction name="getFormGridData" ExtDirect="true" >
					
<cfargument name="page" >
<cfargument name="start" >
<cfargument name="limit" >
<cfargument name="sort" >
<cfargument name="filter" >
<cfargument name="primaryDocVal" >
<cfargument name="eformid" >
<cfargument name="eformgroup" >

<cftry>

	<cfif start gt 0 >
		<cfset start -= 1 >
		<cfset limit -= 1 >
	<cfelse>
		<cfset start += 1 >
		<cfset limit -= 1 >
	</cfif>
		
 	<cfset where = "()" >
	 
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
			
            	<cfcatch type="any">
					<!---Do nothing here since filter is not a valid JSON string--->
				</cfcatch>
            </cftry>
            
            <cfset where = "#where#)" >
			<cfset where = Replace(where, "''", "'" , "all") />
			
			<cfif trim(where) NEQ "()">
				<cfset theFilterCondition =  "WHERE #PreserveSingleQuotes(where)#" >
			<cfelse>
				<cfset theFilterCondition = "" >
			</cfif> 
	
	      
	  <!--- Order By Arguments/Contents --->
	  <cfset thecnt = 1 >
	  <cfloop array=#sort# index="sortdata">
	  	  <cfset ORDERBY = "#sortdata.property# #sortdata.direction#" >
	  	  <cfif thecnt EQ ArrayLen(sort) >
		  <cfelse>
	  	  	<cfset ORDERBY = ORDERBY & ',' >
		  </cfif>
		  <cfset thecnt = thecnt + 1 >
	  </cfloop>
	  <!--- End Order By Arguments/Contents --->
	  	
	  
<!---start generate query  --->
<cfquery name="qryFormGridConfig" datasource="#session.global_dsn#" maxrows="1">
	 SELECT DATASOURCELEVEL, 
			TABLENAME, 
			FIELDS,
			EXTRACONDITION
	   FROM EGRGEFORMGRIDCONFIG
	  WHERE EFORMIDFK = '#eformid#' 
	  		AND EFORMGROUP = '#eformgroup#'
</cfquery>

<cfif qryFormGridConfig.recordcount gt 0 >
	<cfinvoke method="replaceSQLInjection" returnvariable="firsttable" dString="#qryFormGridConfig.TABLENAME#" >
	<cfset firstlevel  = qryFormGridConfig.DATASOURCELEVEL >
	<cfset columnlist  = qryFormGridConfig.FIELDS >
	<cfinvoke method="replaceSQLInjection" returnvariable="addedcondition" dString="#qryFormGridConfig.EXTRACONDITION#" >
<cfelse>
	<cfthrow detail="Use the eForm Grid Configuration to properly set up the datasource level, table name, and associated columns." >
</cfif>

<cfinvoke component="routing" method="getDatasource" tablelevel="#firstlevel#" returnvariable="theLevel" >

<cfif firstlevel neq 'G' >
	<cfset firsttable = "#theLevel#.#firsttable#" >
</cfif>

<cfset fieldArray = ArrayNew(1) >
<cfloop list="#columnlist#" index="listIn"  delimiters=",">
	<cfset ArrayAppend(fieldArray, "#listIn# AS '#replace(listIn,'.','_')#'") >
</cfloop>

<cfif trim(primaryDocVal) neq "{}" >
	<cfset docVal = "#replace(ListGetAt(columnlist,2,','),'_','.')# = '#primaryDocVal#'" >
<cfelse>
	<cfset docVal = "" >
</cfif>

<cfif trim(theFilterCondition) eq "" >
	<cfif trim(addedcondition) neq "" >
		<cfif docVal neq "" >
			<cfset thecondition = "WHERE #addedcondition# AND #docVal#" >
		<cfelse>
			<cfset thecondition = "WHERE #addedcondition#" >
		</cfif>
	<cfelse>
		<cfif docVal neq "" >
	    	<cfset thecondition = "WHERE #docVal#" >
	    <cfelse>
	    	<cfset thecondition = "" >
		</cfif>
	</cfif>
<cfelse>
	<cfif trim(addedcondition) neq "" >
		<cfif docVal neq "" >
			<cfset thecondition = replace(theFilterCondition,'_','.','all') & " AND " & addedcondition  & " AND #docVal#">
		<cfelse>
	    	<cfset thecondition = replace(theFilterCondition,'_','.','all') & " AND " & addedcondition>
		</cfif>
	<cfelse>
		<cfif docVal neq "" >
			<cfset thecondition = replace(theFilterCondition,'_','.','all') & " AND #docVal#">
		<cfelse>
	    	<cfset thecondition = replace(theFilterCondition,'_','.','all')>
		</cfif>
	</cfif>
	
</cfif>

<cfset theQuery = "SELECT #ArrayToList(fieldArray,',')#
					 FROM #firsttable#
					 #thecondition#
				 ORDER BY #replace(ORDERBY,'_','.','all')#">


<cfquery name="qryDynamic" datasource="#session.global_dsn#" >
	#preservesinglequotes(theQuery)#
</cfquery>
	  	
<!--- end generate query --->

	<cfset resultArr = ArrayNew(1) >
	<cfset rootstuct = StructNew() >
	<cfset rootstuct['totalCount'] = qryDynamic.recordcount >
	
	<!---Creates an array of structure to be converted to JSON using serializeJSON--->
	
	<cfloop query="qryDynamic" startrow="#start#" endrow="#start + limit#" >
		<cfset tmpresult = StructNew() > <!---Creates new structure in every loop to be added to the array--->
			<cfloop list="#columnlist#" index="outIndex" >
				<cfset listInd = "qryDynamic.#outIndex#" >
				<cfset tmpresult['#outIndex#'] = evaluate(listInd)  >
				<cfset tmpresult['EFORMID'] = eformid  >
				<cfset tmpresult['COLUMNGROUP'] = eformgroup  >
			</cfloop>
		<cfset ArrayAppend(resultArr, tmpresult) >
	</cfloop>
	
	<cfset rootstuct['topics'] = resultArr >
	<cfreturn rootstuct />
	
	<cfcatch type="any" >
		<cfreturn cfcatch.detail & ' ' & cfcatch.message >
	</cfcatch>
	
</cftry>

</cffunction>




<cffunction name="eFormGridCreate" ExtDirect="true" >
<cfargument name="datatoC" >

<cftry>
	<cfif isArray(datatoC) >
		<cfloop array="#datatoC#" index="arrI" >
			<cfset datatocreate = arrI >
			<cfinvoke method="insertItems" datatodelete="#datatocreate#">
		</cfloop>
	<cfelse>
		<cfset datatocreate = datatoC >
		<cfinvoke method="insertItems" datatodelete="#datatocreate#">
	</cfif>
	
	<cfreturn "true" >
	
	<cfcatch type="any" >
		<cfreturn cfcatch.detail & ' ' & cfcatch.message >
	</cfcatch>
	
</cftry>
</cffunction>


<cffunction name="insertItems" >
	<cfargument name="datatocreate" >
	<cfset eformid = datatocreate.EFORMID >
	<cfset eformgroup = datatocreate.COLUMNGROUP >
	
	<cfquery name="qryFormGridConfig" datasource="#session.global_dsn#" maxrows="1">
		 SELECT FIELDS, TABLENAME, DATASOURCELEVEL
		   FROM EGRGEFORMGRIDCONFIG
		  WHERE EFORMIDFK = '#eformid#' 
		  		AND EFORMGROUP = '#eformgroup#'
	</cfquery>
	
	<cfquery name="qryAutogenText" datasource="#session.global_dsn#">
		 SELECT C.COLUMNTYPE AS COLUMNTYPE
		   FROM EGRGEFORMS A,EGRGIBOSETABLE B,EGRGIBOSETABLEFIELDS C
		  WHERE A.EFORMID = '#eformid#' 
		  		AND A.EFORMID = B.EFORMIDFK 
		  		AND B.TABLEID = C.TABLEIDFK 
		  		AND C.XTYPE = 'grid' 
		  		AND C.COLUMNGROUP = '#eformgroup#'
	   ORDER BY C.COLUMNORDER ASC
	</cfquery>
	
	<cfinvoke component="routing" method="getDatasource" tablelevel="#qryFormGridConfig.DATASOURCELEVEL#" returnvariable="theLevel" >
	
	<cfquery name="addOneRow" datasource="#theLevel#" maxrows="1">
		 INSERT INTO #qryFormGridConfig.TABLENAME# (#qryFormGridConfig.FIELDS#)
		      VALUES (
		      	<cfloop from="1" to="#ListLen(qryFormGridConfig.FIELDS,',')#" index="i" >
		      		<cfset colType = qryAutogenText["COLUMNTYPE"][i] >
		      		<cfset theVal = evaluate('datatocreate.#ListGetAt(qryFormGridConfig.FIELDS,i,",")#') >
		      		<cfif colType eq "string" >
		      			<cfqueryparam cfsqltype="cf_sql_varchar" value="#theVal#">
		      		<cfelseif colType eq "int" >
		      			<cfqueryparam cfsqltype="cf_sql_integer" value="#theVal#">
		      		<cfelseif colType eq "float" >
		      			<cfqueryparam cfsqltype="cf_sql_float" value="#theVal#">
		      		<cfelseif colType eq "date" >
		      			<cfqueryparam cfsqltype="cf_sql_date" value="#left(theVal, 10)#">
		      		<cfelseif colType eq "boolean" >
		      			<cfqueryparam cfsqltype="cf_sql_varchar" value="#theVal#">
		      		<cfelse>
		      			<cfqueryparam cfsqltype="cf_sql_varchar" value="#theVal#">
		      		</cfif>
		      		<cfif i neq ListLen(qryFormGridConfig.FIELDS,',') >,</cfif>
		      	</cfloop>
		      );
	</cfquery>
	
</cffunction>

<cffunction name="eFormGridDelete" ExtDirect="true">
<cfargument name="datatoD" >

<cftry>
	<cfif isArray(datatoD) >
		<cfloop array="#datatoD#" index="arrI" >
			<cfset datatodelete = arrI >
			<cfinvoke method="deleteItems" datatodelete="#datatodelete#">
		</cfloop>
	<cfelse>
		<cfset datatodelete = datatoD >
		<cfinvoke method="deleteItems" datatodelete="#datatodelete#">
	</cfif>
	
	<cfreturn "true" >
	<cfcatch type="any" >
		<cfreturn cfcatch.detail & ' ' & cfcatch.message >
	</cfcatch>
	
</cftry>
</cffunction> 

<cffunction name="eFormGridUpdate" ExtDirect="true">
<cfargument name="datatoU" >

<cftry>
	<cfif isArray(datatoU) >
		<cfloop array="#datatoU#" index="arrI" >
			<cfset datatoupdate = arrI >
			<cfinvoke method="updateItems" datatoupdate="#datatoupdate#">
		</cfloop>
	<cfelse>
		<cfset datatoupdate = datatoU >
		<cfinvoke method="updateItems" datatoupdate="#datatoupdate#">
	</cfif>
	
	<cfreturn "true" >
	
	<cfcatch type="any" >
		<cfreturn cfcatch.detail & ' ' & cfcatch.message >
	</cfcatch>
	
</cftry>
</cffunction>

<cffunction name="updateItems" access="private" >
	<cfargument name="datatoupdate" >
	<cfset eformid = datatoupdate.EFORMID >
	<cfset eformgroup = datatoupdate.COLUMNGROUP >
	
	<cfquery name="qryFormGridConfig" datasource="#session.global_dsn#" maxrows="1">
		 SELECT FIELDS, TABLENAME, DATASOURCELEVEL
		   FROM EGRGEFORMGRIDCONFIG
		  WHERE EFORMIDFK = '#eformid#' 
		  		AND EFORMGROUP = '#eformgroup#'
	</cfquery>
	
	<cfquery name="qryAutogenText" datasource="#session.global_dsn#">
		 SELECT C.COLUMNTYPE AS COLUMNTYPE
		   FROM EGRGEFORMS A,EGRGIBOSETABLE B,EGRGIBOSETABLEFIELDS C
		  WHERE A.EFORMID = '#eformid#' 
		  		AND A.EFORMID = B.EFORMIDFK 
		  		AND B.TABLEID = C.TABLEIDFK 
		  		AND C.XTYPE = 'grid' 
		  		AND C.COLUMNGROUP = '#eformgroup#'
	   ORDER BY C.COLUMNORDER ASC
	</cfquery>
	
	<cfinvoke component="routing" method="getDatasource" tablelevel="#qryFormGridConfig.DATASOURCELEVEL#" returnvariable="theLevel" >
	
	<cfquery name="addOneRow" datasource="#theLevel#" maxrows="1">
		 UPDATE #qryFormGridConfig.TABLENAME#
		    SET <cfloop from="2" to="#ListLen(qryFormGridConfig.FIELDS,',')#" index="i" >
		      		<cfset colType = qryAutogenText["COLUMNTYPE"][i] >
		      		<cfset theCol = ListGetAt(qryFormGridConfig.FIELDS,i,",")>
		      		<cfset theVal = evaluate('datatoupdate.#ListGetAt(qryFormGridConfig.FIELDS,i,",")#') >
		      		<cfif colType eq "string" >
		      			<cfoutput>#theCol#</cfoutput> = <cfqueryparam cfsqltype="cf_sql_varchar" value="#theVal#">
		      		<cfelseif colType eq "int" >
		      			<cfoutput>#theCol#</cfoutput> = <cfqueryparam cfsqltype="cf_sql_integer" value="#theVal#">
		      		<cfelseif colType eq "float" >
		      			<cfoutput>#theCol#</cfoutput> = <cfqueryparam cfsqltype="cf_sql_float" value="#theVal#">
		      		<cfelseif colType eq "date" >
		      			<cfoutput>#theCol#</cfoutput> = <cfqueryparam cfsqltype="cf_sql_date" value="#left(theVal, 10)#">
		      		<cfelseif colType eq "boolean" >
		      			<cfoutput>#theCol#</cfoutput> = <cfqueryparam cfsqltype="cf_sql_varchar" value="#theVal#">
		      		<cfelse>
		      			<cfoutput>#theCol#</cfoutput> = <cfqueryparam cfsqltype="cf_sql_varchar" value="#theVal#">
		      		</cfif>
		      		<cfif i neq ListLen(qryFormGridConfig.FIELDS,',') >,</cfif>
		      	</cfloop>
		       WHERE
		      	    <cfset colType = qryAutogenText["COLUMNTYPE"][1] >
		      		<cfset theCol = ListGetAt(qryFormGridConfig.FIELDS,1,",")>
		      		<cfset theVal = evaluate('datatoupdate.#ListGetAt(qryFormGridConfig.FIELDS,1,",")#') >
		      		<cfif colType eq "string" >
		      			<cfoutput>#theCol#</cfoutput> = <cfqueryparam cfsqltype="cf_sql_varchar" value="#theVal#">
		      		<cfelseif colType eq "int" >
		      			<cfoutput>#theCol#</cfoutput> = <cfqueryparam cfsqltype="cf_sql_integer" value="#theVal#">
		      		<cfelseif colType eq "float" >
		      			<cfoutput>#theCol#</cfoutput> = <cfqueryparam cfsqltype="cf_sql_float" value="#theVal#">
		      		<cfelseif colType eq "date" >
		      			<cfoutput>#theCol#</cfoutput> = <cfqueryparam cfsqltype="cf_sql_date" value="#left(theVal, 10)#">
		      		<cfelseif colType eq "boolean" >
		      			<cfoutput>#theCol#</cfoutput> = <cfqueryparam cfsqltype="cf_sql_varchar" value="#theVal#">
		      		<cfelse>
		      			<cfoutput>#theCol#</cfoutput> = <cfqueryparam cfsqltype="cf_sql_varchar" value="#theVal#">
		      		</cfif>
		      	;
	</cfquery>
</cffunction>


<cffunction name="deleteItems" access="private" >
	<cfargument name="datatodelete" >
	<cfset eformid = datatodelete.EFORMID >
	<cfset eformgroup = datatodelete.COLUMNGROUP >
	
	<cfquery name="qryFormGridConfig" datasource="#session.global_dsn#" maxrows="1">
		 SELECT FIELDS, TABLENAME, DATASOURCELEVEL
		   FROM EGRGEFORMGRIDCONFIG
		  WHERE EFORMIDFK = '#eformid#' 
		  		AND EFORMGROUP = '#eformgroup#'
	</cfquery>
	
	<cfquery name="qryAutogenText" datasource="#session.global_dsn#">
		 SELECT C.COLUMNTYPE AS COLUMNTYPE
		   FROM EGRGEFORMS A,EGRGIBOSETABLE B,EGRGIBOSETABLEFIELDS C
		  WHERE A.EFORMID = '#eformid#' 
		  		AND A.EFORMID = B.EFORMIDFK 
		  		AND B.TABLEID = C.TABLEIDFK 
		  		AND C.XTYPE = 'grid' 
		  		AND C.COLUMNGROUP = '#eformgroup#'
	   ORDER BY C.COLUMNORDER ASC
	</cfquery>
	
	<cfinvoke component="routing" method="getDatasource" tablelevel="#qryFormGridConfig.DATASOURCELEVEL#" returnvariable="theLevel" >
	
	<cfquery name="addOneRow" datasource="#theLevel#" maxrows="1">
		 DELETE FROM #qryFormGridConfig.TABLENAME#
		       WHERE
		      	    <cfset colType = qryAutogenText["COLUMNTYPE"][1] >
		      		<cfset theCol = ListGetAt(qryFormGridConfig.FIELDS,1,",")>
		      		<cfset theVal = evaluate('datatodelete.#ListGetAt(qryFormGridConfig.FIELDS,1,",")#') >
		      		<cfif colType eq "string" >
		      			<cfoutput>#theCol#</cfoutput> = <cfqueryparam cfsqltype="cf_sql_varchar" value="#theVal#">
		      		<cfelseif colType eq "int" >
		      			<cfoutput>#theCol#</cfoutput> = <cfqueryparam cfsqltype="cf_sql_integer" value="#theVal#">
		      		<cfelseif colType eq "float" >
		      			<cfoutput>#theCol#</cfoutput> = <cfqueryparam cfsqltype="cf_sql_float" value="#theVal#">
		      		<cfelseif colType eq "date" >
		      			<cfoutput>#theCol#</cfoutput> = <cfqueryparam cfsqltype="cf_sql_date" value="#left(theVal, 10)#">
		      		<cfelseif colType eq "boolean" >
		      			<cfoutput>#theCol#</cfoutput> = <cfqueryparam cfsqltype="cf_sql_varchar" value="#theVal#">
		      		<cfelse>
		      			<cfoutput>#theCol#</cfoutput> = <cfqueryparam cfsqltype="cf_sql_varchar" value="#theVal#">
		      		</cfif>
		      	;
	</cfquery>
</cffunction>

<cffunction name="initFormGridValue" ExtDirect="true">

<cfargument name="eformid" >
<cfargument name="eformgroup" >
<cfargument name="fkdocvalue" >


<cftry>
	
	<cfquery name="qryFormGridConfig" datasource="#session.global_dsn#" maxrows="1">
		 SELECT FIELDS
		   FROM EGRGEFORMGRIDCONFIG
		  WHERE EFORMIDFK = '#eformid#' 
		  		AND EFORMGROUP = '#eformgroup#'
	</cfquery>
	
	<cfquery name="qryAutogenText" datasource="#session.global_dsn#">
		 SELECT C.AUTOGENTEXT AS AUTOGENTEXT
		   FROM EGRGEFORMS A,EGRGIBOSETABLE B,EGRGIBOSETABLEFIELDS C
		  WHERE A.EFORMID = '#eformid#' 
		  		AND A.EFORMID = B.EFORMIDFK 
		  		AND B.TABLEID = C.TABLEIDFK 
		  		AND C.XTYPE = 'grid' 
		  		AND C.COLUMNGROUP = '#eformgroup#'
	   ORDER BY C.COLUMNORDER ASC
	</cfquery>
	
	<!---qryFormGridConfig is comma separated list of columsn and qryAutogenText is not--->
	<cfset returnStruct = StructNew() >
	<cfloop from="1" to="#ListLen(qryFormGridConfig.FIELDS,',')#" index="i" >
		<cfset autogencolvalue = qryAutogenText["AUTOGENTEXT"][i] >
		<!---replace autogentxt to its masked values--->
		<cfset newVal = replace(autogencolvalue,"{UUID}", createuuid(), "all") >
		<cfset newVal = replace(newVal,"{DATE}", dateformat(now(),"YYYYMMDD"), "all") >
		<cfset newVal = replace(newVal,"{TIME}", dateformat(now(),"HHMMSS"), "all") >
		<cfset newVal = replace(newVal,"{DATEFORMAT}", dateformat(now(),"YYYY-MM-DD"), "all") >
		<cfset newVal = replace(newVal,"{TIMEFORMAT}", timeformat(now(),"short"), "all") >
		<cfset newVal = replace(newVal,"{LOGO}", "#session.icon_path##lcase(session.companycode)#/#session.site_ibose#", "all") >
		
		<cfset newVal = replace(newVal,"{d}", dateformat(now(),"d"), "all") >
		<cfset newVal = replace(newVal,"{dd}", dateformat(now(),"dd"), "all") >
		<cfset newVal = replace(newVal,"{ddd}", dateformat(now(),"ddd"), "all") >
		<cfset newVal = replace(newVal,"{dddd}", dateformat(now(),"dddd"), "all") >
		<cfset newVal = replace(newVal,"{m}", dateformat(now(),"m"), "all") >
		<cfset newVal = replace(newVal,"{mm}", dateformat(now(),"mm"), "all") >
		<cfset newVal = replace(newVal,"{mmm}", dateformat(now(),"mmm"), "all") >
		<cfset newVal = replace(newVal,"{mmmm}", dateformat(now(),"mmmm"), "all") >
		<cfset newVal = replace(newVal,"{yy}", dateformat(now(),"yy"), "all") >
		<cfset newVal = replace(newVal,"{yyyy}", dateformat(now(),"yyyy"), "all") >
		<cfset newVal = replace(newVal,"{gg}", dateformat(now(),"gg"), "all") >
		<cfset newVal = replace(newVal,"{short}", dateformat(now(),"short"), "all") >
		<cfset newVal = replace(newVal,"{medium}", dateformat(now(),"medium"), "all") >
		<cfset newVal = replace(newVal,"{long}", dateformat(now(),"long"), "all") >
		<cfset newVal = replace(newVal,"{full}", dateformat(now(),"full"), "all") >
		
		<cfif find('seed=', newVal) AND find('step=', newVal)>
			<cfinvoke method="autoIncrement" eformid="#eformid#">
		</cfif>
		
		<cfloop condition = "find('{RANDOM}',newVal)"> 
		    <cfset stringList= createuuid() >
			<cfset stringList= replace(stringList,"-", "", "all") >
		    <cfset rndNum    = RandRange(1, len(stringList))>
			<cfset leftStr   = left(stringList,rndNum) >
			<cfset rndString = right(leftStr,1)> 
			<cfset newVal    = replace(newVal,'{RANDOM}', rndString) >
		</cfloop>
		
		<cfloop condition = "find('{NUMBER}',newVal)"> 
	
			<cfset zerocnt = 0 >
			<cfset zerostr = "" >
			<cfset pos = find('{NUMBER}',newVal) >
			<cfif pos gt 1>
				<cfloop condition="right(left(newVal,pos-1),1) eq 0" >
					<cfset pos = pos - 1 >
					<cfoutput>a#pos#a</cfoutput><br>
					<cfset zerocnt = zerocnt + 1 >
					<cfset zerostr = "#zerostr#" & "0" >
					<cfif pos lt 2>
						<cfbreak>
					</cfif>
				</cfloop>
			<cfelseif pos eq 0 >
				<cfbreak>
			</cfif>
			
			<cfif zerocnt eq 0 >
				<cfset rndNum    = RandRange(1, 1000000000) >
				<cfset rndNum    = numberformat(rndNum, '0000000000') >
				<cfset newVal    = replace(newVal,'{NUMBER}', right(rndNum, 5)) >
			<cfelseif zerocnt gt 10 >
				<cfset rndNum    = RandRange(1, 1000000000) >
				<cfset rndNum    = numberformat(rndNum, '0000000000') >
				<cfset newVal    = replace(newVal,'#zerostr#{NUMBER}', right(rndNum, 10)) >
			<cfelse>
				<cfset rndNum    = RandRange(1, 1000000000) >
				<cfset rndNum    = numberformat(rndNum, '0000000000') >
				<cfset newVal    = replace(newVal,'#zerostr#{NUMBER}', right(rndNum, zerocnt)) >
			</cfif>
		
		</cfloop>
		
		<cfif i eq 2 >
			<cfset returnStruct['#ListGetAt(qryFormGridConfig.FIELDS,i,",")#'] = fkdocvalue >
		<cfelse>
			<cfset returnStruct['#ListGetAt(qryFormGridConfig.FIELDS,i,",")#'] = newVal >
		</cfif>
	</cfloop>
	
	<cfset returnStruct['EFORMID'] = eformid >
	<cfset returnStruct['COLUMNGROUP'] = eformgroup >
		
	<cfreturn returnStruct >

	<cfcatch type="any" >
		<cfreturn cfcatch.detail & ' ' & cfcatch.message >
	</cfcatch>
	
</cftry>
</cffunction>


<cffunction name="autoIncrement" access="private" returntype="void" >
	<cfargument name="eformid" >
	<!---format = {seed=num step=num format=0000}--->
	<cfset incVal = 0 >
	<cfset seedPos = find("seed=", newVal) >
	<cfset stepPos = find("step=", newVal) >
	<cfset formatPos = find("format=", newVal) >
	
	<cfset theLeftBracePos = 0 >
	<cfset theRightBracePos = find("}", newVal, seedPos) >
	<cfloop from="#seedPos#" to="1" index="counter" step="-1">
		<cfset substringA = newVal.substring(counter,counter + 1) >
		<cfif substringA eq "{" >
			<cfset theLeftBracePos = counter >
			<cfbreak>
		</cfif>
	</cfloop>
	
	<cfset theAutoIncStr = trim(newVal.substring(theLeftBracePos,theRightBracePos)) >
	
	<cfset seedVal = trim(newVal.substring(seedPos-1,stepPos-1)) >
	<cfset seedRef = find("=", seedVal) >
	<cfset seedValNow = trim(seedVal.substring(seedRef)) >
	
	<cfset stepVal = trim(newVal.substring(stepPos-1,formatPos-1)) >
	<cfset stepRef = find("=", stepVal) >
	<cfset stepValNow = trim(stepVal.substring(stepRef)) >
	
	<cfset formatVal = trim(newVal.substring(formatPos-1,theRightBracePos-1)) >
	<cfset formatRef = find("=", formatVal) >
	<cfset formatValNow = trim(formatVal.substring(formatRef)) >
	
	<cfquery name="getLastContent" datasource="#session.global_dsn#" >
		SELECT LASTCOUNT
		  FROM EGINAUTOINCREMENT
		 WHERE EFORMID = 'grid#eformid#';
	</cfquery>
	
	<cfif getLastContent.recordCount lt 1 >
		<cfset incVal = seedValNow >
		<cfquery name="getLastContent" datasource="#session.global_dsn#" >
			INSERT INTO EGINAUTOINCREMENT (EFORMID,LASTCOUNT,INCREMENTVALUE)
			VALUES (
			  	<cfqueryparam cfsqltype="cf_sql_varchar" value="grid#eformid#">,
			  	<cfqueryparam cfsqltype="cf_sql_integer" value="#incVal#">,
			  	<cfqueryparam cfsqltype="cf_sql_integer" value="#stepValNow#">
			  );
		</cfquery>
	<cfelse>
		<cfset incVal = val(getLastContent.LASTCOUNT) >	
		<cfset currentCnt = val(incVal) + val(stepValNow) >
		<cfquery name="updateAutoInc" datasource="#session.global_dsn#" >
			UPDATE EGINAUTOINCREMENT 
			   SET INCREMENTVALUE = <cfqueryparam cfsqltype="cf_sql_integer" value="#stepValNow#">,
			       LASTCOUNT = <cfqueryparam cfsqltype="cf_sql_integer" value="#currentCnt#">
			 WHERE EFORMID = 'grid#eformid#';
		</cfquery>
	</cfif>
	
	<cfset newVal = replace(newVal,theAutoIncStr, numberFormat(incVal,formatValNow), "all") >
	
</cffunction>

<cffunction name      ="gridtoexcel"
			returntype="string"
			access    ="remote"
			ExtDirect ="true"
>

<cfargument name="eformid" >
<cfargument name="colgroup" >
<cfargument name="tabledocnum" >
    
    <cftry>
    	<cfquery name="qryFormGridConfig" datasource="#session.global_dsn#" maxrows="1">
			 SELECT DATASOURCELEVEL, 
					TABLENAME, 
					FIELDS,
					EXTRACONDITION
			   FROM EGRGEFORMGRIDCONFIG
			  WHERE EFORMIDFK = '#eformid#' 
			  		AND EFORMGROUP = '#colgroup#'
		</cfquery>
		
		<cfquery name="qryColumnName" datasource="#session.global_dsn#">
			 SELECT C.FIELDLABEL AS FIELDLABEL
			   FROM EGRGEFORMS A,EGRGIBOSETABLE B,EGRGIBOSETABLEFIELDS C
			  WHERE A.EFORMID = '#eformid#' 
			  		AND A.EFORMID = B.EFORMIDFK 
			  		AND B.TABLEID = C.TABLEIDFK 
			  		AND C.XTYPE = 'grid' 
			  		AND C.COLUMNGROUP = '#colgroup#'
		   ORDER BY C.COLUMNORDER ASC
		</cfquery>
		
		<cfif qryFormGridConfig.recordcount gt 0 >
			<cfinvoke method="replaceSQLInjection" returnvariable="firsttable" dString="#qryFormGridConfig.TABLENAME#" >
			<cfset firstlevel  = qryFormGridConfig.DATASOURCELEVEL >
			<cfset columnlist  = qryFormGridConfig.FIELDS >
			<cfinvoke method="replaceSQLInjection" returnvariable="addedcondition" dString="#qryFormGridConfig.EXTRACONDITION#" >
		<cfelse>
			<cfthrow detail="Use the eForm Grid Configuration to properly set up the datasource level, table name, and associated columns." >
		</cfif>
		<cfinvoke component="routing" method="getDatasource" tablelevel="#firstlevel#" returnvariable="theLevel" >
		
		<cfif firstlevel neq 'G' >
			<cfset firsttable = "#theLevel#.#firsttable#" >
		</cfif>
		
		<cfset fieldArray = ArrayNew(1) >
		<cfset cnt = 1 >
		<cfloop list="#columnlist#" index="listIn"  delimiters=",">
			<cfset colN = qryColumnName['FIELDLABEL'][cnt] >
			<cfset ArrayAppend(fieldArray, "#listIn# AS '#colN#'") >
			<cfset cnt += 1 >
		</cfloop>
		
		<cfif trim(tabledocnum) neq "{}" >
			<cfif trim(addedcondition) neq "" >
				<cfset thecondition = "WHERE #addedcondition# AND #replace(ListGetAt(columnlist,2,','),'_','.')# = '#tabledocnum#'" >
			<cfelse>
			    <cfset thecondition = "WHERE #replace(ListGetAt(columnlist,2,','),'_','.')# = '#tabledocnum#'" >
			</cfif>
		<cfelse>
			<cfif trim(addedcondition) neq "" >
				<cfset thecondition = "WHERE #addedcondition#" >
			<cfelse>
			    <cfset thecondition = "" >
			</cfif>
		</cfif>
		
		
		<cfset theQuery = "SELECT #ArrayToList(fieldArray,',')#
							 FROM #firsttable#
							 #thecondition#">
		
		<cfquery name="qryDynamic" datasource="#session.global_dsn#" >
			#preservesinglequotes(theQuery)#
		</cfquery>
   
   		<cfspreadsheet  
		    action="write" 
		    filename = "#expandpath('./')#tableData.xls"
		    overwrite = "true"				  
		    query = "qryDynamic" 
		>
		
		<cfreturn "success">
	<cfcatch>
		<cfreturn cfcatch.message & " - " & cfcatch.detail >
	</cfcatch>
		
	</cftry>	
	
		
   
</cffunction>

<cffunction name="replaceSQLInjection" access="public" >
	<cfargument name="dString" >
		<cfset dString  = replace(dString,"INSERT","","all") >
		<cfset dString  = replace(dString,"UPDATE","","all") >
		<cfset dString  = replace(dString,"TRUNCATE","","all") >
		<cfset dString  = replace(dString,"DELETE","","all") >
		<cfset dString  = replace(dString,"GRANT","","all") >
		<cfset dString  = replace(dString,"REVOKE","","all") > 
		<cfset dString  = replace(dString,"CREATE","","all") >
	<cfreturn dString >
</cffunction>

 

</cfcomponent>