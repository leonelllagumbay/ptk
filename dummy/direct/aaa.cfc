<cfcomponent>
	
	<cffunction name="getContacts" ExtDirect="true" >
		<cfset this.open(variables.fileName) />
		<cfreturn variables.data />
	</cffunction>
	
	<cffunction name="getPostBody" returnType="string" output="false" >
		<cfreturn toString(getHttpRequestData().content) />
	</cffunction>

</cfcomponent>