<cfquery name="getFilename" datasource="#session.company_dsn#" maxrows="1">
	SELECT BATCHUPLOADFILE
	  FROM ecinnopa
	 WHERE EFORMID = '#eformid#' AND PROCESSID = '#processid#'
</cfquery>

<cfset theFilename = getFilename.BATCHUPLOADFILE >
<cfset sourceFile = "../../../unDB/forms/#ucase(session.companycode)#/#thefilename#" >

<cfspreadsheet  
    action="read"
    src = "#expandpath(sourceFile)#" 
    columns = "1-20"
    excludeHeaderRow = "true"
    headerrow = "1"
    query = "ExcelNOPAData" 
>

<!---<cfloop query="ExcelNOPAData" >
	<cfquery name="insertToNOPA" datasource="#session.company_dsn#" >
		update original nopa tables here...
	</cfquery>
</cfloop>--->