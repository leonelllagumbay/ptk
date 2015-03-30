<cfcomponent displayname="email" hint="handles all email operation of eforms">

<cffunction name="notifyNextApprovers" >

<cfargument name="pidArray" >
<cfargument name="eformid" >
<cfargument name="processid" >
<cfargument name="extraRecipients" >
<cfargument name="status" >

<cfset formGroup = ArrayNew(1) >
<cfset propertyArr = ArrayNew(1) >
<cfset valueArr    = ArrayNew(1) >

<cfset approverslist = ArrayToList(pidArray, "','") >
<cfset approverslist = "'#approverslist#'" >

<cfif session.dbms eq "MSSQL" >
	<cfset dbsourceg = "#session.global_dsn#.dbo" >
	<cfset dbsourcec = "#session.company_dsn#.dbo" >
<cfelse>
	<cfset dbsourceg = "#session.global_dsn#" >
	<cfset dbsourcec = "#session.company_dsn#" >
</cfif>

<cfquery name="getPersonalEmail" datasource="#session.global_dsn#" >
	SELECT DISTINCT
		   A.FIRSTNAME AS FIRSTNAME,
		   A.LASTNAME AS LASTNAME,
		   A.MIDDLENAME AS MIDDLENAME,
		   B.AVATAR AS AVATAR,
		   E.PROFILENAME AS PROFILENAME,
		   C.DESCRIPTION AS POSITION,
		   D.DESCRIPTION AS DEPARTMENT
	  FROM #dbsourcec#.#session.maintable# A LEFT JOIN #dbsourcec#.ECRGMYIBOSE B ON (A.#session.mainpk#=B.PERSONNELIDNO)
	               LEFT JOIN #dbsourcec#.CLKPOSITION C  ON (A.POSITIONCODE=C.POSITIONCODE)
	               LEFT JOIN #dbsourcec#.CLKDEPARTMENT D ON (A.DEPARTMENTCODE=D.DEPARTMENTCODE)
	               LEFT JOIN EGRGUSERMASTER E ON (A.GUID=E.GUID)
	 WHERE A.#session.mainpk# IN (#preservesinglequotes(approverslist)#)
</cfquery>

<cfset emailArr = ArrayNew(1) >

<cfloop query="getPersonalEmail" >
	<cfset ArrayAppend(emailArr, getPersonalEmail.PROFILENAME) >
</cfloop>

<!---get the table data, using eformid and processid only--->
<cfinvoke method="getMainTableData" returnvariable="theformname" eformid="#eformid#" processid="#processid#" >
<cfif ArrayIsDefined(formGroup, 1) >
	<cfset fgroup = formGroup[1] >
<cfelse>
	<cfset fgroup = "" >
</cfif>
<!--- end get the table data --->


<cfset emaillist = ArrayToList(emailArr, ",") >

<cfif status eq 'PENDING' >
	<cfset theSubject = "My iBOS/e Notification | #theformname#" >
<cfelseif status eq 'APPROVED' >
	<cfset theSubject = "My iBOS/e Notification | 1 APPROVED #theformname#" >
<cfelseif status eq 'DISAPPROVED' >
	<cfset theSubject = "My iBOS/e Notification | 1 DISAPPROVED #theformname#" >
<cfelseif status eq 'RETURNED' >
	<cfset theSubject = "My iBOS/e Notification | 1 RETURNED #theformname#" >
<cfelse>
	<cfset theSubject = "My iBOS/e Notification | No Subject" >
</cfif>

	<cfmail from="#session.websiteemailadd#"
			to="#emaillist#,#extraRecipients#"
			subject="#theSubject#"
			type="html"
			>
			<font color="Maroon" style="font: 21px Arial">#session.companyname#</font><br>
			<table border="1" cellpadding="3" cellspacing="1" style="font: 13px Arial; border-collapse: collapse;" width = "550">
				<TR><TD width=30%><strong>Form Group</strong></TD><TD width=70%>#fgroup#</TD></TR>
				<TR><TD width=30%><strong>eForm</strong></TD><TD width=70%>#theformname#</TD></TR>
				<cfloop from="1" to="#ArrayLen(valueArr)#" index="propIndex" >
					<TR>
						<cftry>
						<TD width=30%>#propertyArr[propIndex]#</TD>
						<TD width=70%>#valueArr[propIndex]#</TD>
						<cfcatch>
							<cfcontinue>
						</cfcatch>
						</cftry>
					</TR>
			    </cfloop>

			</table>

			<p>
				<a href="#session.domain#?bdg=MAINUSRAPPF5038527-9F22-9981-A084244087E398BD">Click to <strong>Open</strong>.</a>
			</p>
			<cfif status eq 'PENDING' >
				<p>
					<a href="#session.domain#?bdg=MAINUSRAPPF5038527-9F22-9981-A084244087E398BD&eformid=#eformid#&actiontype=getneweforms&myvar=hi">Click to <strong>Approve or Disapprove</strong>.</a>
				</p>
			</cfif>
			<p>
			Note: You need to sign on to your account to open the item.
			</p>


	</cfmail>

<cfreturn "success" >
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
		<cfset colModel = tableModel[3] & '__' & tableModel[2] & '__' & tableModel[4] & '__' & tableModel[6]>
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
		<!---ex. FBC_CBOSE.CMFPA CMFPA OR FBC_CBOSE.DBO.CMFPA CMFPA--->
		<cfif theTableLevel eq 'G' >
        	<cfset ArrayAppend(fromArray,"#theTableName# #theTableName#") >
        <cfelse>
			<cfset ArrayAppend(fromArray,"#theLevel#.#theTableName# #theTableName#") >
        </cfif>

		<!---ex CMFPA.PERSONNELIDNO = GMFPEOPLE.PERSONNELIDNO   delimited by AND--->
		<cfif theTableType neq "LookupCard" >
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
			<cfset ArrayAppend( propertyArr, "Employee No" ) >
			<cfset ArrayAppend( valueArr, evaluate("#firstlevel#__#firsttable#__PERSONNELIDNO") ) >
			<cfset ArrayAppend( propertyArr, "Date Filed" ) >
			<cfset ArrayAppend( valueArr, evaluate("#firstlevel#__#firsttable#__DATEACTIONWASDONE") ) >
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