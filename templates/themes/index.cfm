<cfif isdefined("url.companyid") >
	<h1>This is the <cfoutput>#url.companyid#</cfoutput></h1>
<cfelse>
	<h1>No companyid</h1>
</cfif>
<a href="http://localhost:8500/?bdg=loginme">Click to login</a>