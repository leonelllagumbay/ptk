<cfquery name="qryCmfpa" datasource="#session.company_dsn#" maxrows="1">
	SELECT A.POSITIONCODE,
	       A.ALLOWANCECODE,
		   A.SECTIONCODE,
		   A.LEVELCODE,
		   A.EMPLOYMENTSTATUS,
		   B.CURRENTAMOUNT
		   
	  FROM CMFPA A LEFT JOIN #session.subco_dsn#.dbo.SINCBSALARYCURRENT B ON (A.PERSONNELIDNO=B.PERSONNELIDNO)
	 WHERE A.PERSONNELIDNO = '#form.pid#'
	
</cfquery>


<cfloop query="qryCmfpa" >
	<cfif trim(POSITIONCODE) eq "" >
		<cfset POSITIONCODE2 = "none" >
	<cfelse>
		<cfset POSITIONCODE2 = POSITIONCODE >
	</cfif>
	<cfif trim(ALLOWANCECODE) eq "" >
		<cfset ALLOWANCECODE2 = "none" >
	<cfelse>
		<cfset ALLOWANCECODE2 = ALLOWANCECODE >
	</cfif>
	<cfif trim(SECTIONCODE) eq "" >
		<cfset SECTIONCODE2 = "none" >
	<cfelse>
		<cfset SECTIONCODE2 = SECTIONCODE >
	</cfif>
	<cfif trim(LEVELCODE) eq "" >
		<cfset LEVELCODE2 = "none" >
	<cfelse>
		<cfset LEVELCODE2 = LEVELCODE >
	</cfif>
	<cfif trim(EMPLOYMENTSTATUS) eq "" >
		<cfset EMPLOYMENTSTATUS2 = "none" >
	<cfelse>
		<cfset EMPLOYMENTSTATUS2 = EMPLOYMENTSTATUS >
	</cfif>
	<cfif trim(CURRENTAMOUNT) eq "" >
		<cfset CURRENTAMOUNT2 = "none" >
	<cfelse>
		<cfset CURRENTAMOUNT2 = CURRENTAMOUNT >
	</cfif>
	<cfset theResult = "POSITIONCODE~" & POSITIONCODE2 & ":ALLOWANCECODE~" & ALLOWANCECODE2 & ":SECTIONCODE~" & SECTIONCODE2 & ":LEVELCODE~" & LEVELCODE2 & ":EMPLOYMENTSTATUS~" & EMPLOYMENTSTATUS2 & ":CURRENTAMOUNT~" & CURRENTAMOUNT2> 
</cfloop>

<cfoutput>
#theResult#
</cfoutput>
<cfsetting showdebugoutput="false">