<cfcomponent name="FileUploader" accessors=true output=false persistent=false ExtDirect="true" >

<cffunction name="uploadFile" ExtDirect="true" ExtFormHandler="true">

<cftry>
	<cfset returnStruct = StructNew() >
	<!--- Set up an array to hold errors. --->
	<cfset arrErrors = ArrayNew( 1 ) />

	<cfset formDir = ExpandPath( "../../resource/image/companylogo/" ) />
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
	<cfset ArrayAppend(arrErrors,"No files selected.") />

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
						nameconflict="overwrite"
						/>

					<!---
						Store this file name in the uploaded file
						array so we can reference it later.
					--->

					<!--- <cfset appendtext   = right(createuuid(),7) > --->
					<cffile action      = "rename"
				    		source      = "#REQUEST.UploadPath##cffile.serverfile#"
		            		destination = "#REQUEST.UploadPath##cffile.serverfilename#.#cffile.clientfileext#"
		            		attributes  ="normal">

					<cfset ArrayAppend(
						arrUploaded,
						(CFFILE.ServerDirectory & "\" & CFFILE.serverfilename & '.' &  cffile.clientfileext)
						) />

					<cfset arrServerFile[intFileIndex] = CFFILE.serverfilename & '.' & cffile.clientfileext />

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
			<!---
				!! SUCCESS !!
				The files were properly uploaded and processed.
				Here is where you might forward someone to some
				sort of success / confirmation page.
			--->
			<cfset returnStruct["uploadedfiles"] = arrUploaded>
			<cfset returnStruct["success"] = "true">
			<cfreturn returnStruct>

		</cfif>
	<cfelse>
		<cfset returnStruct["message"] = arrErrors>
		<cfreturn returnStruct>
	</cfif>

<cfcatch type="any">
	<cfset returnStruct = StructNew() >
	<cfset returnStruct["message"] = cfcatch.message>
	<cfset returnStruct["detail"] = cfcatch.detail>
	<cfreturn returnStruct>
</cfcatch>
</cftry>

</cffunction>

</cfcomponent>