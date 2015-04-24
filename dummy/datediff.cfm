<cfset startDate = "September 28, 2014" >

<cfset endDate = "November 08, 2014" >

<cfset retArray = ArrayNew(1) >
			<cfset startDate = dateformat("#startDate#","YYYY-MM-DD") >
			<cfset dateRange = datediff("d", startDate, dateformat("#endDate#","YYYY-MM-DD")) >
			<cfloop from="1" to="#dateRange + 1#" index="i" >
				<cfoutput>#i#</cfoutput><br>
				<cfquery name="isin" datasource="#session.company_dsn#" maxrows="1">
	              	SELECT NAME
	              	  FROM ECRGESTICKYNOTES
	             	 WHERE DATECREATED = '#startDate#';
	        	</cfquery>
	        	<cfif isin.recordcount gt 0 >
	        		<cfset retArray[i] = startDate >
	        	<cfelse>
	        		<cfset retArray[i] = startDate >
	        	</cfif>
	        	<cfoutput>#startDate#</cfoutput><br>
	        	<cfset startDate = dateAdd("d",1,startDate) >
	        	<cfoutput>#startDate#</cfoutput><br>
	        	<cfset startDate = dateformat("#startDate#","YYYY-MM-DD") >
	        	
        	</cfloop>
        	
        	<cfdump var="#retArray#"  >

<!---<cfset eformid = "test2" >
<cfset datecreated = now() >
<cfset expirationdate = datecreated >

<cfif datediff( "d", datecreated, expirationdate ) gte 0 > <!---not expired--->
	<cfoutput>not expired#datediff( "d", datecreated, expirationdate )#</cfoutput>
<cfelse> <!---expired--->
	<cfoutput>expired#datediff( "d", datecreated, expirationdate )#</cfoutput>
</cfif>

</br>

<cfoutput>d #dateFormat(now(),"d")#</cfoutput></br>
<cfoutput>dd #dateFormat(now(),"dd")#</cfoutput></br>
<cfoutput>ddd #dateFormat(now(),"ddd")#</cfoutput></br>
<cfoutput>dddd #dateFormat(now(),"dddd")#</cfoutput></br>

<cfoutput>m #dateFormat(now(),"m")#</cfoutput></br>
<cfoutput>mm #dateFormat(now(),"mm")#</cfoutput></br>
<cfoutput>mmm #dateFormat(now(),"mmm")#</cfoutput></br>
<cfoutput>mmmm #dateFormat(now(),"mmmm")#</cfoutput></br>

<cfoutput>yy #dateFormat(now(),"yy")#</cfoutput></br>
<cfoutput>yyyy #dateFormat(now(),"yyyy")#</cfoutput></br>

<cfoutput>gg #dateFormat(now(),"gg")#</cfoutput></br>

<cfoutput>short #dateFormat(now(),"short")#</cfoutput></br>
<cfoutput>medium #dateFormat(now(),"medium")#</cfoutput></br>
<cfoutput>long #dateFormat(now(),"long")#</cfoutput></br>
<cfoutput>full #dateFormat(now(),"full")#</cfoutput></br>

<cfoutput>The following is an auto increment sample</cfoutput>

<cfset theFormat = "{seed=    19 step=   5 format=  0      }   ghijklmnopqrstuvwxyzzyxwvutsrqponml{}kjihgfed{sdfsdjflksdf}cba" >

<cfset incVal = 0 >
<cfset seedPos = find("seed=", theFormat) >
<cfset stepPos = find("step=", theFormat) >
<cfset formatPos = find("format=", theFormat) >

<cfset theLeftBracePos = 0 >
<cfset theRightBracePos = find("}", theFormat, seedPos) >
<cfloop from="#seedPos#" to="1" index="counter" step="-1">
	<cfset substringA = theFormat.substring(counter,counter + 1) >
	<cfif substringA eq "{" >
		<cfset theLeftBracePos = counter>
		<cfbreak>
	</cfif>
</cfloop>

<cfset theAutoIncStr = trim(theFormat.substring(theLeftBracePos,theRightBracePos)) >

<cfset seedVal = trim(theFormat.substring(seedPos-1,stepPos-1)) >
<cfset seedRef = find("=", seedVal) >
<br><br>
<cfoutput >
    	#seedRef#
    </cfoutput>
<cfset seedValNow = trim(seedVal.substring(seedRef)) >

<cfset stepVal = trim(theFormat.substring(stepPos-1,formatPos-1)) >
<cfset stepRef = find("=", stepVal) >
<cfset stepValNow = trim(stepVal.substring(stepRef)) >

<cfset formatVal = trim(theFormat.substring(formatPos-1,theRightBracePos-1)) >
<cfset formatRef = find("=", formatVal) >

<cfset formatValNow = trim(formatVal.substring(formatRef)) >

<cfquery name="getLastContent" datasource="#session.global_dsn#" >
	SELECT LASTCOUNT
	  FROM EGINAUTOINCREMENT
	 WHERE EFORMID = '#eformid#';
</cfquery>

<cfif getLastContent.recordCount lt 1 >
	<cfset incVal = seedValNow >
	<cfquery name="getLastContent" datasource="#session.global_dsn#" >
		INSERT INTO EGINAUTOINCREMENT (EFORMID,LASTCOUNT)
		  VALUES (
		  	<cfqueryparam cfsqltype="cf_sql_varchar" value="#eformid#">,
		  	<cfqueryparam cfsqltype="cf_sql_integer" value="#incVal#">
		  );
	</cfquery>
<cfelse>
	<cfset incVal = val(getLastContent.LASTCOUNT) + val(stepValNow) >
	<cfquery name="getLastContent" datasource="#session.global_dsn#" >
		UPDATE EGINAUTOINCREMENT 
		   SET LASTCOUNT = <cfqueryparam cfsqltype="cf_sql_integer" value="#incVal#">
		  WHERE EFORMID = '#eformid#';
	</cfquery>
</cfif>

<cfset newVal = replace(theFormat,"#theAutoIncStr#", numberFormat(incVal,formatValNow), "all") >
<br><br>
<cfoutput >
    	#theAutoIncStr#
    </cfoutput>
<br><br>
<cfoutput >
    	#newVal#
    </cfoutput>







--->