<cfcomponent name="defmain" ExtDirect="true">

<cffunction name="getDetails" ExtDirect="true">
	<cfreturn "empty" >
</cffunction>

<cffunction name="getFormAsTable" ExtDirect="true">
<cfargument name="eformid" >
<cfargument name="processid" >

<cfset formGroup   = ArrayNew(1) >
<cfset propertyArr = ArrayNew(1) >
<cfset valueArr    = ArrayNew(1) >

	<cfset thecontent = "" >
	<cfinvoke method="getMainTableData" returnvariable="theformname" eformid="#eformid#" processid="#processid#" >
	<cfif ArrayIsDefined(formGroup, 1) >
		<cfset fgroup = formGroup[1] >
	<cfelse>
		<cfset fgroup = "" >
	</cfif>

	<cfset thecontent = thecontent & '<font color="Maroon" style="font: 15px Arial">#session.companyname#</font><br>' >
	<cfset thecontent = thecontent & '<table border="1" cellpadding="1" cellspacing="1" style="font: 10px Arial; border-collapse: collapse;" width = "550">' >
	<cfset thecontent = thecontent & '<TR><TD width=30%><strong>Form Group</strong></TD><TD width=70%>#fgroup#</TD></TR>' >
	<cfset thecontent = thecontent & '<TR><TD width=30%><strong>eForm</strong></TD><TD width=70%>#theformname#</TD></TR>' >
	<cfloop from="1" to="#ArrayLen(valueArr)#" index="propIndex" >
		<cftry>
			<cfset thecontent = thecontent & '<TR><TD width=30%>#propertyArr[propIndex]#</TD><TD width=70%>#valueArr[propIndex]#</TD></TR>' >
		<cfcatch>
			<cfcontinue>
		</cfcatch>
		</cftry>
	</cfloop>
	<cfset thecontent = thecontent & '</table>' >

	<cfreturn thecontent >
</cffunction>

<cffunction name="sendemailNow" ExtDirect="true" ExtFormHandler="true">
<cftry>
<cfset propertyArr=ArrayNew(1) >
<cfset valueArr=ArrayNew(1) >
<cfset formFilePath=ExpandPath("../../../unDB/forms/#session.companycode#/")>
<cfinvoke method="setMailParam" >

<cfmail from="#session.websiteemailadd#"
		to="#form.to#"
		subject="#form.subject#"
		type="html">
#form.body#
	   <cfif trim(form.enableAttachments) eq 'on' >
	   <cfinvoke method="setMailParam" >
	   <cfloop array="#valueArr#" index="valueInd" >
	   	    <cfif trim(valueInd) neq "" AND ucase(trim(valueInd)) neq "NO FILE" >
	   			<cfmailparam file="#formFilePath##valueInd#" remove="false" disposition="attachment">
	   	    </cfif>
	   </cfloop>
	   </cfif>
</cfmail>

<cfset returnStruct = StructNew() >
<cfset returnStruct['success'] = propertyArr >
<cfset returnStruct['data']=valueArr >
<cfreturn returnStruct >
<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message >
</cfcatch>
</cftry>
</cffunction>



