<cfset myStr = "G__EGRGCOMPANY__GLOBAL_DSN__lookupcard" >
<cfset formIndArr = ArrayNew(1) >
<cfset formIndArr = ListToArray(myStr , "__", true, true) >
<cfoutput>#myStr#</cfoutput><br>
<cfoutput>#formIndArr[1]#</cfoutput><br>
<cfoutput>#formIndArr[2]#</cfoutput><br>
<cfoutput>#formIndArr[3]#</cfoutput><br>
<cfoutput>#formIndArr[4]#</cfoutput><br>