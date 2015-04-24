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

<cfif client.dbms eq "MSSQL" >
	<cfset dbsourceg = "#client.global_dsn#.dbo" >
	<cfset dbsourcec = "#client.company_dsn#.dbo" >
<cfelse>
	<cfset dbsourceg = "#client.global_dsn#" >
	<cfset dbsourcec = "#client.company_dsn#" >
</cfif>

<cfquery name="getPersonalEmail" datasource="#client.global_dsn#" maxrows="1" >
	SELECT A.FIRSTNAME AS FIRSTNAME, 
		   A.LASTNAME AS LASTNAME, 
		   A.MIDDLENAME AS MIDDLENAME,
		   B.AVATAR AS AVATAR,
		   E.PROFILENAME AS PROFILENAME,
		   C.DESCRIPTION AS POSITION,
		   D.DESCRIPTION AS DEPARTMENT
	  FROM #dbsourcec#.CMFPA A LEFT JOIN #dbsourcec#.ECRGMYIBOSE B ON (A.PERSONNELIDNO=B.PERSONNELIDNO)
	               LEFT JOIN #dbsourcec#.CLKPOSITION C  ON (A.POSITIONCODE=C.POSITIONCODE)
	               LEFT JOIN #dbsourcec#.CLKDEPARTMENT D ON (A.DEPARTMENTCODE=D.DEPARTMENTCODE)
	               LEFT JOIN EGRGUSERMASTER E ON (A.GUID=E.GUID)
	 WHERE A.PERSONNELIDNO IN ('#approverslist#') 
</cfquery>

<cfset emailArr = ArrayNew(1) >

<!---get the table data, using eformid and processid only--->
<cfinvoke method="getMainTableData" returnvariable="theformname" eformid="#eformid#" processid="#processid#" >
<cfif ArrayIsDefined(formGroup, 1) >
	<cfset fgroup = formGroup[1] > 
<cfelse>
	<cfset fgroup = "" >	 
</cfif>
<!--- end get the table data --->

<cfloop query="getPersonalEmail" >
	<cfset ArrayAppend(emailArr, PROFILENAME) >
</cfloop>
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
	
	<cfmail from="leonelllagumbay@gmail.com,#emaillist#"
			to="leonelllagumbay@gmail.com,#emaillist#,#extraRecipients#"
			subject="#theSubject#"
			type="html" 
			>
			<font color="Maroon" style="font: 21px Arial">#client.companyname#</font><br>
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
			</br>
			<a href="#client.domain#myapps/form/main/">Click here to view.</a>
			</br>
			Note: You need to sign on to your account to open the item.</br>
			
			
	</cfmail>
	
<cfreturn "success" >
</cffunction>


<cffunction name="getMainTableData" returntype="String" >

<cfset gettheForm = ORMExecuteQuery("SELECT A.EFORMNAME, 
											B.TABLENAME AS TABLENAME, 
											B.LEVELID AS LEVELID, 
											C.COLUMNNAME AS COLUMNNAME
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

<cfloop array="#gettheForm#" index="tableModel">
	<cfif trim(tableModel[4]) neq "" > <!---columnName with empty name is not qualified--->
		<cfset colModel = tableModel[3] & '__' & tableModel[2] & '__' & tableModel[4] > 
		<cfset ArrayAppend(columnNameModel, colModel) >
		<cfset ArrayAppend(columnNameReal, tableModel[4]) >  
	</cfif>
</cfloop>


<cfset colModel = firstlevel & '__' & firsttable & '__PERSONNELIDNO' >
<cfset ArrayAppend(columnNameModel, colModel) >
<cfset colModel = firstlevel & '__' & firsttable & '__DATEACTIONWASDONE' >
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



	<cfset theQuery = "SELECT #theSelection#  
					     FROM #theTable#
					    WHERE #theCondition# AND #firsttable#.EFORMID = '#eformid#' AND #firsttable#.PROCESSID = '#processid#'">		   
		   
<cfquery name="qryDynamic" datasource="#client.global_dsn#" maxrows="1" >
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
						<cfset ArrayAppend( propertyArr, columnNameReal[outIndex] ) > 
						<cfset ArrayAppend( valueArr, decrypt( evaluate( columnNameModel[outIndex] ), client.ek ) ) > 
					<cfcatch>
						<cfset ArrayAppend( propertyArr, columnNameReal[outIndex] ) > 
						<cfset ArrayAppend( valueArr, evaluate( columnNameModel[outIndex] ) ) >
					</cfcatch>
					</cftry>
					
				</cfloop>
				
				
			<cfelse>
				
				<cfset ArrayAppend( propertyArr, "Employee No" ) > 
				<cfset ArrayAppend( valueArr, evaluate("#firstlevel#__#firsttable#__PERSONNELIDNO") ) > 
				<cfset ArrayAppend( propertyArr, "Date Filed" ) > 
				<cfset ArrayAppend( valueArr, evaluate("#firstlevel#__#firsttable#__DATEACTIONWASDONE") ) >
				
				<cfloop from="1" to="#ArrayLen(columnNameReal)#" index="outIndex" > 
					
						<cfset ArrayAppend( propertyArr, columnNameReal[outIndex] ) > 
						<cfset ArrayAppend( valueArr, evaluate( columnNameModel[outIndex] ) ) >
					
				</cfloop>  
				
			</cfif>
		
	</cfloop>
	
	<cfreturn theformname />
	
</cffunction>




</cfcomponent>