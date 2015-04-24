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
												A.BEFORELOAD AS BEFORELOAD
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
<cfset columnAutoGenCol    = ArrayNew(1)  >
<cfset columnAutoGenVal    = ArrayNew(1)  >

<!---establish the fields alias name for grid dataindex and form name--->
	
<cfloop array="#gettheForm#" index="tableModel">
	<cfset colModel = tableModel[3] & '__' & tableModel[2] & '__' & tableModel[4] > 
	
	<!---display fields with value are not included. ---> 
	<cfif tableModel[6] eq 'displayfield' AND firsttable neq tableModel[2] AND trim(tableModel[7]) eq "" AND trim(tableModel[5]) eq "">
		<cfset ArrayAppend(columnNameModel, colModel) >
	</cfif>
	
	<cfif trim(tableModel[5]) neq "" > <!---autogen text has a value--->
		<cfset ArrayAppend(columnAutoGenCol, colModel) > 
		<cfset ArrayAppend(columnAutoGenVal, trim(tableModel[5])) >
	</cfif>
	
	<cfset beforeload = tableModel[8] >
	
</cfloop>

<!---execute eform's before load process--->
<cfif beforeload neq "NA" AND beforeload neq "">
	<cfinclude template="../fielddefinition/beforeload/#beforeload#" >
</cfif>
<!---end before load process, afterload is found in data.cfc--->

<cfset selectArray = ArrayNew(1) >
<cfset fromArray   = ArrayNew(1) >
<cfset whereArray  = ArrayNew(1) >
<cfset groupTable  = StructNew() >

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
			<cfset ArrayAppend(whereArray,"#theTableName#.PERSONNELIDNO = '#client.chapa#'") >
			<cfset groupTable['#theTableName#'] = "_" >
		</cfif>
		
</cfloop>

<cfif ArrayLen(selectArray) gt 0 >
		<cfset theSelection = ArrayToList(selectArray, ",") >
		<cfset theTable      = ArrayToList(fromArray, ",") >
		<cfset theCondition = ArrayToList(whereArray, " AND ") >
		
		
		<cfset theQuery = "SELECT #theSelection# 
							FROM #theTable#
						   WHERE #theCondition#">
				   
		<cfquery name="qryDynamic" datasource="#client.global_dsn#" maxrows="1">
			#preservesinglequotes(theQuery)#
		</cfquery>
			  	
		<!--- end generate script --->
			<cfset rootstuct = StructNew() >
			
			
			<cfloop query="qryDynamic" startrow="1" endrow="1" >
				<cfset tmpresult = StructNew() > <!---Creates new structure in every loop to be added to the array--->
				
					<cfloop array="#columnNameModel#" index="outIndex" >
						<cfset tmpresult['#outIndex#']      = evaluate(outIndex)  >
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
		
		
		
		<cfset tmpresult['#autogencolname#'] =  newVal>  
	</cfloop>
	
	<cfset returnStruct = StructNew() >
	
	<cfset returnStruct['success'] = "true" >
	<cfset returnStruct['data']   = tmpresult >
	<cfreturn returnStruct >
<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message >
</cfcatch>
</cftry>
</cffunction> 





<cffunction name="submit" ExtDirect="true" ExtFormHandler="true">

<cftry>

<cfset returnStruct = StructNew() >
	
<cfif form.action eq "save" >
	<cftry>
		<cfinvoke method="saveForm"  > 
		<cfset returnStruct['success'] = "true" >
		<cfset returnStruct['data']   = form.eformid >
		<cfreturn returnStruct>
	<cfcatch>
		<cfreturn cfcatch.detail & ' ' & cfcatch.message >
	</cfcatch>
	</cftry>
</cfif>
	
<cfif form.action eq "approve" >
	<cftry>
		<cfinvoke method="saveForm"  >
		<cfinvoke method="approveForm"  >  
		
		<cfinvoke method="updateProcess"  >
		<cfset returnStruct['success'] = "true" >
		<cfset returnStruct['data']   = form.eformid > 
		<cfreturn returnStruct>
	<cfcatch>
		<cfinvoke method="rollbackAction"  > 
		<cfreturn cfcatch.detail & ' ' & cfcatch.message >
	</cfcatch>
	</cftry>
</cfif>

	
<cfif form.action eq "disapprove" >
	<cftry>
		<cfinvoke method="saveForm"  >
		<cfinvoke method="disapproveForm"  >
		<cfinvoke method="updateProcess"  > 
		<cfset returnStruct['success'] = "true" >
		<cfset returnStruct['data']   = form.eformid > 
		<cfreturn returnStruct>
	<cfcatch>
		<cfinvoke method="rollbackAction"  > 
		<cfreturn cfcatch.detail & ' ' & cfcatch.message >
	</cfcatch>
	</cftry>
