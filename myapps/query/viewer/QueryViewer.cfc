<cfcomponent name="QueryViewer" Persistent="false" ExtDirect="true">

<cffunction name="ReadNow" ExtDirect="true">

	<cfargument name="page" >
	<cfargument name="start" >
	<cfargument name="limit" >
	<cfargument name="sort" >
	<cfargument name="filter" >
    <cfset theargs = StructNew() >
	<cfset theargs["page"] = page >
	<cfset theargs["start"] = start >
	<cfset theargs["limit"] = limit >
	<cfset theargs["sort"] = sort >
	<cfset theargs["filter"] = filter >
 	<cfinvoke component="IBOSE.application.GridQuery"
				method="buildCondition"
				argumentcollection="#theargs#" returnvariable="dresult">

	<cfset WHERE = dresult['where']>
	<cfset ORDERBY = dresult['orderby']>

<cfset processData = ORMExecuteQuery("FROM EGRGQUERY #WHERE# ORDER BY #ORDERBY#", false, {offset=#start#, maxResults=#limit#, timeout=150} ) >

<cfset countAll = ORMExecuteQuery("FROM EGRGQUERY #WHERE#" )>


	<cfset ecounter = 1 >
	<cfset resultArr = ArrayNew(1) >

	<cfset rootstuct = StructNew() >
	<cfset rootstuct['totalCount'] = ArrayLen(countAll) >

	<!---Creates an array of structure to be converted to JSON using serializeJSON--->
	<cfloop array="#processData#" index="calIndex" >
		<cfset tmpresult = StructNew() > <!---Creates new structure in every loop to be added to the array--->
		<cfset tmpresult['EQRYCODE']        	= calIndex.getEQRYCODE()  >
		<cfset tmpresult['EQRYNAME']      	= calIndex.getEQRYNAME() >
		<cfset tmpresult['EQRYDESCRIPTION']    	= calIndex.getEQRYDESCRIPTION()  >
		<cfset tmpresult['EQRYAUTHOR']    	= calIndex.getEQRYAUTHOR()  >
		<!---<cfset tmpresult['EQRYBODY'] = calIndex.getEQRYBODY()  > commented coz this might be a big query and will slow down the performance--->
		<cfset tmpresult['RECDATECREATED']     = calIndex.getRECDATECREATED()  >
		<cfset tmpresult['DATELASTUPDATE'] 			= calIndex.getDATELASTUPDATE()  >

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
<cfset processData.setRECCREATEDBY("#session.userid#") >
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

<cftry>
	<cfset processData.setONBEFOREDELETE("#datatoupdate.ONBEFOREDELETE#") >
	<cfcatch>
		<cfset processData.setONBEFOREDELETE("NA") >
	</cfcatch>
</cftry>
<cftry>
	<cfset processData.setONAFTERDELETE("#datatoupdate.ONAFTERDELETE#") >
	<cfcatch>
		<cfset processData.setONAFTERDELETE("NA") >
	</cfcatch>
</cftry>

<cftry>
	<cfset processData.setONBEFOREROUTE("#datatoupdate.ONBEFOREROUTE#") >
	<cfcatch>
		<cfset processData.setONBEFOREROUTE("NA") >
	</cfcatch>
</cftry>
<cftry>
	<cfset processData.setONAFTERROUTE("#datatoupdate.ONAFTERROUTE#") >
	<cfcatch>
		<cfset processData.setONAFTERROUTE("NA") >
	</cfcatch>
</cftry>


<cfset processData.setCOMPANYCODE("#session.companycode#") >
<cfset processData.setAUDITTDSOURCE("#datatoupdate.AUDITTDSOURCE#") >
<cfset processData.setAUDITTNAME("#datatoupdate.AUDITTNAME#") >
<cfset processData.setLOGDBSOURCE("#datatoupdate.LOGDBSOURCE#") >
<cfset processData.setLOGTABLENAME("#datatoupdate.LOGTABLENAME#") >
<cfset processData.setLOGFILENAME("#datatoupdate.LOGFILENAME#") >
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
	</cfif>
</cfif>
<cfset ormflush()>

<cfreturn "success" >

<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message >
</cfcatch>
</cftry>
</cffunction>

</cfcomponent>