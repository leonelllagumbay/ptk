<!--- <cfset sourceDir = ExpandPath("./Afolder/")>
<cfset destDir = ExpandPath( "./Bfolder/" ) />

<cfset imageArray = ArrayNew(1) >

<cfloop from="1" to="5" index="fileIndex" >
	<cfset arrayappend(imageArray,"file#fileIndex#.js") >
</cfloop>

<cfdump var="#imageArray#" >

<cfloop array="#imageArray#" index="fileInd">
	<cfoutput>#fileInd# </cfoutput><br>
	<cffile action="move" source="#sourceDir##fileInd#" destination="#destDir#" >
</cfloop> --->

<!--- <cfset destDir = ExpandPath( "/unDBpath" ) />
<cfoutput>#destDir#</cfoutput>

<cfdirectory listinfo="all" action="list" name="dlist" directory="#destDir#" >
<cfdump var="#dlist#"> --->


<cfset file = ExpandPath( "/unDBpath/Netsuite.docx" ) />
<!--- <cffile action="read" file="#destDir#" variable="filevar" >
<cfdump var="#filevar#"> --->

<cfcontent type="application/msword" file="#file#" >
<cfheader name="Content-Disposition" value="filename=Netsuite.docx">
