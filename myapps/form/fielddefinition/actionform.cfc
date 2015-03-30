<cfcomponent name="actionform" ExtDirect="true" >
<cffunction name="load" ExtDirect="true" >
	<cfargument name="eformid" >
	<cfset returnStruct = StructNew() >
	<cfset returnArray  = ArrayNew( 1 ) >
	<cfset contentStruct = StructNew() >
	<cfset contentStruct['One'] = "sample" >
	<cfset contentStruct['Two'] = "sample2" >
	<cfset contentStruct['Three'] = "sample3" >
	<cfset returnArray[1] = contentStruct >
	
	<cfset returnStruct['sucess'] = "true" >
	<cfset returnStruct['data']   = returnArray >
	<cfreturn returnStruct >
</cffunction> 





<cffunction name="submit" ExtDirect="true" ExtFormHandler="true">
<cftry>
	
<!--- Set up an array to hold errors. --->
<cfset arrErrors = ArrayNew( 1 ) /> 

<cfif ListGetAt(form.withFile, 1) eq "true" >
	<cfset formDir = ExpandPath( "../../../unDB/forms/#session.companycode#/" ) />
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
					<cfset isArray = evaluate("itemDVal#theTableName#") >
					<cfif isarray(isArray) >
						
					<cfelse>
						<cfset "itemDVal#theTableName#"  = arraynew(1) >	
					</cfif>
				<cfcatch>
					<cfset "itemDVal#theTableName#"  = arraynew(1) >
				</cfcatch>
				</cftry>
				
				<cfset arrayappend(evaluate("items#theTableName#"), theColumnName) >
				<cfset tableStruct['#theTableName#'] = evaluate("items#theTableName#") >
				
				<cfset colVal = evaluate("form.#formIndex#") >
				<cfset arrayappend(evaluate("itemVal#theTableName#"), "'#colVal#'") > 
				<cfset tableValStruct['#theTableName#'] = evaluate("itemVal#theTableName#") >
				
				<cfset arrayappend(evaluate("itemDVal#theTableName#"), "#theColumnName# = '#colVal#'") >
				<cfset tableDValStruct['#theTableName#'] = evaluate("itemDVal#theTableName#") >
				
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
		<cfset itemValList  = ArrayToList( itemValArray, "," ) >
		<cfset itemDValArray = tableDValStruct['#theTables#'] >
		<cfset itemDValList  = ArrayToList( itemDValArray, " AND " ) >
		
		<cfset theLevel = evaluate("level#theTables#") >
		<cfif theLevel eq "G" >
			<cfset theLevel = "#session.global_dsn#" >
		<cfelseif theLevel eq "C" >
			<cfset theLevel = "#session.company_dsn#" >			
		<cfelseif theLevel eq "S" >
			<cfset theLevel = "#session.subco_dsn#" >
		<cfelseif theLevel eq "Q" >
			<cfset theLevel = "#session.query_dsn#" >
		<cfelseif theLevel eq "T" >
			<cfset theLevel = "#session.transact_dsn#" >
		<cfelseif theLevel eq "SD" >
			<cfset theLevel = "#session.site_dsn#" >
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
							VALUES ( #preservesinglequotes(itemValList)#,
									'#chapa#',
									'#eformid#',
									'#processid#',
									'N',
									'#dateformat(now(), "YYYY-MM-DD") & ' ' & timeformat(now(), "HH:MM:SS")#',
									'#dateformat(now(), "YYYY-MM-DD") & ' ' & timeformat(now(), "HH:MM:SS")#' )
		</cfquery>
		
						   
			
		
	</cfloop>
	
	<cfset returnStruct['success'] = "true" >
	<cfset returnStruct['data']   = arrErrors >
	
<cfcatch>
	
	<cfset returnStruct['data']   = "#cfcatch.detail# #cfcatch.message#" >
	<cfset tableArr = StructKeyArray(tableStruct) >
	<cfloop array="#tableArr#" index="theTables" >
		<cfset itemArray = tableStruct['#theTables#'] >
		<cfset itemList  = ArrayToList( itemArray, "," ) >
		<cfset itemValArray = tableValStruct['#theTables#'] >
		<cfset itemValList  = ArrayToList( itemValArray, "," ) >
		<cfset itemDValArray = tableDValStruct['#theTables#'] >
		<cfset itemDValList  = ArrayToList( itemDValArray, " AND " ) >
		
		<cfset theLevel = evaluate("level#theTables#") >
		<cfif theLevel eq "G" >
			<cfset theLevel = "#session.global_dsn#" >
		<cfelseif theLevel eq "C" >
			<cfset theLevel = "#session.company_dsn#" >			
		<cfelseif theLevel eq "S" >
			<cfset theLevel = "#session.subco_dsn#" >
		<cfelseif theLevel eq "Q" >
			<cfset theLevel = "#session.query_dsn#" >
		<cfelseif theLevel eq "T" >
			<cfset theLevel = "#session.transact_dsn#" >
		<cfelseif theLevel eq "SD" >
			<cfset theLevel = "#session.site_dsn#" >
		<cfelse>
			
		</cfif>
		
		<cfquery name='dynamicQuery' datasource='#theLevel#' >
			DELETE FROM #theTables# 
				WHERE #preservesinglequotes(itemDValList)#
		</cfquery>
	
	</cfloop>
	
