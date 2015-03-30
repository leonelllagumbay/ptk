<cfcomponent hint="Scheduler own application to avoid no login validation.">  
	<cfset this.name               = "AppSchedulerSSKsdfssds" />
	<cfset this.clientmanagement   = "true" >
	<cfset this.sessionmanagement  = "true" >
	<cfset this.setclientcookies   = "true" >
	<cfset this.applicationtimeout = "#CreateTimeSpan(2,0,0,0)#">
</cfcomponent>


