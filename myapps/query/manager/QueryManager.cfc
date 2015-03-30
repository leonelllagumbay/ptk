<cfcomponent name="QueryManager" ExtDirect="true">

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
	<cfset EQRYCODE = createUuid() >
	<cfset EQRYAUTHOR = "" >

	<cfif isArray(datatocreate) >
	    <cfset datatocreate = datatocreate[1] >
	</cfif>

    <cfif trim(datatocreate.EQRYCODE) neq "">
		<cfloop list="#datatocreate.EQRYCODE#" index="qryC" delimiters="," >
			<cfif trim(qryC) neq "">
				<cfset EQRYCODE = createUuid() >
				<cfset refQuery = EntityLoad("EGRGQUERY", qryC, true) >

				<cfset processData = EntityNew("EGRGQUERY") >
				<cfset processData.setEQRYCODE("#EQRYCODE#") >
				<cfset processData.setEQRYNAME("#refQuery.getEQRYNAME()# (Copy)") >
				<cfset processData.setEQRYDESCRIPTION("#refQuery.getEQRYDESCRIPTION()#") >
				<cfset processData.setEQRYAUTHOR("#refQuery.getEQRYAUTHOR()#") >
				<cfset processData.setEQRYBODY("#refQuery.getEQRYBODY()#") >
				<cfset processData.setRECDATECREATED("#refQuery.getRECDATECREATED()#") >
				<cfset processData.setDATELASTUPDATE("#CreateODBCDateTime(now())#") >

				<cfset EntitySave(processData) >
			</cfif>
		</cfloop>
		<cfset ormflush()>
	<cfelse>
		<cfset EQRYCODE = createUuid() >
		<cfset EQRYAUTHOR = session.chapa >

		<cfset processData = EntityNew("EGRGQUERY") >
		<cfset processData.setEQRYCODE("#EQRYCODE#") >
		<cfset processData.setEQRYNAME("#datatocreate.EQRYNAME#") >
		<cfset processData.setEQRYDESCRIPTION("#datatocreate.EQRYDESCRIPTION#") >
		<cfset processData.setEQRYAUTHOR("#EQRYAUTHOR#") >
		<cfset processData.setEQRYBODY("SELECT") >
		<cfset processData.setRECDATECREATED("#CreateODBCDateTime(now())#") >

		<cfset EntitySave(processData) >
		<cfset ormflush()>
	</cfif>

	<cfset retstruct = StructNew() >
	<cfset retstruct["EQRYCODE"] = EQRYCODE>
	<cfset retstruct["EQRYAUTHOR"] = EQRYAUTHOR>
	<cfreturn retstruct >
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

	<cfset processData = EntityLoad("EGRGQUERY", datatoupdate.EQRYCODE, true ) >
	<cfset processData.setEQRYNAME("#datatoupdate.EQRYNAME#") >
	<cfset processData.setEQRYDESCRIPTION("#datatoupdate.EQRYDESCRIPTION#") >
	<cfset processData.setDATELASTUPDATE("#CreateODBCDateTime(now())#") >
	<cfset EntitySave(processData) >
	<cfset ormflush()>

	<cfreturn datatoupdate.EQRYCODE >

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
		    <cfset processData = EntityLoad("EGRGQUERY", datatodestroy[dataIdx].EQRYCODE, true ) >
		    <cfif IsDefined("processData") >
				<cfset EntityDelete(processData) >
			</cfif>
		</cfloop>
	<cfelse>
		<cfset processData = EntityLoad("EGRGQUERY", datatodestroy.EQRYCODE, true ) >
		<cfset EntityDelete(processData) >
	</cfif>
	<cfset ormflush()>
	<cfreturn "success" >
<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message >
</cfcatch>
</cftry>
</cffunction>


