<!---This program performs a simple file updater using iBOS/e eForms
triggered on before routing event of an eForm--->


<cfquery name="getFilename" datasource="#session.global_dsn#" maxrows="1">
	SELECT ZIPFILE
	  FROM EGRGCODEUPDATER
	 WHERE EFORMID = '#eformid#' AND PROCESSID = '#newprocessid#'
</cfquery>

<cfset theFilename = getFilename.ZIPFILE >

<cfif trim(theFilename) neq "" >
	
	<cfset thisRelPath = "../../../unDB/forms/" >
	<cfset sourceFile = "#thisRelPath##(session.companycode)#/#thefilename#" >
	
	<cfset thefile = expandpath(sourceFile) >
	
		<cfset dest = expandpath("#thisRelPath#unzippedfiles") >
		<cfzip 
		    action = "unzip"
		    destination = "#dest#"
		    file = "#thefile#"
		    overwrite = "yes"
		    storePath="yes"> 
		    
		 <cfzip 
		    action = "list"
		    file = "#thefile#"
		    name = "filelist"
		    showDirectory= "no"> 
		 
		 <cfloop query="filelist" >
		 	
			 	<cfset sourcea = expandpath('#thisRelPath#unzippedfiles/#filelist.NAME#') >
			 	<cfset destina = expandpath('#thisRelPath#unzippedfiles/#trim(listLast(filelist.NAME, "~"))#') >
			 	<cffile  
				    action = "rename"
				    destination = "#destina#" 
				    source = "#sourcea#"
				    mode = "777"
				>
				
				<cfset sourceb = destina >
			 	<cfset destinb = expandpath('../../../#replace(filelist.NAME, "~", "/", "all")#') >
			 	
			 	<cfset directoryRes = replace(destinb, "#trim(listLast(filelist.NAME, '~'))#", "", "all") >
			 	
			 	<cfif Not DirectoryExists(directoryRes) > 
			 		<cfdirectory  
					    directory = "#directoryRes#"
					    action = "create"
					    type="dir"
					    mode = "777">
			 	</cfif>
			 	
				<cffile  
				    action = "move"
				    destination = "#destinb#" 
				    source = "#sourceb#"
				    mode = "777"
				>
			
		 </cfloop>
	
	
	
	
</cfif>
