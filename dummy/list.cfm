<cfset thelist = "" >
<cfset cOrder = "5" >


<cfif listfind(thelist,cOrder, ",") >
	<cfoutput>It does #listfind(thelist,cOrder, ",")#</cfoutput>
<cfelse>
	<cfoutput>It doesnt #listfind(thelist,cOrder, ",")#</cfoutput>
</cfif>
<br>
<CFSET HI = "">
<cfoutput>#evaluate(HI)#</cfoutput>
<cfif evaluate(HI)> 
	<cfoutput>true</cfoutput> 
<cfelse>
	<cfoutput>false</cfoutput>
</cfif>
<br>
<cfset conditionArr = ArrayNew(1) > 
<cfset conditionUnknown = ArrayNew(1) > 
<cfset conditionExp = ArrayNew(1) > 

<cfset ArrayAppend(conditionArr, "1") >
<cfset ArrayAppend(conditionArr, "0") >
<cfset ArrayAppend(conditionArr, "1") >
<cfset ArrayAppend(conditionArr, "1") >
<cfset ArrayAppend(conditionArr, "0") >
<cfset ArrayAppend(conditionArr, "1") >
<cfset ArrayAppend(conditionArr, "0") >
<cfset ArrayAppend(conditionArr, "0") >
<cfset ArrayAppend(conditionArr, "1") >
<cfset ArrayAppend(conditionArr, "0") >

<cfset ArrayAppend(conditionExp, "AND") >
<cfset ArrayAppend(conditionExp, "AND") >
<cfset ArrayAppend(conditionExp, "OR") >
<cfset ArrayAppend(conditionExp, "AND") >
<cfset ArrayAppend(conditionExp, "AND") >
<cfset ArrayAppend(conditionExp, "OR") >
<cfset ArrayAppend(conditionExp, "AND") >
<cfset ArrayAppend(conditionExp, "AND") >
<cfset ArrayAppend(conditionExp, "OR") >
<cfset ArrayAppend(conditionExp, "AND") >

<cfset expArr = ArrayNew(1) >
<cfloop from="1" to="#ArrayLen(conditionExp)#" index="theCnt" >
	<cfset ArrayAppend(expArr,conditionArr[theCnt]) > 
	<cfif ArrayLen(conditionExp) eq theCnt >
	<cfelse>
		<cfset ArrayAppend(expArr,conditionExp[theCnt]) >
	</cfif> 
</cfloop>

<cfset theConditionExp = ArrayToList(expArr, " ") >
<cfif evaluate(theConditionExp)> 
	<cfoutput>true</cfoutput> 
<cfelse>
	<cfoutput>false</cfoutput>
</cfif>
<cfdump var="#theConditionExp#" >
