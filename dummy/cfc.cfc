<cfcomponent>
	
	<cffunction name="one" output="true" access="remote">
		<cfoutput>One</cfoutput>
		<cfreturn "hi" >
	</cffunction>
	
	<cffunction name="two" output="true" >
		<cfoutput>Two</cfoutput>
	</cffunction>
	
	<cffunction name="three" output="true" >
		<cfargument name="onearg" >
		<cfoutput>Three</cfoutput>
	
	</cffunction>

</cfcomponent>