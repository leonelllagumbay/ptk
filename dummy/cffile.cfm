<form action="cffile.cfm" method="post" enctype="multipart/form-data" >
	
	<input type="file" name="file1" >
	<input type="submit" name="submitafile" >
		
	<cfif isdefined("form.submitafile") >
		<cfset arrErrors = ArrayNew( 1 ) /> 
	
		<cfset formDir = ExpandPath( "./unDB/forms/#session.companycode#/#session.userid#/" ) />
			<cftry>
				<cfif Not directoryExists(formDir) >
		            <cfdirectory action="create" directory="#formDir#" mode="777" >
		        </cfif> 
		    <cfcatch></cfcatch>
		    </cftry>
	  
			
		<cfset REQUEST.UploadPath = formDir />
		
			<cffile
						action="upload"
						destination="#REQUEST.UploadPath#"
						filefield="file1"
						nameconflict="makeunique"  >
					
			<cfset appendtext   = right(createuuid(),7) >
			<cffile action      = "rename" 
		    		source      = "#REQUEST.UploadPath##cffile.serverfile#" 
            		destination = "#REQUEST.UploadPath##cffile.serverfile#__#appendtext#.#cffile.clientfileext#" 
            		attributes  ="normal">
						
			<cfdump var="#cffile#" >
			
	</cfif>
</form>

<!--- Set up an array to hold errors. --->
<!---<cfset arrErrors = ArrayNew( 1 ) /> 

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

<cffile
						action="upload"
						destination="#REQUEST.UploadPath#"
						filefield="file#intFileIndex#"
						nameconflict="makeunique"
						/>--->