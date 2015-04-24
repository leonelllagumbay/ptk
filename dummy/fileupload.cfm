<!---
	Set the number of files that can uploaded in a single
	form submission.
--->  
<cfset REQUEST.FileCount = 5 />

<!--- Set the destination folder for uploads. --->
<cfset REQUEST.UploadPath = ExpandPath( "./uploads/" ) />



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


<!--- Param upload flag. --->
<cftry>
	<cfparam
		name="FORM.submitted"
		type="numeric"
		default="0"
		/>

	<cfcatch>
		<cfset FORM.submitted = 0 />
	</cfcatch>
</cftry>


<!--- Set up an array to hold errors. --->
<cfset arrErrors = ArrayNew( 1 ) />


<!--- Check to see if the form has been submitted. --->
<cfif FORM.submitted>

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
						
					<cfset ArrayAppend(
						arrServerFile,
						CFFILE.ServerFile
					) />


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

			<cfloop
				index="intFileIndex"
				from="1"
				to="#ArrayLen( arrServerFile )#"
				step="1">

				
					<cfquery name="test" datasource="IBOSEDATA" >
						INSERT INTO DUMMYTABLE(TEST)
						    VALUES('#arrServerFile[ intFileIndex ]#') 
					</cfquery>
						

			</cfloop>
			
			<!---
				!! SUCCESS !!
				The files were properly uploaded and processed.
				Here is where you might forward someone to some
				sort of success / confirmation page.
			--->


		</cfif>

	</cfif>

	<cfquery name="test" datasource="IBOSEDATA" >
		INSERT INTO DUMMYTABLE(TEST)
		    VALUES('#form.sample#') 
	</cfquery>
	
</cfif>


	
<!--- Set the content type and reset the output buffer. --->
<cfcontent
	type="text/html"
	reset="true"
	/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>Multiple File Uploads</title>
</head>
<body>

	<cfoutput>

		<h1>
			Multiple File Upload ColdFusion Example
		</h1>


		<!--- Check to see if we have any errors to display. --->
		<cfif ArrayLen( arrErrors )>

			<p>
				Please review the following errors:
			</p>

			<ul>
				<cfloop
					index="intError"
					from="1"
					to="#ArrayLen( arrErrors )#"
					step="1">

					<li>
						#arrErrors[ intError ]#
					</li>

				</cfloop>
			</ul>

		</cfif>


		<form
			action="#CGI.script_name#"
			method="post"
			enctype="multipart/form-data">

			<!--- Submission flag. --->
			<input type="text" name="sample" >
			<input type="hidden" name="submitted" value="1" />


			<!---
				Loop over the number of files we are going to
				allow for the upload.
			--->
			<cfloop
				index="intFileIndex"
				from="1"
				to="#REQUEST.FileCount#"
				step="1">

				<label for="file#intFileIndex#">
					File #intFileIndex#:
				</label>

				<input
					type="file"
					name="file#intFileIndex#"
					id="file#intFileIndex#"
					/>

				<br />

			</cfloop>


			<input type="submit" value="Upload Files" /> 

		</form>

	</cfoutput>

</body>
</html>