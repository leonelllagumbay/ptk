
<cfquery name="queryecinqueryrowtoemail" datasource="#session.company_dsn#" maxrows="1">
	SELECT * 
	  FROM ECINQUERYROWTOEMAIL
	 WHERE EFORMID = '#eformid#' AND PROCESSID = '#processid#'
</cfquery>

<cfset attrStruct = StructNew() >


<cfloop query="queryecinqueryrowtoemail" >
	
	<cfif TFREQUENCY eq "once" >
		<cfset attrStruct.interval="once" >
		<cfset attrStruct.startdate="#dateformat(TASKDURATIONSTARTDATE,'mm/dd/yy')#" >
		<cfset attrStruct.starttime="#timeformat(TFREQONETIMEAT, 'short')#" >
		
	<cfelseif TFREQUENCY eq "recurring" >
		<cfset attrStruct.interval="#TFREQRECURRING#" >
		<cfset attrStruct.startdate="#dateformat(TASKDURATIONSTARTDATE, 'mm/dd/yy')#" >
		<cfset attrStruct.starttime="#timeformat(TFREQONETIMEAT, 'short')#" >
		<cfif trim(TASKDURATIONENDDATE) neq "" >
			<cfset attrStruct.enddate="#dateformat(TASKDURATIONENDDATE, 'mm/dd/yy')#" >
		</cfif>
		
	<cfelseif TFREQUENCY eq "daily" > <!---daily every--->
	    <!---compute interval (in seconds) first--->
	    <!---<cfset intervalInSec = createtime(TFREQDAILYEVERYHOUR,TFREQDAILYEVERYMINUTE,TFREQDAILYEVERYSECOND) >--->
	    
	    <cfset hpartInSec = LSParseNumber(TFREQDAILYEVERYHOUR) * 60 * 60 >
	    <cfset mpartInSec = LSParseNumber(TFREQDAILYEVERYMINUTE) * 60 >
	    <cfset intervalInSec = hpartInSec + mpartInSec + LSParseNumber(TFREQDAILYEVERYSECOND) >
	    
		<cfset attrStruct.interval="#intervalInSec#" >
		<cfset attrStruct.startdate="#TASKDURATIONSTARTDATE#" >
		<cfset attrStruct.starttime="#TFREQONETIMEAT#" >
		
		<cfif trim(TASKDURATIONENDDATE) neq "" >
			<cfset attrStruct.enddate="#dateformat(TASKDURATIONENDDATE, 'mm/dd/yy')#" >
		</cfif>
		<cfif trim(TFREQDAILYEVERYENDTIME) neq "" >
			<cfset attrStruct.endtime="#timeformat(TFREQDAILYEVERYENDTIME, 'short')#" >
		</cfif>
		<cfif trim(TFREQDAILYEVERYREPEAT) eq "repeat" >
			<cfset attrStruct.repeat="#TFREQDAILYEVERYREPEATTIMES#" >
		</cfif>
		
	<cfelseif TFREQUENCY eq "crontime" >
		<cfset attrStruct.cronTime="#TCRONTIMEEXP#" >
	<cfelseif TFREQUENCY eq "chained" >
		
	<cfelse> <!---once--->
		<cfset attrStruct.interval="once" >
		<cfset attrStruct.startdate="#dateformat(TASKDURATIONSTARTDATE,'mm/dd/yy')#" >
		<cfset attrStruct.starttime="#timeformat(TFREQONETIMEAT, 'short')#" >
	</cfif>
	
	<!---Other Settings--->
	
	<cfif trim(TUSERNAME) neq "" >
		<cfset attrStruct.username="#TUSERNAME#" >
	</cfif>
	
	<cfif trim(TPASSWORD) neq "" >
		<cfset attrStruct.password="#TPASSWORD#" >
	</cfif>
	
	
	<cfif trim(TTIMEOUTINSEC) neq "" >
		<cfset attrStruct.requestTimeOut="#TTIMEOUTINSEC#" >
	</cfif>
	
	<cfif trim(TPROXYSERVER) neq "" >
		<cfset attrStruct.proxyServer="#TPROXYSERVER#" >
	</cfif>
	
	<cfif trim(TPROXYPORT) neq "" >
		<cfset attrStruct.proxyPort="#TPROXYPORT#" >
	</cfif>
	
	<cfif trim(TPUBLISH) neq "false" AND trim(TPUBLISH) neq "">
		<cfset attrStruct.publish="#TPUBLISH#" >
		<cfset attrStruct.path = expandpath("./published") >
		<cfset attrStruct.file = '#TASKNAME#' >
	</cfif>
	
	<cfif trim(TRESOLVEURL) neq "false" AND trim(TRESOLVEURL) neq "">
		<cfset attrStruct.resolveURL="#TRESOLVEURL#" >
	</cfif> 
	
	<cfif trim(TEVENTHANDLER) neq "" >
		<cfset attrStruct.eventHandler="#TEVENTHANDLER#" >
	</cfif>
	
	<cfif trim(TEXCLUDE) neq "" >
		<cfset attrStruct.exclude="#TEXCLUDE#" >
	</cfif>
	
	<cfif trim(ONMISFIRE) neq "ignore" >
		<cfset attrStruct.onMisfire="#ONMISFIRE#" >
	</cfif>
	
	<cfif trim(ONEXCEPTION) neq "ignore" >
		<cfset attrStruct.onException="#ONEXCEPTION#" >
	</cfif>
	
	<cfif trim(ONCOMPLETE) neq "" >
		<cfset attrStruct.onComplete="#ONCOMPLETE#" >
	</cfif>
	
	<cfif trim(PRIORITY) neq "" >
		<cfset attrStruct.priority="#PRIORITY#" >
	</cfif>
	
	<cfif trim(RETRYCOUNT) neq "" >
		<cfset attrStruct.retryCount="#RETRYCOUNT#" >  
	</cfif>
	
	<cfif trim(CLUSTER) neq "false" AND trim(CLUSTER) neq "" >
		<cfset attrStruct.cluster="#CLUSTER#" >
	</cfif>
	<!---End Other Settings--->  
	<cfschedule 
	    action="update"
	    operation = "HTTPRequest"
		task="#TASKNAME#"
		group="#TASKGROUP#"
		url="#session.domain##TASKURL#?eformid=#urlencodedformat(eformid)#&processid=#urlencodedformat(processid)#&companydsn=#urlencodedformat(session.company_dsn)#"
		attributecollection="#attrStruct#"
	>

</cfloop>