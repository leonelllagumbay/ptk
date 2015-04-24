<!---This program performs a simple file updater using iBOS/e eForms
triggered on before routing event of an eForm--->

<cfzip 
    action = "unzip"
    destination = "#expandpath('./unzippedfile')#"
    file = "#expandpath('./zippedfile/zippedfile.zip')#"
    overwrite = "yes"
    storePath="yes"> 
    
 <cfzip 
    action = "list"
    file = "#expandpath('./zippedfile/zippedfile.zip')#"
    name = "filelist"
    showDirectory= "no"> 
 
 <cfloop query="filelist" >
 	
 	<cfset sourcea = expandpath('./unzippedfile/#filelist.NAME#') >
 	<cfset destina = expandpath('./unzippedfile/#trim(listLast(filelist.NAME, "~"))#') >
 	<cffile  
	    action = "rename"
	    destination = "#destina#" 
	    source = "#sourcea#"
	    mode = "777"
	>
	
	<cfset sourceb = destina >
 	<cfset destinb = expandpath('./#replace(filelist.NAME, "~", "/", "all")#') >
 	
 	
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




    
    
 
