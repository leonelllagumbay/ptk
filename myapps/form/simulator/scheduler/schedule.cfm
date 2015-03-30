<cfif url.action eq "checkprocess" >

<cfset eformid=url.eformid >
<cfset processid=url.processid >
<cfset domain=url.domain >
<cfset globaldsn=url.globaldsn >
<cfset companydsn=url.companydsn >
<cfset companyname=url.companyname >

<cfset subcomdsn = url.subcomdsn >
<cfset querydsn = url.querydsn >
<cfset transactiondsn = url.transactiondsn >
<cfset sitedsn = url.sitedsn >

<cfset dbsource = url.dbsource >
<cfset tablename = url.tablename >
<cfset pid = url.pid >
<cfset maintable = url.maintable >
<cfset mainpk = url.mainpk >
<cfset websiteemailadd = url.websiteemailadd>

<cfset dbms = url.dbms >
<cfset ek = url.ek >


<!---is the process expired--->
<!---<cfset formProcessData = EntityLoad( "EGINFORMPROCESSDETAILS", #processid#, true ) >--->
<cfquery name="formProcessData" datasource ="#globaldsn#" maxrows="1">
	SELECT * FROM EGINFORMPROCESSDETAILS
	 WHERE PROCESSDETAILSID = '#processid#'
</cfquery>

<cfloop query="formProcessData" >
	<cfset datecreated = formProcessData.RECDATECREATED >
	<cfset expirationdate = dateadd("d", formProcessData.EFORMLIFE, datecreated ) >

	<cfif datediff( "d", now(), expirationdate ) gt 0 > <!---not expired--->
		<cfinvoke method="processNotExpired" >
	<cfelse> <!---expired--->
		<cfinvoke method="processIsExpired" >
	</cfif>
</cfloop>

<cffunction name="processNotExpired" >

	<cfoutput>processNotExpired</cfoutput>

	<cfset previousRouterIsDone = "false" >
	<cfset pidArray = ArrayNew(1) >
	<cfset freqArray = ArrayNew(1) >
	<cfset expirArray = ArrayNew(1) >
	<cfset therouterdetailsid = ArrayNew(1) >

	<!---loop over the routers, then check expiration date of each router--->
	<!---<cfset formRouterData = EntityLoad("EGINROUTERDETAILS", {PROCESSIDFK = #processid#}, "ROUTERORDER ASC") >--->
	<cfquery name="formRouterData" datasource ="#globaldsn#" >
		SELECT * FROM EGINROUTERDETAILS
		 WHERE PROCESSIDFK = '#processid#'
		ORDER BY ROUTERORDER ASC
	</cfquery>
		<cfloop query="formRouterData" >
			<!---check if APPROVED or DISAPPROVED--->
			<cfif formRouterData.STATUS eq 'APPROVED' >
				<!---continue to the next router, this router had been approved successfully--->
				<cfcontinue>
			<cfelseif formRouterData.STATUS eq 'DISAPPROVED' OR formRouterData.STATUS eq 'IGNORED'>
				<!---continue to the next router, this router had been disapproved successfully--->
				<cfcontinue>
			<cfelse> <!---for PENDING and SENT BACK TO ORIGINATOR--->
				<!---check the router if expired--->
				<cfif datediff( "d", now(), formRouterData.EXPIRATIONDATE ) gt 0 > <!---not expired--->
					<!---check if previous router had been expired--->
						<cfoutput>not expired</cfoutput>
					<cfif previousRouterIsDone eq "true" >
						<cfoutput>true prev</cfoutput>
						<cfinvoke method="updateRouterApprover" > <!---set PENDING to CURRENT Status--->
					</cfif>
					<cfcontinue> <!---check following router(s)--->
				<cfelse> <!---expired--->
					<cfoutput>expired</cfoutput>
					<cfinvoke method="routerIsExpired" >
				</cfif>
			</cfif>

		</cfloop>
		<cfoutput>followup NOTIF</cfoutput>
		<cfinvoke method="followUpNotif" >

<cfreturn "success" >
</cffunction>




<cffunction name="processIsExpired" >

	<!---make all status that is not APPROVED and DISAPPROVED to IGNORED
	then update the main form table to APPROVE = Y or D
	depending on the action when the process is expired--->
	<cfif trim( formProcessData.EXPIREDACTION ) eq "APPROVE" >
		<cfoutput>approve</cfoutput>
		<cfinvoke method="updateMainTable" >
		<cfinvoke method="ignoreCurrentAndPending" >
	<cfelse>
		<cfoutput>disapprove</cfoutput>

		<cfinvoke method="disapproveRouter" >
	</cfif>

<cfreturn "success" >
</cffunction>


<cffunction name="routerIsExpired" >
	<!---approve this router--->
	<!---loop over the approvers and set the status with CURRENT,PENDING,SENT BACK TO ORIGINATOR = IGNORED--->


	<!---check importantly if this is the last router--->
	<cfif formRouterData.ISLASTROUTER eq "true" OR ArrayLen(formRouterData) eq formRouterData.ROUTERORDER>
		<!---this router is the last--->
		<!---<cfset currentRouter = EntityLoad("EGINROUTERDETAILS", {ROUTERDETAILSID = #formRouterData.ROUTERDETAILSID#}, true) >
		<cfset currentRouter.setSTATUS("APPROVED") >
		<cfset currentRouter.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')# #timeformat(now(), 'HH:MM:SS')#") >
		<cfset EntitySave(currentRouter) >
		<cfset ormflush()>--->
		<cfquery name="currentRouter" datasource="#globaldsn#" >
			UPDATE EGINROUTERDETAILS
			   SET STATUS = <cfqueryparam cfsqltype="cf_sql_varchar" value="APPROVED">,
			       DATELASTUPDATE = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#dateformat(now(), 'YYYY-MM-DD')# #timeformat(now(), 'HH:MM:SS')#">
			 WHERE ROUTERDETAILSID = '#formRouterData.ROUTERDETAILSID#'
		</cfquery>
		<cfset previousRouterIsDone = "true" >

		<cfif trim(formRouterData.EXPIREDACTION) eq "APPROVE" >
			<cfinvoke method="updateMainTable" >
			<cfinvoke method="ignoreCurrentAndPending" >
		<cfelse>
			<cfinvoke method="disapproveRouter" >
		</cfif>

		<!---no more email notification to originator because the form was approved in a way of router timedout--->

	<cfelse>
		<!---<cfset currentRouter = EntityLoad("EGINROUTERDETAILS", {ROUTERDETAILSID = #formRouterData.ROUTERDETAILSID#}, true) >
		<cfset currentRouter.setSTATUS("TIMEDOUT") >
		<cfset currentRouter.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')# #timeformat(now(), 'HH:MM:SS')#") >
		<cfset EntitySave(currentRouter) >
		<cfset ormflush()>--->
		<cfquery name="currentRouter" datasource="#globaldsn#" >
			UPDATE EGINROUTERDETAILS
			   SET STATUS = <cfqueryparam cfsqltype="cf_sql_varchar" value="TIMEDOUT">,
			       DATELASTUPDATE = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#dateformat(now(), 'YYYY-MM-DD')# #timeformat(now(), 'HH:MM:SS')#">
			 WHERE ROUTERDETAILSID = '#formRouterData.ROUTERDETAILSID#'
		</cfquery>
		<cfset previousRouterIsDone = "true" >
		<cfquery name="currentRouter" datasource="#globaldsn#" maxrows="1">
			SELECT *
			  FROM EGINROUTERDETAILS
			 WHERE ROUTERDETAILSID = '#formRouterData.ROUTERDETAILSID#'
		</cfquery>
		<!---<cfset formApproversDataD = EntityLoad("EGINAPPROVERDETAILS", {ROUTERIDFK =#currentRouter.getROUTERDETAILSID()#}, "APPROVERORDER ASC" ) >--->
		<cfquery name="formApproversDataD" datasource="#globaldsn#">
			SELECT *
			  FROM EGINAPPROVERDETAILS
			 WHERE ROUTERIDFK = '#currentRouter.getROUTERDETAILSID()#'
			 ORDER BY APPROVERORDER ASC
		</cfquery>
		<cfloop query="formApproversDataD" >
			<cftry>
				<!---<cfset updateActionD = EntityLoad("EGINAPPROVERDETAILS", {APPROVERDETAILSID =#formApproversDataD.APPROVERDETAILSID#,ACTION='CURRENT'}, true ) >
				<cfset updateActionD.setACTION("IGNORED") >
				<cfset updateActionD.setDATELASTUPDATE("#dateformat(now(), "YYYY-MM-DD")# #timeformat(now(), "HH:MM:SS")#") >
				<cfset EntitySave(updateActionD) >
				<cfset ormflush() >--->
				<cfquery name="updateActionD" datasource="#globaldsn#" >
					UPDATE EGINAPPROVERDETAILS
					   SET ACTION = <cfqueryparam cfsqltype="cf_sql_varchar" value="IGNORED">,
					       DATELASTUPDATE = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#dateformat(now(), 'YYYY-MM-DD')# #timeformat(now(), 'HH:MM:SS')#">
					 WHERE APPROVERDETAILSID = '#formApproversDataD.APPROVERDETAILSID#' AND ACTION='CURRENT'
				</cfquery>

				<!---for the current router which is approved--->
				<!---<cfset updateCount = EntityLoad("EGINEFORMCOUNT", { EFORMID =#eformid#, PERSONNELIDNO = #formApproversDataD.PERSONNELIDNO#}, true ) >--->
				<cfquery name="queryCount" datasource="#globaldsn#" maxrows="1">
					SELECT * FROM EGINEFORMCOUNT
					 WHERE EFORMID = '#eformid#' AND PERSONNELIDNO='#formApproversDataD.PERSONNELIDNO#'
				</cfquery>
				<cfloop query="queryCount" >
					<cfquery name="updateCount" datasource="#globaldsn#" >
						UPDATE EGINEFORMCOUNT
							<cfif queryCount.PENDING gt 0 >
								<cfset currentCount = queryCount.PENDING - 1 >
								SET PENDING = <cfqueryparam cfsqltype="cf_sql_integer" value="#currentCount#">
							<cfelseif queryCount.NEW gt 0 >
								<cfset currentCount = queryCount.NEW - 1 >
								SET NEW = <cfqueryparam cfsqltype="cf_sql_integer" value="#currentCount#">
							</cfif>
						 WHERE EFORMID = '#eformid#' AND PERSONNELIDNO='#formApproversDataD.PERSONNELIDNO#'
					</cfquery>
				</cfloop>

				<!---<cfif isdefined("updateCount") >
					    <cfif updateCount.getPENDING() gt 0 >
							<cfset currentCount = updateCount.getPENDING() - 1 >
							<cfset updateCount.setPENDING(currentCount) >
						<cfelseif updateCount.getNEW() gt 0 >
							<cfset currentCount = updateCount.getNEW() - 1 >
							<cfset updateCount.setNEW(currentCount) >
						</cfif>
						<cfset EntitySave(updateCount) >
						<cfset ormflush()>
				<!---end for the current router which is approved --->
				</cfif>--->
				<cfcatch>
				</cfcatch>
			</cftry>
			<cftry>
				<!---<cfset updateActionE = EntityLoad("EGINAPPROVERDETAILS", {APPROVERDETAILSID =#formApproversDataD.APPROVERDETAILSID#,ACTION='PENDING'}, true ) >
				<cfset updateActionE.setACTION("IGNORED") >
				<cfset updateActionE.setDATELASTUPDATE("#dateformat(now(), "YYYY-MM-DD")# #timeformat(now(), "HH:MM:SS")#") >
				<cfset EntitySave(updateActionE) >
				<cfset ormflush() >--->
				<cfquery name="updateActionE" datasource="#globaldsn#" >
					UPDATE EGINAPPROVERDETAILS
					   SET ACTION = <cfqueryparam cfsqltype="cf_sql_varchar" value="IGNORED">,
					       DATELASTUPDATE = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#dateformat(now(), 'YYYY-MM-DD')# #timeformat(now(), 'HH:MM:SS')#">
					 WHERE APPROVERDETAILSID = '#formApproversDataD.APPROVERDETAILSID#' AND ACTION='PENDING'
				</cfquery>
				<cfcatch>
					<cfcontinue>
				</cfcatch>
			</cftry>
		</cfloop>

	</cfif>

	<cftry>
		<cfschedule action="delete" task="router#processid#" >
	<cfcatch>
		<cftry>
			<cfschedule action="delete" task="router#processid#" >
			<cfcatch>
			</cfcatch>
		</cftry>
	</cfcatch>
	</cftry>

<cfreturn "success" >
</cffunction>


<cffunction name="updateRouterApprover" >
	<!---<cfset formApproversDataB = EntityLoad("EGINAPPROVERDETAILS", {ROUTERIDFK =#formRouterData.ROUTERDETAILSID#}, "APPROVERORDER ASC" ) >--->
	<cfquery name="formApproversDataB" datasource="#globaldsn#" >
		SELECT *
		  FROM EGINAPPROVERDETAILS
		 WHERE ROUTERIDFK = '#formRouterData.ROUTERDETAILSID#'
		ORDER BY APPROVERORDER ASC
	</cfquery>
	<cfloop query="formApproversDataB" >
		<!---<cfset updateActionB = EntityLoad("EGINAPPROVERDETAILS", {APPROVERDETAILSID =#formApproversDataB.APPROVERDETAILSID#,ACTION='PENDING'}, true ) >--->
			<cfquery name="updateActionB" datasource="#globaldsn#" maxrows="1">
				SELECT *
				  FROM EGINAPPROVERDETAILS
				 WHERE APPROVERDETAILSID = '#formApproversDataB.APPROVERDETAILSID#' AND ACTION='PENDING'
			</cfquery>
			<cfif updateActionB.RecordCount gt 0 >

				<!---<cfset updateCount = EntityLoad("EGINEFORMCOUNT", { EFORMID =#eformid#, PERSONNELIDNO = #updateActionB.getPERSONNELIDNO()#}, true ) >
				<cfif isdefined("updateCount") >
					<cfset currentCount = updateCount.getNEW() + 1 >
					<cfset updateCount.setNEW(currentCount) >
				<cfelse>
					<cfset updateCount = EntityNew("EGINEFORMCOUNT") >
					<cfset updateCount.setNEW("1") >
					<cfset updateCount.setEFORMID(eformid) >
					<cfset updateCount.setPERSONNELIDNO(updateActionB.getPERSONNELIDNO()) >
					<cfset updateCount.setPENDING("0") >
					<cfset updateCount.setRETURNED("0") >
				</cfif>
				<cfset EntitySave(updateCount) >
				<cfset ormflush()>--->
				<cfquery name="queryCount" datasource="#globaldsn#" >
					SELECT *
					 FROM EGINEFORMCOUNT
					 WHERE EFORMID = '#eformid#' AND PERSONNELIDNO='#updateActionB.PERSONNELIDNO#'
				</cfquery>
				<cfif queryCount.recordcount gt 0 >
					<cfquery name="updateCount" datasource="#globaldsn#" >
						UPDATE EGINEFORMCOUNT
							   <cfset currentCount = queryCount.NEW + 1 >
						  SET NEW = <cfqueryparam cfsqltype="cf_sql_integer" value="#currentCount#">
						 WHERE EFORMID = '#eformid#' AND PERSONNELIDNO='#updateActionB.PERSONNELIDNO#'
					</cfquery>
				<cfelse>
					<cfquery name="updateCount" datasource="#globaldsn#" >
						INSERT INTO EGINEFORMCOUNT (EFORMID,PERSONNELIDNO,PENDING,RETURNED,NEW,APPROVED,DISAPPROVED)
						VALUES (
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#eformid#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#updateActionB.PERSONNELIDNO#">,
							<cfqueryparam cfsqltype="cf_sql_integer" value="0">,
							<cfqueryparam cfsqltype="cf_sql_integer" value="0">,
							<cfqueryparam cfsqltype="cf_sql_integer" value="1">,
							<cfqueryparam cfsqltype="cf_sql_integer" value="0">,
							<cfqueryparam cfsqltype="cf_sql_integer" value="0">
						)
					</cfquery>
				</cfif>

				<!---<cfset updateActionB.setACTION("CURRENT") >
				<cfset updateActionB.setISREAD("false") >
				<cfset updateActionB.setDATESTARTED("#dateformat(now(), "YYYY-MM-DD")# #timeformat(now(), "HH:MM:SS")#") >
				<cfset updateActionB.setDATELASTUPDATE("#dateformat(now(), "YYYY-MM-DD")# #timeformat(now(), "HH:MM:SS")#") >
				<cfset EntitySave(updateActionB) >
				<cfset ormflush() >--->

				<cfquery name="updateActionB" datasource="#globaldsn#" >
					UPDATE EGINAPPROVERDETAILS
					   SET ACTION = <cfqueryparam cfsqltype="cf_sql_varchar" value="CURRENT">,
					   	   DATESTARTED = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#dateformat(now(), 'YYYY-MM-DD')# #timeformat(now(), 'HH:MM:SS')#">,
					       DATELASTUPDATE = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#dateformat(now(), 'YYYY-MM-DD')# #timeformat(now(), 'HH:MM:SS')#">
					 WHERE APPROVERDETAILSID = '#formApproversDataB.APPROVERDETAILSID#' AND ACTION='PENDING'
				</cfquery>

				<cfset ArrayAppend(pidArray, updateActionB.getPERSONNELIDNO()) >

			</cfif>
	</cfloop>
	<cfset previousRouterIsDone = "false" >
	<!---notify next approvers which is this approver(s)--->
	<cfif formRouterData.NOTIFYNEXTAPPROVERS eq "true" AND ArrayLen(pidArray) gt 0 >
		<cfset moreemailcopy = formRouterData.MOREEMAILADD >
		<cfset url.routerid  = formRouterData.ROUTERDETAILSID > <!---instead of using the passed one which is the first router's ref--->
		<cfset notfollowup = "remove the follow-up word" >
		<cfinvoke 	method="emailFromSched"
				  	returnvariable="resultemail"
		>
		<cfset ArrayAppend( freqArray, formRouterData.FREQUENCYFOLLOUP ) >
		<cfset ArrayAppend( expirArray, formRouterData.EXPIRATIONDATE ) >
		<cfset ArrayAppend( therouterdetailsid, formRouterData.ROUTERDETAILSID ) >
	</cfif>
	<!---end notifications --->

<cfreturn "success" >
</cffunction>


<cffunction name="followUpNotif" >
			<!---schedule followups--->
<cfif ArrayLen(freqArray) neq 0 >
	<cfset freqinhours = freqArray[1]*60*60 > <!---in seconds--->
	<cfset freqinhours = NumberFormat(freqinhours, "0") >
	<cfset endDateB    = expirArray[1] >
	<cfset therouterdetailsid = therouterdetailsid[1] >

	<cftry>
		<!---make schedule for next approvers, update the existing router shedule--->
		<cfschedule
			action      	 = "update"
		    task        	 = "router#processid#"
			operation   	 = "HTTPRequest"
			interval    	 = "#freqinhours#"
			startdate   	 = "#dateformat(now(), 'mm/dd/yy')#"
			starttime   	 = "#timeformat(now(), 'short')#"
			enddate   	     = "#dateformat(endDateB, 'mm/dd/yy')#"
			url        	 	 = "#domain#myapps/form/simulator/schedule.cfm?eformid=#eformid#&processid=#processid#&action=followupemail&domain=#url.domain#&routerid=#therouterdetailsid#&companydsn=#urn.companydsn#&globaldsn=#url.globaldsn#&companyname=#url.companyname#&subcomdsn=#url.subcomdsn#&querydsn=#url.querydsn#&transactiondsn=#url.transactiondsn#&sitedsn=#url.sitedsn#"
			requestTimeOut	 = "300"

		>  <!---retryCount		 = "3"  --->
		<cfcatch>
		</cfcatch>
	</cftry>
</cfif>
<!---end make schedule for next approvers--->
	<cfreturn "true" >
</cffunction>


<cffunction name="updateMainTable" >
<!---update eform table status--->

<cfset datetimenow = '#dateformat(now(), "YYYY-MM-DD")# #timeformat(now(), "HH:MM:SS")#' >
<cfquery name="updateFormTable" datasource="#dbsource#" >
	UPDATE #tablename#
	   SET APPROVED          = <cfqueryparam cfsqltype="cf_sql_varchar" value="Y" >,
		   DATELASTUPDATE    =  <cfqueryparam cfsqltype="cf_sql_timestamp" value="#datetimenow#" >
     WHERE PROCESSID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#processid#" > AND
	       EFORMID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#eformid#" >
</cfquery>

<!---<cfset updateCount = EntityLoad("EGINEFORMCOUNT", { EFORMID =#eformid#, PERSONNELIDNO = #pid#}, true ) >
<cfif isdefined("updateCount") >
	<cfset currentCount = updateCount.getAPPROVED() + 1 >
	<cfset updateCount.setAPPROVED(currentCount) >
<cfelse>
	<cfset updateCount = EntityNew("EGINEFORMCOUNT") >
	<cfset updateCount.setEFORMID(eformid) >
	<cfset updateCount.setPERSONNELIDNO(pid) >
	<cfset updateCount.setPENDING("0") >
	<cfset updateCount.setRETURNED("0") >
	<cfset updateCount.setNEW("0") >
	<cfset updateCount.setAPPROVED("1") >
	<cfset updateCount.setDISAPPROVED("0") >
</cfif>
<cfset EntitySave(updateCount) >
<cfset ormflush()>--->

<cfquery name="queryCount" datasource="#globaldsn#" >
	SELECT * FROM EGINEFORMCOUNT
	 WHERE EFORMID = '#eformid#' AND PERSONNELIDNO='#pid#'
</cfquery>
<cfif queryCount.recordcount gt 0 >
	<cfquery name="updateCount" datasource="#globaldsn#" >
		UPDATE EGINEFORMCOUNT
			   <cfset currentCount = queryCount.APPROVED + 1 >
		  SET APPROVED = <cfqueryparam cfsqltype="cf_sql_integer" value="#currentCount#">
		 WHERE EFORMID = '#eformid#' AND PERSONNELIDNO='#pid#'
	</cfquery>
<cfelse>
	<cfquery name="updateCount" datasource="#globaldsn#" >
		INSERT INTO EGINEFORMCOUNT (EFORMID,PERSONNELIDNO,PENDING,RETURNED,NEW,APPROVED,DISAPPROVED)
		VALUES (
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#eformid#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#pid#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="0">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="0">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="0">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="1">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="0">
		)
	</cfquery>
</cfif>

</cffunction>



<cffunction name="ignoreCurrentAndPending" >
	<!---once done after the process has completed--->
	<cftry>
		<cfschedule action="delete" task="process#processid#" >
	<cfcatch>
		<cftry>
			<cfschedule action="delete" task="process#processid#" >
			<cfcatch>
			</cfcatch>
		</cftry>
	</cfcatch>
	</cftry>

	<cftry>
		<cfschedule action="delete" task="router#processid#" >
	<cfcatch>
		<cftry>
			<cfschedule action="delete" task="router#processid#" >
			<cfcatch>
			</cfcatch>
		</cftry>
	</cfcatch>
	</cftry>

	<!---<cfset formRouterDataA = EntityLoad("EGINROUTERDETAILS", {PROCESSIDFK = #processid#}, "ROUTERORDER ASC") >--->
	<cfquery name="formRouterDataA" datasource ="#globaldsn#" >
		SELECT * FROM EGINROUTERDETAILS
		 WHERE PROCESSIDFK = '#processid#'
		ORDER BY ROUTERORDER ASC
	</cfquery>
	<cfloop query="formRouterDataA" >
		<!---<cfset updateRouterF = EntityLoad("EGINROUTERDETAILS", {ROUTERDETAILSID = #routerIndexC.ROUTERDETAILSID#, STATUS='PENDING'}, true) >--->
		<cfquery name="updateRouterF" datasource="#globaldsn#" maxrows="1">
			SELECT *
			  FROM EGINROUTERDETAILS
			 WHERE ROUTERDETAILSID = '#routerIndexC.ROUTERDETAILSID#' AND  STATUS='PENDING'
		</cfquery>
		<cfif updateRouterF.RecordCount gt 0 >
			<cfquery name="updateRouterFF" datasource="#globaldsn#" >
				UPDATE EGINROUTERDETAILS
				 SET STATUS = <cfqueryparam cfsqltype="cf_sql_varchar" value="IGNORED">,
				     DATELASTUPDATE = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#dateformat(now(), 'YYYY-MM-DD')# #timeformat(now(), 'HH:MM:SS')#">
				WHERE ROUTERDETAILSID = '#routerIndexC.ROUTERDETAILSID#' AND  STATUS='PENDING'
			</cfquery>
			<!---<cfset updateRouterF.setSTATUS("IGNORED") >
			<cfset updateRouterF.setDATELASTUPDATE("#dateformat(now(), "YYYY-MM-DD")# #timeformat(now(), "HH:MM:SS")#") >
			<cfset EntitySave(updateRouterF) >
			<cfset ormflush() >--->
		</cfif>
		<!---<cfset approverDataC = EntityLoad("EGINAPPROVERDETAILS", {ROUTERIDFK =#routerIndexC.ROUTERDETAILSID#} ) >--->
		<cfquery name="approverDataC" datasource="#globaldsn#">
			SELECT *
			  FROM EGINAPPROVERDETAILS
			 WHERE ROUTERIDFK = '#routerIndexC.ROUTERDETAILSID#'
		</cfquery>
		<cfloop query="approverDataC">
			<cftry>
				<!---<cfset updateAction = EntityLoad("EGINAPPROVERDETAILS", {APPROVERDETAILSID =#approverDataC.APPROVERDETAILSID#,ACTION='CURRENT'}, true ) >
				<cfset updateAction.setACTION("IGNORED") >
				<cfset updateAction.setDATELASTUPDATE("#dateformat(now(), "YYYY-MM-DD")# #timeformat(now(), "HH:MM:SS")#") >
				<cfset EntitySave(updateAction) >
				<cfset ormflush() >--->
				<cfquery name="updateAction" datasource="#globaldsn#" >
					UPDATE EGINAPPROVERDETAILS
					 SET ACTION = <cfqueryparam cfsqltype="cf_sql_varchar" value="IGNORED">,
					     DATELASTUPDATE = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#dateformat(now(), 'YYYY-MM-DD')# #timeformat(now(), 'HH:MM:SS')#">
					WHERE APPROVERDETAILSID = '#approverDataC.APPROVERDETAILSID#' AND ACTION='CURRENT'
				</cfquery>
				<!---for the current router which is approved--->
				<!---<cfset updateCount = EntityLoad("EGINEFORMCOUNT", { EFORMID =#eformid#, PERSONNELIDNO = #approverDataC.PERSONNELIDNO#}, true ) >
				<cfif isdefined("updateCount") >
					<cfif updateCount.getPENDING() gt 0 >
						<cfset currentCount = updateCount.getPENDING() - 1 >
						<cfset updateCount.setPENDING(currentCount) >
					<cfelseif updateCount.getNEW() gt 0 >
						<cfset currentCount = updateCount.getNEW() - 1 >
						<cfset updateCount.setNEW(currentCount) >
					</cfif>
					<cfset EntitySave(updateCount) >
					<cfset ormflush()>
				</cfif><!---end for the current router which is approved --->--->

				<cfquery name="queryCount" datasource="#globaldsn#" maxrows="1">
					SELECT * FROM EGINEFORMCOUNT
					 WHERE EFORMID = '#eformid#' AND PERSONNELIDNO='#approverDataC.PERSONNELIDNO#'
				</cfquery>
				<cfloop query="queryCount" >
					<cfquery name="updateCount" datasource="#globaldsn#" >
						UPDATE EGINEFORMCOUNT
							<cfif queryCount.PENDING gt 0 >
								<cfset currentCount = queryCount.PENDING - 1 >
								SET PENDING = <cfqueryparam cfsqltype="cf_sql_integer" value="#currentCount#">
							<cfelseif queryCount.NEW gt 0 >
								<cfset currentCount = queryCount.NEW - 1 >
								SET NEW = <cfqueryparam cfsqltype="cf_sql_integer" value="#currentCount#">
							</cfif>
						 WHERE EFORMID = '#eformid#' AND PERSONNELIDNO='#approverDataC.PERSONNELIDNO#'
					</cfquery>
				</cfloop>

				<cfcatch>
					<cfcontinue>
				</cfcatch>
			</cftry>

			<cftry>
				<!---<cfset updateActionB = EntityLoad("EGINAPPROVERDETAILS", {APPROVERDETAILSID =#approverDataC.APPROVERDETAILSID#,ACTION='PENDING'}, true ) >
				<cfset updateActionB.setACTION("IGNORED") >
				<cfset updateActionB.setDATELASTUPDATE("#dateformat(now(), "YYYY-MM-DD")# #timeformat(now(), "HH:MM:SS")#") >
				<cfset EntitySave(updateActionB) >
				<cfset ormflush() >--->
				<cfquery name="updateActionB" datasource="#globaldsn#" >
					UPDATE EGINAPPROVERDETAILS
					 SET ACTION = <cfqueryparam cfsqltype="cf_sql_varchar" value="IGNORED">,
					     DATELASTUPDATE = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#dateformat(now(), 'YYYY-MM-DD')# #timeformat(now(), 'HH:MM:SS')#">
					WHERE APPROVERDETAILSID = '#approverDataC.APPROVERDETAILSID#' AND ACTION='PENDING'
				</cfquery>
				<cfcatch>
					<cfcontinue>
				</cfcatch>
			</cftry>

		</cfloop>
	</cfloop>

	<!---execute on complete process--->
	<!---<cfset oncompleteprocess = ORMExecuteQuery("SELECT ONCOMPLETE
		  								       FROM EGRGEFORMS
		  								      WHERE EFORMID = '#eformid#'", true) >--->
	<cfquery name="oncompleteprocess" datasource="#globaldsn#" maxrows="1">
		SELECT ONCOMPLETE
       	  FROM EGRGEFORMS
         WHERE EFORMID = '#eformid#'
	</cfquery>
	<cfloop query="oncompleteprocess" >
		<cfif oncompleteprocess.ONCOMPLETE neq "NA" AND trim(oncompleteprocess.ONCOMPLETE) neq "">
			<cfinclude template="../fielddefinition/oncomplete/#oncompleteprocess#" >
		</cfif>
	</cfloop>
	<!---end on complete process--->
		<!---notes: before and after load : execute before and after loading forms data
		       before and after submit : execute before and after adding forms
		       before and after approve : execute before and after approving forms
		       on complete : execute after the eform is done either approved or disapproved--->
	<cfreturn "success" >

</cffunction>



<cffunction name="disapproveRouter" >
<!---update eform table status--->

<!---all current and pending in this process to 'IGNORED'--->

<!---<cfset formRouterDataD = EntityLoad("EGINROUTERDETAILS", {PROCESSIDFK = #processid#}, "ROUTERORDER ASC") >--->
<cfquery name="formRouterDataD" datasource ="#globaldsn#" >
	SELECT *
	  FROM EGINROUTERDETAILS
	 WHERE PROCESSIDFK = '#processid#'
	ORDER BY ROUTERORDER ASC
</cfquery>
<cfloop query="formRouterDataD" > <!---a big loop--->

	<cfif formRouterDataD.ISLASTROUTER eq "true" OR ArrayLen(formRouterDataD) eq formRouterDataD.ROUTERORDER>
		<!---<cfset updateRouterD = EntityLoad("EGINROUTERDETAILS", {ROUTERDETAILSID = #formRouterDataD.ROUTERDETAILSID#}, true) >
		<cfset updateRouterD.setSTATUS("DISAPPROVED") > <!---set this router as disapproved status--->
		<cfset updateRouterD.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')# #timeformat(now(), 'HH:MM:SS')#") >
		<cfset EntitySave(updateRouterD) >
		<cfset ormflush() >--->
		<cfquery name="updateRouterFF" datasource="#globaldsn#" >
			UPDATE EGINROUTERDETAILS
			 SET STATUS = <cfqueryparam cfsqltype="cf_sql_varchar" value="DISAPPROVED">,
			     DATELASTUPDATE = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#dateformat(now(), 'YYYY-MM-DD')# #timeformat(now(), 'HH:MM:SS')#">
			WHERE ROUTERDETAILSID = '#formRouterDataD.ROUTERDETAILSID#'
		</cfquery>
	</cfif>

	<!---<cfset updateRouterDD = EntityLoad("EGINROUTERDETAILS", {ROUTERDETAILSID = #formRouterDataD.ROUTERDETAILSID#, STATUS='PENDING'}, true) >--->
	<cfquery name="updateRouterDD" datasource ="#globaldsn#" maxrows="1">
		SELECT *
		  FROM EGINROUTERDETAILS
		 WHERE ROUTERDETAILSID = '#formRouterDataD.ROUTERDETAILSID#' AND STATUS='PENDING'
	</cfquery>
	<cfif updateRouterDD.RecordCount gt 0 >
		<!---<cfset updateRouterDD.setSTATUS("IGNORED") > <!---set this router as disapproved status--->
		<cfset updateRouterDD.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')# #timeformat(now(), 'HH:MM:SS')#") >
		<cfset EntitySave(updateRouterDD) >
		<cfset ormflush() >--->
		<cfquery name="updateRouterDDD" datasource="#globaldsn#" >
			UPDATE EGINROUTERDETAILS
			 SET STATUS = <cfqueryparam cfsqltype="cf_sql_varchar" value="IGNORED">,
			     DATELASTUPDATE = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#dateformat(now(), 'YYYY-MM-DD')# #timeformat(now(), 'HH:MM:SS')#">
			WHERE ROUTERDETAILSID = '#formRouterDataD.ROUTERDETAILSID#' AND STATUS='PENDING'
		</cfquery>
	</cfif>
	<!---<cfset formApproversDataD = EntityLoad("EGINAPPROVERDETAILS", {ROUTERIDFK =#formRouterDataD.ROUTERDETAILSID#}, "APPROVERORDER ASC" ) >	--->
	<cfquery name="formApproversDataD" datasource ="#globaldsn#">
		SELECT *
		  FROM EGINAPPROVERDETAILS
		 WHERE ROUTERIDFK = '#formRouterDataD.ROUTERDETAILSID#'
		 ORDER BY APPROVERORDER ASC
	</cfquery>
	<cfloop query="formApproversDataD" >
		<cftry>
			<!---<cfset updateActionD = EntityLoad("EGINAPPROVERDETAILS", {APPROVERDETAILSID =#formApproversDataD.APPROVERDETAILSID#,ACTION='CURRENT'}, true ) >
			<cfset updateActionD.setACTION("IGNORED") >
			<cfset updateActionD.setDATELASTUPDATE("#dateformat(now(), "YYYY-MM-DD")# #timeformat(now(), "HH:MM:SS")#") >
			<cfset EntitySave(updateActionD) >
			<cfset ormflush() >--->
			<cfquery name="updateActionD" datasource="#globaldsn#" >
				UPDATE EGINAPPROVERDETAILS
				   SET ACTION = <cfqueryparam cfsqltype="cf_sql_varchar" value="IGNORED">,
				       DATELASTUPDATE = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#dateformat(now(), 'YYYY-MM-DD')# #timeformat(now(), 'HH:MM:SS')#">
				 WHERE APPROVERDETAILSID = '#formApproversDataD.APPROVERDETAILSID#' AND ACTION='CURRENT'
			</cfquery>
			<!---for the current router which is approved--->
			<!---<cfset updateCount = EntityLoad("EGINEFORMCOUNT", { EFORMID =#eformid#, PERSONNELIDNO = #formApproversDataD.PERSONNELIDNO#}, true ) >
			<cfif isdefined("updateCount") >
				    <cfif updateCount.getPENDING() gt 0 >
						<cfset currentCount = updateCount.getPENDING() - 1 >
						<cfset updateCount.setPENDING(currentCount) >
					<cfelseif updateCount.getNEW() gt 0 >
						<cfset currentCount = updateCount.getNEW() - 1 >
						<cfset updateCount.setNEW(currentCount) >
					</cfif>
					<cfset EntitySave(updateCount) >
					<cfset ormflush()>
			</cfif> --->
			<!---end for the current router which is approved --->

			<cfquery name="queryCount" datasource="#globaldsn#" maxrows="1">
				SELECT * FROM EGINEFORMCOUNT
				 WHERE EFORMID = '#eformid#' AND PERSONNELIDNO='#formApproversDataD.PERSONNELIDNO#'
			</cfquery>
			<cfloop query="queryCount" >
				<cfquery name="updateCount" datasource="#globaldsn#" >
					UPDATE EGINEFORMCOUNT
						<cfif queryCount.PENDING gt 0 >
							<cfset currentCount = queryCount.PENDING - 1 >
							SET PENDING = <cfqueryparam cfsqltype="cf_sql_integer" value="#currentCount#">
						<cfelseif queryCount.NEW gt 0 >
							<cfset currentCount = queryCount.NEW - 1 >
							SET NEW = <cfqueryparam cfsqltype="cf_sql_integer" value="#currentCount#">
						</cfif>
					 WHERE EFORMID = '#eformid#' AND PERSONNELIDNO='#formApproversDataD.PERSONNELIDNO#'
				</cfquery>
			</cfloop>
			<cfcatch>
			</cfcatch>
		</cftry>
		<cftry>
			<!---<cfset updateActionE = EntityLoad("EGINAPPROVERDETAILS", {APPROVERDETAILSID =#formApproversDataD.APPROVERDETAILSID#,ACTION='PENDING'}, true ) >
			<cfset updateActionE.setACTION("IGNORED") >
			<cfset updateActionE.setDATELASTUPDATE("#dateformat(now(), "YYYY-MM-DD")# #timeformat(now(), "HH:MM:SS")#") >
			<cfset EntitySave(updateActionE) >
			<cfset ormflush() >--->
			<cfquery name="updateActionB" datasource="#globaldsn#" >
					UPDATE EGINAPPROVERDETAILS
					 SET ACTION = <cfqueryparam cfsqltype="cf_sql_varchar" value="IGNORED">,
					     DATELASTUPDATE = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#dateformat(now(), 'YYYY-MM-DD')# #timeformat(now(), 'HH:MM:SS')#">
					WHERE APPROVERDETAILSID = '#formApproversDataD.APPROVERDETAILSID#' AND ACTION = 'PENDING'
				</cfquery>
			<cfcatch>
				<cfcontinue>
			</cfcatch>
		</cftry>
	</cfloop>
</cfloop>



<cfset datetimenow = '#dateformat(now(), "YYYY-MM-DD")# #timeformat(now(), "HH:MM:SS")#' >

<cfquery name="updateFormTable" datasource="#dbsource#" >
	UPDATE #tablename#
	   SET APPROVED          = <cfqueryparam cfsqltype="cf_sql_varchar" value="D" >,
		   DATELASTUPDATE    =  <cfqueryparam cfsqltype="cf_sql_timestamp" value="#datetimenow#" >
     WHERE PROCESSID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#processid#" > AND
	       EFORMID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#eformid#" >
</cfquery>

	<!---<cfset updateCount = EntityLoad("EGINEFORMCOUNT", { EFORMID =#eformid#, PERSONNELIDNO = #pid#}, true ) >
	<cfif isdefined("updateCount") >
		<cfset currentCount = updateCount.getDISAPPROVED() + 1 >
		<cfset updateCount.setDISAPPROVED(currentCount) >
	<cfelse>
		<cfset updateCount = EntityNew("EGINEFORMCOUNT") >
		<cfset updateCount.setEFORMID(eformid) >
		<cfset updateCount.setPERSONNELIDNO(pid) >
		<cfset updateCount.setPENDING("0") >
		<cfset updateCount.setRETURNED("0") >
		<cfset updateCount.setNEW("0") >
		<cfset updateCount.setAPPROVED("0") >
		<cfset updateCount.setDISAPPROVED("1") >
	</cfif>
	<cfset EntitySave(updateCount) >
	<cfset ormflush()>--->
	<cfquery name="queryCount" datasource="#globaldsn#" maxrows="1">
		SELECT * FROM EGINEFORMCOUNT
		 WHERE EFORMID = '#eformid#' AND PERSONNELIDNO='#pid#'
	</cfquery>
	<cfif queryCount.recordcount gt 0 >
		<cfquery name="updateCount" datasource="#globaldsn#" >
			UPDATE EGINEFORMCOUNT
				   <cfset currentCount = queryCount.DISAPPROVED + 1 >
			  SET DISAPPROVED = <cfqueryparam cfsqltype="cf_sql_integer" value="#currentCount#">
			 WHERE EFORMID = '#eformid#' AND PERSONNELIDNO='#pid#'
		</cfquery>
	<cfelse>
		<cfquery name="updateCount" datasource="#globaldsn#" >
			INSERT INTO EGINEFORMCOUNT (EFORMID,PERSONNELIDNO,PENDING,RETURNED,NEW,APPROVED,DISAPPROVED)
			VALUES (
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#eformid#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#pid#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="0">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="0">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="0">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="0">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="1">
			)
		</cfquery>
	</cfif>
<!---The eForm is totally disapproved
make a clean up
delete schedulers but do not delete process router approvers information for viewing purposes--->
<cfinvoke method="deleteScheduledTask" >
</cffunction>


<cffunction name="deleteScheduledTask" >
	<cftry>
		<cfschedule action="delete" task="process#processid#" >
	<cfcatch>
		<cftry>
			<cfschedule action="delete" task="process#processid#" >
			<cfcatch>
			</cfcatch>
		</cftry>
	</cfcatch>
	</cftry>

	<cftry>
		<cfschedule action="delete" task="router#processid#" >
	<cfcatch>
		<cftry>
			<cfschedule action="delete" task="router#processid#" >
			<cfcatch>
			</cfcatch>
		</cftry>
	</cfcatch>
	</cftry>

	<cfreturn "success" >
</cffunction>






<cfelse> <!---follow up notifications--->

<cfinvoke method="emailFromSched" >

</cfif>







<cffunction name="emailFromSched" >

<cfset eformid=url.eformid >
<cfset processid=url.processid >
<cfset routerid=url.routerid >
<cfset domain=url.domain >
<cfset globaldsn=url.globaldsn >
<cfset companydsn=url.companydsn >
<cfset companyname=url.companyname >

<cfset subcomdsn = url.subcomdsn >
<cfset querydsn = url.querydsn >
<cfset transactiondsn = url.transactiondsn >
<cfset sitedsn = url.sitedsn >

<cfset formGroup = ArrayNew(1) >
<cfset propertyArr = ArrayNew(1) >
<cfset valueArr    = ArrayNew(1) >
<cfset pidArray    = ArrayNew(1) >

<!---<cfset formRouterData = EntityLoad("EGINROUTERDETAILS", {PROCESSIDFK = #processid#,ROUTERDETAILSID=#routerid#}, "ROUTERORDER ASC") >--->
<cfquery name="formRouterData" datasource ="#globaldsn#">
	SELECT *
	  FROM EGINROUTERDETAILS
	 WHERE PROCESSIDFK = '#processid#' AND ROUTERDETAILSID='#routerid#'
	 ORDER BY ROUTERORDER ASC
</cfquery>
<cfloop query="#formRouterData#">
	<!---<cfset formApproversDataTemp = EntityLoad("EGINAPPROVERDETAILS", {ROUTERIDFK =#routerid#,ACTION='CURRENT'}, "APPROVERORDER ASC" ) >--->
		<cfquery name="formApproversDataTemp" datasource ="#globaldsn#">
			SELECT *
			  FROM EGINAPPROVERDETAILS
			 WHERE ROUTERIDFK = '#routerid#' AND ACTION='CURRENT'
			 ORDER BY APPROVERORDER ASC
		</cfquery>
		<cfloop query="formApproversDataTemp">
			<cfset ArrayAppend( pidArray,formApproversDataTemp.PERSONNELIDNO ) >
		</cfloop>
</cfloop>

<cfif ArrayLen(pidArray) eq 0 >
	<cfabort>
</cfif>

<cfset approverslist = ArrayToList(pidArray, "','") >
<cfset approverslist = "'#approverslist#'" >

<cfif dbms eq "MSSQL" >
	<cfset dbsourceg = "#globaldsn#.dbo" >
	<cfset dbsourcec = "#companydsn#.dbo" >
<cfelse>
	<cfset dbsourceg = "#globaldsn#" >
	<cfset dbsourcec = "#companydsn#" >
</cfif>

<cfquery name="getPersonalEmail" datasource="#globaldsn#" maxrows="1" >
	SELECT A.FIRSTNAME AS FIRSTNAME,
		   A.LASTNAME AS LASTNAME,
		   A.MIDDLENAME AS MIDDLENAME,
		   B.AVATAR AS AVATAR,
		   E.PROFILENAME AS PROFILENAME,
		   C.DESCRIPTION AS POSITION,
		   D.DESCRIPTION AS DEPARTMENT
	  FROM #dbsourcec#.#maintable# A LEFT JOIN #dbsourcec#.ECRGMYIBOSE B ON (A.#mainpk#=B.PERSONNELIDNO)
	               LEFT JOIN #dbsourcec#.CLKPOSITION C  ON (A.POSITIONCODE=C.POSITIONCODE)
	               LEFT JOIN #dbsourcec#.CLKDEPARTMENT D ON (A.DEPARTMENTCODE=D.DEPARTMENTCODE)
	               LEFT JOIN EGRGUSERMASTER E ON (A.GUID=E.GUID)
	 WHERE A.#mainpk# IN (#preservesinglequotes(approverslist)#)
</cfquery>

<cfset emailArr = ArrayNew(1) >

<!---get the table data, using eformid and processid only--->
<cfinvoke method="getMainTableData" returnvariable="theformname" eformid="#eformid#" processid="#processid#" >
<cfif ArrayIsDefined(formGroup, 1) >
	<cfset fgroup = formGroup[1] >
<cfelse>
	<cfset fgroup = "" >
</cfif>
<!--- end get the table data --->

<cfloop query="getPersonalEmail" >
	<cfset ArrayAppend(emailArr, PROFILENAME) >
</cfloop>
<cfset emaillist = ArrayToList(emailArr, ",") >

<cfset isfollowup = "Follow-up" >
<cfif isdefined("notfollowup") >
	<cfset isfollowup = "" >
</cfif>

	<cfmail from="#websiteemailadd#"
			to="#emaillist#"
			subject="My iBOS/e #isfollowup# Notification | #theformname#"
			type="html"
			>
			<font color="Maroon" style="font: 21px Arial">#companyname#</font><br>
			<table border="1" cellpadding="3" cellspacing="1" style="font: 13px Arial; border-collapse: collapse;" width = "550">
				<TR><TD width=30%><strong>Form Group</strong></TD><TD width=70%>#fgroup#</TD></TR>
				<TR><TD width=30%><strong>eForm</strong></TD><TD width=70%>#theformname#</TD></TR>
				<cfloop from="1" to="#ArrayLen(valueArr)#" index="propIndex" >
					<TR>
						<cftry>
						<TD width=30%>#propertyArr[propIndex]#</TD>
						<TD width=70%>#valueArr[propIndex]#</TD>
						<cfcatch>
							<cfcontinue>
						</cfcatch>
						</cftry>
					</TR>
			    </cfloop>

			</table>
			<p>
				<a href="#domain#?bdg=MAINUSRAPPF5038527-9F22-9981-A084244087E398BD">Click to <strong>Open</strong>.</a>
			</p>
			<p>
				<a href="#domain#?bdg=MAINUSRAPPF5038527-9F22-9981-A084244087E398BD&eformid=#eformid#&actiontype=getneweforms&myvar=hi">Click to <strong>Approve or Disapprove</strong>.</a>
			</p>
			<p>
			Note: You need to sign on to your account to open the item.
			</p>
	</cfmail>

	<cfreturn "success" >
</cffunction>


<cffunction name="getMainTableData" returntype="String" >

<!---<cfset gettheForm = ORMExecuteQuery("SELECT A.EFORMNAME,
											B.TABLENAME AS TABLENAME,
											B.LEVELID AS LEVELID,
											C.COLUMNNAME AS COLUMNNAME,
											C.FIELDLABEL AS FIELDLABEL,
											B.TABLETYPE AS TABLETYPE,
											C.COLUMNORDER AS COLUMNORDER,
											B.LINKTABLETO AS LINKTABLETO,
											B.LINKINGCOLUMN AS LINKINGCOLUMN
	  								  FROM EGRGEFORMS A,EGRGIBOSETABLE B,EGRGIBOSETABLEFIELDS C
	  								WHERE EFORMID = '#eformid#' AND A.EFORMID = B.EFORMIDFK AND B.TABLEID = C.TABLEIDFK", false) >--->

<cfquery name="gettheForm" datasource ="#globaldsn#">
	SELECT  A.EFORMNAME,
			B.TABLENAME AS TABLENAME,
			B.LEVELID AS LEVELID,
			C.COLUMNNAME AS COLUMNNAME,
			C.FIELDLABEL AS FIELDLABEL,
			B.TABLETYPE AS TABLETYPE,
			C.COLUMNORDER AS COLUMNORDER,
			B.LINKTABLETO AS LINKTABLETO,
			B.LINKINGCOLUMN AS LINKINGCOLUMN
	  FROM EGRGEFORMS A,EGRGIBOSETABLE B,EGRGIBOSETABLEFIELDS C
	WHERE EFORMID = '#eformid#' AND A.EFORMID = B.EFORMIDFK AND B.TABLEID = C.TABLEIDFK
</cfquery>
<!---<cfset getMainTableID = ORMExecuteQuery("SELECT B.TABLENAME AS TABLENAME,
												B.LEVELID AS LEVELID,
												C.COLUMNNAME AS COLUMNNAME,
												A.ISENCRYPTED AS ISENCRYPTED,
												A.EFORMNAME AS EFORMNAME,
												A.EFORMGROUP AS EFORMGROUP
	  								      FROM EGRGEFORMS A,EGRGIBOSETABLE B,EGRGIBOSETABLEFIELDS C
	 								      WHERE EFORMID = '#eformid#' AND A.EFORMID = B.EFORMIDFK AND B.TABLEID = C.TABLEIDFK AND C.XTYPE = 'id'", true) >--->

<cfquery name="getMainTableID" datasource ="#globaldsn#" maxrows="1">
	SELECT B.TABLENAME AS TABLENAME,
			B.LEVELID AS LEVELID,
			C.COLUMNNAME AS COLUMNNAME,
			A.ISENCRYPTED AS ISENCRYPTED,
			A.EFORMNAME AS EFORMNAME,
			A.EFORMGROUP AS EFORMGROUP
      FROM EGRGEFORMS A,EGRGIBOSETABLE B,EGRGIBOSETABLEFIELDS C
      WHERE EFORMID = '#eformid#' AND A.EFORMID = B.EFORMIDFK AND B.TABLEID = C.TABLEIDFK AND C.XTYPE = 'id'
</cfquery>

<cfif trim(getMainTableID.TABLENAME) neq "" >
	<cfset firsttable  = getMainTableID.TABLENAME >
	<cfset firstlevel  = getMainTableID.LEVELID >
	<cfset firstcolumn = getMainTableID.COLUMNNAME >
	<cfset theformname = getMainTableID.EFORMNAME >
	<cfset ArrayAppend(formGroup, getMainTableID.EFORMGROUP ) >
<cfelse>
	<cfthrow detail="Table has no id specified in table fields. At least one field type is an id type." >
</cfif>

<cfset columnNameModel = ArrayNew(1)  >
<cfset columnNameReal = ArrayNew(1)  >
<cfset lookupLink = ArrayNew(1)  >
<cfset lookupTable = ArrayNew(1)  >
<cfset linkingTable = ArrayNew(1)  >
<cfset linkingColumns = ArrayNew(1)  >

<cfloop query="gettheForm">
	<cfif trim(gettheForm.COLUMNNAME) neq "" > <!---columnName with empty name is not qualified--->
		<cfset colModel = gettheForm.LEVELID & '__' & gettheForm.TABLENAME & '__' & gettheForm.COLUMNNAME & '__' & gettheForm.TABLETYPE >
		<cfset ArrayAppend(columnNameModel, colModel) >
		<cfset ArrayAppend(columnNameReal, gettheForm.FIELDLABEL) >
		<cfif gettheForm.TABLETYPE eq "LookupCard" AND gettheForm.COLUMNORDER eq 1 >
			<cfset ArrayAppend(lookupLink,gettheForm.COLUMNNAME) >
			<cfset ArrayAppend(lookupTable,gettheForm.TABLENAME) >
			<cfset ArrayAppend(linkingTable,gettheForm.LINKTABLETO) >
			<cfset ArrayAppend(linkingColumns,gettheForm.LINKINGCOLUMN) >
		<cfelse>
	    </cfif>
	</cfif>
</cfloop>

<cfset colModel = firstlevel & '__' & firsttable & '__PERSONNELIDNO__X' >
<cfset ArrayAppend(columnNameModel, colModel) >
<cfset colModel = firstlevel & '__' & firsttable & '__DATEACTIONWASDONE__X' >
<cfset ArrayAppend(columnNameModel, colModel) >

<cfset selectArray = ArrayNew(1) >
<cfset fromArray   = ArrayNew(1) >
<cfset whereArray  = ArrayNew(1) >
<cfset groupTable   = StructNew() >

<cfloop array="#columnNameModel#" index="formIndex" >
	<cfset formIndArr = ArrayNew(1) >
	<cfset formIndArr = ListToArray(formIndex , "__", true, true) >
	<cfset theTableLevel = formIndArr[1] >
	<cfset theTableName  = formIndArr[2] >
	<cfset theColumnName = formIndArr[3] >
	<cfset theTableType = formIndArr[4] >

			<cfif theTableLevel eq "G" >
				<cfset theLevel = "#globaldsn#" >
			<cfelseif theTableLevel eq "C" >
				<cfset theLevel = "#companydsn#" >
			<cfelseif theTableLevel eq "S" >
				<cfset theLevel = "#subcomdsn#" >
			<cfelseif theTableLevel eq "Q" >
				<cfset theLevel = "#querydsn#" >
			<cfelseif theTableLevel eq "T" >
				<cfset theLevel = "#transactiondsn#" >
			<cfelseif theTableLevel eq "SD" >
				<cfset theLevel = "#sitedsn#" >
			<cfelse>
				<cfset theLevel = theTableLevel >
			</cfif>
		<cfif dbms eq "MSSQL" >
			<cfif theTableLevel eq "G" >
				<cfset theLevel = "#globaldsn#.dbo" >
			<cfelseif theTableLevel eq "C" >
				<cfset theLevel = "#companydsn#.dbo" >
			<cfelseif theTableLevel eq "S" >
				<cfset theLevel = "#subcomdsn#.dbo" >
			<cfelseif theTableLevel eq "Q" >
				<cfset theLevel = "#querydsn#.dbo" >
			<cfelseif theTableLevel eq "T" >
				<cfset theLevel = "#transactiondsn#.dbo" >
			<cfelseif theTableLevel eq "SD" >
				<cfset theLevel = "#sitedsn#.dbo" >
			<cfelse>
				<cfset theLevel = theTableLevel & ".dbo" >
			</cfif>
		<cfelse>
			<cfif theTableLevel eq "G" >
				<cfset theLevel = "#globaldsn#" >
			<cfelseif theTableLevel eq "C" >
				<cfset theLevel = "#companydsn#" >
			<cfelseif theTableLevel eq "S" >
				<cfset theLevel = "#subcomdsn#" >
			<cfelseif theTableLevel eq "Q" >
				<cfset theLevel = "#querydsn#" >
			<cfelseif theTableLevel eq "T" >
				<cfset theLevel = "#transactiondsn#" >
			<cfelseif theTableLevel eq "SD" >
				<cfset theLevel = "#sitedsn#" >
			<cfelse>
				<cfset theLevel = theTableLevel >
			</cfif>
		</cfif>

		<!---ex. FIRSTNAME.FIRSTNAME AS C__CMFPA__FIRSNAME--->
		<cfset ArrayAppend(selectArray,"#theTableName#.#theColumnName# AS #theTableLevel#__#theTableName#__#theColumnName#") >
		<cfif StructKeyExists(groupTable, '#theTableName#') >

		<cfelse>
			<!---ex. IBOSE_GLOBAL.CMFPA CMFPA OR IBOSE_GLOBAL.DBO.CMFPA CMFPA--->
			<cfif theTableLevel eq 'G' >
            	<cfset ArrayAppend(fromArray,"#theTableName# #theTableName#") >
            <cfelse>
				<cfset ArrayAppend(fromArray,"#theLevel#.#theTableName# #theTableName#") >
            </cfif>
			<cfif theTableType neq "LookupCard" >
				<!---ex CMFPA.PERSONNELIDNO = GMFPEOPLE.PERSONNELIDNO   delimited by AND--->
				<cfset ArrayAppend(whereArray,"#firsttable#.PERSONNELIDNO = #theTableName#.PERSONNELIDNO") >
			</cfif>

			<cfset groupTable['#theTableName#'] = "_" >
		</cfif>

</cfloop>

<cfif ArrayLen(lookupLink) gte 1 >
	<cfloop from="1" to="#ArrayLen(lookupLink)#" index="lookupInd">
		<cfset ArrayAppend(whereArray,"#linkingTable[lookupInd]#.#linkingColumns[lookupInd]# = #lookupTable[lookupInd]#.#lookupLink[lookupInd]#") >
	</cfloop>
</cfif>

<cfset theSelection = ArrayToList(selectArray, ",") >
<cfset theTable      = ArrayToList(fromArray, ",") >
<cfset theCondition = ArrayToList(whereArray, " AND ") >

<cfset theQuery = "SELECT #theSelection#
					     FROM #theTable#
					    WHERE #theCondition# AND #firsttable#.EFORMID = '#eformid#' AND #firsttable#.PROCESSID = '#processid#'">

<cfquery name="qryDynamic" datasource="#globaldsn#" maxrows="1" >
	#preservesinglequotes(theQuery)#
</cfquery>

<!--- end generate script --->

	<!---Creates an array of structure to be converted to JSON using serializeJSON--->

	<cfloop query="qryDynamic" >

			<cfif getMainTableID.ISENCRYPTED eq "true" >

				<cfset ArrayAppend( propertyArr, "Employee No" ) >
				<cfset ArrayAppend( valueArr, evaluate("#firstlevel#__#firsttable#__PERSONNELIDNO") ) >
				<cfset ArrayAppend( propertyArr, "Date Filed" ) >
				<cfset ArrayAppend( valueArr, evaluate("#firstlevel#__#firsttable#__DATEACTIONWASDONE") ) >

				<cfloop from="1" to="#ArrayLen(columnNameReal)#" index="outIndex" >
					<cftry>
						<cfset colName = ListDeleteAt(columnNameModel[outIndex],4,'__') >
						<cfcatch>
						<cfset colName = columnNameModel[outIndex] >
						</cfcatch>
					</cftry>
					<cftry>
						<cfset ArrayAppend( propertyArr, columnNameReal[outIndex] ) >
						<cfset ArrayAppend( valueArr, decrypt( evaluate( colName ), ek ) ) >
					<cfcatch>
						<cfset ArrayAppend( propertyArr, columnNameReal[outIndex] ) >
						<cfset ArrayAppend( valueArr, evaluate( colName ) ) >
					</cfcatch>
					</cftry>
				</cfloop>
			<cfelse>
				<cfset ArrayAppend( propertyArr, "Employee No" ) >
				<cfset ArrayAppend( valueArr, evaluate("#firstlevel#__#firsttable#__PERSONNELIDNO") ) >
				<cfset ArrayAppend( propertyArr, "Date Filed" ) >
				<cfset ArrayAppend( valueArr, evaluate("#firstlevel#__#firsttable#__DATEACTIONWASDONE") ) >

				<cfloop from="1" to="#ArrayLen(columnNameReal)#" index="outIndex" >
					<cftry>
						<cfset colName = ListDeleteAt(columnNameModel[outIndex],4,'__') >
						<cfcatch>
						<cfset colName = columnNameModel[outIndex] >
						</cfcatch>
					</cftry>
					<cfset ArrayAppend( propertyArr, columnNameReal[outIndex] ) >
					<cfset ArrayAppend( valueArr, evaluate( colName ) ) >
				</cfloop>

			</cfif>

	</cfloop>

	<cfreturn theformname />

</cffunction>


