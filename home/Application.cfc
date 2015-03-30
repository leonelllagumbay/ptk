<cfcomponent displayname="Home Application" hint="This is the home application. It is called in every page requests on home.">  
	<cfset this.name               = "cfssdsssss222" />  
	<cfset this.clientmanagement   = "true" >
	<cfset this.sessionmanagement  = "true" >
	<cfset this.setclientcookies   = "true" >
	<cfset this.applicationtimeout = "#CreateTimeSpan(2,0,0,0)#">
	
	<cffunction name="onApplicationStart" returnType="boolean"> 
	    <cfreturn true> 
	</cffunction>
	
	
	<cffunction name="onRequestStart" returnType="boolean"> 
	    <cfreturn true>
		
	</cffunction>
	
	<cffunction name="onApplicationEnd" returnType="void"> 
	    <cfargument name="ApplicationScope" required=true/> 
	    <!---code goes here...--->
	</cffunction>
	
	
	<cffunction name="oncfcRequest" returnType="void"> 
	          <cfargument type="string" name="cfcname"> 
	          <cfargument type="string" name="method"> 
	          <cfargument type="struct" name="args"> 
	</cffunction>
	
	<cffunction name="onError" returnType="void"> 
	    <cfargument name="Exception" required=true/> 
	    <cfargument name="EventName" type="String" required=true/> 
		
		<p><cfoutput>Cause: #Exception.ErrorCode#, #Exception.Message#</cfoutput></p>
		<p><cfoutput>Detail: #Exception.Detail#</cfoutput></p>
		<p><cfoutput>Message: #Exception.Message#</cfoutput></p>
		<p><cfoutput>Root Cause: #Exception.ErrorCode#, #Exception.Message#</cfoutput></p>
		<!---<p><cfoutput>#Exception.StackTrace#</cfoutput></p>--->
		<!---use cfdump to see more fields of the 'Exception' struct--->
		<cfsetting showdebugoutput="false">
	</cffunction>
	
	
	<cffunction name="onMissingTemplate" returnType="boolean"> 
	    <cfargument type="string" name="targetPage" required=true/> 
	    <cfoutput>Missing page #targetPage#</cfoutput>
	    <cfsetting showdebugoutput="false">
	    <cfreturn true /> 
	</cffunction>
	
	
	
	<cffunction name="onRequestEnd" returnType="void"> 
	    <cfargument type="String" name="targetPage" required=true/> 
	    <!---code goes here...--->
	</cffunction>
	
	
	<cffunction name="onSessionEnd" returnType="void" output="true"> 
	    <cfargument name="SessionScope" required=True/> 
	    <cfargument name="ApplicationScope" required=False/> 
	    <cfoutput>Session Out</cfoutput>
	</cffunction>
	
	
	<cffunction name="onSessionStart" returnType="void"> 
	    <!---code goes here...--->
			<!---<cfoutput>Session started</cfoutput>--->
	</cffunction>



</cfcomponent>


