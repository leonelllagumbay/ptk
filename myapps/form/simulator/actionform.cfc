<cfcomponent name="actionform" ExtDirect="true" >

<cffunction name="load" ExtDirect="true" >
	<cfargument name="eformid" >
<cftry>

	<cfset gettheForm = ORMExecuteQuery("SELECT A.EFORMNAME,
												B.TABLENAME AS TABLENAME,
												B.LEVELID AS LEVELID,
												C.COLUMNNAME AS COLUMNNAME,
												C.AUTOGENTEXT AS AUTOGENTEXT,
												C.XTYPE AS XTYPE,
												C.INPUTVALUE AS INPUTVALUE,
												A.BEFORELOAD AS BEFORELOAD,
												B.TABLETYPE AS TABLETYPE,
												C.COLUMNORDER AS COLUMNORDER,
												B.LINKTABLETO AS LINKTABLETO,
												B.LINKINGCOLUMN AS LINKINGCOLUMN
	  								       FROM EGRGEFORMS A,EGRGIBOSETABLE B,EGRGIBOSETABLEFIELDS C
	  								      WHERE EFORMID = '#eformid#' AND A.EFORMID = B.EFORMIDFK AND B.TABLEID = C.TABLEIDFK", false) >

	<cfset getMainTableID = ORMExecuteQuery("SELECT B.TABLENAME AS TABLENAME, B.LEVELID AS LEVELID, C.COLUMNNAME AS COLUMNNAME, A.ISENCRYPTED AS ISENCRYPTED
	  								           FROM EGRGEFORMS A,EGRGIBOSETABLE B,EGRGIBOSETABLEFIELDS C
	 								          WHERE A.EFORMID = '#eformid#' AND A.EFORMID = B.EFORMIDFK AND B.TABLEID = C.TABLEIDFK AND C.XTYPE = 'id'", true) >


<cfif trim(getMainTableID[1]) neq "" >
	<cfset firsttable  = getMainTableID[1] >
	<cfset firstlevel  = getMainTableID[2] >
	<cfset firstcolumn = getMainTableID[3] >
<cfelse>
	<cfthrow detail="Table has no id specified in table fields. At least one field type is an id type." >
</cfif>


<cfset columnNameModel = ArrayNew(1)  >
<cfset columnAutoGenCol    = ArrayNew(1)  >
<cfset columnAutoGenVal    = ArrayNew(1)  >
<cfset lookupLink = ArrayNew(1)  >
<cfset lookupTable = ArrayNew(1)  >
<cfset linkingTable = ArrayNew(1)  >
<cfset linkingColumn = ArrayNew(1)  >

<!---establish the fields alias name for grid dataindex and form name--->

<cfloop array="#gettheForm#" index="tableModel">
	<cftry>
	<cfset tableModel[5] = tableModel[5] >
	<cfcatch>
    	<cfset tableModel[5] = "" >
    </cfcatch>
    </cftry>
	<cfif trim(tableModel[4]) neq "" >  <!---columnName with empty name is not qualified--->
		<cfset colModel = tableModel[3] & '__' & tableModel[2] & '__' & tableModel[4] & '__' & tableModel[9] >

		<!---display fields with value are not included. --->
		<cfif tableModel[6] eq 'displayfield' AND firsttable neq tableModel[2] AND trim(tableModel[7]) eq "" AND trim(tableModel[5]) eq "">
			<cfset ArrayAppend(columnNameModel, colModel) >
		</cfif>

		<cfif trim(tableModel[5]) neq "" > <!---autogen text has a value--->
			<cfset ArrayAppend(columnNameModel, colModel) >
			<cfset ArrayAppend(columnAutoGenCol, colModel) >
			<cfset ArrayAppend(columnAutoGenVal, trim(tableModel[5])) >
		</cfif>
		<cfif tableModel[9] eq "LookupCard" AND tableModel[10] eq 1 >
			<cfset ArrayAppend(lookupLink,tableModel[4]) >
			<cfset ArrayAppend(lookupTable,tableModel[2]) >
			<cfset ArrayAppend(linkingTable,tableModel[11]) >
			<cfset ArrayAppend(linkingColumn,tableModel[12]) >
		<cfelse>
	    </cfif>
	</cfif>

	<cfset beforeload = tableModel[8] >

</cfloop>



<cfset selectArray = ArrayNew(1) >
<cfset fromArray   = ArrayNew(1) >
<cfset whereArray  = ArrayNew(1) >
<cfset groupTable  = StructNew() >
<cfset tmpresult   = StructNew() >

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

			<!---ex CMFPA.PERSONNELIDNO = GMFPEOPLE.PERSONNELIDNO   delimited by AND--->
			<cfif theTableType neq "LookupCard" >
				<cfset ArrayAppend(whereArray,"#theTableName#.PERSONNELIDNO = '#session.chapa#'") >
			</cfif>
			<cfset groupTable['#theTableName#'] = "_" >
		</cfif>
</cfloop>

<cfif ArrayLen(lookupLink) gte 1 >
	<cfloop from="1" to="#ArrayLen(lookupLink)#" index="lookupInd">
		<cfset ArrayAppend(whereArray,"#linkingTable[lookupInd]#.#linkingColumn[lookupInd]# = #lookupTable[lookupInd]#.#lookupLink[lookupInd]#") >
	</cfloop>
</cfif>

<cfif ArrayLen(selectArray) gt 0 >
		<cfset theSelection = ArrayToList(selectArray, ",") >
		<cfset theTable      = ArrayToList(fromArray, ",") >
		<cfset theCondition = ArrayToList(whereArray, " AND ") >


		<cfset theQuery = "SELECT #theSelection#
							 FROM #theTable#
						    WHERE #theCondition#"
	    >

		<!---<cfreturn gettheForm >--->
		<cfquery name="qryDynamic" datasource="#session.global_dsn#" maxrows="1">
			#preservesinglequotes(theQuery)#
		</cfquery>

		<!--- end generate script --->
			<cfset rootstuct = StructNew() >


			<cfloop query="qryDynamic" startrow="1" endrow="1" >
				<cfset tmpresult = StructNew() > <!---Creates new structure in every loop to be added to the array--->

					<cfloop array="#columnNameModel#" index="outIndex" >
						<cftry>
							<cfset listInd = ListDeleteAt(outIndex,4,'__') >
							<cfcatch>
							<cfset listInd = outIndex >
							</cfcatch>
						</cftry>
						<cfset tmpresult['#listInd#']      = evaluate(listInd)  >
					</cfloop>

			</cfloop>
</cfif> <!---end arraylen	--->

	<cfloop from="1" to="#ArrayLen(columnAutoGenCol)#" index="cntr" >
		<cfset autogencolname = columnAutoGenCol[cntr] >
		<cfset autogencolvalue = columnAutoGenVal[cntr] >
		<cfset newVal = replace(autogencolvalue,"{UUID}", createuuid(), "all") >
		<cfset newVal = replace(newVal,"{DATE}", dateformat(now(),"YYYYMMDD"), "all") >
		<cfset newVal = replace(newVal,"{TIME}", dateformat(now(),"HHMMSS"), "all") >
		<cfset newVal = replace(newVal,"{DATEFORMAT}", dateformat(now(),"YYYY-MM-DD"), "all") >
		<cfset newVal = replace(newVal,"{TIMEFORMAT}", timeformat(now(),"short"), "all") >
		<cfset newVal = replace(newVal,"{LOGO}", "#session.icon_path##session.site_ibose#", "all") >

		<cfset newVal = replace(newVal,"{d}", dateformat(now(),"d"), "all") >
		<cfset newVal = replace(newVal,"{dd}", dateformat(now(),"dd"), "all") >
		<cfset newVal = replace(newVal,"{ddd}", dateformat(now(),"ddd"), "all") >
		<cfset newVal = replace(newVal,"{dddd}", dateformat(now(),"dddd"), "all") >
		<cfset newVal = replace(newVal,"{m}", dateformat(now(),"m"), "all") >
		<cfset newVal = replace(newVal,"{mm}", dateformat(now(),"mm"), "all") >
		<cfset newVal = replace(newVal,"{mmm}", dateformat(now(),"mmm"), "all") >
		<cfset newVal = replace(newVal,"{mmmm}", dateformat(now(),"mmmm"), "all") >
		<cfset newVal = replace(newVal,"{yy}", dateformat(now(),"yy"), "all") >
		<cfset newVal = replace(newVal,"{yyyy}", dateformat(now(),"yyyy"), "all") >
		<cfset newVal = replace(newVal,"{gg}", dateformat(now(),"gg"), "all") >
		<cfset newVal = replace(newVal,"{short}", dateformat(now(),"short"), "all") >
		<cfset newVal = replace(newVal,"{medium}", dateformat(now(),"medium"), "all") >
		<cfset newVal = replace(newVal,"{long}", dateformat(now(),"long"), "all") >
		<cfset newVal = replace(newVal,"{full}", dateformat(now(),"full"), "all") >

		<cfset newVal = replace(newVal,"{PID}", session.chapa, "all") >
		<cfset newVal = replace(newVal,"{FIRSTNAME}", session.firstname, "all") >
		<cfset newVal = replace(newVal,"{LASTNAME}", session.lastname, "all") >
		<cfset newVal = replace(newVal,"{MIDDLENAME}", session.middlename, "all") >
		<cfset newVal = replace(newVal,"{COMPANYCODE}", session.companycode, "all") >
		<cfset newVal = replace(newVal,"{COMPANYNAME}", session.companyname, "all") >

		<cfif find('seed=', newVal) AND find('step=', newVal)>
			<cfinvoke method="autoIncrement" eformid="#eformid#">
		</cfif>

		<cfloop condition = "find('{RANDOM}',newVal)">
		    <cfset stringList= createuuid() >
			<cfset stringList= replace(stringList,"-", "", "all") >
		    <cfset rndNum    = RandRange(1, len(stringList))>
			<cfset leftStr   = left(stringList,rndNum) >
			<cfset rndString = right(leftStr,1)>
			<cfset newVal    = replace(newVal,'{RANDOM}', rndString) >
		</cfloop>

		<cfloop condition = "find('{NUMBER}',newVal)">

			<cfset zerocnt = 0 >
			<cfset zerostr = "" >
			<cfset pos = find('{NUMBER}',newVal) >
			<cfif pos gt 1>
				<cfloop condition="right(left(newVal,pos-1),1) eq 0" >
					<cfset pos = pos - 1 >
					<cfoutput>a#pos#a</cfoutput><br>
					<cfset zerocnt = zerocnt + 1 >
					<cfset zerostr = "#zerostr#" & "0" >
					<cfif pos lt 2>
						<cfbreak>
					</cfif>
				</cfloop>
			<cfelseif pos eq 0 >
				<cfbreak>
			</cfif>

			<cfif zerocnt eq 0 >
				<cfset rndNum    = RandRange(1, 1000000000) >
				<cfset rndNum    = numberformat(rndNum, '0000000000') >
				<cfset newVal    = replace(newVal,'{NUMBER}', right(rndNum, 5)) >
			<cfelseif zerocnt gt 10 >
				<cfset rndNum    = RandRange(1, 1000000000) >
				<cfset rndNum    = numberformat(rndNum, '0000000000') >
				<cfset newVal    = replace(newVal,'#zerostr#{NUMBER}', right(rndNum, 10)) >
			<cfelse>
				<cfset rndNum    = RandRange(1, 1000000000) >
				<cfset rndNum    = numberformat(rndNum, '0000000000') >
				<cfset newVal    = replace(newVal,'#zerostr#{NUMBER}', right(rndNum, zerocnt)) >
			</cfif>

		</cfloop>
		<cftry>
			<cfset listInd = ListDeleteAt(autogencolname,5,"__") >
		<cfcatch>
			<cftry>
				<cfset listInd = ListDeleteAt(autogencolname,4,"__") >
				<cfcatch>
				<cfset listInd = autogencolname >
				</cfcatch>
			</cftry>
		</cfcatch>
		</cftry>
		<cfset tmpresult['#listInd#'] =  newVal>
	</cfloop>


	<!---execute eform's before load process--->
	<cfif beforeload neq "NA" AND beforeload neq "">
		<cfinclude template="../fielddefinition/beforeload/#beforeload#" >
	</cfif>
	<!---end before load process, afterload is found in data.cfc--->


	<cfset returnStruct = StructNew() >

	<cfset returnStruct['success'] = "true" >
	<cfset returnStruct['data']   = tmpresult >
	<cfreturn returnStruct >
<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message >
</cfcatch>
</cftry>
</cffunction>


<cffunction name="autoIncrement" access="private" returntype="void" >
	<cfargument name="eformid" >
	<!---format = {seed=num step=num format=0000}--->
	<cfset incVal = 0 >
	<cfset seedPos = find("seed=", newVal) >
	<cfset stepPos = find("step=", newVal) >
	<cfset formatPos = find("format=", newVal) >

	<cfset theLeftBracePos = 0 >
	<cfset theRightBracePos = find("}", newVal, seedPos) >
	<cfloop from="#seedPos#" to="1" index="counter" step="-1">
		<cfset substringA = newVal.substring(counter,counter + 1) >
		<cfif substringA eq "{" >
			<cfset theLeftBracePos = counter >
			<cfbreak>
		</cfif>
	</cfloop>

	<cfset theAutoIncStr = trim(newVal.substring(theLeftBracePos,theRightBracePos)) >

	<cfset seedVal = trim(newVal.substring(seedPos-1,stepPos-1)) >
	<cfset seedRef = find("=", seedVal) >
	<cfset seedValNow = trim(seedVal.substring(seedRef)) >

	<cfset stepVal = trim(newVal.substring(stepPos-1,formatPos-1)) >
	<cfset stepRef = find("=", stepVal) >
	<cfset stepValNow = trim(stepVal.substring(stepRef)) >

	<cfset formatVal = trim(newVal.substring(formatPos-1,theRightBracePos-1)) >
	<cfset formatRef = find("=", formatVal) >
	<cfset formatValNow = trim(formatVal.substring(formatRef)) >

	<cfquery name="getLastContent" datasource="#session.global_dsn#" >
		SELECT LASTCOUNT
		  FROM EGINAUTOINCREMENT
		 WHERE EFORMID = '#eformid#';
	</cfquery>

	<cfif getLastContent.recordCount lt 1 >
		<cfset incVal = seedValNow >
		<cfquery name="getLastContent" datasource="#session.global_dsn#" >
			INSERT INTO EGINAUTOINCREMENT (EFORMID,LASTCOUNT,INCREMENTVALUE)
			VALUES (
			  	<cfqueryparam cfsqltype="cf_sql_varchar" value="#eformid#">,
			  	<cfqueryparam cfsqltype="cf_sql_integer" value="#incVal#">,
			  	<cfqueryparam cfsqltype="cf_sql_integer" value="#stepValNow#">
			  );
		</cfquery>
	<cfelse>
		<cfset incVal = val(getLastContent.LASTCOUNT) >
		<cfquery name="updateAutoInc" datasource="#session.global_dsn#" >
			UPDATE EGINAUTOINCREMENT
			   SET INCREMENTVALUE = <cfqueryparam cfsqltype="cf_sql_integer" value="#stepValNow#">
			 WHERE EFORMID = '#eformid#';
		</cfquery>
	</cfif>

	<cfset newVal = replace(newVal,"#theAutoIncStr#", numberFormat(incVal,formatValNow), "all") >

</cffunction>


<cffunction name="submit" ExtDirect="true" ExtFormHandler="true">

<cftry>



<cfset returnStruct = StructNew() >

<cfif form.action eq "save" >
	<cftry>
		<cfinvoke method="saveForm"  >
		<cfinvoke method="logActivity" theaction="Successfully edited an eForm: #form.eformid#, process id: #theProcessCond#" >
		<cfset returnStruct['success'] = "true" >
		<cfset returnStruct['data']   = form.eformid >
		<cfreturn returnStruct>
	<cfcatch>
		<cfinvoke method="logActivity" theaction="eForm editing error: #form.eformid#, Details: #cfcatch.detail#, Message: #cfcatch.message#" >
		<cfreturn cfcatch.detail & ' ' & cfcatch.message >
	</cfcatch>
	</cftry>
</cfif>

<cfif form.action eq "approve" >
	<cftry>
		<cfinvoke method="saveForm"  >
		<cfinvoke method="approveForm"  >
		<cfinvoke method="logActivity" theaction="Successfully approved an eForm: #form.eformid#, process id: #theProcessCond#" >
		<cfinvoke method="updateProcess"  >
		<cfset returnStruct['success'] = "true" >
		<cfset returnStruct['data']   = form.eformid >
		<cfreturn returnStruct>
	<cfcatch>
		<cfinvoke method="rollbackAction"  >
		<cfinvoke method="logActivity" theaction="eForm approving error: #form.eformid#, Details: #cfcatch.detail#, Message: #cfcatch.message#" >
		<cfreturn cfcatch.detail & ' ' & cfcatch.message >
	</cfcatch>
	</cftry>
</cfif>


<cfif form.action eq "disapprove" >
	<cftry>
		<cfinvoke method="saveForm"  >
		<cfinvoke method="disapproveForm"  >
		<cfinvoke method="logActivity" theaction="Successfully disapproved an eForm: #form.eformid#, process id: #theProcessCond#" >
		<cfinvoke method="updateProcess"  >
		<cfset returnStruct['success'] = "true" >
		<cfset returnStruct['data']   = form.eformid >
		<cfreturn returnStruct>
	<cfcatch>
		<cfinvoke method="rollbackAction"  >
		<cfinvoke method="logActivity" theaction="eForm disapproving error: #form.eformid#, Details: #cfcatch.detail#, Message: #cfcatch.message#" >
		<cfreturn cfcatch.detail & ' ' & cfcatch.message >
	</cfcatch>
	</cftry>
</cfif>


<cfif form.action eq "returntooriginator" >
	<cftry>
		<cfinvoke method="saveForm"  >
		<cfinvoke method="sentBacktoOriginatorForm"  >
		<cfinvoke method="logActivity" theaction="Successfully returned an eForm to originator: #form.eformid#, process id: #theProcessCond#" >
		<cfinvoke method="updateProcess"  >
		<cfset returnStruct['success'] = "true" >
		<cfset returnStruct['data']   = form.eformid >
		<cfreturn returnStruct>
	<cfcatch>
		<cfinvoke method="rollbackAction"  >
		<cfinvoke method="logActivity" theaction="eForm returning to originator error: #form.eformid#, Details: #cfcatch.detail#, Message: #cfcatch.message#" >
		<cfreturn cfcatch.detail & ' ' & cfcatch.message >
	</cfcatch>
	</cftry>
</cfif>


<!--- Set up an array to hold errors. --->
<cfset arrErrors = ArrayNew( 1 ) />

<cfif ListGetAt(form.withFile, 1) eq "true" >
	<cfset formDir = ExpandPath( "../../../unDB/forms/#session.companycode#/" ) />
	<cftry>
		<cfif Not directoryExists(formDir) >
            <cfdirectory action="create" directory="#formDir#" mode="777" >
        </cfif>
    <cfcatch></cfcatch>
    </cftry>

<cfset REQUEST.UploadPath = formDir />
<cfset REQUEST.FileCount = ListGetAt(form.fileCount, 1) >


<!--- Param the appropriate number of file fields. --->
<cfloop
	index="intFileIndex"
	from="1"
	to="#REQUEST.FileCount#"
	step="1">

	<!--- Param file value. --->
	<cfparam
		name="FORM.file#intFileIndex#"
		type="string"
		default=""
		/>

</cfloop>


<!--- Check to see if the form has been submitted. --->
<!---<cfif FORM.submitted>--->

	<!---
		Here is where we would validate the data; however,
		in this example, there really isn't anything to
		validate. In order to validate something, we are going
		to require at least one file to be uploaded!
	--->


	<!---
		Since we are going to require at least one file, I am
		going to start off with an error statement. Then, I am
		gonna let the form tell me to DELETE IT.
	--->
	<cfset ArrayAppend(
		arrErrors,
		"No files selected."
		) />


	<!--- Loop over the files looking for a valid one. --->
	<cfloop
		index="intFileIndex"
		from="1"
		to="#REQUEST.FileCount#"
		step="1">

		<cfif Len( FORM[ "file#intFileIndex#" ] )>

			<!--- Clear the errors array. --->
			<cfset ArrayClear( arrErrors ) />

			<!--- Break out of loop. --->
			<cfbreak />

		</cfif>

	</cfloop>


	<!---
		Check to see if there were any form validation
		errors. If there are no errors, then we can continue
		to process the form. Otherwise, we are going to skip
		this and just let the page render again.
	--->
	<cfif NOT ArrayLen( arrErrors )>

		<!---
			Create an array to hold the list of uploaded
			files.
		--->
		<cfset arrUploaded = ArrayNew( 1 ) />
		<cfset arrServerFile = ArrayNew( 1 ) />

		<!---
			Loop over the form fields and upload the files
			that are valid (have a length).
		--->
		<cfloop
			index="intFileIndex"
			from="1"
			to="#REQUEST.FileCount#"
			step="1">

			<!--- Check to see if file has a length. --->
			<cfif Len( FORM[ "file#intFileIndex#" ] )>

				<!---
					When uploading, remember to use a CFTry /
					CFCatch as complications might be encountered.
				--->
				<cftry>
					<cffile
						action="upload"
						destination="#REQUEST.UploadPath#"
						filefield="file#intFileIndex#"
						nameconflict="makeunique"
						/>

					<!---
						Store this file name in the uploaded file
						array so we can reference it later.
					--->

					<cfset appendtext   = right(createuuid(),7) >
					<cffile action      = "rename"
				    		source      = "#REQUEST.UploadPath##cffile.serverfile#"
		            		destination = "#REQUEST.UploadPath##cffile.serverfilename#__#appendtext#.#cffile.clientfileext#"
		            		attributes  ="normal">

					<cfset ArrayAppend(
						arrUploaded,
						(CFFILE.ServerDirectory & "\" & CFFILE.serverfilename & '__' & appendtext & '.' & cffile.clientfileext)
						) />

					<cfset arrServerFile[intFileIndex] = CFFILE.serverfilename & '__' & appendtext & '.' & cffile.clientfileext />




					<!--- Catch upload errors. --->
					<cfcatch>

						<!--- Store the error. --->
						<cfset ArrayAppend(
							arrErrors,
							"There was a problem uploading file ###intFileIndex#: #CFCATCH.Message#"
							) />

						<!---
							Break out of the upload loop as we
							don't want to deal with any more
							files than we have to.
						--->
						<cfbreak />

					</cfcatch>
				</cftry>

			</cfif>

		</cfloop>


		<!--- Check to see if we have any form errors. --->
		<cfif ArrayLen( arrErrors )>


			<!---
				We encountered an error somewhere in the upload
				process. As such, we want to clean up the server
				a bit by deleteing any files that were
				successfully uploaded as part of this process.
			--->
			<cfloop
				index="intFileIndex"
				from="1"
				to="#ArrayLen( arrUploaded )#"
				step="1">

				<!--- Try to delete this file. --->
				<cftry>
					<cffile
						action="delete"
						file="#arrUploaded[ intFileIndex ]#"
						/>

					<cfcatch>
						<!--- File could not be deleted. --->
					</cfcatch>
				</cftry>

			</cfloop>


		<cfelse>

			<cfinvoke method="saveFormAfterFileUpload" eformid="#eformid#" >

			<!---
				!! SUCCESS !!
				The files were properly uploaded and processed.
				Here is where you might forward someone to some
				sort of success / confirmation page.
			--->


		</cfif>

	<cfelse>
		<cfset arrServerFile = ArrayNew(1) >
		<cfinvoke method="saveFormAfterFileUpload" eformid="#eformid#" >
	</cfif>

<cfelse>
	<cfinvoke method="saveFormNoFile" eformid="#eformid#" >
</cfif>

	<cfreturn returnStruct >
<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message  >
</cfcatch>
</cftry>
</cffunction>




<cffunction name="saveFormNoFile" >
<cfargument name = "eformid" >

<cfinvoke method="getIDofMainTable" >

<!---execute before submit--->
<cfif getMainTableID[5] neq "NA" AND getMainTableID[5] neq "">
	<cfinclude template="../fielddefinition/beforesubmit/#getMainTableID[5]#" >
</cfif>
<!---end before submit--->

<cfinvoke method="setEgrgformsVar" >

<cfset tableStruct = StructNew() >
<cfset tableValStruct = StructNew() >

<cfset processid = createuuid() >

<cfif Not StructIsEmpty(form) >

<cftry>
	<cfset arrForm = StructKeyArray( form ) >
	<cfloop array="#arrForm#" index="formIndex" >

		<cfif len(formIndex) gt 0 >
			<cfoutput>#ListLen( formIndex, "__" )#</cfoutput>
			<cfif ListLen(formIndex, "__") eq 3 >
				<cfset formIndArr = ArrayNew(1) >
				<cfset formIndArr = ListToArray(formIndex , "__", true, true) >
				<cfset theTableLevel = formIndArr[1] >
				<cfset theTableName  = formIndArr[2] >
				<cfset theColumnName = formIndArr[3] >

				<cfif firsttable eq theTableName AND  theColumnName eq 'PROCESSID' AND theTableLevel eq firstlevel >
					<cfcontinue>
				</cfif>

				<cfif firsttable eq theTableName AND  theColumnName eq 'APPROVED' AND theTableLevel eq firstlevel >
					<cfcontinue>
				</cfif>


				<cftry>
					<cfset isArray = evaluate("items#theTableName#") >
					<cfif isarray(isArray) >

					<cfelse>
						<cfset "items#theTableName#"  = arraynew(1) >
					</cfif>
				<cfcatch>
					<cfset "items#theTableName#"  = arraynew(1) >
				</cfcatch>
				</cftry>

				<cftry>
					<cfset isArray = evaluate("itemVal#theTableName#") >
					<cfif isarray(isArray) >

					<cfelse>
						<cfset "itemVal#theTableName#"  = arraynew(1) >
					</cfif>
				<cfcatch>
					<cfset "itemVal#theTableName#"  = arraynew(1) >
				</cfcatch>
				</cftry>



				<cfset arrayappend(evaluate("items#theTableName#"), theColumnName) >
				<cfset tableStruct['#theTableName#'] = evaluate("items#theTableName#") >

				<cfset colVal = evaluate("form.#formIndex#") >
				<cfif isencrypted eq "true" >
					<cfset colVal = encrypt(colVal, session.ek) >
				</cfif>

				<cfset arrayappend(evaluate("itemVal#theTableName#"), "#colVal#") >
				<cfset tableValStruct['#theTableName#'] = evaluate("itemVal#theTableName#") >

				<cfset "level#theTableName#" = theTableLevel >

			</cfif>
		<cfelse>

		</cfif>

	</cfloop>


	<cfset tableArr = StructKeyArray(tableStruct) >
	<cfloop array="#tableArr#" index="theTables" >
		<cfset itemArray = tableStruct['#theTables#'] >
		<cfset itemList  = ArrayToList( itemArray, "," ) >
		<cfset itemValArray = tableValStruct['#theTables#'] >

		<cfset theLevel = evaluate("level#theTables#") >
		<cfinvoke component="routing" method="getDatasourceCF" tablelevel="#theLevel#" returnvariable="theLevel" >

		<cfquery name='dynamicQuery' datasource='#theLevel#' >
			INSERT INTO #theTables# ( #itemList#,
									PERSONNELIDNO,
									EFORMID,
									PROCESSID,
									APPROVED,
									RECDATECREATED,
									DATELASTUPDATE
									)
							VALUES ( <cfloop array="#itemValArray#" index="colVal" >
										<cfqueryparam value="#colVal#" >,
									 </cfloop>
									'#session.chapa#',
									'#eformid#',
									'#processid#',
									'N',
									'#dateformat(now(), "YYYY-MM-DD") & ' ' & timeformat(now(), "HH:MM:SS")#',
									'#dateformat(now(), "YYYY-MM-DD") & ' ' & timeformat(now(), "HH:MM:SS")#' )
		</cfquery>

		<cfinvoke method = "insertAudit" >


	</cfloop>


	<cfinvoke method="executeAfterSubmit" >

	<cfset returnStruct['success'] = "true" >
	<cfset returnStruct['data']   = arrErrors >

<cfcatch>

	<!---
	<cfset tableArr = StructKeyArray(tableStruct) >
	<cfloop array="#tableArr#" index="theTables" >
		<cfset itemArray = tableStruct['#theTables#'] >
		<cfset itemList  = ArrayToList( itemArray, "," ) >
		<cfset itemValArray = tableValStruct['#theTables#'] >

		<cfset theLevel = evaluate("level#theTables#") >
		<cfinvoke component="routing" method="getDatasourceCF" tablelevel="#theLevel#" returnvariable="theLevel" >


		<cfquery name='dynamicQuery' datasource='#theLevel#' >
			DELETE FROM #theTables#
				WHERE <cfloop from="1" to="#ArrayLen(itemValArray)#" index="cntr" >
						#itemArray[cntr]# = <cfqueryparam value="#itemValArray[cntr]#" >
						<cfif Not cntr eq ArrayLen(itemValArray)>
							AND
						</cfif>
					  </cfloop>
		</cfquery>--->
	   <cfset returnStruct['data']   = "#cfcatch.detail# #cfcatch.message#" >
	<!---</cfloop>--->

</cfcatch>
</cftry>

<cfelse>
	<cfset returnStruct['data']   = "emptyForm" >
</cfif>
</cffunction>






<cffunction name="saveFormAfterFileUpload" >
<cfargument name = "eformid" >

<cfinvoke method="getIDofMainTable" >

<!---execute before submit--->
<cfif getMainTableID[5] neq "NA" AND getMainTableID[5] neq "">
	<cfinclude template="../fielddefinition/beforesubmit/#getMainTableID[5]#" >
</cfif>
<!---end before submit--->

<cfinvoke method="setEgrgformsVar" >

<cfset tableStruct 		= StructNew() >
<cfset tableValStruct 	= StructNew() >

<cfset processid = createuuid() >


<cfif Not StructIsEmpty(form) >

<cftry>
	<cfset arrForm = StructKeyArray( form ) >
	<cfloop array="#arrForm#" index="formIndex" >

		<cfif len(formIndex) gt 0 >
			<cfoutput>#ListLen( formIndex, "__" )#</cfoutput>
			<cfif ListLen(formIndex, "__") eq 3 >
				<cfset formIndArr = ArrayNew(1) >
				<cfset formIndArr = ListToArray(formIndex , "__", true, true) >
				<cfset theTableLevel = formIndArr[1] >
				<cfset theTableName  = formIndArr[2] >
				<cfset theColumnName = formIndArr[3] >

				<cfif firsttable eq theTableName AND  theColumnName eq 'PROCESSID' AND theTableLevel eq firstlevel >
					<cfcontinue>
				</cfif> <!---used to escape this columns to prevent duplicating names in a query--->
				<!---not all functions really use this field--->
				<cfif firsttable eq theTableName AND  theColumnName eq 'APPROVED' AND theTableLevel eq firstlevel >
					<cfcontinue>
				</cfif>

				<cftry>
					<cfset isArray = evaluate("items#theTableName#") >
					<cfif isarray(isArray) >

					<cfelse>
						<cfset "items#theTableName#"  = arraynew(1) >
					</cfif>
				<cfcatch>
					<cfset "items#theTableName#"  = arraynew(1) >
				</cfcatch>
				</cftry>

				<cftry>
					<cfset isArray = evaluate("itemVal#theTableName#") >
					<cfif isarray(isArray) >

					<cfelse>
						<cfset "itemVal#theTableName#"  = arraynew(1) >
					</cfif>
				<cfcatch>
					<cfset "itemVal#theTableName#"  = arraynew(1) >
				</cfcatch>
				</cftry>


				<cftry>
					<cfset isArray = evaluate("colFileArray#theTableName#") >
					<cfif isarray(isArray) >

					<cfelse>
						<cfset "colFileArray#theTableName#"  = arraynew(1) >
					</cfif>
				<cfcatch>
					<cfset "colFileArray#theTableName#"  = arraynew(1) >
				</cfcatch>
				</cftry>

				<cfset colVal = evaluate("form.#formIndex#") >

				<cfif find( "forfileonlyaaazzz", colVal )  >
					<cfif ListGetAt(colVal,1,'__') eq "forfileonlyaaazzz#theTableName#" >
						<cfif arrayisdefined(arrServerFile, ListGetAt(colVal,2,'__')) >
							<cfset colVal = arrServerFile[ListGetAt(colVal,2,'__')] >
						<cfelse>
							<cfset colVal = "no file" >
						</cfif>
					<cfelse>
						<cfbreak>
					</cfif>
				</cfif>

				<cfif isencrypted eq "true" >
					<cfset colVal = encrypt(colVal, session.ek) >
				</cfif>


					<cfset arrayappend(evaluate("items#theTableName#"), theColumnName) >
					<cfset tableStruct['#theTableName#'] = evaluate("items#theTableName#") >

					<cfset arrayappend(evaluate("itemVal#theTableName#"), "#colVal#") >
					<cfset tableValStruct['#theTableName#'] = evaluate("itemVal#theTableName#") >


				<cfset "level#theTableName#" = theTableLevel >

			</cfif>
		<cfelse>

		</cfif>

	</cfloop>



	<cfset tableArr = StructKeyArray(tableStruct) >
	<cfloop array="#tableArr#" index="theTables" >
		<cfset itemArray = tableStruct['#theTables#'] >
		<cfset itemList  = ArrayToList( itemArray, "," ) >
		<cfset itemValArray = tableValStruct['#theTables#'] >

		<cfset theLevel = evaluate("level#theTables#") >
		<cfinvoke component="routing" method="getDatasourceCF" tablelevel="#theLevel#" returnvariable="theLevel" >

		<cfquery name='dynamicQuery' datasource='#theLevel#' >
			INSERT INTO #theTables# ( #itemList#,
									PERSONNELIDNO,
									EFORMID,
									PROCESSID,
									APPROVED,
									RECDATECREATED,
									DATELASTUPDATE
									)

							VALUES (
									<cfloop array="#itemValArray#" index="colVal" >
										<cfqueryparam value="#colVal#" >,
									</cfloop>
									'#session.chapa#',
									'#eformid#',
									'#processid#',
									'N',
									'#dateformat(now(), "YYYY-MM-DD") & ' ' & timeformat(now(), "HH:MM:SS")#',
									'#dateformat(now(), "YYYY-MM-DD") & ' ' & timeformat(now(), "HH:MM:SS")#' )
		</cfquery>

		<cfinvoke method = "insertAudit" >

	</cfloop>

	<cfset returnStruct['success'] = "true" >
	<cfset returnStruct['data']   = arrErrors >

	<cfinvoke method="executeAfterSubmit" >

<cfcatch>

	<cfset tableArr = StructKeyArray(tableStruct) >
	<cfloop array="#tableArr#" index="theTables" >
		<cfset itemArray = tableStruct['#theTables#'] >
		<cfset itemList  = ArrayToList( itemArray, "," ) >
		<cfset itemValArray = tableValStruct['#theTables#'] >

		<cfset theLevel = evaluate("level#theTables#") >
		<cfinvoke component="routing" method="getDatasource" tablelevel="#theLevel#" returnvariable="theLevel" >

		<!---
				We encountered an error somewhere in the query
				process. As such, we want to clean up the server
				a bit by deleteing any files that were
				successfully uploaded as part of this process.
			--->
			<cfif isdefined("arrUploaded") >
			<cfloop
				index="intFileIndex"
				from="1"
				to="#ArrayLen( arrUploaded )#"
				step="1">

				<!--- Try to delete this file. --->
				<cftry>
					<cffile
						action="delete"
						file="#arrUploaded[ intFileIndex ]#"
						/>

					<cfcatch>
						<!--- File could not be deleted. --->
					</cfcatch>
				</cftry>

			</cfloop>
			</cfif>

	</cfloop>
	<cfset returnStruct['data']   = "#cfcatch.detail# #cfcatch.message#" >
</cfcatch>
</cftry>

<cfelse>
	<cfset returnStruct['data']   = "emptyForm" >
</cfif>

</cffunction>


<cffunction name="executeAfterSubmit" returntype="void"  access="package" >

	<!---execute after submit--->
	<cfif getMainTableID[6] neq "NA" AND getMainTableID[6] neq "" >
		<cfinclude template="../fielddefinition/aftersubmit/#getMainTableID[6]#" >
	</cfif>
	<!---end after submit--->

		<cfquery name="getLastContent" datasource="#session.global_dsn#" >
			SELECT LASTCOUNT, INCREMENTVALUE
			  FROM EGINAUTOINCREMENT
			 WHERE EFORMID = '#eformid#';
		</cfquery>

		<cfif getLastContent.recordCount gt 0 >
			<cfset currentCnt = val(getLastContent.LASTCOUNT) + val(getLastContent.INCREMENTVALUE) >
			<cfquery name="updateAutoInc" datasource="#session.global_dsn#" >
				UPDATE EGINAUTOINCREMENT
				   SET LASTCOUNT = <cfqueryparam cfsqltype="cf_sql_integer" value="#currentCnt#">
				 WHERE EFORMID = '#eformid#';
			</cfquery>
		</cfif>

</cffunction>



<cffunction name="saveForm" returntype="String" >

<cfinvoke method="getIDofMainTable" >

<cfinvoke method="setEgrgformsVar" >

	<cfset theProcessCond = "form.#firstlevel#__#firsttable#__PROCESSID" >
	<cfset theProcessCond = evaluate(theProcessCond) >

	<cfset tableStruct = StructNew() >
	<cfset tableValStruct = StructNew() >

<cfif Not StructIsEmpty(form) >

	<cfset arrForm = StructKeyArray( form ) >
	<cfloop array="#arrForm#" index="formIndex" >

		<cfif len(formIndex) gt 0 >
			<cfoutput>#ListLen( formIndex, "__" )#</cfoutput>
			<cfif ListLen(formIndex, "__") eq 3 >
				<cfset formIndArr = ArrayNew(1) >
				<cfset formIndArr = ListToArray(formIndex , "__", true, true) >
				<cfset theTableLevel = formIndArr[1] >
				<cfset theTableName  = formIndArr[2] >
				<cfset theColumnName = formIndArr[3] >

				<cfif firsttable eq theTableName AND  theColumnName eq 'PROCESSID' AND theTableLevel eq firstlevel >
					<cfcontinue>
				</cfif>


				<cftry>
					<cfset isArray = evaluate("items#theTableName#") >
					<cfif isarray(isArray) >

					<cfelse>
						<cfset "items#theTableName#"  = arraynew(1) >
					</cfif>
				<cfcatch>
					<cfset "items#theTableName#"  = arraynew(1) >
				</cfcatch>
				</cftry>

				<cftry>
					<cfset isArray = evaluate("itemVal#theTableName#") >
					<cfif isarray(isArray) >

					<cfelse>
						<cfset "itemVal#theTableName#"  = arraynew(1) >
					</cfif>
				<cfcatch>
					<cfset "itemVal#theTableName#"  = arraynew(1) >
				</cfcatch>
				</cftry>

				<cfset arrayappend(evaluate("items#theTableName#"), theColumnName) >
				<cfset tableStruct['#theTableName#'] = evaluate("items#theTableName#") >

				<cfset colVal = evaluate("form.#formIndex#") >
				<cfif isencrypted eq "true" >
					<cfset colVal = encrypt(colVal, session.ek) >
				</cfif>

				<cfset arrayappend(evaluate("itemVal#theTableName#"), "#colVal#") >
				<cfset tableValStruct['#theTableName#'] = evaluate("itemVal#theTableName#") >

				<cfset "level#theTableName#" = theTableLevel >

			</cfif>
		<cfelse>

		</cfif>

	</cfloop>


	<cfset tableArr = StructKeyArray(tableStruct) >
	<cfloop array="#tableArr#" index="theTables" >
		<cfset itemArray = tableStruct['#theTables#'] >
		<cfset itemList  = ArrayToList( itemArray, "," ) >
		<cfset itemValArray = tableValStruct['#theTables#'] >

		<cfset theLevel = evaluate("level#theTables#") >
		<cfinvoke component="routing" method="getDatasourceCF" tablelevel="#theLevel#" returnvariable="theLevel" >


		<cfquery name='dynamicQuery' datasource='#theLevel#' >
			UPDATE #theTables#
			   SET <cfloop from="1" to="#ArrayLen(itemValArray)#" index="cntr" >
					#itemArray[cntr]# = <cfqueryparam value="#itemValArray[cntr]#" >
					<cfif Not cntr eq ArrayLen(itemValArray)>
						,
					</cfif>
				  </cfloop>
			 WHERE PROCESSID = '#theProcessCond#' AND EFORMID = '#form.eformid#'
		</cfquery>

		<cfinvoke method="insertUpdatedToAudit" >


	</cfloop>


	<!---check if this form a returned form--->
	<cfset isReturned = "form.#firstlevel#__#firsttable#__APPROVED" >
	<cfset isReturned = evaluate(isReturned) >
	<cfif isReturned eq "R" > <!---saving returned form will continue to the routing process--->
		<cfset theLevel = firstlevel >
		<cfinvoke component="routing" method="getDatasourceCF" tablelevel="#theLevel#" returnvariable="theLevel" >

		<cfset datetimenow = '#dateformat(now(), "YYYY-MM-DD")# #timeformat(now(), "HH:MM:SS")#' >
		<cfquery name='dynamicQuery' datasource='#theLevel#' >
			UPDATE #firsttable# <!---it is only the first table that hold the eformid,processid,approved : if multiple tables in a form--->
			   SET APPROVED = 'S',
			       DATELASTUPDATE = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#datetimenow#" >
			 WHERE PROCESSID = '#theProcessCond#'
			       AND EFORMID = '#form.eformid#'
		</cfquery>
		<!---also update the approver status from 'SENT BACK TO ORIGINATOR' to 'CURRENT' --->


		<cfset formRouterDataD = EntityLoad("EGINROUTERDETAILS", {PROCESSIDFK = #theProcessCond#}, "ROUTERORDER ASC") >
		<cfloop array="#formRouterDataD#" index="routerIndexD" > <!---a big loop--->

			<cfset formApproversDataD = EntityLoad("EGINAPPROVERDETAILS", {ROUTERIDFK =#routerIndexD.getROUTERDETAILSID()#}, "APPROVERORDER ASC" ) >
			<cfloop array="#formApproversDataD#" index="approverIndexD" >
				<cfset updateActionD = EntityLoad("EGINAPPROVERDETAILS", {APPROVERDETAILSID =#approverIndexD.getAPPROVERDETAILSID()#,ACTION='SENT BACK TO ORIGINATOR'}, true ) >
				<cfif isdefined("updateActionD") >
					<cfset updateActionD.setACTION("CURRENT") >

					<cfinvoke component="routing" method="updateFormCount" eformid="#form.eformid#" personnelidno="#updateActionD.getPERSONNELIDNO()#" theType="addnew">

					<cfset EntitySave(updateActionD) >
					<cfset ormflush() >

				</cfif>
			</cfloop>
		</cfloop>

		<!---update counter, no need to delete on error--->
			<cfinvoke component="routing" method="updateFormCount" eformid="#form.eformid#" personnelidno="#session.chapa#" theType="subtractreturn">

		<!---<cfreturn "success" >---> <!---return to the calling page--->

	</cfif>


<cfelse>

</cfif>




<cfreturn "success" >

</cffunction>



<cffunction name="approveForm" >
<cfset eformid = form.eformid>

<cfset getMainTableID = ORMExecuteQuery("SELECT B.TABLENAME AS TABLENAME,
												B.LEVELID AS LEVELID,
												C.COLUMNNAME AS COLUMNNAME,
												A.ISENCRYPTED AS ISENCRYPTED,
												A.BEFOREAPPROVE AS BEFOREAPPROVE,
												A.AFTERAPPROVE AS AFTERAPPROVE,
												A.AUDITTDSOURCE AS AUDITTDSOURCE,
												A.AUDITTNAME AS AUDITTNAME,
												A.LOGDBSOURCE AS LOGDBSOURCE,
												A.LOGTABLENAME AS LOGTABLENAME,
												A.LOGFILENAME AS LOGFILENAME
	  								       FROM EGRGEFORMS A,
	  								       	    EGRGIBOSETABLE B,
	  								       	    EGRGIBOSETABLEFIELDS C
	 								      WHERE EFORMID = '#eformid#'
	 								      		AND A.EFORMID = B.EFORMIDFK
	 								      		AND B.TABLEID = C.TABLEIDFK
	 								      		AND C.XTYPE = 'id'
	 								    ", true) >


<!---execute before approve--->
<cfif getMainTableID[5] neq "NA" AND getMainTableID[5] neq "">
	<cfinclude template="../fielddefinition/beforeapprove/#getMainTableID[5]#" >
</cfif>
<!---end before approve--->

<cfinvoke method="setEgrgformsVar" >

<cfset processid = evaluate("form.#firstlevel#__#firsttable#__PROCESSID") >

<cfinvoke method="getTheApprovers" >

<cfloop array="#getApprovers#" index="approverIndx">
	<cfset eginapproverdata = EntityLoad("EGINAPPROVERDETAILS", #approverIndx#, true ) >
	<cfif trim(eginapproverdata.getCOMMENTS()) neq "" >
		<cfset thiscomments = "#form.comments#<p> (<i>#dateformat(eginapproverdata.getDATELASTUPDATE(), 'MM/DD/YYYY')# #timeformat(eginapproverdata.getDATELASTUPDATE(), 'short')#</i>) " & eginapproverdata.getCOMMENTS() & "</p>">
	<cfelse>
		<cfset thiscomments = "#form.comments#" >
	</cfif>
	<cfset eginapproverdata.setACTION("APPROVED") >
	<cfset eginapproverdata.setISREAD("true") >
	<cfset eginapproverdata.setDATEACTIONWASDONE("#dateformat(now(), 'YYYY-MM-DD')# #timeformat(now(), 'HH:MM:SS')#") >
	<cfset eginapproverdata.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')# #timeformat(now(), 'HH:MM:SS')#") >
	<cfset eginapproverdata.setCOMMENTS("#thiscomments#") >
	<cfset EntitySave(eginapproverdata) >
	<cfset ormflush()>
</cfloop>


<!---execute after approve--->
<cfif getMainTableID[6] neq "NA" AND getMainTableID[6] neq "" >
	<cfinclude template="../fielddefinition/afterapprove/#getMainTableID[6]#" >
</cfif>
<!---end after approve--->

</cffunction>



<cffunction name="disapproveForm" >
<cfset eformid = form.eformid>

<cfinvoke method="getIDofMainTable" >

<cfinvoke method="setEgrgformsVar" >

<cfset processid = evaluate("form.#firstlevel#__#firsttable#__PROCESSID") >

<cfinvoke method="getTheApprovers" >

<cfloop array="#getApprovers#" index="approverIndx">
	<cfset eginapproverdata = EntityLoad("EGINAPPROVERDETAILS", #approverIndx#, true ) >
	<cfif trim(eginapproverdata.getCOMMENTS()) neq "" >
		<cfset thiscomments = "#form.comments#<p> (<i>#dateformat(eginapproverdata.getDATELASTUPDATE(), 'MM/DD/YYYY')# #timeformat(eginapproverdata.getDATELASTUPDATE(), 'short')#</i>) " & eginapproverdata.getCOMMENTS() & "</p>">
	<cfelse>
		<cfset thiscomments = "#form.comments#" >
	</cfif>
	<cfset eginapproverdata.setACTION("DISAPPROVED") >
	<cfset eginapproverdata.setISREAD("true") >
	<cfset eginapproverdata.setDATEACTIONWASDONE("#dateformat(now(), 'YYYY-MM-DD')# #timeformat(now(), 'HH:MM:SS')#") >
	<cfset eginapproverdata.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')# #timeformat(now(), 'HH:MM:SS')#") >
	<cfset eginapproverdata.setCOMMENTS("#thiscomments#") >
	<cfset EntitySave(eginapproverdata) >
	<cfset ormflush()>
</cfloop>

</cffunction>





<cffunction name="sentBackToOriginatorForm" >
<cfset eformid = form.eformid>

<cfinvoke method="getIDofMainTable" >

<cfinvoke method="setEgrgformsVar" >

<cfset processid = evaluate("form.#firstlevel#__#firsttable#__PROCESSID") >

<cfinvoke method="getTheApprovers" >

<cfloop array="#getApprovers#" index="approverIndx">
	<cfset eginapproverdata = EntityLoad("EGINAPPROVERDETAILS", #approverIndx#, true ) >
	<cfif trim(eginapproverdata.getCOMMENTS()) neq "" >
		<cfset thiscomments = "#form.comments#<p> (<i>#dateformat(eginapproverdata.getDATELASTUPDATE(), 'MM/DD/YYYY')# #timeformat(eginapproverdata.getDATELASTUPDATE(), 'short')#</i>) " & eginapproverdata.getCOMMENTS() & "</p>">
	<cfelse>
		<cfset thiscomments = "#form.comments#" >
	</cfif>
	<cfset eginapproverdata.setACTION("SENT BACK TO ORIGINATOR") >
	<cfset eginapproverdata.setISREAD("false") >
	<cfset eginapproverdata.setDATEACTIONWASDONE("#dateformat(now(), 'YYYY-MM-DD')# #timeformat(now(), 'HH:MM:SS')#") >
	<cfset eginapproverdata.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')# #timeformat(now(), 'HH:MM:SS')#") >
	<cfset eginapproverdata.setCOMMENTS("#thiscomments#") >
	<cfset EntitySave(eginapproverdata) >
	<cfset ormflush()>
</cfloop>

</cffunction>






<cffunction name="updateProcess" hint="a function to update process routers status">

<cfset eformid = form.eformid >
<!---get process id--->
<cfset processid = evaluate("form.#firstlevel#__#firsttable#__PROCESSID") >
<!---get the routers--->
<cfset mypid = "form.#firstlevel#__#firsttable#__PERSONNELIDNO" >
<cfset pid = evaluate(mypid) >

<cfset previousRouterIsDone = "false" > <!---this is used to indicate if the previous router prior to the current is already has the APPROVED status--->

<cfset formRouterData = EntityLoad("EGINROUTERDETAILS", {PROCESSIDFK = #processid#}, "ROUTERORDER ASC") >

<cfset freqArray = ArrayNew(1) >
<cfset expirArray = ArrayNew(1) >
<cfset therouterdetailsid = ArrayNew(1) >

<cfloop array="#formRouterData#" index="routerIndex" > <!---a big loop--->

	<cfif routerIndex.getSTATUS() eq "APPROVED" >
		<!---this router STATUS is set to done may be by other approvers--->
		<!---go to the next router in this process--->
		<cfset previousRouterIsDone = "true" >
		<cfcontinue>
	<cfelseif routerIndex.getSTATUS() eq "DISAPPROVED" >
		<cfbreak> <!---no need to continue to the following routers--->
	<cfelseif routerIndex.getSTATUS() eq "IGNORED" >
		<cfcontinue> <!---no need to continue to the following routers--->
	<cfelseif routerIndex.getSTATUS() eq "SENT BACK TO ORIGINATOR" >
		<cfbreak> <!---no need to continue to the following routers--->
	<cfelse> <!---STATUS : PENDING---> <!---router's side not approver's side--->
		<!---loop over router's approvers--->
		<cfset formApproversData = EntityLoad("EGINAPPROVERDETAILS", {ROUTERIDFK =#routerIndex.getROUTERDETAILSID()#}, "APPROVERORDER ASC" ) >
		<cfif routerIndex.getUSECONDITIONS() eq "true" > <!---with applied conditions, example AND and OR --->
			<cfset conditionArr = ArrayNew(1) >
			<cfset conditionExp = ArrayNew(1) >
			<cfset expArr = ArrayNew(1) >
			<cfloop array="#formApproversData#" index="approverIndex" >
				<!---map each action to a binary representation so that the conditionals will work eh--->
				<cfif approverIndex.getACTION() eq "APPROVED" OR approverIndex.getACTION() eq "IGNORED" >
					<cfset ArrayAppend(conditionArr, "1") >
				<cfelse>
					<cfset ArrayAppend(conditionArr, "0") >
				</cfif>
				<cfset ArrayAppend(conditionExp, approverIndex.getCONDITIONBELOW()) > <!---at the same index to conditionArr, insert AND and OR--->
			</cfloop>
			<!---evaluate the expression--->
			<cfloop from="1" to="#ArrayLen(conditionExp)#" index="theCnt" >
				<cfset ArrayAppend(expArr,conditionArr[theCnt]) >
				<cfif ArrayLen(conditionExp) eq theCnt >
				<cfelse>
					<cfset ArrayAppend(expArr,conditionExp[theCnt]) >
				</cfif>
			</cfloop>

			<cfset theConditionExp = ArrayToList(expArr, " ") > <!---empty condition is an error--->
			<cfif trim(theConditionExp) eq "" >
				<!---<cfthrow detail="empty applied condition or no approver is specified in this router" >--->
				<!---disconnected : abort the process--->
				<cfcontinue>
			</cfif>

			<cfif evaluate(theConditionExp)>
				<cfinvoke method="approveRouter" > <!---the condition shows that this router is qualified to be approved--->
			<cfelse>
				<!---result is false--->
				<!---check if this router is still possible to be approved by setting CURRENT and PENDING equal to 1 above aside from 0 earlier--->
				<!---the codes are repeated here for a reason : check if the router is still a candidate to be approved--->
				<cfset conditionArr2 = ArrayNew(1) >
				<cfset conditionExp2 = ArrayNew(1) >
				<cfset expArr2 = ArrayNew(1) >
				<cfloop array="#formApproversData#" index="approverIndex2" >
					<!---map each action to a binary representation so that the conditionals will work eh--->
					<cfif approverIndex2.getACTION() eq "APPROVED" OR approverIndex2.getACTION() eq "IGNORED" OR approverIndex2.getACTION() eq "CURRENT" OR approverIndex2.getACTION() eq "PENDING">
						<cfset ArrayAppend(conditionArr2, "1") >
					<cfelse>
						<cfset ArrayAppend(conditionArr2, "0") >
					</cfif>
					<cfset ArrayAppend(conditionExp2, approverIndex2.getCONDITIONBELOW()) > <!---at the same index to conditionArr, insert AND and OR--->
				</cfloop>
				<!---evaluate the expression--->
				<cfloop from="1" to="#ArrayLen(conditionExp2)#" index="theCnt2" >
					<cfset ArrayAppend(expArr2,conditionArr2[theCnt2]) >
					<cfif ArrayLen(conditionExp2) eq theCnt2 >
					<cfelse>
						<cfset ArrayAppend(expArr2,conditionExp2[theCnt2]) >
					</cfif>
				</cfloop>

				<cfset theConditionExp2 = ArrayToList(expArr2, " ") > <!---output example : 1 AND 1 OR 0 AND 1--->

				<cfif evaluate(theConditionExp2) >
					<!---the condition shows that this router is still possible to be approved--->
					<cfif previousRouterIsDone eq "true" > <!---previous router is done. notify these approvers after setting pending to current--->
						<cfset pidArray = ArrayNew(1) >
						<cfloop array="#formApproversData#" index="approverIndexC" >

								<cfset updateActionB = EntityLoad("EGINAPPROVERDETAILS", {APPROVERDETAILSID =#approverIndexC.getAPPROVERDETAILSID()#,ACTION='PENDING'}, true ) >
								<cfif isdefined("updateActionB") >

									<cfinvoke component="routing" method="updateFormCount" eformid="#eformid#" personnelidno="#updateActionB.getPERSONNELIDNO()#" theType="updateornew">

									<cfset updateActionB.setACTION("CURRENT") >
									<cfset updateActionB.setISREAD("false") >
									<cfset updateActionB.setDATESTARTED("#dateformat(now(), "YYYY-MM-DD")# #timeformat(now(), "HH:MM:SS")#") >
									<cfset updateActionB.setDATELASTUPDATE("#dateformat(now(), "YYYY-MM-DD")# #timeformat(now(), "HH:MM:SS")#") >
									<cfset EntitySave(updateActionB) >
									<cfset ormflush() >

									<cfset ArrayAppend(pidArray, updateActionB.getPERSONNELIDNO()) >

								</cfif>

						</cfloop>

						<!---notify next approvers which is this approver(s)--->
						<cfif routerIndex.getNOTIFYNEXTAPPROVERS() eq "true" AND ArrayLen(pidArray) gt 0 >
							<cfset moreemailcopy = routerIndex.getMOREEMAILADD() >
							<cfinvoke 	method="notifyNextApprovers"
										component="email"
									  	returnvariable="resultemail"
									  	pidArray="#pidArray#"
									    eformid="#eformid#"
									  	processid="#processid#"
									    extraRecipients="#moreemailcopy#"
				    					status="PENDING"
									  >

							<cfset ArrayAppend( freqArray, routerIndex.getFREQUENCYFOLLOUP() ) >
							<cfset ArrayAppend( expirArray, routerIndex.getEXPIRATIONDATE() ) >
							<cfset ArrayAppend( therouterdetailsid, routerIndex.getROUTERDETAILSID() ) >
						</cfif>
						<!---end notifications --->
					</cfif>
					<cfset previousRouterIsDone = "false" > <!---this router is to be approved yet--->

					<cfcontinue>
				<cfelse>

					<!---the condition shows that this router is not possible to be approved--->
					<!---get the action of the approver possible values are DISAPPROVED, SENT BACK TO SENDER, SENT BACK TO ORIGINATOR--->
					<cfinvoke method="updateNotApprove" >
					<cfbreak>
				</cfif> <!---end evaluate--->
			</cfif> <!---end evaluate(theConditionExp)--->

		<cfelse> <!---it uses "approve at least property, minimum value : 1"--->
			<cfset approveatleast = routerIndex.getAPPROVEATLEAST() >
			<cfset approveArr = ArrayNew(1) >
			<cfset pidArray = ArrayNew(1) >
			<cfloop array="#formApproversData#" index="approverIndex" >
			 	 <cfif approverIndex.getACTION() eq "APPROVED" OR approverIndex.getACTION() eq "IGNORED">
				  	  <cfset ArrayAppend(approveArr, "APPROVED") >
				 <cfelseif approverIndex.getACTION() eq "PENDING" AND previousRouterIsDone eq "true" > <!---set as the current approver(s) bcoz the last router is done--->
				 	 <cfset updateApprover = EntityLoad("EGINAPPROVERDETAILS", {APPROVERDETAILSID =#approverIndex.getAPPROVERDETAILSID()#}, true ) >

					 	<cfinvoke component="routing" method="updateFormCount" eformid="#eformid#" personnelidno="#updateApprover.getPERSONNELIDNO()#" theType="updateornew">

					 	<cfset updateApprover.setACTION("CURRENT") >
					    <cfset updateApprover.setDATESTARTED("#dateformat(now(), "YYYY-MM-DD")# #timeformat(now(), "HH:MM:SS")#") >
					    <cfset updateApprover.setDATELASTUPDATE("#dateformat(now(), "YYYY-MM-DD")# #timeformat(now(), "HH:MM:SS")#") >
					    <cfset EntitySave(updateApprover) >
					    <cfset ormflush() >

						<cfset ArrayAppend(pidArray, updateApprover.getPERSONNELIDNO()) > <!---pid of approvers to be notified--->

				 <cfelse>
				 </cfif>
			</cfloop>	<!---end approversdata--->
				<cfif ArrayLen(approveArr) GTE approveatleast > <!---2nd time--->
					<cfinvoke method="approveRouter" >
				<cfelse> <!---check if possible to be approved--->
					<cfset approveArr = ArrayNew(1) >

					<cfloop array="#formApproversData#" index="approverIndexD" >
					 	 <cfif approverIndexD.getACTION() eq "APPROVED" OR approverIndex.getACTION() eq "IGNORED" OR approverIndexD.getACTION() eq "PENDING" OR approverIndexD.getACTION() eq "CURRENT">
						  	  <cfset ArrayAppend(approveArr, "APPROVED") >
						 <cfelseif approverIndexD.getACTION() eq "PENDING" AND previousRouterIsDone eq "true" > <!---set as the current approver(s) bcoz the last router is done--->
						 	  <cfset updateApproverB = EntityLoad("EGINAPPROVERDETAILS", {APPROVERDETAILSID =#approverIndexD.getAPPROVERDETAILSID()#}, true ) >
							  <cfif isdefined("updateApproverB") >
								  <cfset updateApproverB.setACTION("CURRENT") >
								  <cfset updateApproverB.setDATESTARTED("#dateformat(now(), "YYYY-MM-DD")# #timeformat(now(), "HH:MM:SS")#") >
						          <cfset updateApproverB.setDATELASTUPDATE("#dateformat(now(), "YYYY-MM-DD")# #timeformat(now(), "HH:MM:SS")#") >
								  <cfset EntitySave(updateApproverB) >
								  <cfset ormflush() >

								  <cfset ArrayAppend(pidArray, updateApproverB.getPERSONNELIDNO()) > <!---pid of approvers to be notified--->
				  			  </cfif>
						 <cfelse>
						 </cfif>

					</cfloop>

					<!---notify next approvers which is this approver(s)--->
					<cfif routerIndex.getNOTIFYNEXTAPPROVERS() eq "true" AND ArrayLen(pidArray) gt 0 >
						<cfset moreemailcopy = routerIndex.getMOREEMAILADD() >
						<cfinvoke 	method="notifyNextApprovers"
									component="email"
								  	returnvariable="resultemail"
								  	pidArray="#pidArray#"
								    eformid="#eformid#"
								  	processid="#processid#"
								    extraRecipients="#moreemailcopy#"
				    				status="PENDING"
								  >

						<cfset ArrayAppend( freqArray, routerIndex.getFREQUENCYFOLLOUP() ) >
						<cfset ArrayAppend( expirArray, routerIndex.getEXPIRATIONDATE() ) >
						<cfset ArrayAppend( therouterdetailsid, routerIndex.getROUTERDETAILSID() ) >
					</cfif>
					<!---end notifications --->

					<cfif ArrayLen(approveArr) GTE approveatleast > <!---potential to be approved--->
						<cfset previousRouterIsDone = "false" >
						<cfcontinue>
					<cfelse>
						<!---negative--->
						<!---the condition shows that this router is not possible to be approved--->
						<!---get the action of the approver possible values are DISAPPROVED, SENT BACK TO SENDER, SENT BACK TO ORIGINATOR--->
						<cfinvoke method="updateNotApprove" >
						<cfbreak>
					</cfif>
				 </cfif> <!---end ArrayLen(approveArr)---> <!---2nd time--->
		</cfif> <!---end routerIndex.getUSECONDITIONS()--->


	</cfif>

</cfloop> <!---end routerIndex--->

<!---for the current router which is approved--->
<cfinvoke component="routing" method="updateFormCount" eformid="#eformid#" personnelidno="#session.chapa#" theType="subtractneworpending">

<!---end for the current router which is approved --->

<!---schedule followups--->
<cfif ArrayLen(freqArray) neq 0 >
	<cfset freqinhours = freqArray[1]*60*60 > <!---in seconds--->
	<cfset freqinhours = NumberFormat(freqinhours, "0") >
	<cfset endDateB    = expirArray[1] >
	<cfset therouterdetailsid = therouterdetailsid[1] >

	<cfset subcomdsn = session.subco_dsn >
	<cfset querydsn = session.query_dsn >
	<cfset transactiondsn = session.transaction_dsn >
	<cfset sitedsn = session.site_dsn >

	<cftry>
		<!---make schedule for next approvers--->
		<cfschedule
			action      	 = "update"
		    task        	 = "router#processid#"
			operation   	 = "HTTPRequest"
			interval    	 = "#freqinhours#"
			startdate   	 = "#dateformat(now(), 'mm/dd/yy')#"
			starttime   	 = "#timeformat(now(), 'short')#"
			enddate   	     = "#dateformat(endDateB, 'mm/dd/yy')#"
			url        	 	 = "#session.domain#myapps/form/simulator/scheduler/schedule.cfm?eformid=#eformid#&processid=#processid#&action=followupemail&domain=#session.domain#&routerid=#therouterdetailsid#&companydsn=#session.company_dsn#&globaldsn=#session.global_dsn#&companyname=#session.companyname#&subcomdsn=#subcomdsn#&querydsn=#querydsn#&transactiondsn=#transactiondsn#&sitedsn=#sitedsn#&dbms=#session.dbms#&ek=#session.ek#&websiteemailadd=#session.websiteemailadd#"
			requestTimeOut	 = "300"

		>
		<!---retryCount		 = "3" --->
		<cfcatch>
		</cfcatch>
	</cftry>
</cfif>
<!---end make schedule for next approvers--->


</cffunction>


<cffunction name="approveRouter" >
<!---set this router's STATUS property to 'APPROVED'--->
<!---set this router's approvers with CURRENT and PENDING action equal to 'IGNORED'--->

<cfset updateRouter = EntityLoad("EGINROUTERDETAILS", {ROUTERDETAILSID = #routerIndex.getROUTERDETAILSID()#}, true) >
<cfset updateRouter.setSTATUS("APPROVED") >
<cfset updateRouter.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')# #timeformat(now(), 'HH:MM:SS')#") >
<cfset EntitySave(updateRouter) >
<cfset ormflush() >

<!---check this router if can be the last router--->
<cfif routerIndex.getISLASTROUTER() eq "true" > <!---First approach to check the last router. Process is done. check if we can notify originator--->

	<cfinvoke method="updateMainTable" > <!---update the eform table with an xtype of id only. Applicable also for multiple tables--->


	<!---notify next approvers which is this approver(s)--->
	<cfif routerIndex.getNOTIFYORIGINATOR() eq "true">
		<cfset moreemailcopy = routerIndex.getMOREEMAILADD() >
		<cfset pidArray = ArrayNew(1) >
		<cfset ArrayAppend(pidArray, pid) >

		<cfinvoke 	method="notifyNextApprovers"
					component="email"
				  	returnvariable="resultemail"
				  	pidArray="#pidArray#"
				    eformid="#eformid#"
				  	processid="#processid#"
				    extraRecipients="#moreemailcopy#"
				    status="APPROVED"
				    >
	</cfif>
	<!---end notifications --->



	<cfinvoke method="ignoreCurrentAndPending" > <!---tells to ignore all router's approvers with current and pending status--->
	<cfreturn "success">
	<!---Done process using approve at least and is last approver--->
<cfelseif ArrayLen(formRouterData) eq routerIndex.getROUTERORDER() > <!---Second approach to check the last router. If the length of router array is equal to the router order Process is done. --->
	<cfinvoke method="updateMainTable" >
	<cfinvoke method="ignoreCurrentAndPending" > <!---tells to ignore all router's approvers with current and pending status--->

	<!---notify next approvers which is this approver(s)--->
	<cfif routerIndex.getNOTIFYORIGINATOR() eq "true">
		<cfset moreemailcopy = routerIndex.getMOREEMAILADD() >
		<cfset pidArray = ArrayNew(1) >
		<cfset ArrayAppend(pidArray, pid) >

		<cfinvoke 	method="notifyNextApprovers"
					component="email"
				  	returnvariable="resultemail"
				  	pidArray="#pidArray#"
				    eformid="#eformid#"
				  	processid="#processid#"
				    extraRecipients="#moreemailcopy#"
				    status="APPROVED"
				    >
	</cfif>
	<!---end notifications --->

	<cfreturn "success"> <!---Done process using the very last router--->
<cfelse> <!---make the next router's approvers with PENDING action equal to 'CURRENT' and send notification to each--->
	<cfset previousRouterIsDone = "true" >

	<!---set remaining CURRENT and PENDING to  'IGNORED'--->
	<cfset approverDataC = EntityLoad("EGINAPPROVERDETAILS", {ROUTERIDFK =#routerIndex.getROUTERDETAILSID()#} ) >
	<cfloop array="#approverDataC#" index="approverIndexC" >
		<cftry>
			<cfset updateAction = EntityLoad("EGINAPPROVERDETAILS", {APPROVERDETAILSID =#approverIndexC.getAPPROVERDETAILSID()#,ACTION='CURRENT'}, true ) >
			<cfset updateAction.setACTION("IGNORED") >
			<cfset updateAction.setDATELASTUPDATE("#dateformat(now(), "YYYY-MM-DD")# #timeformat(now(), "HH:MM:SS")#") >
			<cfset EntitySave(updateAction) >
			<cfset ormflush() >
			<!---for the current router which is approved--->
			<cfinvoke component="routing" method="updateFormCount" eformid="#eformid#" personnelidno="#approverIndexC.getPERSONNELIDNO()#" theType="subtractneworpending">

			<!---end for the current router which is approved --->

			<cfcatch>
				<cfcontinue>
			</cfcatch>
		</cftry>
		<cftry>
			<cfset updateActionB = EntityLoad("EGINAPPROVERDETAILS", {APPROVERDETAILSID =#approverIndexC.getAPPROVERDETAILSID()#,ACTION='PENDING'}, true ) >
			<cfset updateActionB.setACTION("IGNORED") >
			<cfset updateActionB.setDATELASTUPDATE("#dateformat(now(), "YYYY-MM-DD")# #timeformat(now(), "HH:MM:SS")#") >
			<cfset EntitySave(updateActionB) >
			<cfset ormflush() >
			<cfcatch>
				<cfcontinue>
			</cfcatch>
		</cftry>
	</cfloop>
		<!---Process here is not yet done, hence, set previousRouterIsDone : true now for the next router to know--->
</cfif> <!---end routerIndex.getISLASTROUTER()--->
</cffunction>



<cffunction name="disapproveRouter" >
<!---update eform table status--->


<cfset updateRouterD = EntityLoad("EGINROUTERDETAILS", {ROUTERDETAILSID = #routerIndex.getROUTERDETAILSID()#}, true) >
<cfset updateRouterD.setSTATUS("DISAPPROVED") > <!---set this router as disapproved status--->
<cfset updateRouterD.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')# #timeformat(now(), 'HH:MM:SS')#") >
<cfset EntitySave(updateRouterD) >
<cfset ormflush() >
<!---all current and pending in this process to 'IGNORED'--->

<cfset formRouterDataD = EntityLoad("EGINROUTERDETAILS", {PROCESSIDFK = #processid#}, "ROUTERORDER ASC") >
<cfloop array="#formRouterDataD#" index="routerIndexD" > <!---a big loop--->
	<cfset updateRouterDD = EntityLoad("EGINROUTERDETAILS", {ROUTERDETAILSID = #routerIndexD.getROUTERDETAILSID()#, STATUS='PENDING'}, true) >
	<cfif isdefined("updateRouterDD") >
		<cfset updateRouterDD.setSTATUS("IGNORED") > <!---set this router as disapproved status--->
		<cfset updateRouterDD.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')# #timeformat(now(), 'HH:MM:SS')#") >
		<cfset EntitySave(updateRouterDD) >
		<cfset ormflush() >
	</cfif>
	<cfset formApproversDataD = EntityLoad("EGINAPPROVERDETAILS", {ROUTERIDFK =#routerIndexD.getROUTERDETAILSID()#}, "APPROVERORDER ASC" ) >
	<cfloop array="#formApproversDataD#" index="approverIndexD" >
		<cftry>
			<cfset updateActionD = EntityLoad("EGINAPPROVERDETAILS", {APPROVERDETAILSID =#approverIndexD.getAPPROVERDETAILSID()#,ACTION='CURRENT'}, true ) >
			<cfset updateActionD.setACTION("IGNORED") >
			<cfset updateActionD.setDATELASTUPDATE("#dateformat(now(), "YYYY-MM-DD")# #timeformat(now(), "HH:MM:SS")#") >
			<cfset EntitySave(updateActionD) >
			<cfset ormflush() >
			<!---for the current router which is approved--->
			<cfinvoke component="routing" method="updateFormCount" eformid="#eformid#" personnelidno="#approverIndexD.getPERSONNELIDNO()#" theType="subtractneworpending">

			<!---end for the current router which is approved --->
			<cfcatch>
			</cfcatch>
		</cftry>
		<cftry>
			<cfset updateActionE = EntityLoad("EGINAPPROVERDETAILS", {APPROVERDETAILSID =#approverIndexD.getAPPROVERDETAILSID()#,ACTION='PENDING'}, true ) >
			<cfset updateActionE.setACTION("IGNORED") >
			<cfset updateActionE.setDATELASTUPDATE("#dateformat(now(), "YYYY-MM-DD")# #timeformat(now(), "HH:MM:SS")#") >
			<cfset EntitySave(updateActionE) >
			<cfset ormflush() >
			<cfcatch>
				<cfcontinue>
			</cfcatch>
		</cftry>
	</cfloop>
</cfloop>


<cfinvoke component="routing" method="getDatasourceCF" tablelevel="#firstlevel#" returnvariable="firstlevel" >


<cfset datetimenow = '#dateformat(now(), "YYYY-MM-DD")# #timeformat(now(), "HH:MM:SS")#' >

<cfquery name="updateFormTable" datasource="#firstlevel#" >
	UPDATE #firsttable#
	   SET APPROVED          = <cfqueryparam cfsqltype="cf_sql_varchar" value="D" >,
		   DATELASTUPDATE    =  <cfqueryparam cfsqltype="cf_sql_timestamp" value="#datetimenow#" >
     WHERE PROCESSID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#processid#" > AND
	       EFORMID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#eformid#" >
</cfquery>

	<cfinvoke component="routing" method="updateFormCount" eformid="#eformid#" personnelidno="#pid#" theType="disapproveone">

    <!---notify next approvers which is this approver(s)--->
	<cfif routerIndex.getNOTIFYORIGINATOR() eq "true">
		<cfset moreemailcopy = routerIndex.getMOREEMAILADD() >
		<cfset pidArray = ArrayNew(1) >
		<cfset ArrayAppend(pidArray, pid) >

		<cfinvoke 	method="notifyNextApprovers"
					component="email"
				  	returnvariable="resultemail"
				  	pidArray="#pidArray#"
				    eformid="#eformid#"
				  	processid="#processid#"
				    extraRecipients="#moreemailcopy#"
				    status="DISAPPROVED"
				    >
	</cfif>
	<!---end notifications --->

<!---The eForm is totally disapproved
make a clean up
delete schedulers but do not delete process router approvers information for viewing purposes--->
<cfinvoke method="deleteScheduledTask" >


</cffunction>






<cffunction name="sentBackToOriginatorRouter" >
<!---no need to update the process and router and approver here--->
<!---update eform table status--->
<cfinvoke component="routing" method="getDatasourceCF" tablelevel="#firstlevel#" returnvariable="firstlevel" >


<cfset datetimenow = '#dateformat(now(), "YYYY-MM-DD")# #timeformat(now(), "HH:MM:SS")#' >

<cfquery name="updateFormTable" datasource="#firstlevel#" >
	UPDATE #firsttable#
	   SET APPROVED          = <cfqueryparam cfsqltype="cf_sql_varchar" value="R" >,
		   DATELASTUPDATE    =  <cfqueryparam cfsqltype="cf_sql_timestamp" value="#datetimenow#" >
     WHERE PROCESSID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#processid#" > AND
	       EFORMID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#eformid#" >
</cfquery>

	<cfinvoke component="routing" method="updateFormCount" eformid="#eformid#" personnelidno="#pid#" theType="returnone">

	<!---notify next approvers which is this approver(s)--->
	<cfif routerIndex.getNOTIFYORIGINATOR() eq "true">
		<cfset moreemailcopy = routerIndex.getMOREEMAILADD() >
		<cfset pidArray = ArrayNew(1) >
		<cfset ArrayAppend(pidArray, pid) >

		<cfinvoke 	method="notifyNextApprovers"
					component="email"
				  	returnvariable="resultemail"
				  	pidArray="#pidArray#"
				    eformid="#eformid#"
				  	processid="#processid#"
				    extraRecipients="#moreemailcopy#"
				    status="RETURNED"
				    >
	</cfif>
	<!---end notifications --->



</cffunction>





<cffunction name="updateMainTable" >
<!---update eform table status--->
<cfinvoke component="routing" method="getDatasourceCF" tablelevel="#firstlevel#" returnvariable="firstlevel" >


<cfset datetimenow = '#dateformat(now(), "YYYY-MM-DD")# #timeformat(now(), "HH:MM:SS")#' >

<cfquery name="updateFormTable" datasource="#firstlevel#" >
	UPDATE #firsttable#
	   SET APPROVED          = <cfqueryparam cfsqltype="cf_sql_varchar" value="Y" >,
		   DATELASTUPDATE    =  <cfqueryparam cfsqltype="cf_sql_timestamp" value="#datetimenow#" >
     WHERE PROCESSID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#processid#" > AND
	       EFORMID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#eformid#" >
</cfquery>

<cfinvoke component="routing" method="updateFormCount" eformid="#eformid#" personnelidno="#pid#" theType="approveone">

</cffunction>



<cffunction name="ignoreCurrentAndPending" >
	<!---once done after the process has completed--->
	<cftry>
		<cfschedule action="delete" task="process#processid#" >
	<cfcatch>
		<cftry>
			<cfschedule action="delete" task="process#processid#" >
			<cfcatch>
			</cfcatch>
		</cftry>
	</cfcatch>
	</cftry>

	<cftry>
		<cfschedule action="delete" task="router#processid#" >
	<cfcatch>
		<cftry>
			<cfschedule action="delete" task="router#processid#" >
			<cfcatch>
			</cfcatch>
		</cftry>
	</cfcatch>
	</cftry>

	<cfloop array="#formRouterData#" index="routerIndexC" >
		<cfset updateRouterF = EntityLoad("EGINROUTERDETAILS", {ROUTERDETAILSID = #routerIndexC.getROUTERDETAILSID()#, STATUS='PENDING'}, true) >
		<cfif isdefined('updateRouterF') >
			<cfset updateRouterF.setSTATUS("IGNORED") >
			<cfset updateRouterF.setDATELASTUPDATE("#dateformat(now(), "YYYY-MM-DD")# #timeformat(now(), "HH:MM:SS")#") >
			<cfset EntitySave(updateRouterF) >
			<cfset ormflush() >
		</cfif>

		<cfset approverDataC = EntityLoad("EGINAPPROVERDETAILS", {ROUTERIDFK =#routerIndexC.getROUTERDETAILSID()#} ) >
		<cfloop array="#approverDataC#" index="approverIndexC" >
			<cftry>
				<cfset updateAction = EntityLoad("EGINAPPROVERDETAILS", {APPROVERDETAILSID =#approverIndexC.getAPPROVERDETAILSID()#,ACTION='CURRENT'}, true ) >
				<cfset updateAction.setACTION("IGNORED") >
				<cfset updateAction.setDATELASTUPDATE("#dateformat(now(), "YYYY-MM-DD")# #timeformat(now(), "HH:MM:SS")#") >
				<cfset EntitySave(updateAction) >
				<cfset ormflush() >
				<!---for the current router which is approved--->

				<cfinvoke component="routing" method="updateFormCount" eformid="#eformid#" personnelidno="#approverIndexC.getPERSONNELIDNO()#" theType="subtractneworpending">

				<!---end for the current router which is approved --->
				<cfcatch>
					<cfcontinue>
				</cfcatch>
			</cftry>

			<cftry>
				<cfset updateActionB = EntityLoad("EGINAPPROVERDETAILS", {APPROVERDETAILSID =#approverIndexC.getAPPROVERDETAILSID()#,ACTION='PENDING'}, true ) >
				<cfset updateActionB.setACTION("IGNORED") >
				<cfset updateActionB.setDATELASTUPDATE("#dateformat(now(), "YYYY-MM-DD")# #timeformat(now(), "HH:MM:SS")#") >
				<cfset EntitySave(updateActionB) >
				<cfset ormflush() >
				<cfcatch>
					<cfcontinue>
				</cfcatch>
			</cftry>

		</cfloop>
	</cfloop>

	<!---execute on complete process--->
	<cfset oncompleteprocess = ORMExecuteQuery("SELECT ONCOMPLETE
		  								       FROM EGRGEFORMS
		  								      WHERE EFORMID = '#eformid#'", true) >
	<cfif oncompleteprocess neq "NA" AND oncompleteprocess neq "">
		<cfinclude template="../fielddefinition/oncomplete/#oncompleteprocess#" >
	</cfif>
	<!---end on complete process--->
		<!---notes: before and after load : execute before and after loading forms data
		       before and after submit : execute before and after adding forms
		       before and after approve : execute before and after approving forms
		       on complete : execute after the eform is done either approved or disapproved--->
	<cfreturn "success" >

</cffunction>


<cffunction name="updateNotApprove" >

<cfset dcount = 0 >
<cfset ocount = 0 >
<cfloop array="#formApproversData#" index="approverIndexB" > <!---find from the above action wins--->
	<cfset theaction = approverIndexB.getACTION() >
	<cfif theaction eq "DISAPPROVED" >
	 	<cfset dcount = dcount + 1 >
	<cfelseif theaction eq "SENT BACK TO ORIGINATOR" >
		<cfset ocount = ocount + 1 >
	</cfif>

</cfloop>

<cfif dcount gt ocount> <!---disapproved wins--->
	<cfinvoke method="disapproveRouter" >
<cfelseif ocount gt dcount> <!---sent back to originator wins--->
	<cfinvoke method="sentBackToOriginatorRouter" >
</cfif>

</cffunction>




<cffunction name="gridApproveDisapprove" ExtDirect="true" >
	<cfargument name="eformid" >
	<cfargument name="processid" >
    <cfargument name="firstlevel" >
	<cfargument name="firsttable" >
	<cfargument name="actiontype" >
	<cfargument name="pid" >
<cftry>
	<!---set is read to true--->
	<cfinvoke method="setIsreadTrue"  returnvariable="result" component="data" eformid="#eformid#" processid="#processid#" >

	<cfset form.eformid = eformid > <!---since it is approved with grid data, make form scope for other required data--->
	<cfset form.comments = " " >
	<cfset "form.#firstlevel#__#firsttable#__PROCESSID" = processid >
	<cfset "form.#firstlevel#__#firsttable#__PERSONNELIDNO" = pid >
	<cfset firstlevel = firstlevel >
	<cfset firsttable = firsttable >
	<cfif actiontype eq "approve" >
		<cfinvoke method="approveForm"  >
		<cfinvoke method="logActivity" theaction="(Direct) Successfully approved an eForm: #form.eformid#, process id: #processid#" >
		<cfinvoke method="updateProcess"  >
	<cfelseif actiontype eq "disapprove" >
		<cfinvoke method="disapproveForm"  >
		<cfinvoke method="logActivity" theaction="(Direct) Successfully disapproved an eForm: #form.eformid#, process id: #processid#" >
		<cfinvoke method="updateProcess"  >
	<cfelse>
	</cfif>

<cfreturn "success" >
<cfcatch>
	<cfinvoke method="rollbackAction"  >
	<cfinvoke method="logActivity" theaction="Direct approve/disapprove on eForm error: #cfcatch.detail#, #cfcatch.message#" >
	<cfreturn cfcatch.detail & ' ' & cfcatch.message >
</cfcatch>
</cftry>
</cffunction>

<cffunction name="preUpdateProcess" access="public">
	<cfargument name="eformid" >
	<cfargument name="processid" >
	<cfargument name="pid" >
	<cfargument name="dbsource" >
	<cfargument name="tablename" >
	<cfset form.eformid = eformid > <!---since it is approved with grid data, make form scope for other required data--->
	<cfset form.comments = " " >
	<cfset "form.#dbsource#__#tablename#__PROCESSID" = processid >
	<cfset "form.#dbsource#__#tablename#__PERSONNELIDNO" = pid >
	<cfset firstlevel = dbsource >
	<cfset firsttable = tablename >
	<cfinvoke method="updateProcess"  >
	<cfreturn "success" >
</cffunction>


<cffunction name="deleteScheduledTask" >
	<cftry>
		<cfschedule action="delete" task="process#processid#" >
	<cfcatch>
		<cftry>
			<cfschedule action="delete" task="process#processid#" >
			<cfcatch>
			</cfcatch>
		</cftry>
	</cfcatch>
	</cftry>

	<cftry>
		<cfschedule action="delete" task="router#processid#" >
	<cfcatch>
		<cftry>
			<cfschedule action="delete" task="router#processid#" >
			<cfcatch>
			</cfcatch>
		</cftry>
	</cfcatch>
	</cftry>

	<cfreturn "success" >
</cffunction>



<cffunction name="rollbackAction" >
<cftry>
	<cfloop array="#getApprovers#" index="approverIndx">
		<cfset eginapproverdata = EntityLoad("EGINAPPROVERDETAILS", #approverIndx#, true ) >
		<cfset eginapproverdata.setACTION("CURRENT") >
		<cfset eginapproverdata.setISREAD("false") >
		<cfset EntitySave(eginapproverdata) >
		<cfset ormflush()>
	</cfloop>
<cfcatch>
</cfcatch>
</cftry>
</cffunction>


<cffunction name="getTheApprovers" access="private" output="true" returntype="void" >
	<cfset getApprovers = ORMExecuteQuery("SELECT C.APPROVERDETAILSID AS APPROVERDETAILSID
	  								     FROM EGINFORMPROCESSDETAILS A,EGINROUTERDETAILS B,EGINAPPROVERDETAILS C
	 								    WHERE A.PROCESSDETAILSID = B.PROCESSIDFK
	 								      		AND B.ROUTERDETAILSID = C.ROUTERIDFK
	 								      		AND C.PERSONNELIDNO = '#session.chapa#'
	 								      		AND A.PROCESSDETAILSID = '#processid#'
	 								      		AND C.ACTION = 'CURRENT'",false ) >
</cffunction>


<cffunction name="getIDofMainTable" access="private" output="true" returntype="void" >
	<cfset getMainTableID = ORMExecuteQuery("SELECT B.TABLENAME AS TABLENAME,
												B.LEVELID AS LEVELID,
												C.COLUMNNAME AS COLUMNNAME,
												A.ISENCRYPTED AS ISENCRYPTED,
												A.BEFORESUBMIT AS BEFORESUBMIT,
												A.AFTERSUBMIT AS AFTERSUBMIT,
												A.AUDITTDSOURCE AS AUDITTDSOURCE,
												A.AUDITTNAME AS AUDITTNAME,
												A.LOGDBSOURCE AS LOGDBSOURCE,
												A.LOGTABLENAME AS LOGTABLENAME,
												A.LOGFILENAME AS LOGFILENAME
	  								       FROM EGRGEFORMS A,
	  								       		EGRGIBOSETABLE B,
	  								       		EGRGIBOSETABLEFIELDS C
	 								      WHERE EFORMID = '#eformid#'
	 								      		AND A.EFORMID = B.EFORMIDFK
	 								      		AND B.TABLEID = C.TABLEIDFK
	 								      		AND C.XTYPE = 'id'
	 								         ", true) >
</cffunction>

<cffunction name="setEgrgformsVar" access="private" output="true" returntype="void" >
	<cfif trim(getMainTableID[1]) neq "" >
		<cfset firsttable  = getMainTableID[1] >
		<cfset firstlevel  = getMainTableID[2] >
		<cfset firstcolumn = getMainTableID[3] >
		<cfset isencrypted = getMainTableID[4] >
		<cfif arrayIsDefined(getMainTableID,7) >
			<cfset auditdatasource = getMainTableID[7] >
		<cfelse>
			<cfset auditdatasource = "NA" >
		</cfif>
		<cfif arrayIsDefined(getMainTableID,8) >
			<cfset audittablename  = getMainTableID[8] >
		<cfelse>
			<cfset audittablename = "NA" >
		</cfif>
		<cfif arrayIsDefined(getMainTableID,9) >
			<cfset logdatasource   = getMainTableID[9] >
		<cfelse>
			<cfset logdatasource = "NA" >
		</cfif>
		<cfif arrayIsDefined(getMainTableID,10) >
			<cfset logtablename    = getMainTableID[10] >
		<cfelse>
			<cfset logtablename = "NA" >
		</cfif>
		<cfif arrayIsDefined(getMainTableID,11) >
			<cfset logthefilename  = getMainTableID[11] >
		<cfelse>
			<cfset logthefilename = "NA" >
		</cfif>

	<cfelse>
		<cfthrow detail="Table has no id specified in table fields. At least one field type is an id type." >
	</cfif>

</cffunction>


<cffunction name="insertAudit" access="private" output="true" returntype="void">
	<cfset allowAudit = ucase(auditdatasource) neq "NA" and trim(auditdatasource) neq "" and ucase(audittablename) neq "NA" and trim(audittablename) neq "" >
	<cfif allowAudit >
		<cfquery name='dynamicQueryAudit' datasource='#auditdatasource#' >
			INSERT INTO #audittablename# ( #itemList#,
									PERSONNELIDNO,
									EFORMID,
									PROCESSID,
									APPROVED,
									RECDATECREATED,
									DATELASTUPDATE,
									OPERATION
									)

							VALUES (
									<cfloop array="#itemValArray#" index="colVal" >
										<cfqueryparam value="#colVal#" >,
									</cfloop>
									'#session.chapa#',
									'#eformid#',
									'#processid#',
									'N',
									'#dateformat(now(), "YYYY-MM-DD") & ' ' & timeformat(now(), "HH:MM:SS")#',
									'#dateformat(now(), "YYYY-MM-DD") & ' ' & timeformat(now(), "HH:MM:SS")#',
									'INSERTED' )
		</cfquery>
	</cfif>

	<cfinvoke method="logActivity" theaction="added an eForm: #eformid#, Process ID: #processid#" >


</cffunction>

<cffunction name="logActivity" access="public" output="true" returntype="void" >
<cfargument name="theaction" >
<cfargument name="logdatasource" required="false">
<cfargument name="logtablename" required="false">

	<cfset allowLogDB = ucase(logdatasource) neq "NA" and trim(logdatasource) neq "" and ucase(logtablename) neq "NA" and trim(logtablename) neq "" >
	<cfif allowLogDB >
		<cfquery name='dynamicLog' datasource='#logdatasource#' >
			INSERT INTO #logtablename# (
									PERSONNELIDNO,
									DATELASTUPDATE,
									OPERATION
									)

							VALUES ('#session.chapa#',
									'#dateformat(now(), "YYYY-MM-DD") & ' ' & timeformat(now(), "HH:MM:SS")#',
									'#theaction#' )
		</cfquery>
	</cfif>

	<cfset allowLogToFile = ucase(logthefilename) neq "NA" and trim(logthefilename) neq "">
	<cfif allowLogToFile>
		<cflog file="#logthefilename#" text="PID: #session.chapa#, #theaction#"  >
	</cfif>
</cffunction>


<cffunction name="insertUpdatedToAudit" >
	<cfset allowAudit = ucase(auditdatasource) neq "NA" and trim(auditdatasource) neq "" and ucase(audittablename) neq "NA" and trim(audittablename) neq "" >
	<cfif allowAudit >
		<cfdbinfo datasource="#theLevel#"
				  name="theColumns"
				  type="columns"
				  table="#theTables#"
		>
		<cfset colArr = ArrayNew(1) >

		<cfloop query="theColumns" >
			<cfset ArrayAppend(colArr, COLUMN_NAME) >
		</cfloop>
		<cfset columnList = ArrayToList(colArr, ',') >

		<cfquery name="insertSelect" datasource="#auditdatasource#" >
			INSERT INTO  #audittablename# (#columnList#)
			     SELECT #columnList#
			       FROM #theLevel#.#theTables#
			      WHERE EFORMID = '#form.eformid#' AND PROCESSID = '#theProcessCond#';
		</cfquery>
		<cfquery name="updatePrev" datasource="#auditdatasource#" >
			UPDATE  #audittablename#
			   SET OPERATION = <cfqueryparam value="UPDATED" cfsqltype="CF_SQL_VARCHAR">,
			       PERSONNELIDNO = <cfqueryparam value="#session.chapa#" cfsqltype="CF_SQL_VARCHAR">,
			       DATELASTUPDATE = <cfqueryparam value="#dateformat(now(), 'YYYY-MM-DD') & ' ' & timeformat(now(), 'HH:MM:SS')#" cfsqltype="CF_SQL_TIMESTAMP" >
			 WHERE EFORMID = '#form.eformid#' AND PROCESSID = '#theProcessCond#';
		</cfquery>
	</cfif>
</cffunction>


</cfcomponent>