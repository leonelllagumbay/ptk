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

<!---is the process expired--->
<cfset formProcessData = EntityLoad( "EGINFORMPROCESSDETAILS", #processid#, true ) >

<cfset datecreated = formProcessData.getRECDATECREATED() >
<cfset expirationdate = dateadd("d", formProcessData.getEFORMLIFE(), datecreated ) >

<cfif datediff( "d", now(), expirationdate ) gt 0 > <!---not expired--->
	<cfinvoke method="processNotExpired" >
<cfelse> <!---expired--->
	<cfinvoke method="processIsExpired" >
</cfif>



<cffunction name="processNotExpired" >
	
	<cfoutput>processNotExpired</cfoutput>
	
	<cfset previousRouterIsDone = "false" > 
	<cfset pidArray = ArrayNew(1) >
	<cfset freqArray = ArrayNew(1) >
	<cfset expirArray = ArrayNew(1) >
	<cfset therouterdetailsid = ArrayNew(1) >
	
	<!---loop over the routers, then check expiration date of each router--->
	<cfset formRouterData = EntityLoad("EGINROUTERDETAILS", {PROCESSIDFK = #processid#}, "ROUTERORDER ASC") >
		<cfloop array="#formRouterData#" index="routerIndex" >
			<!---check if APPROVED or DISAPPROVED--->
			<cfif routerIndex.getSTATUS() eq 'APPROVED' >
				<!---continue to the next router, this router had been approved successfully--->
				<cfcontinue>
			<cfelseif routerIndex.getSTATUS() eq 'DISAPPROVED' OR routerIndex.getSTATUS() eq 'IGNORED'>
				<!---continue to the next router, this router had been disapproved successfully--->
				<cfcontinue>
			<cfelse> <!---for PENDING and SENT BACK TO ORIGINATOR---> 
				<!---check the router if expired--->
				<cfif datediff( "d", now(), routerIndex.getEXPIRATIONDATE() ) gt 0 > <!---not expired--->
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
	<cfif trim( formProcessData.getEXPIREDACTION() ) eq "APPROVE" >
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
	<cfif routerIndex.getISLASTROUTER() eq "true" OR ArrayLen(formRouterData) eq routerIndex.getROUTERORDER()> 
		<!---this router is the last--->
		<cfset currentRouter = EntityLoad("EGINROUTERDETAILS", {ROUTERDETAILSID = #routerIndex.getROUTERDETAILSID()#}, true) >
		<cfset currentRouter.setSTATUS("APPROVED") >
		<cfset currentRouter.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')# #timeformat(now(), 'HH:MM:SS')#") >
		<cfset EntitySave(currentRouter) > 
		<cfset ormflush()>
		<cfset previousRouterIsDone = "true" >
	
	
		<cfif trim(routerIndex.getEXPIREDACTION()) eq "APPROVE" > 
			<cfinvoke method="updateMainTable" > 
			<cfinvoke method="ignoreCurrentAndPending" >
		<cfelse>
			<cfinvoke method="disapproveRouter" >
		</cfif>
	
		<!---no more email notification to originator because the form was approved in a way of router timedout--->
		
	<cfelse> 
		<cfset currentRouter = EntityLoad("EGINROUTERDETAILS", {ROUTERDETAILSID = #routerIndex.getROUTERDETAILSID()#}, true) >
		<cfset currentRouter.setSTATUS("TIMEDOUT") >
		<cfset currentRouter.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')# #timeformat(now(), 'HH:MM:SS')#") >
		<cfset EntitySave(currentRouter) > 
		<cfset ormflush()>
		<cfset previousRouterIsDone = "true" >
		
		<cfset formApproversDataD = EntityLoad("EGINAPPROVERDETAILS", {ROUTERIDFK =#currentRouter.getROUTERDETAILSID()#}, "APPROVERORDER ASC" ) >	
		<cfloop array="#formApproversDataD#" index="approverIndexD" >
			<cftry> 
				<cfset updateActionD = EntityLoad("EGINAPPROVERDETAILS", {APPROVERDETAILSID =#approverIndexD.getAPPROVERDETAILSID()#,ACTION='CURRENT'}, true ) >
				<cfset updateActionD.setACTION("IGNORED") >
				<cfset updateActionD.setDATELASTUPDATE("#dateformat(now(), "YYYY-MM-DD")# #timeformat(now(), "HH:MM:SS")#") >
				<cfset EntitySave(updateActionD) >
				<cfset ormflush() >
				<!---for the current router which is approved--->
				<cfset updateCount = EntityLoad("EGINEFORMCOUNT", { EFORMID =#eformid#, PERSONNELIDNO = #approverIndexD.getPERSONNELIDNO()#}, true ) >
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
				<!---end for the current router which is approved --->	
				</cfif>
				<cfcatch>
				</cfcatch>
			</cftry>
			<cftry>
				<cfset updateActionE = EntityLoad("EGINAPPROVERDETAILS", {APPROVERDETAILSID =#approverIndexD.getAPPROVERDETAILSID()#,ACTION='PENDING'}, true ) >
				<cfset updateActionE.setACTION("IGNORED") >
				<cfset updateActionE.setDATELASTUPDATE("#dateformat(now(), "YYYY-MM-DD")# #timeformat(now(), "HH:MM:SS")#") >
				<cfset EntitySave(updateActionE) >
				<cfset ormflush() >
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
	<cfset formApproversDataB = EntityLoad("EGINAPPROVERDETAILS", {ROUTERIDFK =#routerIndex.getROUTERDETAILSID()#}, "APPROVERORDER ASC" ) >
	<cfloop array="#formApproversDataB#" index="approverIndex" > 
		<cfset updateActionB = EntityLoad("EGINAPPROVERDETAILS", {APPROVERDETAILSID =#approverIndex.getAPPROVERDETAILSID()#,ACTION='PENDING'}, true ) >
			<cfif isdefined("updateActionB") >	
				
				<cfset updateCount = EntityLoad("EGINEFORMCOUNT", { EFORMID =#eformid#, PERSONNELIDNO = #updateActionB.getPERSONNELIDNO()#}, true ) >  
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
				<cfset ormflush()>
				
				<cfset updateActionB.setACTION("CURRENT") >  
				<cfset updateActionB.setISREAD("false") > 
				<cfset updateActionB.setDATESTARTED("#dateformat(now(), "YYYY-MM-DD")# #timeformat(now(), "HH:MM:SS")#") >
				<cfset updateActionB.setDATELASTUPDATE("#dateformat(now(), "YYYY-MM-DD")# #timeformat(now(), "HH:MM:SS")#") > 
				<cfset EntitySave(updateActionB) >
				<cfset ormflush() >
				
				<cfset ArrayAppend(pidArray, updateActionB.getPERSONNELIDNO()) >
				
			</cfif>
	</cfloop>
	<cfset previousRouterIsDone = "false" >
	<!---notify next approvers which is this approver(s)--->
	<cfif routerIndex.getNOTIFYNEXTAPPROVERS() eq "true" AND ArrayLen(pidArray) gt 0 >
		<cfset moreemailcopy = routerIndex.getMOREEMAILADD() >
		<cfset url.routerid  = routerIndex.getROUTERDETAILSID() > <!---instead of using the passed one which is the first router's ref--->
		<cfset notfollowup = "remove the follow-up word" >
		<cfinvoke 	method="emailFromSched"
				  	returnvariable="resultemail" 
		> 	
		<cfset ArrayAppend( freqArray, routerIndex.getFREQUENCYFOLLOUP() ) >
		<cfset ArrayAppend( expirArray, routerIndex.getEXPIRATIONDATE() ) > 
		<cfset ArrayAppend( therouterdetailsid, routerIndex.getROUTERDETAILSID() ) > 	  
	</cfif> 
	<!---end notifications --->	
	
<cfreturn "success" >
</cffunction>
	
	
<cffunction name="followUpNotif" >
			<!---schedule followups--->
<cfif ArrayLen(freqArray) neq 0 >
	<cfset freqinhours = freqArray[1]*60*60 > <!---in seconds--->
	<cfset endDateB    = expirArray[1] >
	<cfset therouterdetailsid = therouterdetailsid[1] > 
	 
	<cftry>
		<!---make schedule for next approvers, update the existing router shedule---> 
		<cfschedule
			action      	 = "update" 
		    task        	 = "router#processid#"
			operation   	 = "HTTPRequest"  
			interval    	 = "#freqinhours#"  
			startdate   	 = "#dateformat(endDateB, 'mm/dd/yy')#" 
			starttime   	 = "#timeformat(endDateB, 'short')#"   
			url        	 	 = "#client.domain#myapps/form/simulator/schedule.cfm?eformid=#eformid#&processid=#processid#&action=followupemail&domain=#url.domain#&routerid=#therouterdetailsid#&companydsn=#urn.companydsn#&globaldsn=#url.globaldsn#&companyname=#url.companyname#&subcomdsn=#url.subcomdsn#&querydsn=#url.querydsn#&transactiondsn=#url.transactiondsn#&sitedsn=#url.sitedsn#" 
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

<cfset updateCount = EntityLoad("EGINEFORMCOUNT", { EFORMID =#eformid#, PERSONNELIDNO = #pid#}, true ) >
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
<cfset ormflush()>
	
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
	
	<cfset formRouterDataA = EntityLoad("EGINROUTERDETAILS", {PROCESSIDFK = #processid#}, "ROUTERORDER ASC") >
		
	<cfloop array="#formRouterDataA#" index="routerIndexC" >
		<cfset updateRouterF = EntityLoad("EGINROUTERDETAILS", {ROUTERDETAILSID = #routerIndexC.getROUTERDETAILSID()#, STATUS='PENDING'}, true) >
		<cfif isdefined('updateRouterF') >
			<cfset updateRouterF.setSTATUS("IGNORED") >
			<cfset updateRouterF.setDATELASTUPDATE("#dateformat(now(), "YYYY-MM-DD")# #timeformat(now(), "HH:MM:SS")#") >
			<cfset EntitySave(updateRouterF) >
			<cfset ormflush() >
		</cfif>
		<cfset approverDataC = EntityLoad("EGINAPPROVERDETAILS", {ROUTERIDFK =#routerIndexC.getROUTERDETAILSID()#} ) >
		<cfloop array="#approverDataC#" index="approverIndexC" >
			<cftry>
				<cfset updateAction = EntityLoad("EGINAPPROVERDETAILS", {APPROVERDETAILSID =#approverIndexC.getAPPROVERDETAILSID()#,ACTION='CURRENT'}, true ) >
				<cfset updateAction.setACTION("IGNORED") >
				<cfset updateAction.setDATELASTUPDATE("#dateformat(now(), "YYYY-MM-DD")# #timeformat(now(), "HH:MM:SS")#") >
				<cfset EntitySave(updateAction) >
				<cfset ormflush() >
				<!---for the current router which is approved--->   
				<cfset updateCount = EntityLoad("EGINEFORMCOUNT", { EFORMID =#eformid#, PERSONNELIDNO = #approverIndexC.getPERSONNELIDNO()#}, true ) >
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
				</cfif><!---end for the current router which is approved --->	
				<cfcatch>
					<cfcontinue>
				</cfcatch>
			</cftry>
			
			<cftry>
				<cfset updateActionB = EntityLoad("EGINAPPROVERDETAILS", {APPROVERDETAILSID =#approverIndexC.getAPPROVERDETAILSID()#,ACTION='PENDING'}, true ) >
				<cfset updateActionB.setACTION("IGNORED") >
				<cfset updateActionB.setDATELASTUPDATE("#dateformat(now(), "YYYY-MM-DD")# #timeformat(now(), "HH:MM:SS")#") >
				<cfset EntitySave(updateActionB) >
				<cfset ormflush() >
				<cfcatch>
					<cfcontinue>
				</cfcatch>
			</cftry>
			
		</cfloop>
	</cfloop>
	
	<!---execute on complete process--->	
	<cfset oncompleteprocess = ORMExecuteQuery("SELECT ONCOMPLETE
		  								       FROM EGRGEFORMS
		  								      WHERE EFORMID = '#eformid#'", true) >
	<cfif oncompleteprocess neq "NA" AND oncompleteprocess neq "">
		<cfinclude template="../fielddefinition/oncomplete/#oncompleteprocess#" > 
	</cfif>	
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

<cfset formRouterDataD = EntityLoad("EGINROUTERDETAILS", {PROCESSIDFK = #processid#}, "ROUTERORDER ASC") >

<cfloop array="#formRouterDataD#" index="routerIndexD" > <!---a big loop--->
	
	<cfif routerIndexD.getISLASTROUTER() eq "true" OR ArrayLen(formRouterDataD) eq routerIndexD.getROUTERORDER()>
		<cfset updateRouterD = EntityLoad("EGINROUTERDETAILS", {ROUTERDETAILSID = #routerIndexD.getROUTERDETAILSID()#}, true) >
		<cfset updateRouterD.setSTATUS("DISAPPROVED") > <!---set this router as disapproved status--->
		<cfset updateRouterD.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')# #timeformat(now(), 'HH:MM:SS')#") >
		<cfset EntitySave(updateRouterD) > 
		<cfset ormflush() >
	</cfif>
	
	<cfset updateRouterDD = EntityLoad("EGINROUTERDETAILS", {ROUTERDETAILSID = #routerIndexD.getROUTERDETAILSID()#, STATUS='PENDING'}, true) >
	<cfif isdefined("updateRouterDD") >
		<cfset updateRouterDD.setSTATUS("IGNORED") > <!---set this router as disapproved status--->
		<cfset updateRouterDD.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')# #timeformat(now(), 'HH:MM:SS')#") >
		<cfset EntitySave(updateRouterDD) >
		<cfset ormflush() >
	</cfif>
	<cfset formApproversDataD = EntityLoad("EGINAPPROVERDETAILS", {ROUTERIDFK =#routerIndexD.getROUTERDETAILSID()#}, "APPROVERORDER ASC" ) >	
	<cfloop array="#formApproversDataD#" index="approverIndexD" >
		<cftry>
			<cfset updateActionD = EntityLoad("EGINAPPROVERDETAILS", {APPROVERDETAILSID =#approverIndexD.getAPPROVERDETAILSID()#,ACTION='CURRENT'}, true ) >
			<cfset updateActionD.setACTION("IGNORED") >
			<cfset updateActionD.setDATELASTUPDATE("#dateformat(now(), "YYYY-MM-DD")# #timeformat(now(), "HH:MM:SS")#") >
			<cfset EntitySave(updateActionD) >
			<cfset ormflush() >
			<!---for the current router which is approved--->
			<cfset updateCount = EntityLoad("EGINEFORMCOUNT", { EFORMID =#eformid#, PERSONNELIDNO = #approverIndexD.getPERSONNELIDNO()#}, true ) >
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
			<!---end for the current router which is approved --->	
			</cfif>
			<cfcatch>
			</cfcatch>
		</cftry>
		<cftry>
			<cfset updateActionE = EntityLoad("EGINAPPROVERDETAILS", {APPROVERDETAILSID =#approverIndexD.getAPPROVERDETAILSID()#,ACTION='PENDING'}, true ) >
			<cfset updateActionE.setACTION("IGNORED") >
			<cfset updateActionE.setDATELASTUPDATE("#dateformat(now(), "YYYY-MM-DD")# #timeformat(now(), "HH:MM:SS")#") >
			<cfset EntitySave(updateActionE) >
			<cfset ormflush() >
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

	<cfset updateCount = EntityLoad("EGINEFORMCOUNT", { EFORMID =#eformid#, PERSONNELIDNO = #pid#}, true ) >
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
	<cfset ormflush()>	
	
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

<cfset formRouterData = EntityLoad("EGINROUTERDETAILS", {PROCESSIDFK = #processid#,ROUTERDETAILSID=#routerid#}, "ROUTERORDER ASC") >
<cfloop array="#formRouterData#" index="routerIndex" >
	<cfset formApproversDataTemp = EntityLoad("EGINAPPROVERDETAILS", {ROUTERIDFK =#routerid#,ACTION='CURRENT'}, "APPROVERORDER ASC" ) >
		<cfloop array="#formApproversDataTemp#" index="approverIndexTemp" > 
			<cfset ArrayAppend( pidArray,approverIndexTemp.getPERSONNELIDNO() ) >
		</cfloop>
</cfloop>

<cfif ArrayLen(pidArray) eq 0 >
	<cfabort>
</cfif>

<cfset approverslist = ArrayToList(pidArray, "','") >

<cfif client.dbms eq "MSSQL" >
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
	  FROM #dbsourcec#.CMFPA A LEFT JOIN #dbsourcec#.ECRGMYIBOSE B ON (A.PERSONNELIDNO=B.PERSONNELIDNO)
	               LEFT JOIN #dbsourcec#.CLKPOSITION C  ON (A.POSITIONCODE=C.POSITIONCODE)
	               LEFT JOIN #dbsourcec#.CLKDEPARTMENT D ON (A.DEPARTMENTCODE=D.DEPARTMENTCODE)
	               LEFT JOIN EGRGUSERMASTER E ON (A.GUID=E.GUID)
	 WHERE A.PERSONNELIDNO IN ('#approverslist#') 
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
	
	<cfmail from="leonelllagumbay@gmail.com,#emaillist#"
			to="leonelllagumbay@gmail.com,#emaillist#"
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
			</br>
			<a href="#client.domain#myapps/form/main/">Click here to view.</a>
			</br>
			Note: You need to sign on to your account to open the item.</br>
	</cfmail>
	
	<cfreturn "success" >
</cffunction>	


<cffunction name="getMainTableData" returntype="String" >

<cfset gettheForm = ORMExecuteQuery("SELECT A.EFORMNAME, 
											B.TABLENAME AS TABLENAME, 
											B.LEVELID AS LEVELID, 
											C.COLUMNNAME AS COLUMNNAME
	  								  FROM EGRGEFORMS A,EGRGIBOSETABLE B,EGRGIBOSETABLEFIELDS C
	  								WHERE EFORMID = '#eformid#' AND A.EFORMID = B.EFORMIDFK AND B.TABLEID = C.TABLEIDFK", false) >
  
<cfset getMainTableID = ORMExecuteQuery("SELECT B.TABLENAME AS TABLENAME, 
												B.LEVELID AS LEVELID, 
												C.COLUMNNAME AS COLUMNNAME, 
												A.ISENCRYPTED AS ISENCRYPTED,
												A.EFORMNAME AS EFORMNAME,
												A.EFORMGROUP AS EFORMGROUP
	  								      FROM EGRGEFORMS A,EGRGIBOSETABLE B,EGRGIBOSETABLEFIELDS C
	 								      WHERE EFORMID = '#eformid#' AND A.EFORMID = B.EFORMIDFK AND B.TABLEID = C.TABLEIDFK AND C.XTYPE = 'id'", true) >



<cfif trim(getMainTableID[1]) neq "" >
	<cfset firsttable  = getMainTableID[1] >
	<cfset firstlevel  = getMainTableID[2] >
	<cfset firstcolumn = getMainTableID[3] >
	<cfset theformname = getMainTableID[5] >
	<cfset ArrayAppend(formGroup, getMainTableID[6] ) >
<cfelse>
	<cfthrow detail="Table has no id specified in table fields. At least one field type is an id type." >
</cfif>


<cfset columnNameModel = ArrayNew(1)  >
<cfset columnNameReal = ArrayNew(1)  >

<cfloop array="#gettheForm#" index="tableModel">
	<cfif trim(tableModel[4]) neq "" > <!---columnName with empty name is not qualified--->
		<cfset colModel = tableModel[3] & '__' & tableModel[2] & '__' & tableModel[4] > 
		<cfset ArrayAppend(columnNameModel, colModel) >
		<cfset ArrayAppend(columnNameReal, tableModel[4]) >  
	</cfif>
</cfloop>


<cfset colModel = firstlevel & '__' & firsttable & '__PERSONNELIDNO' >
<cfset ArrayAppend(columnNameModel, colModel) >
<cfset colModel = firstlevel & '__' & firsttable & '__DATEACTIONWASDONE' >
<cfset ArrayAppend(columnNameModel, colModel) >

<cfset selectArray = ArrayNew(1) >
<cfset fromArray   = ArrayNew(1) >
<cfset whereArray  = ArrayNew(1) >
<cfset groupTable   = StructNew() >

<cfloop array="#columnNameModel#" index="formIndex" >
	
		<cfset theTableLevel = ListGetAt( formIndex, 1, "__" ) >
		<cfset theTableName  = ListGetAt( formIndex, 2, "__"  ) >
		<cfset theColumnName = ListGetAt( formIndex, 3, "__"  ) >
		
		<cfset client.dbms = "MYSQL" >
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
		<cfif client.dbms eq "MSSQL" >
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
		<cfset ArrayAppend(selectArray,"#theTableName#.#theColumnName# AS #formIndex#") >
		<cfif StructKeyExists(groupTable, '#theTableName#') >
			
		<cfelse>
			<!---ex. IBOSE_GLOBAL.CMFPA CMFPA OR IBOSE_GLOBAL.DBO.CMFPA CMFPA---> 
			<cfset ArrayAppend(fromArray,"#theLevel#.#theTableName# #theTableName#") >
			
			<!---ex CMFPA.PERSONNELIDNO = GMFPEOPLE.PERSONNELIDNO   delimited by AND--->
			<cfset ArrayAppend(whereArray,"#firsttable#.PERSONNELIDNO = #theTableName#.PERSONNELIDNO") >
			<cfset groupTable['#theTableName#'] = "_" >
		</cfif>
		
</cfloop>

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
		
			<cfif getMainTableID[4] eq "true" >
				
				<cfset ArrayAppend( propertyArr, "Employee No" ) > 
				<cfset ArrayAppend( valueArr, evaluate("#firstlevel#__#firsttable#__PERSONNELIDNO") ) > 
				<cfset ArrayAppend( propertyArr, "Date Filed" ) > 
				<cfset ArrayAppend( valueArr, evaluate("#firstlevel#__#firsttable#__DATEACTIONWASDONE") ) >
				
				<cfloop from="1" to="#ArrayLen(columnNameReal)#" index="outIndex" > 
					<cftry>
						<cfset ArrayAppend( propertyArr, columnNameReal[outIndex] ) > 
						<cfset ArrayAppend( valueArr, decrypt( evaluate( columnNameModel[outIndex] ), client.ek ) ) > 
					<cfcatch>
						<cfset ArrayAppend( propertyArr, columnNameReal[outIndex] ) > 
						<cfset ArrayAppend( valueArr, evaluate( columnNameModel[outIndex] ) ) >
					</cfcatch>
					</cftry>
					
				</cfloop>
				
				
			<cfelse>
				
				<cfset ArrayAppend( propertyArr, "Employee No" ) > 
				<cfset ArrayAppend( valueArr, evaluate("#firstlevel#__#firsttable#__PERSONNELIDNO") ) > 
				<cfset ArrayAppend( propertyArr, "Date Filed" ) > 
				<cfset ArrayAppend( valueArr, evaluate("#firstlevel#__#firsttable#__DATEACTIONWASDONE") ) >
				
				<cfloop from="1" to="#ArrayLen(columnNameReal)#" index="outIndex" > 
					
						<cfset ArrayAppend( propertyArr, columnNameReal[outIndex] ) > 
						<cfset ArrayAppend( valueArr, evaluate( columnNameModel[outIndex] ) ) >
					
				</cfloop>  
				
			</cfif>
		
	</cfloop>

	<cfreturn theformname />
	
</cffunction>


