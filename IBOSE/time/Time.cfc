<cfcomponent displayname="Time">
	<cffunction name="convertTimeToWords" access="public"  >
		<cfargument name="theTime" type="date" >
		<!---convert time to words--->
		<cfset thedate = "#dateformat(theTime, "YYYY-MM-DD")# #timeformat(theTime, "HH:MM:SS")#" />
		                            
		<cfset ddiff_second = datediff("s", thedate, Now()) />
	    <cfset ddiff_minute = datediff("n", thedate, Now()) />
	    <cfset ddiff_hour   = datediff("h", thedate, Now()) />
	    <cfset ddiff_day    = datediff("d", thedate, Now()) />
	    <cfset ddiff_week   = datediff("w", thedate, Now()) />
	    <cfset ddiff_month  = datediff("m", thedate, Now()) />
	    <cfset ddiff_year   = datediff("yyyy", thedate, Now()) />
		                            
		<cfif ddiff_second LT 60 AND ddiff_minute LT 1 AND ddiff_hour LT 1 AND ddiff_day LT 1 AND ddiff_week LT 1 AND ddiff_month LT 1 AND ddiff_year LT 1>
			<cfif ddiff_second EQ 60>
		        <cfset aaggoo = 'about a minute ago'> 
		    <cfelse>
				<cfset aaggoo = 'a few seconds ago'> 
		    </cfif>
		<cfelseif ddiff_minute LT 60 AND ddiff_hour LT 1 AND ddiff_day LT 1 AND ddiff_week LT 1 AND ddiff_month LT 1 AND ddiff_year LT 1>
		    <cfif ddiff_minute EQ 60>
		        <cfset aaggoo = 'about an hour ago'>
		    <cfelseif ddiff_minute EQ 1>
		        <cfset aaggoo = 'a minute ago'>
		    <cfelse>
		        <cfset aaggoo = '#ddiff_minute# minutes ago'>
		    </cfif>
		<cfelseif ddiff_hour LT 24 AND ddiff_day LT 1 AND ddiff_week LT 1 AND ddiff_month LT 1 AND ddiff_year LT 1>
		    <cfif ddiff_hour EQ 24>
		        <cfset aaggoo = 'about a day ago'>
		    <cfelseif ddiff_hour EQ 1>
		        <cfset aaggoo = 'about an hour ago'>
		    <cfelseif ddiff_hour EQ 0>
		        <cfset aaggoo = '#ddiff_minute# minutes ago'>
		    <cfelse>
		        <cfset aaggoo = '#ddiff_hour# hours ago'>
		    </cfif>
		<cfelseif ddiff_day LT 7 AND ddiff_week LT 1 AND ddiff_month LT 1 AND ddiff_year LT 1>
		    <cfif ddiff_day EQ 7>
		        <cfset aaggoo = 'about a week ago'>
		    <cfelseif ddiff_day EQ 1>
		        <cfset aaggoo = 'about a day ago'>
		    <cfelseif ddiff_day EQ 0>
		        <cfset aaggoo = '#ddiff_hour# hours ago'>
		    <cfelse>
		        <cfset aaggoo = '#ddiff_day# days ago'>
		    </cfif>
		<cfelseif ddiff_week LT 4 AND ddiff_month LT 1 AND ddiff_year LT 1>
		    <cfif ddiff_week EQ 4>
		        <cfset aaggoo = 'about a month ago'>
		    <cfelseif ddiff_week EQ 1>
		        <cfset aaggoo = 'about a week ago'>
		    <cfelseif ddiff_week EQ 0>
		        <cfset aaggoo = '#ddiff_day# days ago'>
		    <cfelse>
		        <cfset aaggoo = '#ddiff_week# weeks ago'>
		    </cfif>
		<cfelseif ddiff_month LT 12 AND ddiff_year LT 1>
		    <cfif ddiff_month EQ 12>
		        <cfset aaggoo = 'about a year ago'>
		    <cfelseif ddiff_month EQ 1>
		        <cfset aaggoo = 'about a month ago'>
		    <cfelseif ddiff_month EQ 0>
		        <cfset aaggoo = '#ddiff_week# weeks ago'>
		    <cfelse>
		    
		        <cfset aaggoo = '#ddiff_month# months ago'>
		    </cfif>
		<cfelse>
		    <cfif ddiff_year EQ 1>
		        <cfset aaggoo = 'about a year ago'>
		    <cfelse>
		        <cfset aaggoo = '#ddiff_year# years ago'>
		    </cfif>
		</cfif>
		
		<cfreturn aaggoo >
	</cffunction>
</cfcomponent>