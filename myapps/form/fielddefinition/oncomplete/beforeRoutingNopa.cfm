
<cfquery name="getFilename" datasource="#session.company_dsn#" maxrows="1">
	SELECT BATCHUPLOADFILE
	  FROM ecinnopa
	 WHERE EFORMID = '#eformid#' AND PROCESSID = '#newprocessid#'
</cfquery>

<cfset theFilename = getFilename.BATCHUPLOADFILE >
<cfif trim(theFilename) neq "" >
	<cfset sourceFile = "../../../unDB/forms/#(session.companycode)#/#thefilename#" >
	
	<cfspreadsheet  
	    action="read"
	    src = "#expandpath(sourceFile)#" 
	    columns = "1-20"
	    excludeHeaderRow = "true"
	    headerrow = "1"
	    query = "nameExl" 
	>
	    
	   
	 <cfset requiredColumns = ArrayNew(1) >
	 <cfset requiredColumns[1] = "EMPLOYEENO" >
	 <cfset requiredColumns[2] = "DEPARTMENT" >
	 <cfset requiredColumns[3] = "FIRSTNAME" >
	 <cfset requiredColumns[4] = "LASTNAME" >
	 <cfset requiredColumns[5] = "MIDDLENAME" >
	 <cfset requiredColumns[6] = "POSITION" >
	 <cfset requiredColumns[7] = "PAY GRADE" >
	 <cfset requiredColumns[8] = "PRESENT SALARY" >
	 <cfset requiredColumns[9] = "DATE HIRED" >
	 <cfset requiredColumns[10] = "PAR RATING" >
	 <cfset requiredColumns[11] = "DEPT HEADS FINAL RANKING" >
	 <cfset requiredColumns[12] = "TRANSLATION" >
	 <cfset requiredColumns[13] = "MERIT INCREASE" >
	 <cfset requiredColumns[14] = "SALARY AFTER MI" >
	 <cfset requiredColumns[15] = "PROMOTION INCREASE" >
	 <cfset requiredColumns[16] = "SALARY AFTER PROMOTION" >
	 <cfset requiredColumns[17] = "SPECIAL LEVELLING INCREASE" >
	 <cfset requiredColumns[18] = "TYPE" >
	 <cfset requiredColumns[19] = "FINAL NEW RATE" >
	 <cfset requiredColumns[20] = "REMARKS" >
	 
	 
	 <cfloop array="#requiredColumns#" index="rCol" >
	 	<cfset rex = ArrayFindNoCase(nameExl.getMeta().getColumnLabels(), rCol) >
	 	<cfif rex eq 0 >
	 		<cfthrow message="Missing #rCol#. Excel file header columns does not meet the requirements." >
	 	</cfif>
	 </cfloop>
 
 </cfif>
    