<cfquery name="getOTpd" datasource="#session.company_dsn#" maxrows="1">
	SELECT OTPASSEDDUE FROM ECINOTPASSEDDUE
</cfquery>
<cfif getOTpd.recordcount gt 0 >
	<cfoutput>#DateFormat(getOTpd.OTPASSEDDUE, "YYYY-MM-DD")#</cfoutput>
<cfelse>
	<cfoutput>#DateFormat(now(), "YYYY-MM-DD")#</cfoutput>
</cfif>
<cfsetting showdebugoutput="false">