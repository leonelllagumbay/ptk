<cfquery name="getMyLeave" datasource="#session.company_dsn#" >
	select sum(availbalance) AS LVBALANCE, LEAVETYPE 
	  from cinlvrecord
	 where personnelidno = '#formOwner#'
	group by LEAVETYPE
</cfquery>

<cfset strA = "" >
<cfloop query="getMyLeave" >
	<cfset strA = strA & "<tr><td>#LEAVETYPE#</td><td>#LVBALANCE#</td></tr>">
</cfloop>

<cfscript>
	tmpresult['C__CMFPA__GUID'] = "<table style='font: inherit;'>#strA#</table>";   
</cfscript>

<cfset returnStruct['success'] = "true" >
<cfset returnStruct['data']   = tmpresult > 