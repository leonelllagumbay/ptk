<cfquery name="queryecinqueryrowtoemail" datasource="#session.company_dsn#" maxrows="1">
	SELECT TOCOLUMN,
		   SUBJECTCOLUMN,
		   BODYCOLUMN,
		   HEADERCOLUMN,
		   FOOTERCOLUMN,
		   SOURCEQUERY,
		   COPYEMAILTO,
		   DEFAULTSUBJECT,
		   DEFAULTBODY,
		   DEFAULTHEADER,
		   DEFAULTFOOTER
	  FROM ECINQUERYROWTOEMAIL
	 WHERE EFORMID = '#url.eformid#' AND PROCESSID = '#url.processid#'
</cfquery>



<cfloop query="queryecinqueryrowtoemail" >
	
	<cfquery name="querySource" datasource="#url.companydsn#" >
		#preservesinglequotes(queryecinqueryrowtoemail.SOURCEQUERY)#
	</cfquery>
	
	<cfdump var="#querySource#" >
	
	<cfloop query="querySource" > <!---loop each row data source to email--->
		<cfif trim(queryecinqueryrowtoemail.TOCOLUMN) neq "" >
			<cfset recipient = evaluate("querySource.#queryecinqueryrowtoemail.TOCOLUMN#") >
		<cfelse>
			<cfset recipient = "" >
		</cfif>
		
		<cfif trim(queryecinqueryrowtoemail.SUBJECTCOLUMN) neq "" >
			<cfset subject = evaluate("querySource.#queryecinqueryrowtoemail.SUBJECTCOLUMN#") >
		<cfelse>
			<cfset subject = "" >
		</cfif>
		
		<cfif trim(queryecinqueryrowtoemail.BODYCOLUMN) neq "" >
			<cfset body = evaluate("querySource.#queryecinqueryrowtoemail.BODYCOLUMN#") >
		<cfelse>
			<cfset body = "" >
		</cfif>
		
		<cfif trim(queryecinqueryrowtoemail.HEADERCOLUMN) neq "" >
			<cfset header = evaluate("querySource.#queryecinqueryrowtoemail.HEADERCOLUMN#") >
		<cfelse>
			<cfset header = "" >
		</cfif>
		
		<cfif trim(queryecinqueryrowtoemail.FOOTERCOLUMN) neq "" >
			<cfset footer = evaluate("querySource.#queryecinqueryrowtoemail.FOOTERCOLUMN#") >
		<cfelse>
			<cfset footer = "" >
		</cfif>
		
		<cfif trim(recipient) eq "" >
			<cfset recipient2 = trim(queryecinqueryrowtoemail.COPYEMAILTO) >
			<cfif trim(recipient2) eq "" >
				<cfcontinue>
			<cfelse>
				<cfset recipientn = recipient2 >
			</cfif>
		<cfelse> <!---recipient not empty--->
			<cfset recipient2 = trim(queryecinqueryrowtoemail.COPYEMAILTO) >
			<cfif trim(recipient2) neq "" >
				<cfset recipientn = recipient & "," & recipient2 >
			<cfelse>
				<cfset recipientn = recipient >
			</cfif>
		</cfif>
		
		<cfset subjectn  = trim(queryecinqueryrowtoemail.DEFAULTSUBJECT) & subject >
		<cfset bodyn 	 = trim(queryecinqueryrowtoemail.DEFAULTBODY) & body>
		<cfset headern 	 = trim(queryecinqueryrowtoemail.DEFAULTHEADER) & header >
		<cfset footern 	 = trim(queryecinqueryrowtoemail.DEFAULTFOOTER) & footer >
		
		<cfmail from="#recipientn#" subject="#subjectn#" to="#recipientn#" >
			#headern# </br>
			#bodyn# </br>
			#footern# </br>
		</cfmail>	
	</cfloop>
</cfloop>