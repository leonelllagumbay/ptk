<cfcomponent >
   <cffunction name="helloWorld" returnType="string" access="remote" returnformat="JSON" >
   	
   		<cfset testA = ArrayNew(1) >
   		<cfset ArrayAppend(testA,"A") >
   		<cfset ArrayAppend(testA,"B") >
   		<cfset ArrayAppend(testA,"C") >
   		<cfset ArrayAppend(testA,"D") >
   		<cfset ArrayAppend(testA,"E") >
   		
      <cfreturn serializeJSON(testA)>
   </cffunction>
</cfcomponent>