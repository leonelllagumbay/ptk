<cfcomponent name="defmain" ExtDirect="true">

<cffunction name="getDetails" ExtDirect="true">
	<cfreturn "empty" >
</cffunction>  

<cffunction name="sendemailNow" ExtDirect="true" ExtFormHandler="true">
<cftry>

<cfmail from="#form.to#"
		to="#form.to#"
		subject="#form.subject#" 
		type="html">
#form.body#
</cfmail>

<cfset returnStruct = StructNew() >
<cfset returnStruct['success'] = "true" >
<cfset returnStruct['data']=form.to >
<cfreturn returnStruct >
<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message > 
</cfcatch>
</cftry>
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
<cfset processData.setCOMPANYCODE("#client.companycode#") >
<cfset processData.setRECCREATEDBY("#client.userid#") > 
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
<cfset eformData.setRECCREATEDBY("client.userid") >
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
<cfset processData.setRECCREATEDBY("#client.userid#") >  
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
	
	<cfset processData.setRECCREATEDBY("#client.userid#") >  
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





</cfcomponent>