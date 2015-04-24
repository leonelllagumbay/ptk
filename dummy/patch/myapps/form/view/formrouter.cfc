<cfcomponent name="data" ExtDirect="true">
	
<cffunction name="ReadNow" ExtDirect="true">
					
	<cfargument name="page" >
	<cfargument name="start" >
	<cfargument name="limit" >
	<cfargument name="sort" >
	<cfargument name="filter" >
	<cfargument name="process" >
		
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
				<cfset WHERE =  "WHERE #PreserveSingleQuotes(where)# AND PROCESSIDFK = '#process#'" >
			<cfelse>
				<cfset WHERE = "WHERE PROCESSIDFK = '#process#'" >
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

<cfset processData = ORMExecuteQuery("FROM EGINFORMROUTER #WHERE# ORDER BY #ORDERBY#", false, {offset=#start#, maxResults=#limit#, timeout=60} ) >

<cfset countAll = ORMExecuteQuery("FROM EGINFORMROUTER #WHERE#" )>


	<cfset ecounter = 1 >
	<cfset resultArr = ArrayNew(1) >
	
	<cfset rootstuct = StructNew() >
	<cfset rootstuct['totalCount'] = ArrayLen(countAll) >
	
	<!---Creates an array of structure to be converted to JSON using serializeJSON--->
	<cfloop array="#processData#" index="calIndex" >
		<cfset tmpresult = StructNew() > <!---Creates new structure in every loop to be added to the array--->
		<cfset tmpresult['ROUTERID']      = calIndex.getROUTERID()  >
		<cfset tmpresult['PROCESSIDFK']      = calIndex.getPROCESSIDFK()  >
		<cfset tmpresult['ROUTERNAME']      = calIndex.getROUTERNAME()  >
		<cfset tmpresult['DESCRIPTION']      = calIndex.getDESCRIPTION()  >
		<cfset tmpresult['EFORMSTAYTIME']      = calIndex.getEFORMSTAYTIME()  >
		<cfset tmpresult['NOTIFYNEXTAPPROVERS']      = calIndex.getNOTIFYNEXTAPPROVERS()  >
		<cfset tmpresult['NOTIFYALLAPPROVERS']      = calIndex.getNOTIFYALLAPPROVERS()  >
		<cfset tmpresult['NOTIFYORIGINATOR']      = calIndex.getNOTIFYORIGINATOR()  >
		<cfset tmpresult['FREQUENCYFOLLOUP']      = calIndex.getFREQUENCYFOLLOUP()  >
		<cfset tmpresult['EXPIREDACTION']      = calIndex.getEXPIREDACTION()  >
		<cfset tmpresult['APPROVEATLEAST']      = calIndex.getAPPROVEATLEAST()  >
		<cfset tmpresult['USECONDITIONS']      = calIndex.getUSECONDITIONS()  >
		<cfset tmpresult['AUTOAPPROVE']      = calIndex.getAUTOAPPROVE()  >
		<cfset tmpresult['ROUTERORDER']      = calIndex.getROUTERORDER()  >
		<cfset tmpresult['ISLASTROUTER']      = calIndex.getISLASTROUTER()  >
		<cfset tmpresult['MAXIMUMAPPROVERS']      = calIndex.getMAXIMUMAPPROVERS()  >
		<cfset tmpresult['CANOVERRIDE']      = calIndex.getCANOVERRIDE()  >
		<cfset tmpresult['MOREEMAILADD']      = calIndex.getMOREEMAILADD()  >
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

<cfset processData = EntityLoad("EGINFORMROUTER", #datatoupdate.ROUTERID#, true ) >
<cfset processData.setROUTERNAME("#datatoupdate.ROUTERNAME#") >
<cfset processData.setDESCRIPTION("#datatoupdate.DESCRIPTION#") >
<cfset processData.setEFORMSTAYTIME("#datatoupdate.EFORMSTAYTIME#") >
<cfset processData.setNOTIFYNEXTAPPROVERS("#datatoupdate.NOTIFYNEXTAPPROVERS#") >
<cfset processData.setNOTIFYALLAPPROVERS("#datatoupdate.NOTIFYALLAPPROVERS#") >
<cfset processData.setNOTIFYORIGINATOR("#datatoupdate.NOTIFYORIGINATOR#") > 
<cfset processData.setFREQUENCYFOLLOUP("#datatoupdate.FREQUENCYFOLLOUP#") >
<cfset processData.setEXPIREDACTION("#datatoupdate.EXPIREDACTION#") >
<cfset processData.setAPPROVEATLEAST("#datatoupdate.APPROVEATLEAST#") >
<cfset processData.setUSECONDITIONS("#datatoupdate.USECONDITIONS#") >
<cfset processData.setAUTOAPPROVE("#datatoupdate.AUTOAPPROVE#") >
<cfset processData.setROUTERORDER("#datatoupdate.ROUTERORDER#") >
<cfset processData.setISLASTROUTER("#datatoupdate.ISLASTROUTER#") >
<cfset processData.setMAXIMUMAPPROVERS("#datatoupdate.MAXIMUMAPPROVERS#") >
<cfset processData.setCANOVERRIDE("#datatoupdate.CANOVERRIDE#") >
<cfset processData.setMOREEMAILADD("#datatoupdate.MOREEMAILADD#") >
<cfset processData.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')#") >


<cfset EntitySave(processData) >
<cfset ormflush()>

<cfreturn datatoupdate >

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
		<cfset processDataB = EntityLoad("EGINROUTERAPPROVERS", {PROCESSIDFK = #datatodestroy[dataIdx].PROCESSIDFK#, ROUTERIDFK = #datatodestroy[dataIdx].ROUTERID#} ) >
		<cfif ArrayLen(processDataB) EQ 0 >
	
			<cfset processData = EntityLoad("EGINFORMROUTER", #datatodestroy[dataIdx].ROUTERID#, true ) >
			<cfset EntityDelete(processData) >
		<cfelse>
			<cfcontinue>
		</cfif>
	</cfloop>
	
<cfelse>
	<cfset processDataB = EntityLoad("EGINROUTERAPPROVERS", {PROCESSIDFK = #datatodestroy.PROCESSIDFK#, ROUTERIDFK = #datatodestroy.ROUTERID#} ) >
	<cfif ArrayLen(processDataB) EQ 0 >
	<cfset processData = EntityLoad("EGINFORMROUTER", #datatodestroy.ROUTERID#, true ) >
	<cfset EntityDelete(processData) >
	<cfelse>
		<cfreturn "hasrouters" >
	</cfif>
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
</cffunction>

<cffunction name="submitRouterRecords" ExtDirect="true" ExtFormHandler="true">   
<cftry>
<cfif trim(form.actiontype) EQ 'add' >
<cfset processData = EntityNew("EGINFORMROUTER") > 
<cfset processData.setROUTERID("#createuuid()#") >
<cfset processData.setPROCESSIDFK("#form.PROCESSIDFK#") >
<cfset processData.setROUTERNAME("#form.ROUTERNAME#") >
<cfset processData.setDESCRIPTION("#form.DESCRIPTION#") >
<cfset processData.setEFORMSTAYTIME("#form.EFORMSTAYTIME#") >
<cfset processData.setNOTIFYNEXTAPPROVERS("#form.NOTIFYNEXTAPPROVERS#") >
<cfset processData.setNOTIFYALLAPPROVERS("#form.NOTIFYALLAPPROVERS#") >
<cfset processData.setNOTIFYORIGINATOR("#form.NOTIFYORIGINATOR#") > 
<cfset processData.setFREQUENCYFOLLOUP("#form.FREQUENCYFOLLOUP#") >
<cfset processData.setEXPIREDACTION("#form.EXPIREDACTION#") >
<cfset processData.setAPPROVEATLEAST("#form.APPROVEATLEAST#") >
<cfset processData.setUSECONDITIONS("#form.USECONDITIONS#") >
<cfset processData.setAUTOAPPROVE("#form.AUTOAPPROVE#") >
<cfset processData.setROUTERORDER("#form.ROUTERORDER#") >
<cfset processData.setISLASTROUTER("#form.ISLASTROUTER#") >
<cfset processData.setMAXIMUMAPPROVERS("#form.MAXIMUMAPPROVERS#") >
<cfset processData.setCANOVERRIDE("#form.CANOVERRIDE#") > 
<cfset processData.setMOREEMAILADD("#form.MOREEMAILADD#") >
<cfset processData.setRECCREATEDBY("#client.userid#") >
<cfset processData.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')#") >
<cfelseif trim(form.actiontype) EQ 'update' AND trim(form.ROUTERID) NEQ ""> 
	<!---update--->
<cfset processData = EntityLoad("EGINFORMROUTER", #form.ROUTERID#, true ) >
<cfset processData.setROUTERNAME("#form.ROUTERNAME#") >
<cfset processData.setDESCRIPTION("#form.DESCRIPTION#") >
<cfset processData.setEFORMSTAYTIME("#form.EFORMSTAYTIME#") >
<cfset processData.setNOTIFYNEXTAPPROVERS("#form.NOTIFYNEXTAPPROVERS#") >
<cfset processData.setNOTIFYALLAPPROVERS("#form.NOTIFYALLAPPROVERS#") >
<cfset processData.setNOTIFYORIGINATOR("#form.NOTIFYORIGINATOR#") >
<cfset processData.setFREQUENCYFOLLOUP("#form.FREQUENCYFOLLOUP#") >
<cfset processData.setEXPIREDACTION("#form.EXPIREDACTION#") >
<cfset processData.setAPPROVEATLEAST("#form.APPROVEATLEAST#") >
<cfset processData.setUSECONDITIONS("#form.USECONDITIONS#") >
<cfset processData.setAUTOAPPROVE("#form.AUTOAPPROVE#") >
<cfset processData.setROUTERORDER("#form.ROUTERORDER#") >
<cfset processData.setISLASTROUTER("#form.ISLASTROUTER#") >
<cfset processData.setMAXIMUMAPPROVERS("#form.MAXIMUMAPPROVERS#") >
<cfset processData.setCANOVERRIDE("#form.CANOVERRIDE#") >
<cfset processData.setMOREEMAILADD("#form.MOREEMAILADD#") >
<cfset processData.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')#") >
	
</cfif>

<cfset EntitySave(processData) >
<cfset ormflush()>
<cfset returnStruct = StructNew() >
<cfset returnStruct['success'] = "true" >
<cfset returnStruct['data']=form.ROUTERNAME >
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