<cffunction name="InsertQueryItems" ExtDirect="true" returntype="Any">
	<cfargument name="bdata" type="struct" >

    <cfset returnStruct = StructNew()>

	<!--- Delete first selected tables --->

	<cfquery name="qryTruncateTables" datasource="#session.global_dsn#">
		DELETE FROM EGRGEVIEWDATASOURCE
		 WHERE EQRYCODEFK = <cfqueryparam value="#bdata['querycode']#" cfsqltype="cf_sql_varchar">
	</cfquery>
	<cfquery name="qryTruncateTables" datasource="#session.global_dsn#">
		DELETE FROM EGRGEVIEWTABLES
		 WHERE EQRYCODEFK = <cfqueryparam value="#bdata['querycode']#" cfsqltype="cf_sql_varchar">
	</cfquery>
	<cfquery name="qryTruncateField" datasource="#session.global_dsn#">
		SELECT EVIEWFIELDCODE FROM EGRGEVIEWFIELDS
		 WHERE EQRYCODEFK = <cfqueryparam value="#bdata['querycode']#" cfsqltype="cf_sql_varchar">
	</cfquery>
	<cfloop query="qryTruncateField">
		<cfquery name="qryTruncateColumn" datasource="#session.global_dsn#">
			DELETE FROM EGRGQRYCOLUMN
			 WHERE EVIEWFIELDCODE = <cfqueryparam value="#qryTruncateField.EVIEWFIELDCODE#" cfsqltype="cf_sql_varchar">
		</cfquery>
	</cfloop>
	<cfquery name="qryTruncateTables" datasource="#session.global_dsn#">
		DELETE FROM EGRGEVIEWFIELDS
		 WHERE EQRYCODEFK = <cfqueryparam value="#bdata['querycode']#" cfsqltype="cf_sql_varchar">
	</cfquery>
	<cfquery name="qryTruncateTables" datasource="#session.global_dsn#">
		DELETE FROM EGRGEVIEWCONDITION
		 WHERE EQRYCODEFK = <cfqueryparam value="#bdata['querycode']#" cfsqltype="cf_sql_varchar">
	</cfquery>
	<cfquery name="qryTruncateTables" datasource="#session.global_dsn#">
		DELETE FROM EGRGEVIEWGROUPBY
		 WHERE EQRYCODEFK = <cfqueryparam value="#bdata['querycode']#" cfsqltype="cf_sql_varchar">
	</cfquery>
	<cfquery name="qryTruncateTables" datasource="#session.global_dsn#">
		DELETE FROM EGRGEVIEWHAVING
		 WHERE EQRYCODEFK = <cfqueryparam value="#bdata['querycode']#" cfsqltype="cf_sql_varchar">
	</cfquery>
	<cfquery name="qryTruncateTables" datasource="#session.global_dsn#">
		DELETE FROM EGRGEVIEWJOINEDTABLES
		 WHERE EQRYCODEFK = <cfqueryparam value="#bdata['querycode']#" cfsqltype="cf_sql_varchar">
	</cfquery>
	<cfquery name="qryTruncateTables" datasource="#session.global_dsn#">
		DELETE FROM EGRGEVIEWORDERBY
		 WHERE EQRYCODEFK = <cfqueryparam value="#bdata['querycode']#" cfsqltype="cf_sql_varchar">
	</cfquery>

	<!--- Insert new values to selected tables --->
	<cfloop from="1" to="#ArrayLen(bdata['selecteddatasource'])#" index="d">
		<cfset osrc = EntityNew("EGRGEVIEWDATASOURCE")>
		<cfset dscode = Createuuid() >
		<cfset osrc.setDATASOURCECODE(dscode)>
		<cfset osrc.setEQRYCODEFK(bdata["querycode"])>
		<cfset osrc.setCOLUMNORDER(d)>
		<cfset osrc.setDATASOURCETYPE(bdata['selecteddatasource'][d]['DATASOURCETYPE'])>
		<cfset osrc.setDATASOURCENAME(bdata['selecteddatasource'][d]['DATASOURCENAME'])>
		<cfset EntitySave(osrc) >
	</cfloop>
	<cfloop from="1" to="#ArrayLen(bdata['selectedtable'])#" index="f">
		<cfset fosrc = EntityNew("EGRGEVIEWTABLES")>
		<cfset tablecode = Createuuid()>
		<cfset fosrc.setEVIEWTABLECODE(tablecode)>
		<cfset fosrc.setEQRYCODEFK(bdata["querycode"])>
		<cfset fosrc.setCOLUMNORDER(f)>
		<cfset fosrc.setDATASOURCECODEFK(bdata['selectedtable'][f]['DATASOURCE'])>
		<cfset fosrc.setTABLENAME(bdata['selectedtable'][f]['TABLENAME'])>
		<cfset fosrc.setTEMPTABLE(bdata['selectedtable'][f]['TEMPTABLE'])>
		<cfset fosrc.setTABLEALIAS(bdata['selectedtable'][f]['TABLEALIAS'])>
		<cfset EntitySave(fosrc) >
	</cfloop>
	<cfloop from="1" to="#ArrayLen(bdata['selectedfield'])#" index="g">
		<cfset gosrc = EntityNew("EGRGEVIEWFIELDS")>
		<cfset dcolumn = EntityNew("EGRGQRYCOLUMN") >
		<cfset fieldcode = Createuuid()>
		<cfset gosrc.setEVIEWFIELDCODE(fieldcode)>
		<cfset dcolumn.setEVIEWFIELDCODE(fieldcode)>
		<cfset gosrc.setEQRYCODEFK(bdata["querycode"])>
		<cfset gosrc.setCOLUMNORDER(g)>
		<cfset gosrc.setTABLENAME(bdata['selectedfield'][g]['TABLENAME'])>
		<cfset gosrc.setFIELDNAME(bdata['selectedfield'][g]['FIELDNAME'])>
		<cfset gosrc.setDISPLAY(bdata['selectedfield'][g]['DISPLAY'])>
		<cfset gosrc.setFIELDALIAS(bdata['selectedfield'][g]['FIELDALIAS'])>
		<cfset gosrc.setPRIORITYNO(g)>
		<cfset gosrc.setAGGREGATEFUNC(bdata['selectedfield'][g]['AGGREGATEFUNC'])>
		<cfset gosrc.setDATEANDSTRINGFUNC(bdata['selectedfield'][g]['DATEANDSTRINGFUNC'])>
		<cfset gosrc.setNUMBERFORMAT(bdata['selectedfield'][g]['NUMBERFORMAT'])>
		<cfset gosrc.setISDISTINCT(bdata['selectedfield'][g]['ISDISTINCT'])>
		<cfset gosrc.setWRAPON(bdata['selectedfield'][g]['WRAPON'])>
		<cfset gosrc.setSUPPRESSZERO(bdata['selectedfield'][g]['SUPPRESSZERO'])>
		<cfset gosrc.setOVERRIDESTATEMENT(bdata['selectedfield'][g]['OVERRIDESTATEMENT'])>
		<cfset gosrc.setIS_PRIMARYKEY(bdata['selectedfield'][g]['IS_PRIMARYKEY'])>
		<cfset gosrc.setORDINAL_POSITION(bdata['selectedfield'][g]['ORDINAL_POSITION'])>
		<cfset gosrc.setTYPE_NAME(bdata['selectedfield'][g]['TYPE_NAME'])>
		<cfset gosrc.setDECIMAL_DIGITS(bdata['selectedfield'][g]['DECIMAL_DIGITS'])>
		<cfset gosrc.setIS_NULLABLE(bdata['selectedfield'][g]['IS_NULLABLE'])>
		<cfset gosrc.setCOLUMN_DEFAULT_VALUE(bdata['selectedfield'][g]['COLUMN_DEFAULT_VALUE'])>
		<cfset gosrc.setCHAR_OCTET_LENGTH(bdata['selectedfield'][g]['CHAR_OCTET_LENGTH'])>
		<cfset gosrc.setIS_FOREIGNKEY(bdata['selectedfield'][g]['IS_FOREIGNKEY'])>
		<cfset gosrc.setREFERENCED_PRIMARYKEY(bdata['selectedfield'][g]['REFERENCED_PRIMARYKEY'])>
		<cfset gosrc.setREFERENCED_PRIMARYKEY_TABLE(bdata['selectedfield'][g]['REFERENCED_PRIMARYKEY_TABLE'])>
		<cfset dcolumn.setEGRGEVIEWFIELDS(gosrc)>
		<cfset EntitySave(gosrc) >
		<cfset EntitySave(dcolumn) >
	</cfloop>
	<cfloop from="1" to="#ArrayLen(bdata['selectedjoin'])#" index="h">
		<cfset hosrc = EntityNew("EGRGEVIEWJOINEDTABLES")>
		<cfset fieldcode = Createuuid()>
		<cfset hosrc.setEVIEWJOINEDTABLECODE(fieldcode)>
		<cfset hosrc.setEQRYCODEFK(bdata["querycode"])>
		<cfset hosrc.setCOLUMNORDER(h)>
		<cfset hosrc.setPRIORITYNO(h)>
		<cfset hosrc.setJOINOPERATOR(bdata['selectedjoin'][h]['JOINOPERATOR'])>
		<cfset hosrc.setTABLENAME(bdata['selectedjoin'][h]['TABLENAME'])>
		<cfset hosrc.setONCOLUMN(bdata['selectedjoin'][h]['ONCOLUMN'])>
		<cfset hosrc.setEQUALTOCOLUMN(bdata['selectedjoin'][h]['EQUALTOCOLUMN'])>
		<cfset hosrc.setDISPLAY(bdata['selectedjoin'][h]['DISPLAY'])>
		<cfset EntitySave(hosrc) >
	</cfloop>
	<cfloop from="1" to="#ArrayLen(bdata['selectedcondition'])#" index="m">
		<cfset mosrc = EntityNew("EGRGEVIEWCONDITION")>
		<cfset fieldcode = Createuuid()>
		<cfset mosrc.setEVIEWCONDITIONCODE(fieldcode)>
		<cfset mosrc.setEQRYCODEFK(bdata["querycode"])>
		<cfset mosrc.setCOLUMNORDER(m)>
		<cfset mosrc.setPRIORITYNO(m)>
		<cfset mosrc.setCONJUNCTIVEOPERATOR(bdata['selectedcondition'][m]['CONJUNCTIVEOPERATOR'])>
		<cfset mosrc.setONCOLUMN(bdata['selectedcondition'][m]['ONCOLUMN'])>
		<cfset mosrc.setCONDITIONOPERATOR(bdata['selectedcondition'][m]['CONDITIONOPERATOR'])>
		<cfset mosrc.setCOLUMNVALUE(bdata['selectedcondition'][m]['COLUMNVALUE'])>
		<cfset EntitySave(mosrc) >
	</cfloop>
	<cfloop from="1" to="#ArrayLen(bdata['selectedgroupby'])#" index="n">
		<cfset nosrc = EntityNew("EGRGEVIEWGROUPBY")>
		<cfset fieldcode = Createuuid()>
		<cfset nosrc.setEVIEWGROUPBYCODE(fieldcode)>
		<cfset nosrc.setEQRYCODEFK(bdata["querycode"])>
		<cfset nosrc.setCOLUMNORDER(n)>
		<cfset nosrc.setPRIORITYNO(n)>
		<cfset nosrc.setGROUPBYCOLUMN(bdata['selectedgroupby'][n]['GROUPBYCOLUMN'])>
		<cfset EntitySave(nosrc) >
	</cfloop>
	<cfloop from="1" to="#ArrayLen(bdata['selectedhaving'])#" index="o">
		<cfset oosrc = EntityNew("EGRGEVIEWHAVING")>
		<cfset fieldcode = Createuuid()>
		<cfset oosrc.setEVIEWHAVINGCODE(fieldcode)>
		<cfset oosrc.setEQRYCODEFK(bdata["querycode"])>
		<cfset oosrc.setCOLUMNORDER(o)>
		<cfset oosrc.setPRIORITYNO(o)>
		<cfset oosrc.setCONJUNCTIVEOPERATOR(bdata['selectedhaving'][o]['CONJUNCTIVEOPERATOR'])>
		<cfset oosrc.setAGGREGATECOLUMN(bdata['selectedhaving'][o]['AGGREGATECOLUMN'])>
		<cfset oosrc.setCONDITIONOPERATOR(bdata['selectedhaving'][o]['CONDITIONOPERATOR'])>
		<cfset oosrc.setAGGREGATEVALUE(bdata['selectedhaving'][o]['AGGREGATEVALUE'])>
		<cfset oosrc.setDISPLAY(bdata['selectedhaving'][o]['DISPLAY'])>
		<cfset EntitySave(oosrc) >
	</cfloop>
	<cfloop from="1" to="#ArrayLen(bdata['selectedorderby'])#" index="p">
		<cfset posrc = EntityNew("EGRGEVIEWORDERBY")>
		<cfset fieldcode = Createuuid()>
		<cfset posrc.setEVIEWORDERBYCODE(fieldcode)>
		<cfset posrc.setEQRYCODEFK(bdata["querycode"])>
		<cfset posrc.setCOLUMNORDER(p)>
		<cfset posrc.setPRIORITYNO(p)>
		<cfset posrc.setFIELDNAME(bdata['selectedorderby'][p]['FIELDNAME'])>
		<cfset posrc.setDISPLAY(bdata['selectedorderby'][p]['DISPLAY'])>
		<cfset posrc.setASCORDESC(bdata['selectedorderby'][p]['ASCORDESC'])>
		<cfset EntitySave(posrc) >
	</cfloop>



	<cfset qry = EntityLoad("EGRGQUERY", bdata["querycode"], true) >

	<cfset qry.setEQRYBODY(bdata["cuteQuery"])>
	<cfset qry.setDATELASTUPDATE("#CreateODBCDateTime(now())#")>
	<cfset EntitySave(qry) >
	<cfset ormflush()>

	 <cfset returnStruct = bdata["querycode"]>
	 <cfreturn returnStruct >

</cffunction>

</cfcomponent>