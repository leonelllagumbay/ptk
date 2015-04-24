<cfquery name="test" datasource="IBOSE_GLOBAL" fetchclientinfo="TRUE" result="resultTest"  >
	SELECT APPROVERSID  as "Approvers ID", APPROVERNAME as "Approver Name"
	FROM eginrouterapprovers
</cfquery>

<cfdump var="#test#" >
<cfdump var="#resultTest#" >