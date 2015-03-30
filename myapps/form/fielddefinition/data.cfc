<cfcomponent name="data" ExtDirect="true">

<cffunction name="getThemes" ExtDirect="true" hint="This is used to load the company or user theme">   
<cftry>

<cfset retArr = ArrayNew(1) >

<cfset retArr[1] = '<img src="' & session.root_undb & 'images/' & lcase(session.companycode) & '/' & session.site_bannerlogo & '" width="290" height="60">' >

<cfreturn retArr >
<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message >
</cfcatch>			
</cftry>
</cffunction> 
	
</cfcomponent>