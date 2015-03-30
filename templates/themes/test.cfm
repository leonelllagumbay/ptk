<cfif isdefined("url.companyid") >
	<h1>test This is the test <cfoutput>#url.companyid#</cfoutput></h1>
<cfelse>
	<h1>test No companyid</h1>
</cfif>