<cffunction name="setMailParam" access="private" returnvalue="void" >
<cfset gettheForm = ORMExecuteQuery("SELECT A.EFORMNAME,
											B.TABLENAME AS TABLENAME,
											B.LEVELID AS LEVELID,
											C.COLUMNNAME AS COLUMNNAME,
											C.XTYPE AS XTYPE,
											B.TABLETYPE AS TABLETYPE,
											C.COLUMNORDER AS COLUMNORDER,
											B.LINKTABLETO AS LINKTABLETO,
											B.LINKINGCOLUMN AS LINKINGCOLUMN
	  								  FROM EGRGEFORMS A,EGRGIBOSETABLE B,EGRGIBOSETABLEFIELDS C
	  								WHERE EFORMID = '#form.eformid#' AND A.EFORMID = B.EFORMIDFK AND B.TABLEID = C.TABLEIDFK AND C.XTYPE='filefield'", false) >

<cfset getMainTableID = ORMExecuteQuery("SELECT B.TABLENAME AS TABLENAME,
												B.LEVELID AS LEVELID,
												C.COLUMNNAME AS COLUMNNAME,
												A.ISENCRYPTED AS ISENCRYPTED,
												A.EFORMNAME AS EFORMNAME,
												A.EFORMGROUP AS EFORMGROUP
	  								      FROM EGRGEFORMS A,EGRGIBOSETABLE B,EGRGIBOSETABLEFIELDS C
	 								      WHERE EFORMID = '#form.eformid#' AND A.EFORMID = B.EFORMIDFK AND B.TABLEID = C.TABLEIDFK AND C.XTYPE = 'id'", true) >



<cfif trim(getMainTableID[1]) neq "" >
	<cfset firsttable  = getMainTableID[1] >
	<cfset firstlevel  = getMainTableID[2] >
	<cfset firstcolumn = getMainTableID[3] >
	<cfset theformname = getMainTableID[5] >
<cfelse>
	<cfthrow detail="Table has no id specified in table fields. At least one field type is an id type." >
</cfif>


<cfset columnNameModel = ArrayNew(1)  >
<cfset columnNameReal = ArrayNew(1)  >
<cfset lookupLink = ArrayNew(1)  >
<cfset lookupTable = ArrayNew(1)  >
<cfset linkingTable = ArrayNew(1)  >
<cfset linkingColumn = ArrayNew(1)  >

<cfloop array="#gettheForm#" index="tableModel">
	<cfif trim(tableModel[4]) neq ""> <!---columnName with empty name is not qualified--->
		<cfset colModel = tableModel[3] & '__' & tableModel[2] & '__' & tableModel[4] & '__' & tableModel[6]>
		<cfset ArrayAppend(columnNameModel, colModel) >
		<cfset ArrayAppend(columnNameReal, tableModel[4]) >
		<cfif tableModel[6] eq "LookupCard" AND tableModel[7] eq 1 >
			<cfset ArrayAppend(lookupLink,tableModel[4]) >
			<cfset ArrayAppend(lookupTable,tableModel[2]) >
			<cfset ArrayAppend(linkingTable,tableModel[8]) >
			<cfset ArrayAppend(linkingColumn,tableModel[9]) >
		<cfelse>
	    </cfif>
	</cfif>
</cfloop>

<cfset selectArray = ArrayNew(1) >
<cfset fromArray   = ArrayNew(1) >
<cfset whereArray  = ArrayNew(1) >
<cfset groupTable   = StructNew() >

<cfloop array="#columnNameModel#" index="formIndex" >
	<cfset formIndArr = ArrayNew(1) >
	<cfset formIndArr = ListToArray(formIndex , "__", true, true) >
	<cfset theTableLevel = formIndArr[1] >
	<cfset theTableName  = formIndArr[2] >
	<cfset theColumnName = formIndArr[3] >
	<cfset theTableType = formIndArr[4] >

	<cfinvoke component="routing" method="getDatasource" tablelevel="#theTableLevel#" returnvariable="theLevel" >


	 <!---ex. FIRSTNAME.FIRSTNAME AS C__CMFPA__FIRSNAME--->
	<cfset ArrayAppend(selectArray,"#theTableName#.#theColumnName# AS #theTableLevel#__#theTableName#__#theColumnName#") >
	<cfif StructKeyExists(groupTable, '#theTableName#') >

	<cfelse>
		<!---ex. IBOSE_GLOBAL.CMFPA CMFPA OR IBOSE_GLOBAL.DBO.CMFPA CMFPA--->
		<cfif theTableLevel eq 'G' >
        	<cfset ArrayAppend(fromArray,"#theTableName# #theTableName#") >
        <cfelse>
			<cfset ArrayAppend(fromArray,"#theLevel#.#theTableName# #theTableName#") >
        </cfif>
		<cfif theTableType neq "LookupCard" >
			<!---ex CMFPA.PERSONNELIDNO = GMFPEOPLE.PERSONNELIDNO   delimited by AND--->
			<cfset ArrayAppend(whereArray,"#firsttable#.PERSONNELIDNO = #theTableName#.PERSONNELIDNO") >
		</cfif>

		<cfset groupTable['#theTableName#'] = "_" >
	</cfif>

</cfloop>

<cfif ArrayLen(lookupLink) gte 1 >
	<cfloop from="1" to="#ArrayLen(lookupLink)#" index="lookupInd">
		<cfset ArrayAppend(whereArray,"#linkingTable[lookupInd]#.#linkingColumn[lookupInd]# = #lookupTable[lookupInd]#.#lookupLink[lookupInd]#") >
	</cfloop>
</cfif>

<cfset theSelection = ArrayToList(selectArray, ",") >
<cfset theTable      = ArrayToList(fromArray, ",") >
<cfset theCondition = ArrayToList(whereArray, " AND ") >


<cfset theQuery = "SELECT #theSelection#
					     FROM #theTable#
					    WHERE #theCondition# AND #firsttable#.EFORMID = '#eformid#' AND #firsttable#.PROCESSID = '#form.processid#'">

<cfquery name="qryDynamic" datasource="#session.global_dsn#" maxrows="1" >
	#preservesinglequotes(theQuery)#
</cfquery>

<!--- end generate script --->

	<!---Creates an array of structure to be converted to JSON using serializeJSON--->

<cfloop query="qryDynamic" >
	<cfif getMainTableID[4] eq "true" >
			<cfloop from="1" to="#ArrayLen(columnNameReal)#" index="outIndex" >
				<cftry>
					<cfset colName = ListDeleteAt(columnNameModel[outIndex],4,'__') >
					<cfcatch>
					<cfset colName = columnNameModel[outIndex] >
					</cfcatch>
				</cftry>
				<cftry>
					<cfset ArrayAppend( propertyArr, columnNameReal[outIndex] ) >
					<cfset ArrayAppend( valueArr, decrypt( evaluate( colName ), session.ek ) ) >
				<cfcatch>
					<cfset ArrayAppend( propertyArr, columnNameReal[outIndex] ) >
					<cfset ArrayAppend( valueArr, evaluate( colName ) ) >
				</cfcatch>
				</cftry>
			</cfloop>
	<cfelse>
			<cfloop from="1" to="#ArrayLen(columnNameReal)#" index="outIndex" >
				<cftry>
					<cfset colName = ListDeleteAt(columnNameModel[outIndex],4,'__') >
					<cfcatch>
					<cfset colName = columnNameModel[outIndex] >
					</cfcatch>
				</cftry>
				<cfset ArrayAppend( propertyArr, columnNameReal[outIndex] ) >
				<cfset ArrayAppend( valueArr, evaluate( colName ) ) >
			</cfloop>
	</cfif>
</cfloop>

</cffunction>



<cffunction name="submitRecords" ExtDirect="true" ExtFormHandler="true">
<cftry>
<cfset eformid = createuuid() >
<cfset processData = EntityNew("EGRGEFORMS") >
<cfset processData.setEFORMID("#eformid#") >
<cfset processData.setEFORMNAME("#form.EFORMNAME#") >
<cfset processData.setDESCRIPTION("#form.DESCRIPTION#") >
<cfset processData.setEFORMGROUP("#form.EFORMGROUP#") >
<cfset processData.setFORMFLOWPROCESS("#form.FORMFLOWPROCESS#") >
<cfset processData.setLAYOUTQUERY("_") >
<cfset processData.setVIEWAS("#form.VIEWAS#") >
<cfset processData.setFORMPADDING("#form.FORMPADDING#") >
<cfset processData.setGROUPMARGIN("#form.GROUPMARGIN#") >
<cfset processData.setBEFORELOAD("#form.BEFORELOAD#") >
<cfset processData.setAFTERLOAD("#form.AFTERLOAD#") >
<cfset processData.setBEFORESUBMIT("#form.BEFORESUBMIT#") >
<cfset processData.setAFTERSUBMIT("#form.AFTERSUBMIT#") >
<cfset processData.setBEFOREAPPROVE("#form.BEFOREAPPROVE#") >
<cfset processData.setAFTERAPPROVE("#form.AFTERAPPROVE#") >
<cfset processData.setONCOMPLETE("#form.ONCOMPLETE#") >
<cfset processData.setCOMPANYCODE("#session.companycode#") >
<cfset processData.setRECCREATEDBY("#session.userid#") >
<cfset processData.setRECDATECREATED("#dateformat(now(), 'YYYY-MM-DD')#") >
<cfset processData.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')#") >

<cfset EntitySave(processData) >
<!---also update the egineformtable--->

<cfset eformData = EntityNew("EGINEFORMTABLE") >
<cfset eformData.setEFORMTABLEID("#createuuid()#") >
<cfset eformData.setPROCESSIDFK("#form.FORMFLOWPROCESS#") >
<cfset eformData.setEFORMIDFK("#eformid#") >
<cfset eformData.setMAINTABLEIDFK("_") >
<cfset eformData.setSTATUS("NEW") >
<cfset eformData.setRECCREATEDBY("session.userid") >
<cfset eformData.setRECDATECREATED("#dateformat(now(), 'YYYY-MM-DD')#") >
<cfset eformData.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')#") >
<cfset EntitySave(eformData) >

<cfset ormflush()>

<cfset returnStruct = StructNew() >
<cfset returnStruct['success'] = "true" >
<cfset returnStruct['data']=form.EFORMNAME >
<cfreturn returnStruct >
<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message >
</cfcatch>
</cftry>
</cffunction>




<cffunction name="getTableDetails" ExtDirect="true">
	<cfreturn "empty" >
</cffunction>

<cffunction name="submitTableRecords" ExtDirect="true" ExtFormHandler="true">
<cftry>

<cfset processData = EntityNew("EGRGIBOSETABLE") >
<cfset processData.setTABLEID("#createuuid()#") >
<cfset processData.setEFORMIDFK("#form.EFORMIDFK#") >
<cfset processData.setTABLENAME("#form.TABLENAME#") >
<cfset processData.setDESCRIPTION("#form.DESCRIPTION#") >
<cfset processData.setLINKTABLETO("#form.LINKTABLETO#") >
<cfset processData.setLINKINGCOLUMN("#form.LINKINGCOLUMN#") >
<cfset processData.setTABLETYPE("#form.TABLETYPE#") >
<cfset processData.setLEVELID("#form.LEVELID#") >
<cfset processData.setRECCREATEDBY("#session.userid#") >
<cfset processData.setRECDATECREATED("#dateformat(now(), 'YYYY-MM-DD')#") >
<cfset processData.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')#") >

<cfset EntitySave(processData) >
<cfset ormflush()>

<cfset returnStruct = StructNew() >
<cfset returnStruct['success'] = "true" >
<cfset returnStruct['data']=form.TABLENAME >
<cfreturn returnStruct >
<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message >
</cfcatch>
</cftry>
</cffunction>



<cffunction name="submitCopyTableTo" ExtDirect="true" ExtFormHandler="true">
<cftry>


	<cfset tableid = createuuid() >
	<cfset processDataB = EntityNew("EGRGIBOSETABLE") >
	<cfset processDataB.setTABLEID("#tableid#") >
	<cfset processDataB.setEFORMIDFK("#form.EFORMIDFK2#") >
	<cfset processDataB.setTABLENAME("#form.TABLENAME#_COPY") >
	<cfset processDataB.setDESCRIPTION("#form.DESCRIPTION#") >
	<cfset processDataB.setLINKTABLETO("#form.LINKTABLETO#") >
	<cfset processDataB.setLINKINGCOLUMN("#form.LINKINGCOLUMN#") >
	<cfset processDataB.setTABLETYPE("#form.TABLETYPE#") >
	<cfset processDataB.setLEVELID("#form.LEVELID#") >
	<cfset processDataB.setRECCREATEDBY("#form.RECCREATEDBY#") >
	<cfset processDataB.setRECDATECREATED("#dateformat(now(), 'YYYY-MM-DD')#") >
	<cfset processDataB.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')#") >

	<cfset processDataC = EntityLoad("EGRGIBOSETABLEFIELDS", {TABLEIDFK = #form.TABLEID#} ) >
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

<cfset returnStruct = StructNew() >
<cfset returnStruct['success'] = "true" >
<cfset returnStruct['data']=form.EFORMIDFK2 >
<cfreturn returnStruct >
<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message >
</cfcatch>
</cftry>
</cffunction>




<cffunction name="submitColumnRecords" ExtDirect="true" ExtFormHandler="true">
<cftry>

<cfif form.actiontype EQ 'add' >
	<cfset processData = EntityNew("EGRGIBOSETABLEFIELDS") >
	<cfset processData.setCOLUMNID("#createuuid()#") >
	<cfset processData.setTABLEIDFK("#form.tableid#") >
	<cfset processData.setALLOWBLANK("#form.ALLOWBLANK#") >
	<cfset processData.setANCHORPOSITION("#form.ANCHORPOSITION#") >
	<cfset processData.setBORDER("#form.BORDER#") >
	<cfset processData.setISCHECKED("#form.ISCHECKED#") >
	<cfset processData.setCOLUMNGROUP("#form.COLUMNGROUP#") >
	<cfset processData.setCOLUMNNAME("#form.COLUMNNAME#") >
	<cfset processData.setCOLUMNORDER("#form.COLUMNORDER#") >
	<cfset processData.setCOLUMNTYPE("#form.COLUMNTYPE#") >
	<cfset processData.setCSSCLASS("#form.CSSCLASS#") >
	<cfset processData.setISDISABLED("#form.ISDISABLED#") >
	<cfset processData.setFIELDLABEL("#form.FIELDLABEL#") >
	<cfset processData.setFIELDLABELALIGN("#form.FIELDLABELALIGN#") >
	<cfset processData.setFIELDLABELWIDTH("#form.FIELDLABELWIDTH#") >
	<cfset processData.setINPUTFORMAT("#form.INPUTFORMAT#") >
	<cfset processData.setHEIGHT("#form.HEIGHT#") >
	<cfset processData.setISHIDDEN("#form.ISHIDDEN#") >
	<cfset processData.setMARGIN("#form.MARGIN#") >
	<cfset processData.setMAXCHARLENGTH("#form.MAXCHARLENGTH#") >
	<cfset processData.setMAXINPUTVALUE("#form.MAXINPUTVALUE#") >
	<cfset processData.setMINCHARLENGTH("#form.MINCHARLENGTH#") >
	<cfset processData.setMININPUTVALUE("#form.MININPUTVALUE#") >
	<cfset processData.setPADDING("#form.PADDING#") >
	<cfset processData.setISREADONLY("#form.ISREADONLY#") >
	<cfset processData.setRENDERER("#form.RENDERER#") >
	<cfset processData.setSTYLE("#form.STYLE#") >
	<cfset processData.setUNCHECKEDVALUE("#form.UNCHECKEDVALUE#") >
	<cfset processData.setVALIDATIONTYPE("#form.VALIDATIONTYPE#") >
	<cfset processData.setINPUTVALUE("#form.INPUTVALUE#") >
	<cfset processData.setVTYPETEXT("#form.VTYPETEXT#") >
	<cfset processData.setWIDTH("#form.WIDTH#") >
	<cfset processData.setXPOSITION("#form.XPOSITION#") >
	<cfset processData.setXTYPE("#form.XTYPE#") >
	<cfset processData.setYPOSITION("#form.YPOSITION#") >

	<cfset processData.setCHECKITEMS("#form.CHECKITEMS#") >
	<cfset processData.setNOOFCOLUMNS("#form.NOOFCOLUMNS#") >
	<cfset processData.setAUTOGENTEXT("#form.AUTOGENTEXT#") >
	<cfset processData.setCOMBOLOCALDATA("#form.COMBOLOCALDATA#") >
	<cfset processData.setCOMBOREMOTEDATA("#form.COMBOREMOTEDATA#") >
	<cfset processData.setEDITABLEONROUTENO("#form.EDITABLEONROUTENO#") >

	<cfset processData.setRECCREATEDBY("#session.userid#") >
	<cfset processData.setRECDATECREATED("#dateformat(now(), 'YYYY-MM-DD')#") >
	<cfset processData.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')#") >
<cfelse>
	<cfset processData = EntityLoad("EGRGIBOSETABLEFIELDS", #form.COLUMNID#, true) >
	<cfset processData.setTABLEIDFK("#form.TABLEIDFK#") >
	<cfset processData.setALLOWBLANK("#form.ALLOWBLANK#") >
	<cfset processData.setANCHORPOSITION("#form.ANCHORPOSITION#") >
	<cfset processData.setBORDER("#form.BORDER#") >
	<cfset processData.setISCHECKED("#form.ISCHECKED#") >
	<cfset processData.setCOLUMNGROUP("#form.COLUMNGROUP#") >
	<cfset processData.setCOLUMNNAME("#form.COLUMNNAME#") >
	<cfset processData.setCOLUMNORDER("#form.COLUMNORDER#") >
	<cfset processData.setCOLUMNTYPE("#form.COLUMNTYPE#") >
	<cfset processData.setCSSCLASS("#form.CSSCLASS#") >
	<cfset processData.setISDISABLED("#form.ISDISABLED#") >
	<cfset processData.setFIELDLABEL("#form.FIELDLABEL#") >
	<cfset processData.setFIELDLABELALIGN("#form.FIELDLABELALIGN#") >
	<cfset processData.setFIELDLABELWIDTH("#form.FIELDLABELWIDTH#") >
	<cfset processData.setINPUTFORMAT("#form.INPUTFORMAT#") >
	<cfset processData.setHEIGHT("#form.HEIGHT#") >
	<cfset processData.setISHIDDEN("#form.ISHIDDEN#") >
	<cfset processData.setMARGIN("#form.MARGIN#") >
	<cfset processData.setMAXCHARLENGTH("#form.MAXCHARLENGTH#") >
	<cfset processData.setMAXINPUTVALUE("#form.MAXINPUTVALUE#") >
	<cfset processData.setMINCHARLENGTH("#form.MINCHARLENGTH#") >
	<cfset processData.setMININPUTVALUE("#form.MININPUTVALUE#") >
	<cfset processData.setPADDING("#form.PADDING#") >
	<cfset processData.setISREADONLY("#form.ISREADONLY#") >
	<cfset processData.setRENDERER("#form.RENDERER#") >
	<cfset processData.setSTYLE("#form.STYLE#") >
	<cfset processData.setUNCHECKEDVALUE("#form.UNCHECKEDVALUE#") >
	<cfset processData.setVALIDATIONTYPE("#form.VALIDATIONTYPE#") >
	<cfset processData.setINPUTVALUE("#form.INPUTVALUE#") >
	<cfset processData.setVTYPETEXT("#form.VTYPETEXT#") >
	<cfset processData.setWIDTH("#form.WIDTH#") >
	<cfset processData.setXPOSITION("#form.XPOSITION#") >
	<cfset processData.setXTYPE("#form.XTYPE#") >
	<cfset processData.setYPOSITION("#form.YPOSITION#") >
	<cfset processData.setCHECKITEMS("#form.CHECKITEMS#") >
	<cfset processData.setNOOFCOLUMNS("#form.NOOFCOLUMNS#") >
	<cfset processData.setAUTOGENTEXT("#form.AUTOGENTEXT#") >
	<cfset processData.setCOMBOLOCALDATA("#form.COMBOLOCALDATA#") >
	<cfset processData.setCOMBOREMOTEDATA("#form.COMBOREMOTEDATA#") >
	<cfset processData.setEDITABLEONROUTENO("#form.EDITABLEONROUTENO#") >
	<cfset processData.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')#") >

</cfif>

<cfset EntitySave(processData) >
<cfset ormflush()>

<cfset returnStruct = StructNew() >
<cfset returnStruct['success'] = "true" >
<cfset returnStruct['data']=form.TABLEIDFK >
<cfreturn returnStruct >
<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message >
</cfcatch>
</cftry>
</cffunction>


<cffunction name="getMainTableData" returntype="String" >

<cfset gettheForm = ORMExecuteQuery("SELECT A.EFORMNAME,
											B.TABLENAME AS TABLENAME,
											B.LEVELID AS LEVELID,
											C.COLUMNNAME AS COLUMNNAME,
											C.FIELDLABEL AS FIELDLABEL,
											B.TABLETYPE AS TABLETYPE,
											C.COLUMNORDER AS COLUMNORDER,
											B.LINKTABLETO AS LINKTABLETO,
											B.LINKINGCOLUMN AS LINKINGCOLUMN
	  								  FROM EGRGEFORMS A,EGRGIBOSETABLE B,EGRGIBOSETABLEFIELDS C
	  								WHERE EFORMID = '#eformid#' AND A.EFORMID = B.EFORMIDFK AND B.TABLEID = C.TABLEIDFK", false) >

<cfset getMainTableID = ORMExecuteQuery("SELECT B.TABLENAME AS TABLENAME,
												B.LEVELID AS LEVELID,
												C.COLUMNNAME AS COLUMNNAME,
												A.ISENCRYPTED AS ISENCRYPTED,
												A.EFORMNAME AS EFORMNAME,
												A.EFORMGROUP AS EFORMGROUP
	  								      FROM EGRGEFORMS A,EGRGIBOSETABLE B,EGRGIBOSETABLEFIELDS C
	 								      WHERE EFORMID = '#eformid#' AND A.EFORMID = B.EFORMIDFK AND B.TABLEID = C.TABLEIDFK AND C.XTYPE = 'id'", true) >



<cfif trim(getMainTableID[1]) neq "" >
	<cfset firsttable  = getMainTableID[1] >
	<cfset firstlevel  = getMainTableID[2] >
	<cfset firstcolumn = getMainTableID[3] >
	<cfset theformname = getMainTableID[5] >
	<cfset ArrayAppend(formGroup, getMainTableID[6] ) >
<cfelse>
	<cfthrow detail="Table has no id specified in table fields. At least one field type is an id type." >
</cfif>


<cfset columnNameModel = ArrayNew(1)  >
<cfset columnNameReal = ArrayNew(1)  >
<cfset lookupLink = ArrayNew(1)  >
<cfset lookupTable = ArrayNew(1)  >
<cfset linkingTable = ArrayNew(1)  >
<cfset linkingColumn = ArrayNew(1)  >

<cfloop array="#gettheForm#" index="tableModel">
	<cfif trim(tableModel[4]) neq "" > <!---columnName with empty name is not qualified--->
		<cfset colModel = tableModel[3] & '__' & tableModel[2] & '__' & tableModel[4] & '__' & tableModel[6] >
		<cfset ArrayAppend(columnNameModel, colModel) >
		<cfset ArrayAppend(columnNameReal, tableModel[5]) >
		<cfif tableModel[6] eq "LookupCard" AND tableModel[7] eq 1 >
			<cfset ArrayAppend(lookupLink,tableModel[4]) >
			<cfset ArrayAppend(lookupTable,tableModel[2]) >
			<cfset ArrayAppend(linkingTable,tableModel[8]) >
			<cfset ArrayAppend(linkingColumn,tableModel[9]) >
		<cfelse>
	    </cfif>
	</cfif>
</cfloop>


<cfset colModel = firstlevel & '__' & firsttable & '__PERSONNELIDNO__X' >
<cfset ArrayAppend(columnNameModel, colModel) >
<cfset colModel = firstlevel & '__' & firsttable & '__DATEACTIONWASDONE__X' >
<cfset ArrayAppend(columnNameModel, colModel) >
<cfset colModel = firstlevel & '__' & firsttable & '__APPROVED__X' >
<cfset ArrayAppend(columnNameModel, colModel) >

<cfset selectArray = ArrayNew(1) >
<cfset fromArray   = ArrayNew(1) >
<cfset whereArray  = ArrayNew(1) >
<cfset groupTable   = StructNew() >

<cfloop array="#columnNameModel#" index="formIndex" >
	<cfset formIndArr = ArrayNew(1) >
	<cfset formIndArr = ListToArray(formIndex , "__", true, true) >
	<cfset theTableLevel = formIndArr[1] >
	<cfset theTableName  = formIndArr[2] >
	<cfset theColumnName = formIndArr[3] >
	<cfset theTableType = formIndArr[4] >

		<cfinvoke component="routing" method="getDatasource" tablelevel="#theTableLevel#" returnvariable="theLevel" >


		 <!---ex. FIRSTNAME.FIRSTNAME AS C__CMFPA__FIRSNAME--->
		<cfset ArrayAppend(selectArray,"#theTableName#.#theColumnName# AS #theTableLevel#__#theTableName#__#theColumnName#") >
		<cfif StructKeyExists(groupTable, '#theTableName#') >

		<cfelse>
			<!---ex. IBOSE_GLOBAL.CMFPA CMFPA OR IBOSE_GLOBAL.DBO.CMFPA CMFPA--->
			<cfif theTableLevel eq 'G' >
            	<cfset ArrayAppend(fromArray,"#theTableName# #theTableName#") >
            <cfelse>
				<cfset ArrayAppend(fromArray,"#theLevel#.#theTableName# #theTableName#") >
            </cfif>
			<cfif theTableType neq "LookupCard" >
				<!---ex CMFPA.PERSONNELIDNO = GMFPEOPLE.PERSONNELIDNO   delimited by AND--->
				<cfset ArrayAppend(whereArray,"#firsttable#.PERSONNELIDNO = #theTableName#.PERSONNELIDNO") >
			</cfif>

			<cfset groupTable['#theTableName#'] = "_" >
		</cfif>

</cfloop>

<cfif ArrayLen(lookupLink) gte 1 >
	<cfloop from="1" to="#ArrayLen(lookupLink)#" index="lookupInd">
		<cfset ArrayAppend(whereArray,"#linkingTable[lookupInd]#.#linkingColumn[lookupInd]# = #lookupTable[lookupInd]#.#lookupLink[lookupInd]#") >
	</cfloop>
</cfif>

<cfset theSelection = ArrayToList(selectArray, ",") >
<cfset theTable      = ArrayToList(fromArray, ",") >
<cfset theCondition = ArrayToList(whereArray, " AND ") >



	<cfset theQuery = "SELECT #theSelection#
					     FROM #theTable#
					    WHERE #theCondition# AND #firsttable#.EFORMID = '#eformid#' AND #firsttable#.PROCESSID = '#processid#'">

<cfquery name="qryDynamic" datasource="#session.global_dsn#" maxrows="1" >
	#preservesinglequotes(theQuery)#
</cfquery>

<!--- end generate script --->

	<!---Creates an array of structure to be converted to JSON using serializeJSON--->

	<cfloop query="qryDynamic" >

			<cfif getMainTableID[4] eq "true" >

				<cfset ArrayAppend( propertyArr, "Employee No" ) >
				<cfset ArrayAppend( valueArr, evaluate("#firstlevel#__#firsttable#__PERSONNELIDNO") ) >
				<cfset ArrayAppend( propertyArr, "Date Filed" ) >
				<cfset ArrayAppend( valueArr, evaluate("#firstlevel#__#firsttable#__DATEACTIONWASDONE") ) >
				<cfset ArrayAppend( propertyArr, "Approved" ) >
				<cfset ArrayAppend( valueArr, evaluate("#firstlevel#__#firsttable#__APPROVED") ) >



				<cfloop from="1" to="#ArrayLen(columnNameReal)#" index="outIndex" >
					<cftry>
						<cfset colName = ListDeleteAt(columnNameModel[outIndex],4,'__') >
						<cfcatch>
						<cfset colName = columnNameModel[outIndex] >
						</cfcatch>
					</cftry>
					<cftry>
						<cfset ArrayAppend( propertyArr, columnNameReal[outIndex] ) >
						<cfset ArrayAppend( valueArr, decrypt( evaluate( colName ), session.ek ) ) >
					<cfcatch>
						<cfset ArrayAppend( propertyArr, columnNameReal[listInd] ) >
						<cfset ArrayAppend( valueArr, evaluate( colName ) ) >
					</cfcatch>
					</cftry>

				</cfloop>
			<cfelse>

				<cfset ArrayAppend( propertyArr, "Employee No" ) >
				<cfset ArrayAppend( valueArr, evaluate("#firstlevel#__#firsttable#__PERSONNELIDNO") ) >
				<cfset ArrayAppend( propertyArr, "Date Filed" ) >
				<cfset ArrayAppend( valueArr, evaluate("#firstlevel#__#firsttable#__DATEACTIONWASDONE") ) >
				<cfset ArrayAppend( propertyArr, "Approved" ) >
				<cfset ArrayAppend( valueArr, evaluate("#firstlevel#__#firsttable#__APPROVED") ) >

				<cfloop from="1" to="#ArrayLen(columnNameReal)#" index="outIndex" >
					<cftry>
						<cfset colName = ListDeleteAt(columnNameModel[outIndex],4,'__') >
						<cfcatch>
						<cfset colName = columnNameModel[outIndex] >
						</cfcatch>
					</cftry>
					<cfset ArrayAppend( propertyArr, columnNameReal[outIndex] ) >
					<cfset ArrayAppend( valueArr, evaluate( colName ) ) >
				</cfloop>

			</cfif>

	</cfloop>

	<cfreturn theformname />

</cffunction>


</cfcomponent>