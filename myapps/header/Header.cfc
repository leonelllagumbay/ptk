<cfcomponent name="Header" ExtDirect="true">
	<cffunction name="getCompanyUserLogo" ExtDirect="true" >
		<cftry>

		<cfcatch>
			<cfreturn cfcatch.detail & ' ' & cfcatch.message >
		</cfcatch>
		</cftry>
	</cffunction>
</cfcomponent>