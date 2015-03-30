<cfquery name="qryEmail" datasource="#session.company_dsn#" maxrows="1">
	SELECT * 
	  FROM ECINEMAIL
	 WHERE EFORMID = '#eformid#' AND PROCESSID = '#newprocessid#'
</cfquery>

<cfloop query="qryEmail" >
	<cfmail from="#qryEmail.EMAILTO#"
			to="#qryEmail.EMAILTO#"
			subject="#qryEmail.EMAILSUBJECT#"
			type="html" 
			>
			<cfoutput>#qryEmail.EMAILBODY#</cfoutput>
			<!---Attachment only--->
			<cfif trim(qryEmail.EMAILATTACHMENT) neq "" AND trim(lcase(qryEmail.EMAILATTACHMENT)) neq "no file" >
				<cfset dFile = ExpandPath( "../../../unDB/forms/#session.companycode#/#qryEmail.EMAILATTACHMENT#" ) >
				<cfmailparam 
				   disposition="attachment" 
			       file = "#dFile#"
			     >
			</cfif>
	</cfmail>
	
	
</cfloop>


<cfquery name="updateFormTable" datasource="#theLevel#" >
	UPDATE #thetable#
	   SET EMAILSTATUS          = <cfqueryparam cfsqltype="cf_sql_varchar"   value="SENT" >
     WHERE PROCESSID 		 = <cfqueryparam cfsqltype="cf_sql_varchar"   value="#newprocessid#" > AND 
	       EFORMID 			 = <cfqueryparam cfsqltype="cf_sql_varchar"   value="#eformid#" >
</cfquery>