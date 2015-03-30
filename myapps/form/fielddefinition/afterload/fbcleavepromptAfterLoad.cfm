<CFPARAM name="pID" default="#formOwner#">
<CFPARAM name="SLcode" default= "SL">
<CFPARAM name="VLcode" default= "VL">
<CFPARAM name="ULcode" default= "UL">
<CFPARAM name="sLVLbegBal" default="0">
<CFPARAM name="ulbegBal" default="5.5">
<CFPARAM name="sLVLcred" default="1.25">
<CFPARAM name="lvDeb" default="1.1">
<CFPARAM name="sLEarnLv" default= "0">
<CFPARAM name="sLActLv" default= "0">
<CFPARAM name="vLEarnLv" default= "0">
<CFPARAM name="vLActLv" default= "0">
<CFPARAM name="uLActLv" default= "0">
<CFPARAM name="SLActBal" default= "0">
<CFPARAM name="VLActBal" default= "0">
<CFPARAM name="ULActBal" default= "0">
<CFPARAM name="SLpend" default= "0">
<CFPARAM name="VLpend" default= "0">
<CFPARAM name="ULpend" default= "0">



<cfif IsDefined("GETENTRY.ROUTEID") AND Len(GETENTRY.ROUTEID)>
    <CFQUERY NAME="qryPID" DATASOURCE="#session.COMPANY_DSN#">    
         SELECT PERSONNELIDNO 
         FROM CINLEAVEAPPSI
         WHERE ROUTEID = '#GETENTRY.ROUTEID#'
    </cfquery>
    <cfset pID = qryPID.PERSONNELIDNO>
</cfif>

<CFQUERY name="getPA" datasource="#session.COMPANY_DSN#">
	SELECT DATEHIRED
    FROM CMFPA
    WHERE PERSONNELIDNO = '#pID#'
</CFQUERY>

<CFIF YEAR(getPA.DATEHIRED) EQ YEAR(NOW())>
	<CFSET moHired = Month(getPA.DATEHIRED)>
    <CFSET daHired = Day(getPA.DATEHIRED)>
	<CFSET nMo = (Month(Now()) - Month(getPA.DATEHIRED)) - 1>    
    <CFIF nMo>
		<CFSET sLVLbegBal = ((DaysInMonth(moHired) - daHired) * sLVLcred ) / DaysInMonth(moHired)>
        <CFSET sLVLbegBalTEMP = nMo * sLVLcred>
        <CFSET sLVLbegBal = sLVLbegBalTEMP + sLVLbegBal>
    </CFIF>
<CFELSE>
	<CFSET nMo = Month(Now())>
    <CFSET sLVLbegBal = nMo * sLVLcred>
</CFIF>

<CFIF sLVLbegBal LT ulbegBal>
	<CFSET ulbegBal = sLVLbegBal>
    <CFSET ulbegBal = NumberFormat(ulbegBal,'9.99')>
</CFIF>
<CFSET sLVLbegBal = NumberFormat(sLVLbegBal,'9.99')>

<CFQUERY NAME="getEnt" DATASOURCE="#session.COMPANY_DSN#">
	SELECT LEAVEENTITLEMENT, LEAVEBALANCE, AVAILEDLEAVE, LEAVETYPE
    FROM CINLVENTITLEMENT
    WHERE PERSONNELIDNO  = '#pID#'
    AND LEAVETYPE IN ('#SLcode#','#VLcode#','#ULcode#')
</CFQUERY>

<CFIF getEnt.RecordCount>
    <cfquery name="sl" dbtype="query">
    	SELECT * FROM getEnt
        WHERE LEAVETYPE = '#SLcode#'
    </cfquery>
    
    <CFIF sl.RecordCount>
		<CFSET sLEarnLv = sl.LEAVEENTITLEMENT>
        <CFSET sLActLv = sl.AVAILEDLEAVE>
    </CFIF>
    
    <cfquery name="vl" dbtype="query">
    	SELECT * FROM getEnt
        WHERE LEAVETYPE = '#VLcode#'
    </cfquery>
    <CFIF vl.RecordCount>
		<CFSET vLEarnLv = vl.LEAVEENTITLEMENT>
        <CFSET vLActLv = vl.AVAILEDLEAVE>
    </CFIF>
    
    
     <cfquery name="ul" dbtype="query">
    	SELECT * FROM getEnt
        WHERE LEAVETYPE = '#ULcode#'
    </cfquery>
    <CFIF ul.RecordCount>
    	<CFSET uLActLv = ul.AVAILEDLEAVE>  
    </CFIF>
</CFIF>

<CFQUERY NAME="getLvs" DATASOURCE="#session.COMPANY_DSN#">
	SELECT COUNT(DOCNUMBER) AS COUNT, LEAVETYPE
    FROM CINLEAVEAPPSI
    WHERE PERSONNELIDNO  = '#pID#'
    AND LEAVETYPE IN ('#SLcode#','#VLcode#','#ULcode#')
    AND APPROVED IS NOT NULL
    AND APPROVED NOT IN ('Y','N')
    GROUP BY LEAVETYPE
</CFQUERY>

<CFIF getLvs.RecordCount>
    <cfquery name="sl" dbtype="query">
    	SELECT * FROM getLvs
        WHERE LEAVETYPE = '#SLcode#'
    </cfquery> 
    <CFIF sl.RecordCount>
    	<cfset SLpend = sl.COUNT>
    </CFIF>
    
    <cfquery name="vl" dbtype="query">
    	SELECT * FROM getLvs
        WHERE LEAVETYPE = '#VLcode#'
    </cfquery>
    <CFIF vl.RecordCount>
    	<cfset VLpend = vl.COUNT>
    </CFIF>
    
    <cfquery name="ul" dbtype="query">
    	SELECT * FROM getLvs
        WHERE LEAVETYPE = '#ULcode#'
    </cfquery>
    <CFIF ul.RecordCount>
    	<cfset ULpend = ul.COUNT>
    </CFIF>

