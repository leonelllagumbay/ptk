<cfcomponent name="data" ExtDirect="true">
	
<cffunction name="ReadNow" ExtDirect="true">
					
	<cfargument name="page" >
	<cfargument name="start" >
	<cfargument name="limit" >
	<cfargument name="sort" >
	<cfargument name="filter" >
	<!---<cfargument name="group" >---> 
		
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
				<cfset WHERE =  "WHERE #PreserveSingleQuotes(where)# AND COMPANYCODE = '#client.companycode#'" >
			<cfelse>
				<cfset WHERE = "WHERE COMPANYCODE = '#client.companycode#'" >
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

<cfset processData = ORMExecuteQuery("FROM EGINFORMPROCESS #WHERE# ORDER BY #ORDERBY#", false, {offset=#start#, maxResults=#limit#, timeout=60} ) >

<cfset countAll = ORMExecuteQuery("FROM EGINFORMPROCESS #WHERE#" )>


	<cfset ecounter = 1 >
	<cfset resultArr = ArrayNew(1) >
	
	<cfset rootstuct = StructNew() >
	<cfset rootstuct['totalCount'] = ArrayLen(countAll) >
	
	<!---Creates an array of structure to be converted to JSON using serializeJSON--->
	<cfloop array="#processData#" index="calIndex" >
		<cfset tmpresult = StructNew() > <!---Creates new structure in every loop to be added to the array--->
		<cfset tmpresult['PROCESSID']      = calIndex.getPROCESSID()  >
		<cfset tmpresult['GROUPNAME']      = calIndex.getGROUPNAME() >
		<cfset tmpresult['COMPANYCODE']    = calIndex.getCOMPANYCODE()  >
		<cfset tmpresult['PROCESSNAME']    = calIndex.getPROCESSNAME()  >
		<cfset tmpresult['DESCRIPTION']    = calIndex.getDESCRIPTION()  >
		<cfset tmpresult['EFORMLIFE'] = calIndex.getEFORMLIFE()  >
		<cfset tmpresult['EXPIREDACTION'] = calIndex.getEXPIREDACTION()  >
		<cfset tmpresult['RECCREATEDBY']   = calIndex.getRECCREATEDBY()  >
		<cfset tmpresult['DATELASTUPDATE'] = calIndex.getDATELASTUPDATE()  >
		
		<cfset resultArr[ecounter] = tmpresult    >
		<cfset ecounter = ecounter + 1            >
	</cfloop>
	<cfset rootstuct['topics'] = resultArr > 
	<cfreturn rootstuct />	
</cffunction>
	
	
<cffunction name="CreateNow" ExtDirect="true">
<cfargument name="PROCESSID" >
<cfargument name="GROUPNAME" >
<cfargument name="PROCESSNAME" >
<cfargument name="DESCRIPTION" > 
<cfargument name="EFORMLIFE" > 
<cfargument name="EXPIREDACTION" >
<cftry> 

<cfset thisuuid = createuuid() >
<cfset processData = EntityNew("EGINFORMPROCESS") >

<cfset processData.setPROCESSID("#thisuuid#") >
<cfset processData.setCOMPANYCODE("#client.companycode#") >
<cfset processData.setGROUPNAME("#GROUPNAME#") >
<cfset processData.setPROCESSNAME("#PROCESSNAME#") >
<cfset processData.setDESCRIPTION("#DESCRIPTION#") >
<cfset processData.setEFORMLIFE("#EFORMLIFE#") >
<cfset processData.setEXPIREDACTION("#EXPIREDACTION#") >
<cfset processData.setRECCREATEDBY("#client.userid#") >
<cfset processData.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')#") >

<cfset processDataA = EntityLoad("EGINFORMROUTER", {PROCESSIDFK = #PROCESSID#} ) >
<cfloop array="#processDataA#" index="calIndex" >

	<cfset thisrouterid = createuuid() >
	<cfset processDataB = EntityNew("EGINFORMROUTER") > 
	<cfset processDataB.setROUTERID("#thisrouterid#") >
	<cfset processDataB.setPROCESSIDFK("#thisuuid#") >
	<cfset processDataB.setROUTERNAME("#calIndex.getROUTERNAME()#") >
	<cfset processDataB.setDESCRIPTION("#calIndex.getDESCRIPTION()#") >
	<cfset processDataB.setEFORMSTAYTIME("#calIndex.getEFORMSTAYTIME()#") >
	<cfset processDataB.setNOTIFYNEXTAPPROVERS("#calIndex.getNOTIFYNEXTAPPROVERS()#") >
	<cfset processDataB.setNOTIFYALLAPPROVERS("#calIndex.getNOTIFYALLAPPROVERS()#") >
	<cfset processDataB.setNOTIFYORIGINATOR("#calIndex.getNOTIFYORIGINATOR()#") >
	<cfset processDataB.setEXPIREDACTION("#calIndex.getEXPIREDACTION()#") >
	<cfset processDataB.setAPPROVEATLEAST("#calIndex.getAPPROVEATLEAST()#") >
	<cfset processDataB.setUSECONDITIONS("#calIndex.getUSECONDITIONS()#") >
	<cfset processDataB.setAUTOAPPROVE("#calIndex.getAUTOAPPROVE()#") >
	<cfset processDataB.setROUTERORDER("#calIndex.getROUTERORDER()#") >
	<cfset processDataB.setISLASTROUTER("#calIndex.getISLASTROUTER()#") >
	<cfset processDataB.setMAXIMUMAPPROVERS("#calIndex.getMAXIMUMAPPROVERS()#") >
	<cfset processDataB.setCANOVERRIDE("#calIndex.getCANOVERRIDE()#") > 
	<cfset processDataB.setMOREEMAILADD("#calIndex.getMOREEMAILADD()#") >
	<cfset processDataB.setRECCREATEDBY("#calIndex.getRECCREATEDBY()#") >
	<cfset processDataB.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')#") >

	<cfset processDataC = EntityLoad("EGINROUTERAPPROVERS", {PROCESSIDFK = #PROCESSID#, ROUTERIDFK = #calIndex.getROUTERID()#} ) >
	<cfloop array="#processDataC#" index="calIndex2" >
		<cfset approverid = createuuid() >
		<cfset processDataD = EntityNew("EGINROUTERAPPROVERS") > 
		<cfset processDataD.setAPPROVERSID("#approverid#") >
		<cfset processDataD.setROUTERIDFK("#thisrouterid#") > 
		<cfset processDataD.setPROCESSIDFK("#thisuuid#") >
		<cfset processDataD.setAPPROVERORDER("#calIndex2.getAPPROVERORDER()#") >
		<cfset processDataD.setAPPROVERNAME("#calIndex2.getAPPROVERNAME()#") >
		<cfset processDataD.setCANVIEWROUTEMAP("#calIndex2.getCANVIEWROUTEMAP()#") >
		<cfset processDataD.setCANOVERRIDE("#calIndex2.getCANOVERRIDE()#") >
		<cfset processDataD.setUSERID("#calIndex2.getUSERID()#") >
		<cfset processDataD.setPERSONNELIDNO("#calIndex2.getPERSONNELIDNO()#") >
		<cfset processDataD.setUSERGRPID("#calIndex2.getUSERGRPID()#") > 
		<cfset processDataD.setCONDITIONABOVE("#calIndex2.getCONDITIONABOVE()#") >
		<cfset processDataD.setCONDITIONBELOW("#calIndex2.getCONDITIONBELOW()#") >
		<cfset EntitySave(processDataD) >
	</cfloop>

	<cfset EntitySave(processDataB) >
	
</cfloop>

<cfset EntitySave(processData) >
<cfset ormflush()>

<cfreturn GROUPNAME >
<cfcatch>
  <cftry>
	<cfset processData = EntityLoad("EGINFORMPROCESS", #thisuuid#, true) >
	<cfset entityDelete(processData) >
	<cfcatch></cfcatch>
  </cftry>
  <cftry>
	<cfset processDataB = EntityLoad("EGINFORMROUTER", #thisrouterid#, true) >
	<cfset entityDelete(processDataB) >
	<cfcatch></cfcatch>
  </cftry>
  <cftry>
	<cfset processDataC = EntityLoad("EGINROUTERAPPROVERS", #approverid#, true) >
	<cfset entityDelete(processDataC) >
	<cfcatch></cfcatch>
  </cftry>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message >
</cfcatch>
</cftry>	
</cffunction>

<cffunction name="UpdateNow" ExtDirect="true">
<cfargument name="datatoupdate" >
<cftry>
<cfif isArray(datatoupdate) >
	<cfset datatoupdate = datatoupdate[1] >
</cfif>

<cfset processData = EntityLoad("EGINFORMPROCESS", #datatoupdate.PROCESSID#, true ) >
<cfset processData.setGROUPNAME("#datatoupdate.GROUPNAME#") >
<cfset processData.setPROCESSNAME("#datatoupdate.PROCESSNAME#") >
<cfset processData.setDESCRIPTION("#datatoupdate.DESCRIPTION#") >
<cfset processData.setEFORMLIFE("#datatoupdate.EFORMLIFE#") >
<cfset processData.setEXPIREDACTION("#datatoupdate.EXPIREDACTION#") >
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
		<cfset processDataB = EntityLoad("EGINFORMROUTER", {PROCESSIDFK = #datatodestroy[dataIdx].PROCESSID#} ) >
		<cfif ArrayLen(processDataB) EQ 0 >
	
			<cfset processData = EntityLoad("EGINFORMPROCESS", #datatodestroy[dataIdx].PROCESSID#, true ) >
			<cfset EntityDelete(processData) >
		<cfelse>
			<cfcontinue>
		</cfif>
	</cfloop>
	
<cfelse>
	<cfset processDataB = EntityLoad("EGINFORMROUTER", {PROCESSIDFK = #datatodestroy.PROCESSID#} ) >
	<cfif ArrayLen(processDataB) EQ 0 >
	<cfset processData = EntityLoad("EGINFORMPROCESS", #datatodestroy.PROCESSID#, true ) >
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


<cffunction name="newProcess" ExtDirect="true">
<cfargument name="goupname" >
<cfargument name="processname" >
<cfargument name="description" >
<cfargument name="eformlife" >
<cfargument name="expirationaction" >
<cftry>

<cfset processData = EntityNew("EGINFORMPROCESS") >

<cfset processData.setPROCESSID("#createuuid()#") >
<cfset processData.setCOMPANYCODE("#client.companycode#") >
<cfset processData.setGROUPNAME("#goupname#") >
<cfset processData.setPROCESSNAME("#processname#") >
<cfset processData.setDESCRIPTION("#description#") >
<cfset processData.setEFORMLIFE("#eformlife#") >
<cfset processData.setEXPIREDACTION("#expirationaction#") >
<cfset processData.setRECCREATEDBY("#client.userid#") >
<cfset processData.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')#") >
<cfset EntitySave(processData) >
<cfset ormflush()>


	<cfset rootstuct = StructNew() >
	
	<cfset tmpresult                       = StructNew() > 
		<cfset tmpresult['firstnamex']     = "Leonell X"  >
		<cfset tmpresult['lastnamex']      = "Lagumbay X"  >
	
	<cfset rootstuct['success'] = true >
	<cfset rootstuct['data'] = tmpresult >
	
	<cfreturn goupname >
<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message >
</cfcatch>
</cftry>
</cffunction>




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

	
<cffunction name=formsaving >
	<cfset firstname = form.firstnamex & ' ' & form.lastnamex >
    <cfreturn firstname >
</cffunction>


	
</cfcomponent>