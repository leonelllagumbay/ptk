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
<cfset processData.setVIEWAS("#datatocreate.VIEWAS#") >
<cfset processData.setFORMPADDING("#datatocreate.FORMPADDING#") >
<cfset processData.setGROUPMARGIN("#datatocreate.GROUPMARGIN#") >
<cfset processData.setBEFORELOAD("#datatocreate.BEFORELOAD#") >
<cfset processData.setAFTERLOAD("#datatocreate.AFTERLOAD#") >
<cfset processData.setBEFORESUBMIT("#datatocreate.BEFORESUBMIT#") >
<cfset processData.setAFTERSUBMIT("#datatocreate.AFTERSUBMIT#") >
<cfset processData.setBEFOREAPPROVE("#datatocreate.BEFOREAPPROVE#") >
<cfset processData.setAFTERAPPROVE("#datatocreate.AFTERAPPROVE#") >
<cfset processData.setONCOMPLETE("#datatocreate.ONCOMPLETE#") >
<cfset processData.setCOMPANYCODE("#datatocreate.COMPANYCODE#") >  
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
	<cfargument name="tableid" >
		
 	<cfset where             = "()" >
	 <cfif isdefined('query')>
	   <cfset WHERE =  "WHERE COLUMNNAME LIKE '%#query#%'" >
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
				<cfset WHERE =  "WHERE #PreserveSingleQuotes(where)# AND TABLEIDFK = '#tableid#'" >
			<cfelse>
				<cfset WHERE = "WHERE TABLEIDFK = '#tableid#'" >
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

<cfset processData = ORMExecuteQuery("FROM EGRGIBOSETABLEFIELDS #WHERE# ORDER BY #ORDERBY#", false, {offset=#start#, maxResults=#limit#, timeout=60} ) >

<cfset countAll = ORMExecuteQuery("FROM EGRGIBOSETABLEFIELDS #WHERE#" )> 
      

	<cfset ecounter = 1 >
	<cfset resultArr = ArrayNew(1) >
	
	<cfset rootstuct = StructNew() >
	<cfset rootstuct['totalCount'] = ArrayLen(countAll) >
	
	<!---Creates an array of structure to be converted to JSON using serializeJSON--->
	<cfloop array="#processData#" index="calIndex" >
		<cfset tmpresult = StructNew() > <!---Creates new structure in every loop to be added to the array--->
		<cfset tmpresult['COLUMNID']      = calIndex.getCOLUMNID()  >
		<cfset tmpresult['TABLEIDFK']      = calIndex.getTABLEIDFK()  >
		<cfset tmpresult['COLUMNNAME']      = calIndex.getCOLUMNNAME()  >
		<cfset tmpresult['FIELDLABEL']      = calIndex.getFIELDLABEL()  >
		<cfset tmpresult['FIELDLABELWIDTH']      = calIndex.getFIELDLABELWIDTH()  >
		<cfset tmpresult['COLUMNORDER']      = calIndex.getCOLUMNORDER()  > 
		<cfset tmpresult['COLUMNTYPE']      = calIndex.getCOLUMNTYPE()  >
		<cfset tmpresult['XTYPE']      = calIndex.getXTYPE()  >
		<cfset tmpresult['COLUMNGROUP']      = calIndex.getCOLUMNGROUP()  >
		<cfset tmpresult['FIELDLABELALIGN']      = calIndex.getFIELDLABELALIGN()  >
		<cfset tmpresult['ALLOWBLANK']      = calIndex.getALLOWBLANK()  >
		<cfset tmpresult['ISCHECKED']      = calIndex.getISCHECKED()  >
		<cfset tmpresult['CSSCLASS']      = calIndex.getCSSCLASS()  >
		<cfset tmpresult['ISDISABLED']      = calIndex.getISDISABLED()  >
		<cfset tmpresult['HEIGHT']      = calIndex.getHEIGHT()  >
		<cfset tmpresult['WIDTH']      = calIndex.getWIDTH()  >
		<cfset tmpresult['MININPUTVALUE']      = calIndex.getMININPUTVALUE()  >
		<cfset tmpresult['MAXINPUTVALUE']      = calIndex.getMAXINPUTVALUE()  >
		<cfset tmpresult['MINCHARLENGTH']      = calIndex.getMINCHARLENGTH()  >
		<cfset tmpresult['MAXCHARLENGTH']      = calIndex.getMAXCHARLENGTH()  >
		<cfset tmpresult['ISHIDDEN']      = calIndex.getISHIDDEN()  >
		<cfset tmpresult['INPUTID']      = calIndex.getINPUTID()  >
		<cfset tmpresult['MARGIN']      = calIndex.getMARGIN()  >
		<cfset tmpresult['PADDING']      = calIndex.getPADDING()  >
		<cfset tmpresult['BORDER']      = calIndex.getBORDER()  >
		<cfset tmpresult['STYLE']      = calIndex.getSTYLE()  >
		<cfset tmpresult['ISREADONLY']      = calIndex.getISREADONLY()  >
		<cfset tmpresult['UNCHECKEDVALUE']      = calIndex.getUNCHECKEDVALUE()  >
		<cfset tmpresult['INPUTVALUE']      = calIndex.getINPUTVALUE()  >
		<cfset tmpresult['VALIDATIONTYPE']      = calIndex.getVALIDATIONTYPE()  >
		<cfset tmpresult['VTYPETEXT']      = calIndex.getVTYPETEXT()  >
		<cfset tmpresult['RENDERER']      = calIndex.getRENDERER()  >
		<cfset tmpresult['XPOSITION']      = calIndex.getXPOSITION()  >
		<cfset tmpresult['YPOSITION']      = calIndex.getYPOSITION()  >
		<cfset tmpresult['ANCHORPOSITION']      = calIndex.getANCHORPOSITION()  >
		<cfset tmpresult['INPUTFORMAT']      = calIndex.getINPUTFORMAT()  >
		<cfset tmpresult['CHECKITEMS']      = calIndex.getCHECKITEMS()  >
		<cfset tmpresult['NOOFCOLUMNS']      = calIndex.getNOOFCOLUMNS()  >
		<cfset tmpresult['AUTOGENTEXT']      = calIndex.getAUTOGENTEXT()  >
		<cfset tmpresult['COMBOLOCALDATA']      = calIndex.getCOMBOLOCALDATA()  >
		<cfset tmpresult['COMBOREMOTEDATA']      = calIndex.getCOMBOREMOTEDATA()  >
		<cfset tmpresult['EDITABLEONROUTENO']      = calIndex.getEDITABLEONROUTENO()  >
		<cfset tmpresult['RECCREATEDBY']      = calIndex.getRECCREATEDBY()  >
		<cfset tmpresult['RECDATECREATED']      = calIndex.getRECDATECREATED()  >
		<cfset tmpresult['DATELASTUPDATE']      = calIndex.getDATELASTUPDATE()  >
		
		<cfset resultArr[ecounter] = tmpresult    >
		<cfset ecounter = ecounter + 1            >
	</cfloop>
	<cfset rootstuct['topics'] = resultArr > 
	<cfreturn rootstuct />	
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