</CFIF>

<cfset sLVLbegBal = chcNum(sLVLbegBal)>
<cfset sLEarnLv = chcNum(sLEarnLv)>
<cfset sLActLv = chcNum(sLActLv)>
<cfset vLEarnLv = chcNum(vLEarnLv)>
<cfset vLActLv = chcNum(vLActLv)>
<cfset ulbegBal = chcNum(ulbegBal)>
<cfset uLActLv = chcNum(uLActLv)>


<CFSET SLActBal = Evaluate( (sLVLbegBal + sLEarnLv) - sLActLv )>
<CFSET VLActBal  = Evaluate( (sLVLbegBal + vLEarnLv) - vLActLv )>
<CFSET ULActBal = Evaluate( ulbegBal - uLActLv )>



<CFOUTPUT>
<cfset str1 =     '<TABLE  BORDER = 1 CELLPADDING = 3 CELLSPACING = 0 class="prelvtble">' >
<cfset str1 = str1 & '<TR>' >
<cfset str1 = str1 & '<TH WIDTH = "150px">&nbsp;</TD>' >
<cfset str1 = str1 & '<TH WIDTH = "150px">Sick Leave</TD>' >
<cfset str1 = str1 & '<TH WIDTH = "150px">Vacation Leave</TD>' >
<cfset str1 = str1 & '<TH WIDTH = "150px">Unscheduled Leave</TD>' >
<cfset str1 = str1 & '</TR>' >
<cfset str1 = str1 & '<TR>' >
<cfset str1 = str1 & '<TD>Beg. Balance as of <b>Jan #Year(Now())#</b></TD>'>
<cfset str1 = str1 & '<TD>#sLVLbegBal#</TD>' >
<cfset str1 = str1 & '<TD>#sLVLbegBal#</TD>' >
<cfset str1 = str1 & '<TD>#ulbegBal#</TD>' >
<cfset str1 = str1 & '</TR>' >
<cfset str1 = str1 & '<TR>' >
<cfset str1 = str1 & '<TD>YTD Earned Leaves</TD>' >
<cfset str1 = str1 & '<TD>#sLEarnLv#</TD>' >
<cfset str1 = str1 & '<TD>#vLEarnLv#</TD>' >
<cfset str1 = str1 & '<TD>-</TD>' >
<cfset str1 = str1 & '</TR>' >
<cfset str1 = str1 & '<TR>' >
<cfset str1 = str1 & '<TD>YTD Used Leaves</TD>' >
<cfset str1 = str1 & '<TD>#sLActLv#</TD>' >
<cfset str1 = str1 & '<TD>#vLActLv#</TD>' >
<cfset str1 = str1 & '<TD>#uLActLv#</TD>' >
<cfset str1 = str1 & '</TR>' >
<cfset str1 = str1 & '<TR>' >
<cfset str1 = str1 & '<TD>YTD Actual Balance</TD> ' >
<cfset str1 = str1 & '<TD>#SLActBal#</TD>' >
<cfset str1 = str1 & '<TD>#VLActBal#</TD>' >
<cfset str1 = str1 & '<TD>#ULActBal#</TD>' >
<cfset str1 = str1 & '</TR>' >
<cfset str1 = str1 & '<TR>' >
<cfset str1 = str1 & '<TD>YTD Pending Approval/Unused</TD> ' >
<cfset str1 = str1 & '<TD>#SLpend#</TD>' >
<cfset str1 = str1 & '<TD>#VLpend#</TD>' >
<cfset str1 = str1 & '<TD>#ULpend#</TD>' >
<cfset str1 = str1 & '</TR>' >
<cfset str1 = str1 & '<TR>' >
<cfset str1 = str1 & '<TD>YTD Available Balance</TD>' >
<cfset str1 = str1 & '<TD>#Evaluate(SLActBal - SLpend )#</TD>' >
<cfset str1 = str1 & '<TD>#Evaluate(VLActBal - VLpend )#</TD>' >
<cfset str1 = str1 & '<TD>#Evaluate(ULActBal - ULpend )#</TD>' >
<cfset str1 = str1 & '</TR>' >
<cfset str1 = str1 & '</TABLE>' >
</CFOUTPUT>

<cffunction name="chcNum" returntype="numeric" access="private">
	<cfargument name="str" type="string" default="0">
    
    <CFIF Len(str) AND IsNumeric(str)>
    	<cfreturn str>
    <CFELSE>
    	<cfreturn 0>
    </CFIF>
    

</cffunction>



<cfset str1 = str1 & '<style type="text/css">' >
<cfset str1 = str1 & '.prelvtble{' >
<cfset str1 = str1 & 'border-collapse:collapse; ' >
<cfset str1 = str1 & 'border:1px solid ##000' >
<cfset str1 = str1 & '}' >
	
<cfset str1 = str1 & '.prelvtble TR TH {' >
<cfset str1 = str1 & 'font-weight:bold;	' >
<cfset str1 = str1 & 'font-size:12px;' >
<cfset str1 = str1 & '}' >
	
<cfset str1 = str1 & '.prelvtble tr:not(:first-child) td:not(:first-child){' >
<cfset str1 = str1 & 'text-align:center;' >
<cfset str1 = str1 & 'font-weight:bold;	' >
<cfset str1 = str1 & '}' >
<cfset str1 = str1 & '</style>' >

<!---afterload--->

<cfscript>
	tmpresult['C__CMFPA__GUID'] = "#str1#";   
</cfscript>

<cfset returnStruct['success'] = "true" >
<cfset returnStruct['data']   = tmpresult >




