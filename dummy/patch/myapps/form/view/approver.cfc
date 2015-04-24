<cfcomponent name="data" ExtDirect="true">
	
<cffunction name="ReadNow" ExtDirect="true">
					
	<cfargument name="page" >
	<cfargument name="start" >
	<cfargument name="limit" >
	<cfargument name="sort" >
	<cfargument name="filter" >
	<cfargument name="processid" >
	<cfargument name="routerid" >
		
 	<cfset where             = "()" >
	 <cfif isdefined('query')>
	   <cfset WHERE =  "WHERE PROCESSNAME LIKE '%#query#%'" >
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
				<cfset WHERE =  "WHERE #PreserveSingleQuotes(where)# AND PROCESSIDFK = '#processid#' AND ROUTERIDFK = '#routerid#' " >
			<cfelse>
				<cfset WHERE = "WHERE PROCESSIDFK = '#processid#' AND ROUTERIDFK = '#routerid#' " >
			</cfif> 
			
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

<cfset processData = ORMExecuteQuery("FROM EGINROUTERAPPROVERS #WHERE# ORDER BY #ORDERBY#", false, {offset=#start#, maxResults=#limit#, timeout=60} ) >

<cfset countAll = ORMExecuteQuery("FROM EGINROUTERAPPROVERS #WHERE#" )>


	<cfset ecounter = 1 >
	<cfset resultArr = ArrayNew(1) >
	
	<cfset rootstuct = StructNew() >
	<cfset rootstuct['totalCount'] = ArrayLen(countAll) >
	
	<!---Creates an array of structure to be converted to JSON using serializeJSON--->
	<cfloop array="#processData#" index="calIndex" >
		<cfset tmpresult = StructNew() > <!---Creates new structure in every loop to be added to the array--->
		<cfset tmpresult['APPROVERSID']      = calIndex.getAPPROVERSID()  >
		<cfset tmpresult['ROUTERIDFK']      = calIndex.getROUTERIDFK()  >
		<cfset tmpresult['PROCESSIDFK']      = calIndex.getPROCESSIDFK()  >
		<cfset tmpresult['APPROVERORDER']      = calIndex.getAPPROVERORDER()  >
		<cfset tmpresult['APPROVERNAME']      = calIndex.getAPPROVERNAME()  >
		<cfset tmpresult['CANVIEWROUTEMAP']      = calIndex.getCANVIEWROUTEMAP()  >
		<cfset tmpresult['CANOVERRIDE']      = calIndex.getCANOVERRIDE()  >
		<cfset tmpresult['USERID']      = calIndex.getUSERID()  >
		<cfset tmpresult['PERSONNELIDNO']      = calIndex.getPERSONNELIDNO()  >
		<cfset tmpresult['USERGRPID']      = calIndex.getUSERGRPID()  >
		<cfset tmpresult['CONDITIONABOVE']      = calIndex.getCONDITIONABOVE()  >
		<cfset tmpresult['CONDITIONBELOW']      = calIndex.getCONDITIONBELOW()  >
		<cfset tmpresult['RECCREATEDBY']      = calIndex.getRECCREATEDBY()  >
		<cfset tmpresult['DATELASTUPDATE']      = calIndex.getDATELASTUPDATE()  >
		
		<cfset resultArr[ecounter] = tmpresult    >
		<cfset ecounter = ecounter + 1            >
	</cfloop>
	<cfset rootstuct['topics'] = resultArr > 
	<cfreturn rootstuct />	
</cffunction>
	

<cffunction name="UpdateNow" ExtDirect="true">
<cfargument name="datatoupdate" >
<cftry>
<cfif isArray(datatoupdate) >
	<cfset datatoupdate = datatoupdate[1] >
</cfif>

<cfset processData = EntityLoad("EGINROUTERAPPROVERS", #datatoupdate.APPROVERSID#, true ) >
<cfset processData.setAPPROVERNAME("#datatoupdate.APPROVERNAME#") >
<cfset processData.setAPPROVERORDER("#datatoupdate.APPROVERORDER#") >
<cfset processData.setCANOVERRIDE("#datatoupdate.CANOVERRIDE#") >
<cfset processData.setCANVIEWROUTEMAP("#datatoupdate.CANVIEWROUTEMAP#") >
<cfset processData.setCONDITIONABOVE("#datatoupdate.CONDITIONABOVE#") >
<cfset processData.setCONDITIONBELOW("#datatoupdate.CONDITIONBELOW#") >
<cfset processData.setUSERID("#datatoupdate.USERID#") >
<cfset processData.setPERSONNELIDNO("#datatoupdate.PERSONNELIDNO#") >
<cfset processData.setUSERGRPID("#datatoupdate.USERGRPID#") >
<cfset processData.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')#") >

<cfset EntitySave(processData) >
<cfset ormflush()>

<cfreturn datatoupdate.APPROVERNAME >

<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message >
</cfcatch>
</cftry>
</cffunction>


<cffunction name="DestroyNow" ExtDirect="true">
<cfargument name="datatodestroy" >

<cftry>
<cfif isArray(datatodestroy) >
<cfset arrayLen = ArrayLen(datatodestroy) >
	<cfloop from="1" to="#arrayLen#" index="dataIdx" step="1"  >
	<cfset processData = EntityLoad("EGINROUTERAPPROVERS", #datatodestroy[dataIdx].APPROVERSID#, true ) >
	<cfset EntityDelete(processData) >
	</cfloop>
<cfelse>
	<cfset processData = EntityLoad("EGINROUTERAPPROVERS", #datatodestroy.APPROVERSID#, true ) >
	<cfset EntityDelete(processData) >
</cfif>
<cfset ormflush()>
	<cfreturn "success" >
<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message >
</cfcatch>
</cftry>
</cffunction>


<!---Use the following function if you use direct to upload files and submit forms.
If you have a doubt, this will simplify your work. Thanks!--->
<cffunction name="submitRec" ExtDirect="true" ExtFormHandler="true" >

<cftry>
	 <cfif form.filename2 NEQ "" >
		<cfset myfolder = "./" >  
    	<cfset destin = "#expandpath(myfolder)#" />  
    	<cffile action      = "upload"
                fileField   = "filename2"
                destination = "#destin#"
                mode        = "777"
                result      = "fileuploadresult2"
                nameconflict="MakeUnique"
		>
		<cfset theimageserverfilename = fileuploadresult2.serverfile >
        <cfif ucase(fileuploadresult2.FILEWASSAVED)  EQ 'YES' >
		<cfelse>
        </cfif>
	<cfelse>
	</cfif> 
<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message >
</cfcatch>
</cftry>
	
<cftry>
 	 <cfif form.filename NEQ "" >
		<cfset myfolder = "./" >  
    	<cfset destin = "#expandpath(myfolder)#" />  
    	<cffile action   	= "upload"
                fileField   = "filename"
            	destination = "#destin#"
            	mode 		= "777"
           		result		="fileuploadresult"
            	nameconflict="MakeUnique"
		>
		<cfset theimageserverfilename = fileuploadresult.serverfile >
        <cfif ucase(fileuploadresult.FILEWASSAVED)  EQ 'YES' >
			 <cfreturn "success" >
        <cfelse>
            <cfreturn "failure" >
        </cfif>
    <cfelse>
		<cfinvoke method="formsaving" returnvariable="returned">
	    <cfreturn returned >
	</cfif>   
<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message >
</cfcatch>
</cftry>
</cffunction>

<cffunction name="getDetails" ExtDirect="true">
	<cfreturn "empty" >
</cffunction>

<cffunction name="submitApproverRecords" ExtDirect="true" ExtFormHandler="true">   
<cftry>

<cfset processData = EntityNew("EGINROUTERAPPROVERS") > 
<cfset processData.setAPPROVERSID("#createuuid()#") >
<cfset processData.setROUTERIDFK("#form.ROUTERIDFK#") >
<cfset processData.setPROCESSIDFK("#form.PROCESSIDFK#") >
<cfset processData.setAPPROVERORDER("#form.APPROVERORDER#") >
<cfset processData.setAPPROVERNAME("#form.APPROVERNAME#") >
<cfset processData.setCANVIEWROUTEMAP("#form.CANVIEWROUTEMAP#") >
<cfset processData.setCANOVERRIDE("#form.CANOVERRIDE#") >
<cfset processData.setUSERID("#form.USERID#") >
<cfset processData.setPERSONNELIDNO("#form.PERSONNELIDNO#") >
<cfset processData.setUSERGRPID("#form.USERGRPID#") >
<cfset processData.setCONDITIONABOVE("#form.CONDITIONABOVE#") >
<cfset processData.setCONDITIONBELOW("#form.CONDITIONBELOW#") >
<cfset processData.setRECCREATEDBY("#client.userid#") >
<cfset processData.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')#") >

<cfset EntitySave(processData) >
<cfset ormflush()>

<cfset returnStruct = StructNew() >
<cfset returnStruct['success'] = "true" >
<cfset returnStruct['data']=form.APPROVERNAME >
<cfreturn returnStruct >
<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message > 
</cfcatch>
</cftry>
</cffunction>

	
<cffunction name=formsaving >
	<cfset firstname = form.firstnamex & ' ' & form.lastnamex >
    <cfreturn firstname >
</cffunction>


	
</cfcomponent>