<cfcomponent name="data" ExtDirect="true">
	
<cffunction name="ReadNow" ExtDirect="true">
					
	<cfargument name="page" >
	<cfargument name="start" >
	<cfargument name="limit" >
	<cfargument name="sort" >
	<cfargument name="filter" >
		
 	<cfset where             = "()" >
	 <cfif isdefined('query')>
	   <cfset WHERE =  "WHERE EFORMNAME LIKE '%#query#%'" >
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

<cfset processData = ORMExecuteQuery("FROM EGRGEFORMS #WHERE# ORDER BY #ORDERBY#", false, {offset=#start#, maxResults=#limit#, timeout=60} ) >

<cfset countAll = ORMExecuteQuery("FROM EGRGEFORMS #WHERE#" )> 


	<cfset ecounter = 1 >
	<cfset resultArr = ArrayNew(1) >
	
	<cfset rootstuct = StructNew() >
	<cfset rootstuct['totalCount'] = ArrayLen(countAll) >
	
	<!---Creates an array of structure to be converted to JSON using serializeJSON--->
	<cfloop array="#processData#" index="calIndex" >
		<cfset tmpresult = StructNew() > <!---Creates new structure in every loop to be added to the array--->
		<cfset tmpresult['EFORMID']      = calIndex.getEFORMID()  >
		<cfset tmpresult['EFORMNAME']      = calIndex.getEFORMNAME() >
		<cfset tmpresult['DESCRIPTION']    = calIndex.getDESCRIPTION()  >
		<cfset tmpresult['EFORMGROUP']    = calIndex.getEFORMGROUP()  >
		<cfset tmpresult['FORMFLOWPROCESS']    = calIndex.getFORMFLOWPROCESS()  >
		<cfset tmpresult['ISENCRYPTED']    = calIndex.getISENCRYPTED()  >
		<cfset tmpresult['LAYOUTQUERY'] = calIndex.getLAYOUTQUERY()  >
		<cfset tmpresult['VIEWAS'] = calIndex.getVIEWAS()  >
		<cfset tmpresult['FORMPADDING'] = calIndex.getFORMPADDING()  >
		<cfset tmpresult['GROUPMARGIN'] = calIndex.getGROUPMARGIN()  >
		<cfset tmpresult['BEFORELOAD'] = calIndex.getBEFORELOAD()  >
		<cfset tmpresult['AFTERLOAD']   = calIndex.getAFTERLOAD()  >
		<cfset tmpresult['BEFORESUBMIT'] = calIndex.getBEFORESUBMIT()  >
		<cfset tmpresult['AFTERSUBMIT'] = calIndex.getAFTERSUBMIT()  >
		<cfset tmpresult['BEFOREAPPROVE'] = calIndex.getBEFOREAPPROVE()  >
		<cfset tmpresult['AFTERAPPROVE'] = calIndex.getAFTERAPPROVE()  >
		<cfset tmpresult['ONCOMPLETE'] = calIndex.getONCOMPLETE()  >
		<cfset tmpresult['COMPANYCODE'] = calIndex.getCOMPANYCODE()  >
		<cfset tmpresult['RECCREATEDBY'] = calIndex.getRECCREATEDBY()  >
		<cfset tmpresult['RECDATECREATED'] = calIndex.getRECDATECREATED()  >
		<cfset tmpresult['DATELASTUPDATE'] = calIndex.getDATELASTUPDATE()  >
		
		<cfset resultArr[ecounter] = tmpresult    >
		<cfset ecounter = ecounter + 1            >
	</cfloop>
	<cfset rootstuct['topics'] = resultArr > 
	<cfreturn rootstuct />	
</cffunction>
	
	
<cffunction name="CreateNow" ExtDirect="true">
<cfargument name="datatocreate" >
<cftry>
	
<cfif isArray(datatocreate) >
	<cfset datatocreate = datatocreate[1] >
</cfif>

<cfset mainid = createuuid() >

<cfset processData = EntityNew("EGRGEFORMS") >
<cfset processData.setEFORMID("#mainid#") >
<cfset processData.setEFORMNAME("#datatocreate.EFORMNAME#_COPY") >
<cfset processData.setDESCRIPTION("#datatocreate.DESCRIPTION#") >
<cfset processData.setEFORMGROUP("#datatocreate.EFORMGROUP#") >
<cfset processData.setFORMFLOWPROCESS("#datatocreate.FORMFLOWPROCESS#") >
<cfset processData.setISENCRYPTED("#datatocreate.ISENCRYPTED#") >
<cfset processData.setLAYOUTQUERY("#datatocreate.LAYOUTQUERY#") >
<cfset processData.setVIEWAS("#datatocreate.VIEWAS#") >
<cfset processData.setFORMPADDIG("#datatocreate.FORMPADDING#") >
<cfset processData.setGROUPMARGIN("#datatocreate.GROUPMARGIN#") >
<cfset processData.setBEFORELOAD("#datatocreate.BEFORELOAD#") >
<cfset processData.setAFTERLOAD("#datatocreate.AFTERLOAD#") >
<cfset processData.setBEFORESUBMIT("#datatocreate.BEFORESUBMIT#") >
<cfset processData.setAFTERSUBMIT("#datatocreate.AFTERSUBMIT#") >
<cfset processData.setBEFOREAPPROVE("#datatocreate.BEFOREAPPROVE#") >
<cfset processData.setAFTERAPPROVE("#datatocreate.AFTERAPPROVE#") >
<cfset processData.setONCOMPLETE("#datatocreate.ONCOMPLETE#") >
<cfset processData.setCOMPANYCODE("#datatocreate.COMPANYCODE#") > 
<cfset processData.setLAYOUTQUERY("#datatocreate.LAYOUTQUERY#") >  
<cfset processData.setRECCREATEDBY("#client.userid#") >
<cfset processData.setRECDATECREATED("#dateformat(now(), 'YYYY-MM-DD')#") >
<cfset processData.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')#") > 

<cfset processDataA = EntityLoad("EGRGIBOSETABLE", {EFORMIDFK = '#datatocreate.EFORMID#' } ) >  
<cfloop array="#processDataA#" index="calIndex" >
	<cfset thetableid = createuuid() >
	<cfset processDataB = EntityNew("EGRGIBOSETABLE") > 
	<cfset processDataB.setTABLEID("#thetableid#") >
	<cfset processDataB.setEFORMIDFK("#mainid#") >
	<cfset processDataB.setTABLENAME("#calIndex.getTABLENAME()#") >
	<cfset processDataB.setDESCRIPTION("#calIndex.getDESCRIPTION()#") >
	<cfset processDataB.setLINKTABLETO("#calIndex.getLINKTABLETO()#") >
	<cfset processDataB.setLINKINGCOLUMN("#calIndex.getLINKINGCOLUMN()#") >
	<cfset processDataB.setTABLETYPE("#calIndex.getTABLETYPE()#") >
	<cfset processDataB.setLEVELID("#calIndex.getLEVELID()#") >
	<cfset processDataB.setRECCREATEDBY("#calIndex.getRECCREATEDBY()#") >
	<cfset processDataB.setRECDATECREATED("#dateformat(now(), 'YYYY-MM-DD')#") >
	<cfset processDataB.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')#") >
	
	<cfset processDataC = EntityLoad("EGRGIBOSETABLEFIELDS", {TABLEIDFK = '#calIndex.getTABLEID()#'} ) >
	<cfloop array="#processDataC#" index="calIndex2" >
		<cfset processDataD = EntityNew("EGRGIBOSETABLEFIELDS") > 
		<cfset processDataD.setCOLUMNID("#createuuid()#") >
		<cfset processDataD.setTABLEIDFK("#thetableid#") > 
		<cfset processDataD.setCOLUMNNAME("#calIndex2.getCOLUMNNAME()#") >
		<cfset processDataD.setFIELDLABEL("#calIndex2.getFIELDLABEL()#") >
		<cfset processDataD.setFIELDLABELWIDTH("#calIndex2.getFIELDLABELWIDTH()#") >
		<cfset processDataD.setCOLUMNORDER("#calIndex2.getCOLUMNORDER()#") >
		<cfset processDataD.setCOLUMNTYPE("#calIndex2.getCOLUMNTYPE()#") >
		<cfset processDataD.setXTYPE("#calIndex2.getXTYPE()#") >
		<cfset processDataD.setCOLUMNGROUP("#calIndex2.getCOLUMNGROUP()#") >
		<cfset processDataD.setFIELDLABELALIGN("#calIndex2.getFIELDLABELALIGN()#") >
		<cfset processDataD.setALLOWBLANK("#calIndex2.getALLOWBLANK()#") >
		<cfset processDataD.setISCHECKED("#calIndex2.getISCHECKED()#") >
		<cfset processDataD.setCSSCLASS("#calIndex2.getCSSCLASS()#") >
		<cfset processDataD.setISDISABLED("#calIndex2.getISDISABLED()#") >
		<cfset processDataD.setHEIGHT("#calIndex2.getHEIGHT()#") >
		<cfset processDataD.setWIDTH("#calIndex2.getWIDTH()#") >
		<cfset processDataD.setMININPUTVALUE("#calIndex2.getMININPUTVALUE()#") >
		<cfset processDataD.setMAXINPUTVALUE("#calIndex2.getMAXINPUTVALUE()#") >
		<cfset processDataD.setMINCHARLENGTH("#calIndex2.getMINCHARLENGTH()#") >
		<cfset processDataD.setMAXCHARLENGTH("#calIndex2.getMAXCHARLENGTH()#") >
		<cfset processDataD.setISHIDDEN("#calIndex2.getISHIDDEN()#") >
		<cfset processDataD.setINPUTID("#calIndex2.getINPUTID()#") >
		<cfset processDataD.setMARGIN("#calIndex2.getMARGIN()#") >
		<cfset processDataD.setPADDING("#calIndex2.getPADDING()#") >
		<cfset processDataD.setBORDER("#calIndex2.getBORDER()#") >
		<cfset processDataD.setSTYLE("#calIndex2.getSTYLE()#") >
		<cfset processDataD.setISREADONLY("#calIndex2.getISREADONLY()#") >
		<cfset processDataD.setUNCHECKEDVALUE("#calIndex2.getUNCHECKEDVALUE()#") >
		<cfset processDataD.setINPUTVALUE("#calIndex2.getINPUTVALUE()#") >
		<cfset processDataD.setVALIDATIONTYPE("#calIndex2.getVALIDATIONTYPE()#") >
		<cfset processDataD.setVTYPETEXT("#calIndex2.getVTYPETEXT()#") >
		<cfset processDataD.setRENDERER("#calIndex2.getRENDERER()#") >
		<cfset processDataD.setXPOSITION("#calIndex2.getXPOSITION()#") >
		<cfset processDataD.setYPOSITION("#calIndex2.getYPOSITION()#") >
		<cfset processDataD.setANCHORPOSITION("#calIndex2.getANCHORPOSITION()#") >
		<cfset processDataD.setINPUTFORMAT("#calIndex2.getINPUTFORMAT()#") >
		<cfset processDataD.setCHECKITEMS("#calIndex2.getCHECKITEMS()#") >
		<cfset processDataD.setNOOFCOLUMNS("#calIndex2.getNOOFCOLUMNS()#") >
		<cfset processDataD.setAUTOGENTEXT("#calIndex2.getAUTOGENTEXT()#") >
		<cfset processDataD.setCOMBOLOCALDATA("#calIndex2.getCOMBOLOCALDATA()#") >
		<cfset processDataD.setCOMBOREMOTEDATA("#calIndex2.getCOMBOREMOTEDATA()#") >
		<cfset processDataD.setEDITABLEONROUTENO("#calIndex2.getEDITABLEONROUTENO()#") >
		<cfset processDataD.setRECCREATEDBY("#calIndex2.getRECCREATEDBY()#") >
		<cfset processDataD.setRECDATECREATED("#dateformat(now(), 'YYYY-MM-DD')#") >
		<cfset processDataD.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')#") >
		
		
		<cfset EntitySave(processDataD) >
		
	</cfloop>
	
	<cfset EntitySave(processDataB) >
	
</cfloop>

<cfset EntitySave(processData) >
<!---also update the egineformtable--->

<cfset eformData = EntityNew("EGINEFORMTABLEMAIN") >
<cfset eformData.setEFORMTABLEID("#createuuid()#") >
<cfset eformData.setPROCESSIDFK("#datatocreate.FORMFLOWPROCESS#") > 
<cfset eformData.setPERSONNELIDNO("#client.chapa#") >
<cfset eformData.setEFORMIDFK("#mainid#") > 
<cfset eformData.setMAINTABLEIDFK("_") > 
<cfset eformData.setSTATUS("NEW") >
<cfset eformData.setRECCREATEDBY("client.userid") >
<cfset eformData.setRECDATECREATED("#dateformat(now(), 'YYYY-MM-DD')#") >
<cfset eformData.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')#") >
<cfset EntitySave(eformData) > 


<cfset ormflush()>

<cfreturn mainid >
<cfcatch>
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

<cfset processData = EntityLoad("EGRGEFORMS", #datatoupdate.EFORMID#, true ) >
<cfset processData.setEFORMNAME("#datatoupdate.EFORMNAME#") >
<cfset processData.setDESCRIPTION("#datatoupdate.DESCRIPTION#") >
<cfset processData.setEFORMGROUP("#datatoupdate.EFORMGROUP#") >
<cfset processData.setFORMFLOWPROCESS("#datatoupdate.FORMFLOWPROCESS#") > 
<cfset processData.setISENCRYPTED("#datatoupdate.ISENCRYPTED#") >
<cfset processData.setLAYOUTQUERY("#datatoupdate.LAYOUTQUERY#") >
<cfset processData.setVIEWAS("#datatoupdate.VIEWAS#") >
<cfset processData.setFORMPADDING("#datatoupdate.FORMPADDING#") >
<cfset processData.setGROUPMARGIN("#datatoupdate.GROUPMARGIN#") >
<cfset processData.setBEFORELOAD("#datatoupdate.BEFORELOAD#") >
<cfset processData.setAFTERLOAD("#datatoupdate.AFTERLOAD#") >
<cfset processData.setBEFORESUBMIT("#datatoupdate.BEFORESUBMIT#") >
<cfset processData.setAFTERSUBMIT("#datatoupdate.AFTERSUBMIT#") >
<cfset processData.setBEFOREAPPROVE("#datatoupdate.BEFOREAPPROVE#") >
<cfset processData.setAFTERAPPROVE("#datatoupdate.AFTERAPPROVE#") >
<cfset processData.setONCOMPLETE("#datatoupdate.ONCOMPLETE#") >
<cfset processData.setCOMPANYCODE("#client.companycode#") >
<cfset processData.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')#") >

<cfset EntitySave(processData) >

<cfset eformData = EntityLoad("EGINEFORMTABLE", {EFORMIDFK = #datatoupdate.EFORMID# }, true) >
<cfset eformData.setPROCESSIDFK("#datatoupdate.FORMFLOWPROCESS#") > 
<cfset eformData.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')#") >
<cfset EntitySave(eformData) >



<cfset ormflush()>

<cfreturn datatoupdate.EFORMNAME >

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
		<cfset processDataA = EntityLoad("EGRGIBOSETABLE", {EFORMIDFK = #datatodestroy[dataIdx].EFORMID# } ) >
		<cfif ArrayLen(processDataA) EQ 0 >
		    <cfset processData = EntityLoad("EGRGEFORMS", #datatodestroy[dataIdx].EFORMID#, true ) >
			<cfset EntityDelete(processData) >
		<cfelse>
			<cfcontinue>
		</cfif> 
	</cfloop>
	
<cfelse>
	<cfset processDataA = EntityLoad("EGRGIBOSETABLE", {EFORMIDFK = #datatodestroy.EFORMID# } ) >
	<cfif ArrayLen(processDataA) EQ 0 >
		<cfset processData = EntityLoad("EGRGEFORMS", #datatodestroy.EFORMID#, true ) >
		<cfset EntityDelete(processData) >
	<cfelse>
		<cfcontinue>
	</cfif>
</cfif>
<cfset ormflush()>

<cfreturn "success" >

<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message >
</cfcatch>
</cftry>
</cffunction>







<cffunction name="TableReadNow" ExtDirect="true">
					
	<cfargument name="page" >
	<cfargument name="start" >
	<cfargument name="limit" >
	<cfargument name="sort" >
	<cfargument name="filter" >
	<cfargument name="eformid" >
		
 	<cfset where             = "()" >
	 <cfif isdefined('query')>
	   <cfset WHERE =  "WHERE TABLENAME LIKE '%#query#%'" >
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
				<cfset WHERE =  "WHERE #PreserveSingleQuotes(where)# AND EFORMIDFK = '#eformid#' " >
			<cfelse>
				<cfset WHERE = "WHERE EFORMIDFK = '#eformid#'" >
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

<cfset processData = ORMExecuteQuery("FROM EGRGIBOSETABLE #WHERE# ORDER BY #ORDERBY#", false, {offset=#start#, maxResults=#limit#, timeout=60} ) >

<cfset countAll = ORMExecuteQuery("FROM EGRGIBOSETABLE #WHERE#" )> 


	<cfset ecounter = 1 >
	<cfset resultArr = ArrayNew(1) >
	
	<cfset rootstuct = StructNew() >
	<cfset rootstuct['totalCount'] = ArrayLen(countAll) >
	
	<!---Creates an array of structure to be converted to JSON using serializeJSON--->
	<cfloop array="#processData#" index="calIndex" >
		<cfset tmpresult = StructNew() > <!---Creates new structure in every loop to be added to the array--->
		<cfset tmpresult['TABLEID']         = calIndex.getTABLEID()  >
		<cfset tmpresult['EFORMIDFK']      	= calIndex.getEFORMIDFK()  >
		<cfset tmpresult['TABLENAME']      	= calIndex.getTABLENAME()  >
		<cfset tmpresult['DESCRIPTION']     = calIndex.getDESCRIPTION() >
		<cfset tmpresult['LINKTABLETO']     = calIndex.getLINKTABLETO() >
		<cfset tmpresult['LINKINGCOLUMN']    = calIndex.getLINKINGCOLUMN() >
		<cfset tmpresult['TABLETYPE']    	= calIndex.getTABLETYPE()  >
		<cfset tmpresult['LEVELID']    		= calIndex.getLEVELID()  >
		<cfset tmpresult['RECCREATEDBY'] 	= calIndex.getRECCREATEDBY()  >
		<cfset tmpresult['RECDATECREATED'] 	= calIndex.getRECDATECREATED()  >
		<cfset tmpresult['DATELASTUPDATE'] 	= calIndex.getDATELASTUPDATE()  >
		
		<cfset resultArr[ecounter] = tmpresult    >
		<cfset ecounter = ecounter + 1            >
	</cfloop>
	<cfset rootstuct['topics'] = resultArr > 
	<cfreturn rootstuct />	
</cffunction>
	
	
<cffunction name="TableCreateNow" ExtDirect="true">
<cfargument name="datatocreate" > 
<cftry>

	
<cfif isArray(datatocreate) >
	<cfset datatocreate = datatocreate[1] >
</cfif>

	<cfset tableid = createuuid() >
	<cfset processDataB = EntityNew("EGRGIBOSETABLE") > 
	<cfset processDataB.setTABLEID("#tableid#") >
	<cfset processDataB.setEFORMIDFK("#datatocreate.EFORMIDFK#") >
	<cfset processDataB.setTABLENAME("#datatocreate.TABLENAME#_COPY") >
	<cfset processDataB.setDESCRIPTION("#datatocreate.DESCRIPTION#") >
	<cfif isdefined("datatocreate.LINKTABLETO") >
		<cfset processDataB.setLINKTABLETO("#datatocreate.LINKTABLETO#") >
	<cfelse>
		<cfset processDataB.setLINKTABLETO("") >
	</cfif>
	<cfif isdefined("datatocreate.LINKINGCOLUMN") >
		<cfset processDataB.setLINKINGCOLUMN("#datatocreate.LINKINGCOLUMN#") >
	<cfelse>
		<cfset processDataB.setLINKINGCOLUMN("") >
	</cfif>
	
	<cfset processDataB.setTABLETYPE("#datatocreate.TABLETYPE#") >
	<cfset processDataB.setLEVELID("#datatocreate.LEVELID#") >
	<cfset processDataB.setRECCREATEDBY("#datatocreate.RECCREATEDBY#") >
	<cfset processDataB.setRECDATECREATED("#dateformat(now(), 'YYYY-MM-DD')#") >
	<cfset processDataB.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')#") >
	
	<cfset processDataC = EntityLoad("EGRGIBOSETABLEFIELDS", {TABLEIDFK = #datatocreate.TABLEID#} ) >
	<cfloop array="#processDataC#" index="calIndex2" >
		<cfset processDataD = EntityNew("EGRGIBOSETABLEFIELDS") > 
		<cfset processDataD.setCOLUMNID("#createuuid()#") > 
		<cfset processDataD.setTABLEIDFK("#tableid#") >  
		<cfset processDataD.setCOLUMNNAME("#calIndex2.getCOLUMNNAME()#") >
		<cfset processDataD.setFIELDLABEL("#calIndex2.getFIELDLABEL()#") >
		<cfset processDataD.setFIELDLABELWIDTH("#calIndex2.getFIELDLABELWIDTH()#") >
		<cfset processDataD.setCOLUMNORDER("#calIndex2.getCOLUMNORDER()#") >
		<cfset processDataD.setCOLUMNTYPE("#calIndex2.getCOLUMNTYPE()#") >
		<cfset processDataD.setXTYPE("#calIndex2.getXTYPE()#") >
		<cfset processDataD.setCOLUMNGROUP("#calIndex2.getCOLUMNGROUP()#") >
		<cfset processDataD.setFIELDLABELALIGN("#calIndex2.getFIELDLABELALIGN()#") >
		<cfset processDataD.setALLOWBLANK("#calIndex2.getALLOWBLANK()#") >
		<cfset processDataD.setISCHECKED("#calIndex2.getISCHECKED()#") >
		<cfset processDataD.setCSSCLASS("#calIndex2.getCSSCLASS()#") >
		<cfset processDataD.setISDISABLED("#calIndex2.getISDISABLED()#") >
		<cfset processDataD.setHEIGHT("#calIndex2.getHEIGHT()#") >
		<cfset processDataD.setWIDTH("#calIndex2.getWIDTH()#") >
		<cfset processDataD.setMININPUTVALUE("#calIndex2.getMININPUTVALUE()#") >
		<cfset processDataD.setMAXINPUTVALUE("#calIndex2.getMAXINPUTVALUE()#") >
		<cfset processDataD.setMINCHARLENGTH("#calIndex2.getMINCHARLENGTH()#") >
		<cfset processDataD.setMAXCHARLENGTH("#calIndex2.getMAXCHARLENGTH()#") >
		<cfset processDataD.setISHIDDEN("#calIndex2.getISHIDDEN()#") >
		<cfset processDataD.setINPUTID("#calIndex2.getINPUTID()#") >
		<cfset processDataD.setMARGIN("#calIndex2.getMARGIN()#") >
		<cfset processDataD.setPADDING("#calIndex2.getPADDING()#") >
		<cfset processDataD.setBORDER("#calIndex2.getBORDER()#") >
		<cfset processDataD.setSTYLE("#calIndex2.getSTYLE()#") >
		<cfset processDataD.setISREADONLY("#calIndex2.getISREADONLY()#") >
		<cfset processDataD.setUNCHECKEDVALUE("#calIndex2.getUNCHECKEDVALUE()#") >
		<cfset processDataD.setINPUTVALUE("#calIndex2.getINPUTVALUE()#") >
		<cfset processDataD.setVALIDATIONTYPE("#calIndex2.getVALIDATIONTYPE()#") >
		<cfset processDataD.setVTYPETEXT("#calIndex2.getVTYPETEXT()#") >
		<cfset processDataD.setRENDERER("#calIndex2.getRENDERER()#") >
		<cfset processDataD.setXPOSITION("#calIndex2.getXPOSITION()#") >
		<cfset processDataD.setYPOSITION("#calIndex2.getYPOSITION()#") >
		<cfset processDataD.setANCHORPOSITION("#calIndex2.getANCHORPOSITION()#") >
		<cfset processDataD.setINPUTFORMAT("#calIndex2.getINPUTFORMAT()#") >
		
		<cfset processDataD.setCHECKITEMS("#calIndex2.getCHECKITEMS()#") >
		<cfset processDataD.setNOOFCOLUMNS("#calIndex2.getNOOFCOLUMNS()#") >
		<cfset processDataD.setAUTOGENTEXT("#calIndex2.getAUTOGENTEXT()#") >
		<cfset processDataD.setCOMBOLOCALDATA("#calIndex2.getCOMBOLOCALDATA()#") >
		<cfset processDataD.setCOMBOREMOTEDATA("#calIndex2.getCOMBOREMOTEDATA()#") >
		<cfset processDataD.setEDITABLEONROUTENO("#calIndex2.getEDITABLEONROUTENO()#") >
		
		<cfset processDataD.setRECCREATEDBY("#calIndex2.getRECCREATEDBY()#") >
		<cfset processDataD.setRECDATECREATED("#dateformat(now(), 'YYYY-MM-DD')#") >
		<cfset processDataD.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')#") >
		
		
		<cfset EntitySave(processDataD) >
		
	</cfloop>
	
<cfset EntitySave(processDataB) >

<cfset ormflush()>

<cfreturn datatocreate.TABLENAME >

<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message >
</cfcatch>
</cftry>	
</cffunction>

<cffunction name="TableUpdateNow" ExtDirect="true">
<cfargument name="datatoupdate" >
<cftry>

<cfif isArray(datatoupdate) >
	<cfset datatoupdate = datatoupdate[1] >
</cfif>

<cfset processData = EntityLoad("EGRGIBOSETABLE", #datatoupdate.TABLEID#, true ) >
<cfset processData.setEFORMIDFK("#datatoupdate.EFORMIDFK#") >
<cfset processData.setTABLENAME("#datatoupdate.TABLENAME#") >
<cfset processData.setDESCRIPTION("#datatoupdate.DESCRIPTION#") >
<cfset processData.setLINKTABLETO("#datatoupdate.LINKTABLETO#") >
<cfset processData.setLINKINGCOLUMN("#datatoupdate.LINKINGCOLUMN#") >
<cfset processData.setTABLETYPE("#datatoupdate.TABLETYPE#") > 
<cfset processData.setLEVELID("#datatoupdate.LEVELID#") >
<cfset processData.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')#") >

<cfset EntitySave(processData) >
<cfset ormflush()>

<cfreturn datatoupdate.TABLENAME >

<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message >
</cfcatch>
</cftry>
</cffunction>



<cffunction name="TableDestroyNow" ExtDirect="true">
<cfargument name="datatodestroy" >
<cftry>
<cfif isArray(datatodestroy) >
<cfset arrayLen = ArrayLen(datatodestroy) >
    <cfloop from="1" to="#arrayLen#" index="dataIdx" step="1"  >
		<cfset processDataA = EntityLoad("EGRGIBOSETABLEFIELDS", {TABLEIDFK = #datatodestroy[dataIdx].TABLEID# } ) >
		<cfif ArrayLen(processDataA) EQ 0 >
		    <cfset processData = EntityLoad("EGRGIBOSETABLE", #datatodestroy[dataIdx].TABLEID#, true ) >
			<cfset EntityDelete(processData) >
		<cfelse>
			<cfcontinue>
		</cfif>
	</cfloop>
	
<cfelse>
	<cfset processDataA = EntityLoad("EGRGIBOSETABLEFIELDS", {TABLEIDFK = #datatodestroy.TABLEID# } ) > 
	<cfif ArrayLen(processDataA) EQ 0 >
		<cfset processData = EntityLoad("EGRGIBOSETABLE", #datatodestroy.TABLEID#, true ) >
		<cfset EntityDelete(processData) >
	<cfelse>
		<cfcontinue>
	</cfif>
</cfif>
<cfset ormflush()>

<cfreturn "success" >

<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message >
</cfcatch>
</cftry>
</cffunction>








<cffunction name="ColumnReadNow" ExtDirect="true">
					
	<cfargument name="page" >
	<cfargument name="start" >
	<cfargument name="limit" >
	<cfargument name="sort" >
	<cfargument name="filter" >
	<cfargument name="eformid" >
	<cfargument name="isnew" >
	<cfargument name="ispending" >

<cftry>
		
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
            
            	<cfset filterdatafield = filterdata.field /> <!---ex L__TABLE__COLUMN : isrequired--->
				<cfset filterdatafieldtable = listgetat(filterdatafield,2,'__') >
				<cfset filterdatafieldcolumn = listgetat(filterdatafield,3,'__') >
				
				<cfset filterdatafield = "#filterdatafieldtable#.#filterdatafieldcolumn#" >
				
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
				<cfset theFilterCondition =  "AND #PreserveSingleQuotes(where)#" >
			<cfelse>
				<cfset theFilterCondition = "" >
			</cfif> 
	
	      
	  <!--- Order By Arguments/Contents --->
	  <cfset thecnt = 1 >
	  <cfloop array=#sort# index="sortdata">
	  	  <cfset filterdatafieldtable = listgetat(sortdata.property,2, '__') >
		  <cfset filterdatafieldcolumn = listgetat(sortdata.property,3, '__') >
	  	  <cfset ORDERBY = "#filterdatafieldtable#.#filterdatafieldcolumn# #sortdata.direction#" >
	  	  <cfif thecnt EQ ArrayLen(sort) >
		  <cfelse>
	  	  	<cfset ORDERBY = ORDERBY & ',' >
		  </cfif>
		  <cfset thecnt = thecnt + 1 >
	  </cfloop>
	  <!--- End Order By Arguments/Contents --->
	  	
	  
	  <!---start generate script  --->



<cfset gettheForm = ORMExecuteQuery("SELECT A.EFORMNAME, 
											B.TABLENAME AS TABLENAME, 
											B.LEVELID AS LEVELID, 
											C.COLUMNNAME AS COLUMNNAME
	  								  FROM EGRGEFORMS A,EGRGIBOSETABLE B,EGRGIBOSETABLEFIELDS C
	  								WHERE EFORMID = '#eformid#' AND A.EFORMID = B.EFORMIDFK AND B.TABLEID = C.TABLEIDFK", false) >
  
<cfset getMainTableID = ORMExecuteQuery("SELECT B.TABLENAME AS TABLENAME, B.LEVELID AS LEVELID, C.COLUMNNAME AS COLUMNNAME, A.ISENCRYPTED AS ISENCRYPTED
	  								      FROM EGRGEFORMS A,EGRGIBOSETABLE B,EGRGIBOSETABLEFIELDS C
	 								      WHERE EFORMID = '#eformid#' AND A.EFORMID = B.EFORMIDFK AND B.TABLEID = C.TABLEIDFK AND C.XTYPE = 'id'", true) >



<cfif trim(getMainTableID[1]) neq "" >
	<cfset firsttable  = getMainTableID[1] >
	<cfset firstlevel  = getMainTableID[2] >
	<cfset firstcolumn = getMainTableID[3] >
<cfelse>
	<cfthrow detail="Table has no id specified in table fields. At least one field type is an id type." >
</cfif>




<cfset columnNameModel = ArrayNew(1)  >

<cfloop array="#gettheForm#" index="tableModel">
	<cfif trim(tableModel[4]) neq "" >  <!---columnName with empty name is not qualified---> 
		<cfset colModel = tableModel[3] & '__' & tableModel[2] & '__' & tableModel[4] > 
        <cfset ArrayAppend(columnNameModel, colModel) >
    </cfif>
</cfloop>

<cfset colModel = firstlevel & '__' & firsttable & '__APPROVED' >
<cfset ArrayAppend(columnNameModel, colModel) >
<cfset colModel = firstlevel & '__' & firsttable & '__EFORMID' >
<cfset ArrayAppend(columnNameModel, colModel) >
<cfset colModel = firstlevel & '__' & firsttable & '__PROCESSID' >
<cfset ArrayAppend(columnNameModel, colModel) >
<cfset colModel = firstlevel & '__' & firsttable & '__ACTIONBY' >
<cfset ArrayAppend(columnNameModel, colModel) >
<cfset colModel = firstlevel & '__' & firsttable & '__PERSONNELIDNO' >
<cfset ArrayAppend(columnNameModel, colModel) >
<cfset colModel = firstlevel & '__' & firsttable & '__RECDATECREATED' >
<cfset ArrayAppend(columnNameModel, colModel) >
<cfset colModel = firstlevel & '__' & firsttable & '__DATEACTIONWASDONE' >
<cfset ArrayAppend(columnNameModel, colModel) >
<cfset colModel = firstlevel & '__' & firsttable & '__DATELASTUPDATE' >
<cfset ArrayAppend(columnNameModel, colModel) > 

<cfset selectArray = ArrayNew(1) >
<cfset fromArray   = ArrayNew(1) >
<cfset whereArray  = ArrayNew(1) >
<cfset groupTable   = StructNew() >

<cfloop array="#columnNameModel#" index="formIndex" >
	
		<cfset theTableLevel = ListGetAt( formIndex, 1, "__" ) >
		<cfset theTableName  = ListGetAt( formIndex, 2, "__"  ) >
		<cfset theColumnName = ListGetAt( formIndex, 3, "__"  ) >
		
		<cfset client.dbms = "MYSQL" >
			<cfif theTableLevel eq "G" >
				<cfset theLevel = "#client.global_dsn#" >
			<cfelseif theTableLevel eq "C" >
				<cfset theLevel = "#client.company_dsn#" >			
			<cfelseif theTableLevel eq "S" >
				<cfset theLevel = "#client.subco_dsn#" >
			<cfelseif theTableLevel eq "Q" >
				<cfset theLevel = "#client.query_dsn#" >
			<cfelseif theTableLevel eq "T" >
				<cfset theLevel = "#client.transaction_dsn#" >
			<cfelseif theTableLevel eq "SD" >
				<cfset theLevel = "#client.site_dsn#" >
			<cfelse>
				<cfset theLevel = theTableLevel >
			</cfif>
		<cfif client.dbms eq "MSSQL" >
			<cfif theTableLevel eq "G" >
				<cfset theLevel = "#client.global_dsn#.dbo" >
			<cfelseif theTableLevel eq "C" >
				<cfset theLevel = "#client.company_dsn#.dbo" >			
			<cfelseif theTableLevel eq "S" >
				<cfset theLevel = "#client.subco_dsn#.dbo" >
			<cfelseif theTableLevel eq "Q" >
				<cfset theLevel = "#client.query_dsn#.dbo" >
			<cfelseif theTableLevel eq "T" >
				<cfset theLevel = "#client.transaction_dsn#.dbo" >
			<cfelseif theTableLevel eq "SD" >
				<cfset theLevel = "#client.site_dsn#.dbo" >
			<cfelse>
				<cfset theLevel = theTableLevel & ".dbo" >
			</cfif>
		<cfelse>
			<cfif theTableLevel eq "G" >
				<cfset theLevel = "#client.global_dsn#" >
			<cfelseif theTableLevel eq "C" >
				<cfset theLevel = "#client.company_dsn#" >			
			<cfelseif theTableLevel eq "S" >
				<cfset theLevel = "#client.subco_dsn#" >
			<cfelseif theTableLevel eq "Q" >
				<cfset theLevel = "#client.query_dsn#" >
			<cfelseif theTableLevel eq "T" >
				<cfset theLevel = "#client.transaction_dsn#" >
			<cfelseif theTableLevel eq "SD" >
				<cfset theLevel = "#client.site_dsn#" >
			<cfelse>
				<cfset theLevel = theTableLevel >
			</cfif>
		</cfif>
			
		
		 <!---ex. FIRSTNAME.FIRSTNAME AS C__CMFPA__FIRSNAME--->
		<cfset ArrayAppend(selectArray,"#theTableName#.#theColumnName# AS #formIndex#") >
		<cfif StructKeyExists(groupTable, '#theTableName#') >
			
		<cfelse>
			<!---ex. IBOSE_GLOBAL.CMFPA CMFPA OR IBOSE_GLOBAL.DBO.CMFPA CMFPA---> 
			<cfset ArrayAppend(fromArray,"#theLevel#.#theTableName# #theTableName#") >
			
			<!---ex CMFPA.PERSONNELIDNO = GMFPEOPLE.PERSONNELIDNO   delimited by AND--->
			<cfset ArrayAppend(whereArray,"#firsttable#.PERSONNELIDNO = #theTableName#.PERSONNELIDNO") >  
			<cfset groupTable['#theTableName#'] = "_" >
		</cfif>
		
</cfloop>

<cfset theSelection = ArrayToList(selectArray, ",") >
<cfset theTable      = ArrayToList(fromArray, ",") >
<cfset theCondition = ArrayToList(whereArray, " AND ") >

<cfif isnew eq "false" AND ispending eq "false" >
<cfset theQuery = "SELECT #theSelection# 
					FROM #theTable#
				   WHERE #theCondition# #theFilterCondition# AND #firsttable#.PERSONNELIDNO = '#client.chapa#'
				   ORDER BY #ORDERBY#">
<cfelseif isnew eq "true" >
	<!---query approver details and get an array of process id--->
	<cfset getprocessID = ORMExecuteQuery("SELECT A.PROCESSDETAILSID AS PROCESSID
	  								      FROM EGINFORMPROCESSDETAILS A,EGINROUTERDETAILS B,EGINAPPROVERDETAILS C
	 								      WHERE A.PROCESSDETAILSID = B.PROCESSIDFK 
	 								      		AND B.ROUTERDETAILSID = C.ROUTERIDFK 
	 								      		AND C.PERSONNELIDNO = '#client.chapa#'
	 								      		AND C.ISREAD = 'false'
	 								      		AND C.ACTION = 'CURRENT'", false) > 
	<cfset theQuery = "SELECT #theSelection#  
					     FROM #theTable#
					    WHERE #theCondition# #theFilterCondition# AND #firsttable#.EFORMID = '#eformid#' AND #firsttable#.PROCESSID IN ('#ArrayToList(getprocessID, "','")#')
					 ORDER BY #ORDERBY#">
					 
					 
<cfelseif ispending eq "true" > <!---get pending forms using the current PID---> 
	<cfset theQuery = "SELECT #theSelection# 
						FROM #theTable#
					   WHERE #theCondition# #theFilterCondition# AND #firsttable#.PERSONNELIDNO = '#client.chapa#'
					   ORDER BY #ORDERBY#">

	<!---query approver details and get an array of process id--->
	<cfset getprocessID = ORMExecuteQuery("SELECT A.PROCESSDETAILSID AS PROCESSID
	  								      FROM EGINFORMPROCESSDETAILS A,EGINROUTERDETAILS B,EGINAPPROVERDETAILS C
	 								      WHERE A.PROCESSDETAILSID = B.PROCESSIDFK 
	 								      		AND B.ROUTERDETAILSID = C.ROUTERIDFK 
	 								      		AND C.PERSONNELIDNO = '#client.chapa#'
	 								      		AND C.ISREAD = 'true'
	 								      		AND C.ACTION = 'CURRENT'", false) > 
	<cfset theQuery = "SELECT #theSelection#  
					     FROM #theTable#
					    WHERE #theCondition# #theFilterCondition# AND #firsttable#.EFORMID = '#eformid#' AND #firsttable#.PROCESSID IN ('#ArrayToList(getprocessID, "','")#')
					 ORDER BY #ORDERBY#">		   
</cfif>			   
<cfquery name="qryDynamic" datasource="#client.global_dsn#" >
	#preservesinglequotes(theQuery)#
</cfquery>
	  	
<!--- end generate script --->
	 <cfset resultArr = ArrayNew(1) >
	
	<cfset rootstuct = StructNew() >
	<cfset rootstuct['totalCount'] = qryDynamic.recordcount >
	
	<!---Creates an array of structure to be converted to JSON using serializeJSON--->
	<cfif start lt 1 >
		<cfset start = 1 >	
	</cfif>
	<cfloop query="qryDynamic" startrow="#start#" endrow="#start + limit#" >
		<cfset tmpresult = StructNew() > <!---Creates new structure in every loop to be added to the array--->
		
			<cfif getMainTableID[4] eq "true" >
				<cfloop array="#columnNameModel#" index="outIndex" > 
					<cftry>
						<cfset tmpresult['#outIndex#']      = decrypt(evaluate(outIndex), client.ek)  >
					<cfcatch>
						<cfset tmpresult['#outIndex#']      = evaluate(outIndex)  >
					</cfcatch>
					</cftry>
					
				</cfloop>
				
				<cfset tmpresult['#firstlevel#__#firsttable#__APPROVED']      = evaluate("#firstlevel#__#firsttable#__APPROVED")  >
				<cfset tmpresult['#firstlevel#__#firsttable#__EFORMID']      = evaluate("#firstlevel#__#firsttable#__EFORMID")  >
				<cfset tmpresult['#firstlevel#__#firsttable#__PROCESSID']      = evaluate("#firstlevel#__#firsttable#__PROCESSID")  >
				<cfset tmpresult['#firstlevel#__#firsttable#__ACTIONBY']      = evaluate("#firstlevel#__#firsttable#__ACTIONBY")  >
				<cfset tmpresult['#firstlevel#__#firsttable#__PERSONNELIDNO']      = evaluate("#firstlevel#__#firsttable#__PERSONNELIDNO")  >
				<cfset tmpresult['#firstlevel#__#firsttable#__RECDATECREATED']      = evaluate("#firstlevel#__#firsttable#__RECDATECREATED")  >
				<cfset tmpresult['#firstlevel#__#firsttable#__DATEACTIONWASDONE']      = evaluate("#firstlevel#__#firsttable#__DATEACTIONWASDONE")  >
				<cfset tmpresult['#firstlevel#__#firsttable#__DATELASTUPDATE']      = evaluate("#firstlevel#__#firsttable#__DATELASTUPDATE")  >
				<cfset tmpresult['thefilepath']      = "#client.domain#unDB/forms/#client.companycode#/"  >
			<cfelse>
				<cfloop array="#columnNameModel#" index="outIndex" >
					<cfset tmpresult['#outIndex#']      = evaluate(outIndex)  >	
				</cfloop>
				<cfset tmpresult['#firstlevel#__#firsttable#__APPROVED']      = evaluate("#firstlevel#__#firsttable#__APPROVED")  >
				<cfset tmpresult['#firstlevel#__#firsttable#__EFORMID']      = evaluate("#firstlevel#__#firsttable#__EFORMID")  >
				<cfset tmpresult['#firstlevel#__#firsttable#__PROCESSID']      = evaluate("#firstlevel#__#firsttable#__PROCESSID")  >
				<cfset tmpresult['#firstlevel#__#firsttable#__ACTIONBY']      = evaluate("#firstlevel#__#firsttable#__ACTIONBY")  >
				<cfset tmpresult['#firstlevel#__#firsttable#__PERSONNELIDNO']      = evaluate("#firstlevel#__#firsttable#__PERSONNELIDNO")  >
				<cfset tmpresult['#firstlevel#__#firsttable#__RECDATECREATED']      = evaluate("#firstlevel#__#firsttable#__RECDATECREATED")  >
				<cfset tmpresult['#firstlevel#__#firsttable#__DATEACTIONWASDONE']      = evaluate("#firstlevel#__#firsttable#__DATEACTIONWASDONE")  >
				<cfset tmpresult['#firstlevel#__#firsttable#__DATELASTUPDATE']      = evaluate("#firstlevel#__#firsttable#__DATELASTUPDATE")  >
				<cfset tmpresult['thefilepath']      = "#client.domain#unDB/forms/#client.companycode#/"  >
			</cfif>
		
		
	
		
		<cfset ArrayAppend(resultArr, tmpresult) >
	</cfloop>
	<cfset rootstuct['topics'] = resultArr > 
	<cfreturn rootstuct />
<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message >
</cfcatch>
</cftry>	
</cffunction>
	
	
	
	
	
	
	
	
<cffunction name="ColumnCreateNow" ExtDirect="true">
<cfargument name="datatocreate" >
<cftry>

<cfreturn datatocreate >
<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message >
</cfcatch>
</cftry>	
</cffunction>

<cffunction name="ColumnUpdateNow" ExtDirect="true">
<cfargument name="datatoupdate" >
<cftry>

<cfif isArray(datatoupdate) >
	<cfset datatoupdate = datatoupdate[1] >
</cfif>

<cfset processData = EntityLoad("EGRGIBOSETABLEFIELDS", #datatoupdate.COLUMNID#, true ) >
	
	<cfif isdefined("datatoupdate.COLUMNGROUP") >
		<cfset processData.setCOLUMNGROUP("#datatoupdate.COLUMNGROUP#") >
	<cfelse>
		<cfset processData.setCOLUMNGROUP("") >
	</cfif>
	<cfset processData.setCOLUMNNAME("#datatoupdate.COLUMNNAME#") >
	<cfset processData.setFIELDLABEL("#datatoupdate.FIELDLABEL#") >
	<cfset processData.setXTYPE("#datatoupdate.XTYPE#") >
	<cfset processData.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')#") >

<cfset EntitySave(processData) >
<cfset ormflush()>

<cfreturn datatoupdate.COLUMNNAME >

<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message >
</cfcatch>
</cftry>
</cffunction>


<cffunction name="ColumnDestroyNow" ExtDirect="true">
<cfargument name="datatodestroy" >
<cftry>
<cfif isArray(datatodestroy) >
<cfset arrayLen = ArrayLen(datatodestroy) >
    <cfloop from="1" to="#arrayLen#" index="dataIdx" step="1"  >
		<cfset processData = EntityLoad("EGRGIBOSETABLEFIELDS", #datatodestroy[dataIdx].COLUMNID#, true ) >
		<cfset EntityDelete(processData) >
	</cfloop>
<cfelse>
	<cfset processData = EntityLoad("EGRGIBOSETABLEFIELDS", #datatodestroy.COLUMNID#, true ) >
		<cfset EntityDelete(processData) >
</cfif>
<cfset ormflush()>

<cfreturn "success" >
<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message >
</cfcatch>
</cftry>
</cffunction>

</cfcomponent>