</cfcatch>
</cftry>
	
<cfelse>
	<cfset returnStruct['data']   = "emptyForm" >
</cfif>	
</cffunction>






<cffunction name="saveFormAfterFileUpload" >
<cfargument name = "eformid" >

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
					<cfset isArray = evaluate("itemDVal#theTableName#") >
					<cfif isarray(isArray) >
						
					<cfelse>
						<cfset "itemDVal#theTableName#"  = arraynew(1) >	
					</cfif>
				<cfcatch>
					<cfset "itemDVal#theTableName#"  = arraynew(1) >
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
				
					<cfset arrayappend(evaluate("items#theTableName#"), theColumnName) >
					<cfset tableStruct['#theTableName#'] = evaluate("items#theTableName#") >
					
					<cfset arrayappend(evaluate("itemVal#theTableName#"), "'#colVal#'") > 
					<cfset tableValStruct['#theTableName#'] = evaluate("itemVal#theTableName#") >
					
					<cfset arrayappend(evaluate("itemDVal#theTableName#"), "#theColumnName# = '#colVal#'") >
					<cfset tableDValStruct['#theTableName#'] = evaluate("itemDVal#theTableName#") >
				
				
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
		<cfset itemValList  = ArrayToList( itemValArray, "," ) >
		<cfset itemDValArray = tableDValStruct['#theTables#'] >
		<cfset itemDValList  = ArrayToList( itemDValArray, " AND " ) >
		
		<cfset theLevel = evaluate("level#theTables#") >
		<cfif theLevel eq "G" >
			<cfset theLevel = "#session.global_dsn#" >
		<cfelseif theLevel eq "C" >
			<cfset theLevel = "#session.company_dsn#" >			
		<cfelseif theLevel eq "S" >
			<cfset theLevel = "#session.subco_dsn#" >
		<cfelseif theLevel eq "Q" >
			<cfset theLevel = "#session.query_dsn#" >
		<cfelseif theLevel eq "T" >
			<cfset theLevel = "#session.transact_dsn#" >
		<cfelseif theLevel eq "SD" >
			<cfset theLevel = "#session.site_dsn#" >
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
							VALUES ( #preservesinglequotes(itemValList)#,
									'#chapa#',
									'#eformid#',
									'#processid#',
									'N',
									'#dateformat(now(), "YYYY-MM-DD") & ' ' & timeformat(now(), "HH:MM:SS")#',
									'#dateformat(now(), "YYYY-MM-DD") & ' ' & timeformat(now(), "HH:MM:SS")#' )
		</cfquery>
		
						   
			
		
	</cfloop>
	
	<cfset returnStruct['success'] = "true" >
	<cfset returnStruct['data']   = arrErrors >
	
<cfcatch>
	<cfset returnStruct['data']   = "#cfcatch.detail# #cfcatch.message#" >
	<cfset tableArr = StructKeyArray(tableStruct) >
	<cfloop array="#tableArr#" index="theTables" >
		<cfset itemArray = tableStruct['#theTables#'] >
		<cfset itemList  = ArrayToList( itemArray, "," ) >
		<cfset itemValArray = tableValStruct['#theTables#'] >
		<cfset itemValList  = ArrayToList( itemValArray, "," ) >
		<cfset itemDValArray = tableDValStruct['#theTables#'] >
		<cfset itemDValList  = ArrayToList( itemDValArray, " AND " ) >
		
		<cfset theLevel = evaluate("level#theTables#") >
		<cfif theLevel eq "G" >
			<cfset theLevel = "#session.global_dsn#" >
		<cfelseif theLevel eq "C" >
			<cfset theLevel = "#session.company_dsn#" >			
		<cfelseif theLevel eq "S" >
			<cfset theLevel = "#session.subco_dsn#" >
		<cfelseif theLevel eq "Q" >
			<cfset theLevel = "#session.query_dsn#" >
		<cfelseif theLevel eq "T" >
			<cfset theLevel = "#session.transact_dsn#" >
		<cfelseif theLevel eq "SD" >
			<cfset theLevel = "#session.site_dsn#" >
		<cfelse>
			
		</cfif>
		
		<cfquery name='dynamicQuery' datasource='#theLevel#' >
			DELETE FROM #theTables# 
				WHERE #preservesinglequotes(itemDValList)#
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
	
</cfcatch>
</cftry>
	
<cfelse>
	<cfset returnStruct['data']   = "emptyForm" >
</cfif>	

</cffunction>


</cfcomponent>