</cfif>

	
<cfif form.action eq "returntooriginator" >
	<cftry> 
		<cfinvoke method="saveForm"  >
		<cfinvoke method="sentBacktoOriginatorForm"  > 
		<cfinvoke method="updateProcess"  >
		<cfset returnStruct['success'] = "true" >
		<cfset returnStruct['data']   = form.eformid >
		<cfreturn returnStruct>
	<cfcatch>
		<cfinvoke method="rollbackAction"  > 
		<cfreturn cfcatch.detail & ' ' & cfcatch.message >
	</cfcatch>
	</cftry>
</cfif>


<!--- Set up an array to hold errors. --->
<cfset arrErrors = ArrayNew( 1 ) /> 

<cfif ListGetAt(form.withFile, 1) eq "true" >
	<cfset formDir = ExpandPath( "../../../unDB/forms/#client.companycode#/" ) />
	<cfif Not directoryExists(formDir) >
		<cfdirectory action="create" directory="#formDir#" mode="777" >
	</cfif> 
	
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
					<cfset ArrayAppend(
						arrUploaded,
						(CFFILE.ServerDirectory & "\" & CFFILE.ServerFile)
						) />
						
					<cfset arrServerFile[intFileIndex] = CFFILE.ServerFile />


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


<cfset getMainTableID = ORMExecuteQuery("SELECT B.TABLENAME AS TABLENAME, 
												B.LEVELID AS LEVELID, 
												C.COLUMNNAME AS COLUMNNAME, 
												A.ISENCRYPTED AS ISENCRYPTED,
												A.BEFORESUBMIT AS BEFORESUBMIT,
												A.AFTERSUBMIT AS AFTERSUBMIT
	  								      FROM EGRGEFORMS A,EGRGIBOSETABLE B,EGRGIBOSETABLEFIELDS C
	 								      WHERE EFORMID = '#eformid#' AND A.EFORMID = B.EFORMIDFK AND B.TABLEID = C.TABLEIDFK AND C.XTYPE = 'id'", true) >

<!---execute before submit--->
<cfif getMainTableID[5] neq "NA" AND getMainTableID[5] neq "">
	<cfinclude template="../fielddefinition/beforesubmit/#getMainTableID[5]#" > 
</cfif>
<!---end before submit--->

	<cfif trim(getMainTableID[1]) neq "" >
		<cfset firsttable  = getMainTableID[1] >
		<cfset firstlevel  = getMainTableID[2] >
		<cfset firstcolumn = getMainTableID[3] >
		<cfset isencrypted = getMainTableID[4] >
	<cfelse>
		<cfthrow detail="Table has no id specified in table fields. At least one field type is an id type." >
	</cfif>
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
				<cfset theTableLevel = ListGetAt( formIndex, 1, "__" ) >
				<cfset theTableName  = ListGetAt( formIndex, 2, "__"  ) >
				<cfset theColumnName = ListGetAt( formIndex, 3, "__"  ) >
				
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
					<cfset colVal = encrypt(colVal, client.ek) >  
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
		<cfif theLevel eq "G" >
			<cfset theLevel = "#client.global_dsn#" >
		<cfelseif theLevel eq "C" >
			<cfset theLevel = "#client.company_dsn#" >			
		<cfelseif theLevel eq "S" >
			<cfset theLevel = "#client.subco_dsn#" >
		<cfelseif theLevel eq "Q" >
			<cfset theLevel = "#client.query_dsn#" >
		<cfelseif theLevel eq "T" >
			<cfset theLevel = "#client.transact_dsn#" >
		<cfelseif theLevel eq "SD" >
			<cfset theLevel = "#client.site_dsn#" >
		<cfelse>
			
		</cfif>
		
		
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
									'#client.chapa#',
									'#eformid#',
									'#processid#',
									'N',
									'#dateformat(now(), "YYYY-MM-DD") & ' ' & timeformat(now(), "HH:MM:SS")#',
									'#dateformat(now(), "YYYY-MM-DD") & ' ' & timeformat(now(), "HH:MM:SS")#' )
		</cfquery>
		
						   
			
		
	</cfloop>

<!---execute after submit--->
<cfif getMainTableID[6] neq "NA" AND getMainTableID[6] neq "" >
	<cfinclude template="../fielddefinition/aftersubmit/#getMainTableID[6]#" > 
</cfif>
<!---end after submit--->
	
	<cfset returnStruct['success'] = "true" >
	<cfset returnStruct['data']   = arrErrors >
	
<cfcatch>
	
	
	<cfset tableArr = StructKeyArray(tableStruct) >
	<cfloop array="#tableArr#" index="theTables" >
		<cfset itemArray = tableStruct['#theTables#'] >
		<cfset itemList  = ArrayToList( itemArray, "," ) >
		<cfset itemValArray = tableValStruct['#theTables#'] >
		
		<cfset theLevel = evaluate("level#theTables#") >
		<cfif theLevel eq "G" >
			<cfset theLevel = "#client.global_dsn#" >
		<cfelseif theLevel eq "C" >
			<cfset theLevel = "#client.company_dsn#" >			
		<cfelseif theLevel eq "S" >
			<cfset theLevel = "#client.subco_dsn#" >
		<cfelseif theLevel eq "Q" >
			<cfset theLevel = "#client.query_dsn#" >
		<cfelseif theLevel eq "T" >
			<cfset theLevel = "#client.transact_dsn#" >
		<cfelseif theLevel eq "SD" >
			<cfset theLevel = "#client.site_dsn#" >
		<cfelse>
			
		</cfif>
		
		<cfquery name='dynamicQuery' datasource='#theLevel#' >
			DELETE FROM #theTables# 
				WHERE <cfloop from="1" to="#ArrayLen(itemValArray)#" index="cntr" >
						#itemArray[cntr]# = <cfqueryparam value="#itemValArray[cntr]#" > 
						<cfif Not cntr eq ArrayLen(itemValArray)>
							AND
						</cfif>
					  </cfloop>
		</cfquery>
	   <cfset returnStruct['data']   = "#cfcatch.detail# #cfcatch.message#" >
	</cfloop>
	
</cfcatch>
</cftry>
	
<cfelse>
	<cfset returnStruct['data']   = "emptyForm" >
</cfif>	
</cffunction>






<cffunction name="saveFormAfterFileUpload" >
<cfargument name = "eformid" >


<cfset getMainTableID = ORMExecuteQuery("SELECT B.TABLENAME AS TABLENAME, 
												B.LEVELID AS LEVELID, 
												C.COLUMNNAME AS COLUMNNAME, 
												A.ISENCRYPTED AS ISENCRYPTED,
												A.BEFORESUBMIT AS BEFORESUBMIT,
												A.AFTERSUBMIT AS AFTERSUBMIT
	  								      FROM EGRGEFORMS A,EGRGIBOSETABLE B,EGRGIBOSETABLEFIELDS C
	 								      WHERE EFORMID = '#eformid#' AND A.EFORMID = B.EFORMIDFK AND B.TABLEID = C.TABLEIDFK AND C.XTYPE = 'id'", true) >


<!---execute before submit--->
<cfif getMainTableID[5] neq "NA" AND getMainTableID[5] neq "">
	<cfinclude template="../fielddefinition/beforesubmit/#getMainTableID[5]#" > 
</cfif>
<!---end before submit--->
	
	<cfif trim(getMainTableID[1]) neq "" >
		<cfset firsttable  = getMainTableID[1] >
		<cfset firstlevel  = getMainTableID[2] >
		<cfset firstcolumn = getMainTableID[3] >
		<cfset isencrypted = getMainTableID[4] >
	<cfelse>
		<cfthrow detail="Table has no id specified in table fields. At least one field type is an id type." >
	</cfif>
	
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
				<cfset theTableLevel = ListGetAt( formIndex, 1, "__" ) >
				<cfset theTableName  = ListGetAt( formIndex, 2, "__"  ) >
				<cfset theColumnName = ListGetAt( formIndex, 3, "__"  ) >
				
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
					<cfset colVal = encrypt(colVal, client.ek) >  
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
		<cfif theLevel eq "G" >
			<cfset theLevel = "#client.global_dsn#" >
		<cfelseif theLevel eq "C" >
			<cfset theLevel = "#client.company_dsn#" >			
		<cfelseif theLevel eq "S" >
			<cfset theLevel = "#client.subco_dsn#" >
		<cfelseif theLevel eq "Q" >
			<cfset theLevel = "#client.query_dsn#" >
		<cfelseif theLevel eq "T" >
			<cfset theLevel = "#client.transact_dsn#" >
		<cfelseif theLevel eq "SD" >
			<cfset theLevel = "#client.site_dsn#" >
		<cfelse>
			
		</cfif>
		
		
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
									'#client.chapa#',
									'#eformid#',
									'#processid#',
									'N',
									'#dateformat(now(), "YYYY-MM-DD") & ' ' & timeformat(now(), "HH:MM:SS")#',
									'#dateformat(now(), "YYYY-MM-DD") & ' ' & timeformat(now(), "HH:MM:SS")#' )
		</cfquery>
		
						   
			
		
	</cfloop>
	
	<cfset returnStruct['success'] = "true" >
	<cfset returnStruct['data']   = arrErrors >

<!---execute after submit--->
<cfif getMainTableID[6] neq "NA" AND getMainTableID[6] neq "" >
	<cfinclude template="../fielddefinition/aftersubmit/#getMainTableID[6]#" > 
</cfif>
<!---end after submit--->
	
<cfcatch>
	
	<cfset tableArr = StructKeyArray(tableStruct) >
	<cfloop array="#tableArr#" index="theTables" >
		<cfset itemArray = tableStruct['#theTables#'] >
		<cfset itemList  = ArrayToList( itemArray, "," ) >
		<cfset itemValArray = tableValStruct['#theTables#'] >
		
		<cfset theLevel = evaluate("level#theTables#") >
		<cfif theLevel eq "G" >
			<cfset theLevel = "#client.global_dsn#" >
		<cfelseif theLevel eq "C" >
			<cfset theLevel = "#client.company_dsn#" >			
		<cfelseif theLevel eq "S" >
			<cfset theLevel = "#client.subco_dsn#" >
		<cfelseif theLevel eq "Q" >
			<cfset theLevel = "#client.query_dsn#" >
		<cfelseif theLevel eq "T" >
			<cfset theLevel = "#client.transact_dsn#" >
		<cfelseif theLevel eq "SD" >
			<cfset theLevel = "#client.site_dsn#" >
		<cfelse>
			
		</cfif>
		
		<cfquery name='dynamicQuery' datasource='#theLevel#' >
			DELETE FROM #theTables# 
				WHERE <cfloop from="1" to="#ArrayLen(itemValArray)#" index="cntr" >
						#itemArray[cntr]# = <cfqueryparam value="#itemValArray[cntr]#" > 
						<cfif Not cntr eq ArrayLen(itemValArray)>
							AND
						</cfif>
					  </cfloop>
		</cfquery>
		
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


<cffunction name="saveForm" returntype="String" >


<cfset getMainTableID = ORMExecuteQuery("SELECT B.TABLENAME AS TABLENAME, B.LEVELID AS LEVELID, C.COLUMNNAME AS COLUMNNAME, A.ISENCRYPTED AS ISENCRYPTED
	  								      FROM EGRGEFORMS A,EGRGIBOSETABLE B,EGRGIBOSETABLEFIELDS C
	 								      WHERE EFORMID = '#eformid#' AND A.EFORMID = B.EFORMIDFK AND B.TABLEID = C.TABLEIDFK AND C.XTYPE = 'id'", true) >

	<cfif trim(getMainTableID[1]) neq "" >
		<cfset firsttable  = getMainTableID[1] >
		<cfset firstlevel  = getMainTableID[2] >
		<cfset firstcolumn = getMainTableID[3] >
		<cfset isencrypted = getMainTableID[4] >
	<cfelse>
		<cfthrow detail="Table has no id specified in table fields. At least one field type is an id type." >
	</cfif>
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
				<cfset theTableLevel = ListGetAt( formIndex, 1, "__" ) >
				<cfset theTableName  = ListGetAt( formIndex, 2, "__"  ) >
				<cfset theColumnName = ListGetAt( formIndex, 3, "__"  ) >
				
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
					<cfset colVal = encrypt(colVal, client.ek) >  
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
		<cfif theLevel eq "G" >
			<cfset theLevel = "#client.global_dsn#" >
		<cfelseif theLevel eq "C" >
			<cfset theLevel = "#client.company_dsn#" >			
		<cfelseif theLevel eq "S" >
			<cfset theLevel = "#client.subco_dsn#" >
		<cfelseif theLevel eq "Q" >
			<cfset theLevel = "#client.query_dsn#" >
		<cfelseif theLevel eq "T" >
			<cfset theLevel = "#client.transact_dsn#" >
		<cfelseif theLevel eq "SD" >
			<cfset theLevel = "#client.site_dsn#" >
		<cfelse>
			
		</cfif>
		
		
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
		
		
	</cfloop>
	
	
	<!---check if this form a returned form--->
	<cfset isReturned = "form.#firstlevel#__#firsttable#__APPROVED" >
	<cfset isReturned = evaluate(isReturned) >
	<cfif isReturned eq "R" > <!---saving returned form will continue to the routing process--->
		<cfset theLevel = firstlevel >
		<cfif theLevel eq "G" >
			<cfset theLevel = "#client.global_dsn#" >
		<cfelseif theLevel eq "C" >
			<cfset theLevel = "#client.company_dsn#" >			
		<cfelseif theLevel eq "S" >
			<cfset theLevel = "#client.subco_dsn#" >
		<cfelseif theLevel eq "Q" >
			<cfset theLevel = "#client.query_dsn#" >
		<cfelseif theLevel eq "T" >
			<cfset theLevel = "#client.transact_dsn#" >
		<cfelseif theLevel eq "SD" >
			<cfset theLevel = "#client.site_dsn#" >
		<cfelse>
			
		</cfif> 
		
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
					
					
					<cfset updateCount = EntityLoad("EGINEFORMCOUNT", { EFORMID =#form.eformid#, PERSONNELIDNO = #updateActionD.getPERSONNELIDNO()#}, true ) >	
					<cfif isdefined("updateCount") >
						<cfset currentCount = updateCount.getNEW() + 1 >
						<cfset updateCount.setNEW(currentCount) >
						<cfset EntitySave(updateCount) > 
						<cfset ormflush()>   
					</cfif>
					
					
					<cfset EntitySave(updateActionD) >
					<cfset ormflush() >
					
				</cfif>	
			</cfloop>
		</cfloop>
		
		<!---update counter, no need to delete on error--->
		
			<cfset updateCount = EntityLoad("EGINEFORMCOUNT", { EFORMID =#form.eformid#, PERSONNELIDNO = #client.chapa#}, true ) >	
			<cfif isdefined("updateCount") >
				<cfif updateCount.getRETURNED() gt 0>	
					<cfset currentCount = updateCount.getRETURNED() - 1 >
					<cfset updateCount.setRETURNED(currentCount) >
					<cfset EntitySave(updateCount) > 
					<cfset ormflush()>   
			    </cfif> 
			</cfif>
		
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
												A.AFTERAPPROVE AS AFTERAPPROVE
	  								      FROM EGRGEFORMS A,EGRGIBOSETABLE B,EGRGIBOSETABLEFIELDS C
	 								      WHERE EFORMID = '#eformid#' AND A.EFORMID = B.EFORMIDFK AND B.TABLEID = C.TABLEIDFK AND C.XTYPE = 'id'", true) >


<!---execute before approve--->
<cfif getMainTableID[5] neq "NA" AND getMainTableID[5] neq "">
	<cfinclude template="../fielddefinition/beforeapprove/#getMainTableID[5]#" > 
</cfif>
<!---end before approve--->
	


<cfif trim(getMainTableID[1]) neq "" >
	<cfset firsttable  = getMainTableID[1] >
	<cfset firstlevel  = getMainTableID[2] >
	<cfset firstcolumn = getMainTableID[3] >
<cfelse>
	<cfthrow detail="Table has no id specified in table fields. At least one field type is an id type." >
</cfif>
<cfset processid = evaluate("form.#firstlevel#__#firsttable#__PROCESSID") >

<cfset getApprovers = ORMExecuteQuery("SELECT C.APPROVERDETAILSID AS APPROVERDETAILSID
	  								     FROM EGINFORMPROCESSDETAILS A,EGINROUTERDETAILS B,EGINAPPROVERDETAILS C
	 								    WHERE A.PROCESSDETAILSID = B.PROCESSIDFK 
	 								      		AND B.ROUTERDETAILSID = C.ROUTERIDFK 
	 								      		AND C.PERSONNELIDNO = '#client.chapa#'
	 								      		AND A.PROCESSDETAILSID = '#processid#'
	 								      		AND C.ACTION = 'CURRENT'",false ) > 


<cfloop array="#getApprovers#" index="approverIndx">
	<cfset eginapproverdata = EntityLoad("EGINAPPROVERDETAILS", #approverIndx#, true ) >
	<cfset eginapproverdata.setACTION("APPROVED") >
	<cfset eginapproverdata.setISREAD("true") > 
	<cfset eginapproverdata.setDATEACTIONWASDONE("#dateformat(now(), 'YYYY-MM-DD')# #timeformat(now(), 'HH:MM:SS')#") >
	<cfset eginapproverdata.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')# #timeformat(now(), 'HH:MM:SS')#") >
	<cfset eginapproverdata.setCOMMENTS("#form.comments#") >
	<cfset EntitySave(eginapproverdata) > 
	<cfset ormflush()> 
</cfloop>


<!---execute after approve--->
<cfif getMainTableID[6] neq "NA" AND getMainTableID[6] neq "" >
	<cfinclude template="../fielddefinition/aftersubmit/#getMainTableID[6]#" > 
</cfif>
<!---end after approve--->

</cffunction>




<cffunction name="disapproveForm" >
<cfset eformid = form.eformid>

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
<cfset processid = evaluate("form.#firstlevel#__#firsttable#__PROCESSID") >

<cfset getApprovers = ORMExecuteQuery("SELECT C.APPROVERDETAILSID AS APPROVERDETAILSID
	  								     FROM EGINFORMPROCESSDETAILS A,EGINROUTERDETAILS B,EGINAPPROVERDETAILS C
	 								    WHERE A.PROCESSDETAILSID = B.PROCESSIDFK 
	 								      		AND B.ROUTERDETAILSID = C.ROUTERIDFK 
	 								      		AND C.PERSONNELIDNO = '#client.chapa#'
	 								      		AND A.PROCESSDETAILSID = '#processid#'
	 								      		AND C.ACTION = 'CURRENT'",false ) > 

<cfloop array="#getApprovers#" index="approverIndx">
	<cfset eginapproverdata = EntityLoad("EGINAPPROVERDETAILS", #approverIndx#, true ) >
	<cfset eginapproverdata.setACTION("DISAPPROVED") >
	<cfset eginapproverdata.setISREAD("true") > 
	<cfset eginapproverdata.setDATEACTIONWASDONE("#dateformat(now(), 'YYYY-MM-DD')# #timeformat(now(), 'HH:MM:SS')#") >
	<cfset eginapproverdata.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')# #timeformat(now(), 'HH:MM:SS')#") >
	<cfset eginapproverdata.setCOMMENTS("#form.comments#") >
	<cfset EntitySave(eginapproverdata) > 
	<cfset ormflush()> 
</cfloop>

</cffunction>





<cffunction name="sentBackToOriginatorForm" >
<cfset eformid = form.eformid>

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
<cfset processid = evaluate("form.#firstlevel#__#firsttable#__PROCESSID") >

<cfset getApprovers = ORMExecuteQuery("SELECT C.APPROVERDETAILSID AS APPROVERDETAILSID
	  								     FROM EGINFORMPROCESSDETAILS A,EGINROUTERDETAILS B,EGINAPPROVERDETAILS C
	 								    WHERE A.PROCESSDETAILSID = B.PROCESSIDFK 
	 								      		AND B.ROUTERDETAILSID = C.ROUTERIDFK 
	 								      		AND C.PERSONNELIDNO = '#client.chapa#'
	 								      		AND A.PROCESSDETAILSID = '#processid#'
	 								      		AND C.ACTION = 'CURRENT'",false ) > 

<cfloop array="#getApprovers#" index="approverIndx">
	<cfset eginapproverdata = EntityLoad("EGINAPPROVERDETAILS", #approverIndx#, true ) >
	<cfset eginapproverdata.setACTION("SENT BACK TO ORIGINATOR") >
	<cfset eginapproverdata.setISREAD("false") >  
	<cfset eginapproverdata.setDATEACTIONWASDONE("#dateformat(now(), 'YYYY-MM-DD')# #timeformat(now(), 'HH:MM:SS')#") >
	<cfset eginapproverdata.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')# #timeformat(now(), 'HH:MM:SS')#") >
	<cfset eginapproverdata.setCOMMENTS("#form.comments#") >
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
									
									<cfset updateCount = EntityLoad("EGINEFORMCOUNT", { EFORMID =#eformid#, PERSONNELIDNO = #updateActionB.getPERSONNELIDNO()#}, true ) >  
									<cfif isdefined("updateCount") >	
										<cfset currentCount = updateCount.getNEW() + 1 >
										<cfset updateCount.setNEW(currentCount) >
									<cfelse>
										<cfset updateCount = EntityNew("EGINEFORMCOUNT") >
										<cfset updateCount.setNEW("1") >
										<cfset updateCount.setEFORMID(eformid) >
										<cfset updateCount.setPERSONNELIDNO(updateActionB.getPERSONNELIDNO()) >
										<cfset updateCount.setPENDING("0") >
										<cfset updateCount.setRETURNED("0") > 
									</cfif> 	
									<cfset EntitySave(updateCount) >  
									<cfset ormflush()>
									
									
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
			 	 <cfif approverIndex.getACTION() eq "APPROVED" >
				  	  <cfset ArrayAppend(approveArr, "APPROVED") >
				 <cfelseif approverIndex.getACTION() eq "PENDING" AND previousRouterIsDone eq "true" > <!---set as the current approver(s) bcoz the last router is done--->
				 	 <cfset updateApprover = EntityLoad("EGINAPPROVERDETAILS", {APPROVERDETAILSID =#approverIndex.getAPPROVERDETAILSID()#}, true ) >
					 
					    <cfset updateCount = EntityLoad("EGINEFORMCOUNT", { EFORMID =#eformid#, PERSONNELIDNO = #updateApprover.getPERSONNELIDNO()#}, true ) >  
						<cfif isdefined("updateCount") >	
							<cfset currentCount = updateCount.getNEW() + 1 >
							<cfset updateCount.setNEW(currentCount) >
						<cfelse>
							<cfset updateCount = EntityNew("EGINEFORMCOUNT") >  
							<cfset updateCount.setNEW("1") >
							<cfset updateCount.setEFORMID(eformid) >
							<cfset updateCount.setPERSONNELIDNO(updateApprover.getPERSONNELIDNO()) >
							<cfset updateCount.setPENDING("0") >
							<cfset updateCount.setRETURNED("0") >
						</cfif> 	
						<cfset EntitySave(updateCount) >  
						<cfset ormflush()> 
					 
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
					 	 <cfif approverIndexD.getACTION() eq "APPROVED" OR approverIndexD.getACTION() eq "PENDING" OR approverIndexD.getACTION() eq "CURRENT">
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
<cfset updateCount = EntityLoad("EGINEFORMCOUNT", { EFORMID =#eformid#, PERSONNELIDNO = #client.chapa#}, true ) >
<cfif isdefined("updateCount") >
	<cfif updateCount.getPENDING() gt 0 >	
		<cfset currentCount = updateCount.getPENDING() - 1 >
		<cfset updateCount.setPENDING(currentCount) >
	<cfelseif updateCount.getNEW() gt 0 >	
		<cfset currentCount = updateCount.getNEW() - 1 >
		<cfset updateCount.setNEW(currentCount) > 
	</cfif> 
	<cfset EntitySave(updateCount) >  
	<cfset ormflush()>   
<!---end for the current router which is approved --->	 
</cfif>

<!---schedule followups--->
<cfif ArrayLen(freqArray) neq 0 >
	<cfset freqinhours = freqArray[1]*60*60 > <!---in seconds--->
	<cfset endDateB    = expirArray[1] >
	<cfset therouterdetailsid = therouterdetailsid[1] > 
	
	<cfset subcomdsn = client.subco_dsn >
	<cfset querydsn = client.query_dsn >
	<cfset transactiondsn = client.transaction_dsn >
	<cfset sitedsn = client.site_dsn > 
	
	<cftry>
		<!---make schedule for next approvers---> 
		<cfschedule
			action      	 = "update" 
		    task        	 = "router#processid#"
			operation   	 = "HTTPRequest"  
			interval    	 = "#freqinhours#"  
			startdate   	 = "#dateformat(endDateB, 'mm/dd/yy')#" 
			starttime   	 = "#timeformat(endDateB, 'short')#"   
			url        	 	 = "#client.domain#myapps/form/simulator/schedule.cfm?eformid=#eformid#&processid=#processid#&action=followupemail&domain=#client.domain#&routerid=#therouterdetailsid#&companydsn=#client.company_dsn#&globaldsn=#client.global_dsn#&companyname=#client.companyname#&subcomdsn=#subcomdsn#&querydsn=#querydsn#&transactiondsn=#transactiondsn#&sitedsn=#sitedsn#" 
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
			<cfset updateCount = EntityLoad("EGINEFORMCOUNT", { EFORMID =#eformid#, PERSONNELIDNO = #approverIndexC.getPERSONNELIDNO()#}, true ) >
			<cfif isdefined("updateCount") >
					<cfif updateCount.getPENDING() gt 0 >	
						<cfset currentCount = updateCount.getPENDING() - 1 >
						<cfset updateCount.setPENDING(currentCount) >
					<cfelseif updateCount.getNEW() gt 0 >	
						<cfset currentCount = updateCount.getNEW() - 1 >
						<cfset updateCount.setNEW(currentCount) > 
					</cfif> 
					<cfset EntitySave(updateCount) >  
					<cfset ormflush()>   
			<!---end for the current router which is approved --->	
			</cfif>
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
			<cfset updateCount = EntityLoad("EGINEFORMCOUNT", { EFORMID =#eformid#, PERSONNELIDNO = #approverIndexD.getPERSONNELIDNO()#}, true ) >
			<cfif isdefined("updateCount") >
				    <cfif updateCount.getPENDING() gt 0 >	
						<cfset currentCount = updateCount.getPENDING() - 1 >
						<cfset updateCount.setPENDING(currentCount) >
					<cfelseif updateCount.getNEW() gt 0 >	
						<cfset currentCount = updateCount.getNEW() - 1 >
						<cfset updateCount.setNEW(currentCount) > 
					</cfif>  
					<cfset EntitySave(updateCount) >  
					<cfset ormflush()>   
			<!---end for the current router which is approved --->	
			</cfif>
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
	
	

<cfif firstlevel eq "G" >
	<cfset firstlevel = "#client.global_dsn#" >
<cfelseif firstlevel eq "C" >
	<cfset firstlevel = "#client.company_dsn#" >			
<cfelseif firstlevel eq "S" >
	<cfset firstlevel = "#client.subco_dsn#" >
<cfelseif firstlevel eq "Q" >
	<cfset firstlevel = "#client.query_dsn#" >
<cfelseif firstlevel eq "T" >
	<cfset firstlevel = "#client.transact_dsn#" >
<cfelseif firstlevel eq "SD" >
	<cfset firstlevel = "#client.site_dsn#" >
<cfelse>
	
</cfif>

<cfset datetimenow = '#dateformat(now(), "YYYY-MM-DD")# #timeformat(now(), "HH:MM:SS")#' >

<cfquery name="updateFormTable" datasource="#firstlevel#" >
	UPDATE #firsttable#
	   SET APPROVED          = <cfqueryparam cfsqltype="cf_sql_varchar" value="D" >,
		   DATELASTUPDATE    =  <cfqueryparam cfsqltype="cf_sql_timestamp" value="#datetimenow#" >
     WHERE PROCESSID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#processid#" > AND 
	       EFORMID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#eformid#" >
</cfquery>

	<cfset updateCount = EntityLoad("EGINEFORMCOUNT", { EFORMID =#eformid#, PERSONNELIDNO = #pid#}, true ) >
	<cfif isdefined("updateCount") >	
		<cfset currentCount = updateCount.getDISAPPROVED() + 1 >
		<cfset updateCount.setDISAPPROVED(currentCount) >
	<cfelse>
		<cfset updateCount = EntityNew("EGINEFORMCOUNT") >
		<cfset updateCount.setEFORMID(eformid) >
		<cfset updateCount.setPERSONNELIDNO(pid) >
		<cfset updateCount.setPENDING("0") >
		<cfset updateCount.setRETURNED("0") >
		<cfset updateCount.setNEW("0") >
		<cfset updateCount.setAPPROVED("0") >
		<cfset updateCount.setDISAPPROVED("1") >
	</cfif> 	
	<cfset EntitySave(updateCount) >  
	<cfset ormflush()>
		
		
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

<cfif firstlevel eq "G" >
	<cfset firstlevel = "#client.global_dsn#" >
<cfelseif firstlevel eq "C" >
	<cfset firstlevel = "#client.company_dsn#" >			
<cfelseif firstlevel eq "S" >
	<cfset firstlevel = "#client.subco_dsn#" >
<cfelseif firstlevel eq "Q" >
	<cfset firstlevel = "#client.query_dsn#" >
<cfelseif firstlevel eq "T" >
	<cfset firstlevel = "#client.transact_dsn#" >
<cfelseif firstlevel eq "SD" >
	<cfset firstlevel = "#client.site_dsn#" >
<cfelse>
	
</cfif>

<cfset datetimenow = '#dateformat(now(), "YYYY-MM-DD")# #timeformat(now(), "HH:MM:SS")#' >

<cfquery name="updateFormTable" datasource="#firstlevel#" >
	UPDATE #firsttable#
	   SET APPROVED          = <cfqueryparam cfsqltype="cf_sql_varchar" value="R" >,
		   DATELASTUPDATE    =  <cfqueryparam cfsqltype="cf_sql_timestamp" value="#datetimenow#" >
     WHERE PROCESSID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#processid#" > AND 
	       EFORMID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#eformid#" >
</cfquery>


<cfset updateCount = EntityLoad("EGINEFORMCOUNT", { EFORMID =#eformid#, PERSONNELIDNO = #pid#}, true ) >
<cfif isdefined("updateCount") >	
	<cfset currentCount = updateCount.getRETURNED() + 1 >
	<cfset updateCount.setRETURNED(currentCount) >
<cfelse>
	<cfset updateCount = EntityNew("EGINEFORMCOUNT") > 
	<cfset updateCount.setNEW("0") >
	<cfset updateCount.setEFORMID(eformid) >
	<cfset updateCount.setPERSONNELIDNO(pid) >
	<cfset updateCount.setPENDING("0") >
	<cfset updateCount.setRETURNED("1") >
</cfif> 	
<cfset EntitySave(updateCount) > 
<cfset ormflush()> 


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
<cfif firstlevel eq "G" >
	<cfset firstlevel = "#client.global_dsn#" > 
<cfelseif firstlevel eq "C" >
	<cfset firstlevel = "#client.company_dsn#" >			
<cfelseif firstlevel eq "S" >
	<cfset firstlevel = "#client.subco_dsn#" >
<cfelseif firstlevel eq "Q" >
	<cfset firstlevel = "#client.query_dsn#" >
<cfelseif firstlevel eq "T" >
	<cfset firstlevel = "#client.transact_dsn#" >
<cfelseif firstlevel eq "SD" >
	<cfset firstlevel = "#client.site_dsn#" >
<cfelse>
	
</cfif>

<cfset datetimenow = '#dateformat(now(), "YYYY-MM-DD")# #timeformat(now(), "HH:MM:SS")#' >

<cfquery name="updateFormTable" datasource="#firstlevel#" >
	UPDATE #firsttable#
	   SET APPROVED          = <cfqueryparam cfsqltype="cf_sql_varchar" value="Y" >,
		   DATELASTUPDATE    =  <cfqueryparam cfsqltype="cf_sql_timestamp" value="#datetimenow#" >
     WHERE PROCESSID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#processid#" > AND 
	       EFORMID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#eformid#" >
</cfquery>


<cfset updateCount = EntityLoad("EGINEFORMCOUNT", { EFORMID =#eformid#, PERSONNELIDNO = #pid#}, true ) >
<cfif isdefined("updateCount") >	
	<cfset currentCount = updateCount.getAPPROVED() + 1 >
	<cfset updateCount.setAPPROVED(currentCount) >
<cfelse>
	<cfset updateCount = EntityNew("EGINEFORMCOUNT") >
	<cfset updateCount.setEFORMID(eformid) >
	<cfset updateCount.setPERSONNELIDNO(pid) >
	<cfset updateCount.setPENDING("0") >
	<cfset updateCount.setRETURNED("0") >
	<cfset updateCount.setNEW("0") >
	<cfset updateCount.setAPPROVED("1") >
	<cfset updateCount.setDISAPPROVED("0") >
</cfif> 	
<cfset EntitySave(updateCount) >   
<cfset ormflush()>
	
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
				<cfset updateCount = EntityLoad("EGINEFORMCOUNT", { EFORMID =#eformid#, PERSONNELIDNO = #approverIndexC.getPERSONNELIDNO()#}, true ) >
				<cfif isdefined("updateCount") > 
					<cfif updateCount.getPENDING() gt 0 >	
						<cfset currentCount = updateCount.getPENDING() - 1 >
						<cfset updateCount.setPENDING(currentCount) >
					<cfelseif updateCount.getNEW() gt 0 >	
						<cfset currentCount = updateCount.getNEW() - 1 >
						<cfset updateCount.setNEW(currentCount) > 
					</cfif> 
					<cfset EntitySave(updateCount) >  
					<cfset ormflush()>   
				</cfif><!---end for the current router which is approved --->	
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
	<cfset form.eformid = eformid > <!---since it is approved with grid data, make form scope for other required data--->
	<cfset form.comments = " " >
	<cfset "form.#firstlevel#__#firsttable#__PROCESSID" = processid >
	<cfset "form.#firstlevel#__#firsttable#__PERSONNELIDNO" = pid >
	<cfif actiontype eq "approve" >
		<cfinvoke method="approveForm"  >  
		<cfinvoke method="updateProcess"  >
	<cfelseif actiontype eq "disapprove" >
		<cfinvoke method="disapproveForm"  >  
		<cfinvoke method="updateProcess"  >
	<cfelse>
	</cfif>
	
<cfreturn "success" >
<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message > 
</cfcatch>
</cftry>
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



</cfcomponent>