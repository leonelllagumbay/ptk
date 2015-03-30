<cfcomponent>


<cffunction name="fixProcess">
	<cfargument name="eformid" >
	<cfargument name="processID" >
	<cfargument name="personnelidno" >
	<cfargument name="theLevel" >
	<cfargument name="theTable" >

	<!---the following code is the same or comes from schedule.cfm with a little additional codes--->
	<cfset pStruct      = structnew() >
	<cfset pStruct.eformid		= eformid >
	<cfset pStruct.processid	= processID >
	<cfset pStruct.pid 			= personnelidno >
	<cfset dbsource 	= theLevel >
	<cfset pStruct.tablename 	= theTable >


	<cfset pStruct.domain		= session.domain >
	<cfset pStruct.globaldsn	= session.global_dsn >
	<cfset pStruct.companydsn	= session.company_dsn >
	<cfset pStruct.companyname	= session.companyname >

	<cfset pStruct.subcomdsn 	= session.subco_dsn >
	<cfset pStruct.querydsn 	= session.query_dsn >
	<cfset pStruct.transactiondsn = session.transaction_dsn >
	<cfset pStruct.sitedsn 		= session.site_dsn >

	<cfset pStruct.maintable 	= session.maintable >
	<cfset pStruct.mainpk 		= session.mainpk >

	<cfif dbsource eq "G" >
		<cfset pStruct.dbsource = "#session.global_dsn#" >
	<cfelseif dbsource eq "C" >
		<cfset pStruct.dbsource = "#session.company_dsn#" >
	<cfelseif dbsource eq "S" >
		<cfset pStruct.dbsource = "#session.subco_dsn#" >
	<cfelseif dbsource eq "Q" >
		<cfset vdbsource = "#session.query_dsn#" >
	<cfelseif dbsource eq "T" >
		<cfset pStruct.dbsource = "#session.transaction_dsn#" >
	<cfelseif dbsource eq "SD" >
		<cfset pStruct.dbsource = "#session.site_dsn#" >
	<cfelse>
		<cfset pStruct.dbsource = dbsource >
	</cfif>

	<!---is the process expired--->
	<cfset formProcessData = EntityLoad( "EGINFORMPROCESSDETAILS", #processid#, true ) >

	<cfset datecreated = formProcessData.getRECDATECREATED() >
	<cfset expirationdate = dateadd("d", formProcessData.getEFORMLIFE(), datecreated ) >

	<cfif datediff( "d", now(), expirationdate ) gt 0 > <!---not expired--->
		<cfinvoke method="processNotExpired" argumentcollection="#pStruct#" >
	<cfelse> <!---expired--->
		<cfinvoke method="processIsExpired" argumentcollection="#pStruct#">
	</cfif>

</cffunction>

	<cffunction name="processNotExpired" access="public" >
		<cfargument name="eformid" >
		<cfargument name="processid" >
		<cfargument name="pid" >
		<cfargument name="tablename" >
		<cfargument name="domain" >
		<cfargument name="globaldsn" >
		<cfargument name="companydsn" >
		<cfargument name="companyname" >
		<cfargument name="subcomdsn" >
		<cfargument name="querydsn" >
		<cfargument name="transactiondsn" >
		<cfargument name="sitedsn" >
		<cfargument name="maintable" >
		<cfargument name="mainpk" >
		<cfargument name="dbsource" >

		<cfset pStruct      = structnew() >
		<cfset pStruct.eformid		= eformid >
		<cfset pStruct.processid	= processid >
		<cfset pStruct.pid 			= pid >
		<cfset pStruct.tablename 	= tablename >
		<cfset pStruct.domain		= domain >
		<cfset pStruct.globaldsn	= globaldsn >
		<cfset pStruct.companydsn	= companydsn >
		<cfset pStruct.companyname	= companyname >
		<cfset pStruct.subcomdsn 	= subcomdsn >
		<cfset pStruct.querydsn 	= querydsn >
		<cfset pStruct.transactiondsn = transactiondsn >
		<cfset pStruct.sitedsn 		= sitedsn >
		<cfset pStruct.maintable 	= maintable >
		<cfset pStruct.mainpk 		= mainpk >
		<cfset pStruct.dbsource 	= dbsource >

		<!---<cfoutput>processNotExpired</cfoutput>--->

		<cfset previousRouterIsDone = "true" >
		<cfset pidArray = ArrayNew(1) >
		<cfset freqArray = ArrayNew(1) >
		<cfset expirArray = ArrayNew(1) >
		<cfset therouterdetailsid = ArrayNew(1) >

		<!---loop over the routers, then check expiration date of each router--->
		<cfset formRouterData = EntityLoad("EGINROUTERDETAILS", {PROCESSIDFK = #processid#}, "ROUTERORDER ASC") >
			<cfloop array="#formRouterData#" index="routerIndex" >
				<!---check if APPROVED or DISAPPROVED--->
				<cfif routerIndex.getSTATUS() eq 'APPROVED' OR routerIndex.getSTATUS() eq 'IGNORED'>
					<!---continue to the next router, this router had been approved successfully--->
					<!---make its approvers current and pending status to ignored ignoreCurrentAndPending--->
					<cfinvoke method="ignoreRoutersApprovers" argumentcollection="#pStruct#">
					<!---double check if this process is done do the clean up also--->
					<cfif routerIndex.getISLASTROUTER() eq "true" OR ArrayLen(formRouterData) eq routerIndex.getROUTERORDER()>
						<cfinvoke method="updateMainTable" argumentcollection="#pStruct#">
						<cfinvoke method="ignoreCurrentAndPending" argumentcollection="#pStruct#">
					</cfif>
				<cfelseif routerIndex.getSTATUS() eq 'DISAPPROVED' >
					<cfinvoke method="disapproveRouter" argumentcollection="#pStruct#">
					<cfinvoke method="ignoreCurrentAndPending" argumentcollection="#pStruct#" >
					<cfbreak>
				<cfelse> <!---for PENDING and SENT BACK TO ORIGINATOR--->
					<!---check the router if expired--->
					<cfif datediff( "d", now(), routerIndex.getEXPIRATIONDATE() ) gt 0 > <!---not expired--->
						<!---check if previous router had been expired--->
						<!---<cfif previousRouterIsDone eq "true" >
							<cfinvoke method="updateRouterApprover" argumentcollection="#pStruct#"> <!---set PENDING to CURRENT Status--->
						</cfif>--->

					<cfelse> <!---expired--->
						<!---<cfoutput>expired</cfoutput>--->
						<cfinvoke method="routerIsExpired" argumentcollection="#pStruct#">
					</cfif>
				</cfif>

			</cfloop>
			<!---<cfoutput>followup NOTIF</cfoutput>--->

			<cfinvoke method="preUpdateProcess" component="actionform" argumentcollection="#pStruct#">

	<cfreturn "success" >

	</cffunction>




	<cffunction name="processIsExpired" >
		<cfargument name="eformid" >
		<cfargument name="processid" >
		<cfargument name="pid" >
		<cfargument name="tablename" >
		<cfargument name="domain" >
		<cfargument name="globaldsn" >
		<cfargument name="companydsn" >
		<cfargument name="companyname" >
		<cfargument name="subcomdsn" >
		<cfargument name="querydsn" >
		<cfargument name="transactiondsn" >
		<cfargument name="sitedsn" >
		<cfargument name="maintable" >
		<cfargument name="mainpk" >
		<cfargument name="dbsource" >

		<cfset pStruct      = structnew() >
		<cfset pStruct.eformid		= eformid >
		<cfset pStruct.processid	= processid >
		<cfset pStruct.pid 			= pid >
		<cfset pStruct.tablename 	= tablename >
		<cfset pStruct.domain		= domain >
		<cfset pStruct.globaldsn	= globaldsn >
		<cfset pStruct.companydsn	= companydsn >
		<cfset pStruct.companyname	= companyname >
		<cfset pStruct.subcomdsn 	= subcomdsn >
		<cfset pStruct.querydsn 	= querydsn >
		<cfset pStruct.transactiondsn = transactiondsn >
		<cfset pStruct.sitedsn 		= sitedsn >
		<cfset pStruct.maintable 	= maintable >
		<cfset pStruct.mainpk 		= mainpk >
		<cfset pStruct.dbsource 	= dbsource >

		<!---make all status that is not APPROVED and DISAPPROVED to IGNORED
		then update the main form table to APPROVE = Y or D
		depending on the action when the process is expired--->
		<cfif trim( formProcessData.getEXPIREDACTION() ) eq "APPROVE" >
			<!---<cfoutput>approve</cfoutput>--->
			<cfinvoke method="updateMainTable" argumentcollection="#pStruct#">
			<cfinvoke method="ignoreCurrentAndPending" argumentcollection="#pStruct#">
		<cfelse>
			<!---<cfoutput>disapprove</cfoutput>--->
			<cfinvoke method="disapproveRouter" argumentcollection="#pStruct#">
		</cfif>

	<cfreturn "success" >
	</cffunction>


	<cffunction name="routerIsExpired" >
		<cfargument name="eformid" >
		<cfargument name="processid" >
		<cfargument name="pid" >
		<cfargument name="tablename" >
		<cfargument name="domain" >
		<cfargument name="globaldsn" >
		<cfargument name="companydsn" >
		<cfargument name="companyname" >
		<cfargument name="subcomdsn" >
		<cfargument name="querydsn" >
		<cfargument name="transactiondsn" >
		<cfargument name="sitedsn" >
		<cfargument name="maintable" >
		<cfargument name="mainpk" >
		<cfargument name="dbsource" >

		<cfset pStruct      = structnew() >
		<cfset pStruct.eformid		= eformid >
		<cfset pStruct.processid	= processid >
		<cfset pStruct.pid 			= pid >
		<cfset pStruct.tablename 	= tablename >
		<cfset pStruct.domain		= domain >
		<cfset pStruct.globaldsn	= globaldsn >
		<cfset pStruct.companydsn	= companydsn >
		<cfset pStruct.companyname	= companyname >
		<cfset pStruct.subcomdsn 	= subcomdsn >
		<cfset pStruct.querydsn 	= querydsn >
		<cfset pStruct.transactiondsn = transactiondsn >
		<cfset pStruct.sitedsn 		= sitedsn >
		<cfset pStruct.maintable 	= maintable >
		<cfset pStruct.mainpk 		= mainpk >
		<cfset pStruct.dbsource 	= dbsource >
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
				<cfinvoke method="updateMainTable" argumentcollection="#pStruct#" >
				<cfinvoke method="ignoreCurrentAndPending" argumentcollection="#pStruct#">
			<cfelse>
				<cfinvoke method="disapproveRouter" argumentcollection="#pStruct#">
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
					<cfinvoke component="routing" method="updateFormCount" eformid="#eformid#" personnelidno="#approverIndexD.getPERSONNELIDNO()#" theType="subtractneworpending">
					<!---end for the current router which is approved --->

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
		<cfargument name="eformid" >
		<cfargument name="processid" >
		<cfargument name="pid" >
		<cfargument name="tablename" >
		<cfargument name="domain" >
		<cfargument name="globaldsn" >
		<cfargument name="companydsn" >
		<cfargument name="companyname" >
		<cfargument name="subcomdsn" >
		<cfargument name="querydsn" >
		<cfargument name="transactiondsn" >
		<cfargument name="sitedsn" >
		<cfargument name="maintable" >
		<cfargument name="mainpk" >
		<cfargument name="dbsource" >

		<cfset pStruct      = structnew() >
		<cfset pStruct.eformid		= eformid >
		<cfset pStruct.processid	= processid >
		<cfset pStruct.pid 			= pid >
		<cfset pStruct.tablename 	= tablename >
		<cfset pStruct.domain		= domain >
		<cfset pStruct.globaldsn	= globaldsn >
		<cfset pStruct.companydsn	= companydsn >
		<cfset pStruct.companyname	= companyname >
		<cfset pStruct.subcomdsn 	= subcomdsn >
		<cfset pStruct.querydsn 	= querydsn >
		<cfset pStruct.transactiondsn = transactiondsn >
		<cfset pStruct.sitedsn 		= sitedsn >
		<cfset pStruct.maintable 	= maintable >
		<cfset pStruct.mainpk 		= mainpk >
		<cfset pStruct.dbsource 	= dbsource >

		<cfset formApproversDataB = EntityLoad("EGINAPPROVERDETAILS", {ROUTERIDFK =#routerIndex.getROUTERDETAILSID()#}, "APPROVERORDER ASC" ) >



		<cfloop array="#formApproversDataB#" index="approverIndex" >
			<cfset updateActionB = EntityLoad("EGINAPPROVERDETAILS", {APPROVERDETAILSID =#approverIndex.getAPPROVERDETAILSID()#,ACTION='PENDING'}, true ) >
				<cfif isdefined("updateActionB") >
					<cfinvoke component="routing" method="updateFormCount" eformid="#eformid#" personnelidno="#updateActionB.getPERSONNELIDNO()#" theType="updateornew">

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
					    argumentcollection="#pStruct#"
			>
			<cfset ArrayAppend( freqArray, routerIndex.getFREQUENCYFOLLOUP() ) >
			<cfset ArrayAppend( expirArray, routerIndex.getEXPIRATIONDATE() ) >
			<cfset ArrayAppend( therouterdetailsid, routerIndex.getROUTERDETAILSID() ) >
		</cfif>
		<!---end notifications --->

	<cfreturn "success" >
	</cffunction>


	<cffunction name="ignoreRoutersApprovers" >
		<cfargument name="eformid" >
		<cfargument name="processid" >
		<cfargument name="pid" >
		<cfargument name="tablename" >
		<cfargument name="domain" >
		<cfargument name="globaldsn" >
		<cfargument name="companydsn" >
		<cfargument name="companyname" >
		<cfargument name="subcomdsn" >
		<cfargument name="querydsn" >
		<cfargument name="transactiondsn" >
		<cfargument name="sitedsn" >
		<cfargument name="maintable" >
		<cfargument name="mainpk" >
		<cfargument name="dbsource" >
	    <cfset formApproversDataB = EntityLoad("EGINAPPROVERDETAILS", {ROUTERIDFK =#routerIndex.getROUTERDETAILSID()#}, "APPROVERORDER ASC" ) >
		<cfloop array="#formApproversDataB#" index="approverIndex" >
			<cfset updateActionB = EntityLoad("EGINAPPROVERDETAILS", {APPROVERDETAILSID =#approverIndex.getAPPROVERDETAILSID()#,ACTION='PENDING'}, true ) >
				<cfif isdefined("updateActionB") >
					<cfset updateActionB.setACTION("IGNORED") >
					<cfset updateActionB.setISREAD("false") >
					<cfset EntitySave(updateActionB) >
					<cfset ormflush() >
				</cfif>
			<cfset updateActionC = EntityLoad("EGINAPPROVERDETAILS", {APPROVERDETAILSID =#approverIndex.getAPPROVERDETAILSID()#,ACTION='CURRENT'}, true ) >
				<cfif isdefined("updateActionC") >
					<cfset updateActionC.setACTION("IGNORED") >
					<cfset updateActionC.setISREAD("false") >
					<cfset EntitySave(updateActionC) >
					<cfset ormflush() >
				</cfif>
		</cfloop>
	<cfreturn "success" >
	</cffunction>


	<cffunction name="followUpNotif" >
		<cfargument name="eformid" >
		<cfargument name="processid" >
		<cfargument name="pid" >
		<cfargument name="tablename" >
		<cfargument name="domain" >
		<cfargument name="globaldsn" >
		<cfargument name="companydsn" >
		<cfargument name="companyname" >
		<cfargument name="subcomdsn" >
		<cfargument name="querydsn" >
		<cfargument name="transactiondsn" >
		<cfargument name="sitedsn" >
		<cfargument name="maintable" >
		<cfargument name="mainpk" >
		<cfargument name="dbsource" >
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
				url        	 	 = "#session.domain#myapps/form/simulator/scheduler/schedule.cfm?eformid=#eformid#&processid=#processid#&action=followupemail&domain=#url.domain#&routerid=#therouterdetailsid#&companydsn=#urn.companydsn#&globaldsn=#url.globaldsn#&companyname=#url.companyname#&subcomdsn=#url.subcomdsn#&querydsn=#url.querydsn#&transactiondsn=#url.transactiondsn#&sitedsn=#url.sitedsn#&maintable=#maintable#&mainpk=#mainpk#&dbms=#session.dbms#&ek=#session.ek#&websiteemailadd=#session.websiteemailadd#"
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
		<cfargument name="eformid" >
		<cfargument name="processid" >
		<cfargument name="pid" >
		<cfargument name="tablename" >
		<cfargument name="domain" >
		<cfargument name="globaldsn" >
		<cfargument name="companydsn" >
		<cfargument name="companyname" >
		<cfargument name="subcomdsn" >
		<cfargument name="querydsn" >
		<cfargument name="transactiondsn" >
		<cfargument name="sitedsn" >
		<cfargument name="maintable" >
		<cfargument name="mainpk" >
		<cfargument name="dbsource" >
	<!---update eform table status--->

	<cfset datetimenow = '#dateformat(now(), "YYYY-MM-DD")# #timeformat(now(), "HH:MM:SS")#' >
	<cfquery name="updateFormTable" datasource="#dbsource#" >
		UPDATE #tablename#
		   SET APPROVED          = <cfqueryparam cfsqltype="cf_sql_varchar" value="Y" >
	     WHERE PROCESSID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#processid#" > AND
		       EFORMID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#eformid#" >
	</cfquery>

	</cffunction>



	<cffunction name="ignoreCurrentAndPending" >
		<cfargument name="eformid" >
		<cfargument name="processid" >
		<cfargument name="pid" >
		<cfargument name="tablename" >
		<cfargument name="domain" >
		<cfargument name="globaldsn" >
		<cfargument name="companydsn" >
		<cfargument name="companyname" >
		<cfargument name="subcomdsn" >
		<cfargument name="querydsn" >
		<cfargument name="transactiondsn" >
		<cfargument name="sitedsn" >
		<cfargument name="maintable" >
		<cfargument name="mainpk" >
		<cfargument name="dbsource" >
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
				<cfset EntitySave(updateRouterF) >
				<cfset ormflush() >
			</cfif>
			<cfset approverDataC = EntityLoad("EGINAPPROVERDETAILS", {ROUTERIDFK =#routerIndexC.getROUTERDETAILSID()#} ) >
			<cfloop array="#approverDataC#" index="approverIndexC" >
				<cftry>
					<cfset updateAction = EntityLoad("EGINAPPROVERDETAILS", {APPROVERDETAILSID =#approverIndexC.getAPPROVERDETAILSID()#,ACTION='CURRENT'}, true ) >
					<cfset updateAction.setACTION("IGNORED") >
					<cfset EntitySave(updateAction) >
					<cfset ormflush() >
					<!---for the current router which is approved--->
					<cfinvoke component="routing" method="updateFormCount" eformid="#eformid#" personnelidno="#approverIndexC.getPERSONNELIDNO()#" theType="subtractneworpending">
					<!---end for the current router which is approved --->
					<cfcatch>
						<cfcontinue>
					</cfcatch>
				</cftry>

				<cftry>
					<cfset updateActionB = EntityLoad("EGINAPPROVERDETAILS", {APPROVERDETAILSID =#approverIndexC.getAPPROVERDETAILSID()#,ACTION='PENDING'}, true ) >
					<cfset updateActionB.setACTION("IGNORED") >
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
		<cfargument name="eformid" >
		<cfargument name="processid" >
		<cfargument name="pid" >
		<cfargument name="tablename" >
		<cfargument name="domain" >
		<cfargument name="globaldsn" >
		<cfargument name="companydsn" >
		<cfargument name="companyname" >
		<cfargument name="subcomdsn" >
		<cfargument name="querydsn" >
		<cfargument name="transactiondsn" >
		<cfargument name="sitedsn" >
		<cfargument name="maintable" >
		<cfargument name="mainpk" >
		<cfargument name="dbsource" >

		<cfset pStruct      = structnew() >
		<cfset pStruct.eformid		= eformid >
		<cfset pStruct.processid	= processid >
		<cfset pStruct.pid 			= pid >
		<cfset pStruct.tablename 	= tablename >
		<cfset pStruct.domain		= domain >
		<cfset pStruct.globaldsn	= globaldsn >
		<cfset pStruct.companydsn	= companydsn >
		<cfset pStruct.companyname	= companyname >
		<cfset pStruct.subcomdsn 	= subcomdsn >
		<cfset pStruct.querydsn 	= querydsn >
		<cfset pStruct.transactiondsn = transactiondsn >
		<cfset pStruct.sitedsn 		= sitedsn >
		<cfset pStruct.maintable 	= maintable >
		<cfset pStruct.mainpk 		= mainpk >
		<cfset pStruct.dbsource 	= dbsource >
	<!---update eform table status--->

	<!---all current and pending in this process to 'IGNORED'--->

	<cfset formRouterDataD = EntityLoad("EGINROUTERDETAILS", {PROCESSIDFK = #processid#}, "ROUTERORDER ASC") >

	<cfloop array="#formRouterDataD#" index="routerIndexD" > <!---a big loop--->

		<cfif routerIndexD.getISLASTROUTER() eq "true" OR ArrayLen(formRouterDataD) eq routerIndexD.getROUTERORDER()>
			<cfset updateRouterD = EntityLoad("EGINROUTERDETAILS", {ROUTERDETAILSID = #routerIndexD.getROUTERDETAILSID()#}, true) >
			<cfset updateRouterD.setSTATUS("DISAPPROVED") > <!---set this router as disapproved status--->
			<cfset EntitySave(updateRouterD) >
			<cfset ormflush() >
		</cfif>

		<cfset updateRouterDD = EntityLoad("EGINROUTERDETAILS", {ROUTERDETAILSID = #routerIndexD.getROUTERDETAILSID()#, STATUS='PENDING'}, true) >
		<cfif isdefined("updateRouterDD") >
			<cfset updateRouterDD.setSTATUS("IGNORED") > <!---set this router as disapproved status--->
			<cfset EntitySave(updateRouterDD) >
			<cfset ormflush() >
		</cfif>
		<cfset formApproversDataD = EntityLoad("EGINAPPROVERDETAILS", {ROUTERIDFK =#routerIndexD.getROUTERDETAILSID()#}, "APPROVERORDER ASC" ) >
		<cfloop array="#formApproversDataD#" index="approverIndexD" >
			<cftry>
				<cfset updateActionD = EntityLoad("EGINAPPROVERDETAILS", {APPROVERDETAILSID =#approverIndexD.getAPPROVERDETAILSID()#,ACTION='CURRENT'}, true ) >
				<cfset updateActionD.setACTION("IGNORED") >
				<cfset EntitySave(updateActionD) >
				<cfset ormflush() >
				<!---for the current router which is approved--->
				<cfinvoke component="routing" method="updateFormCount" eformid="#eformid#" personnelidno="#approverIndexD.getPERSONNELIDNO()#" theType="subtractneworpending">
				<!---end for the current router which is approved --->

				<cfcatch>
				</cfcatch>
			</cftry>
			<cftry>
				<cfset updateActionE = EntityLoad("EGINAPPROVERDETAILS", {APPROVERDETAILSID =#approverIndexD.getAPPROVERDETAILSID()#,ACTION='PENDING'}, true ) >
				<cfset updateActionE.setACTION("IGNORED") >
				<cfset EntitySave(updateActionE) >
				<cfset ormflush() >
				<cfcatch>
					<cfcontinue>
				</cfcatch>
			</cftry>
		</cfloop>
	</cfloop>


	<cfquery name="updateFormTable" datasource="#dbsource#" >
		UPDATE #tablename#
		   SET APPROVED  = <cfqueryparam cfsqltype="cf_sql_varchar" value="D" >
	     WHERE PROCESSID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#processid#" > AND
		       EFORMID   = <cfqueryparam cfsqltype="cf_sql_varchar" value="#eformid#" >
	</cfquery>


	<!---The eForm is totally disapproved
	make a clean up
	delete schedulers but do not delete process router approvers information for viewing purposes--->
	<cfinvoke method="deleteScheduledTask" argumentcollection="#pStruct#">
	</cffunction>


	<cffunction name="deleteScheduledTask" >
		<cfargument name="eformid" >
		<cfargument name="processid" >
		<cfargument name="pid" >
		<cfargument name="tablename" >
		<cfargument name="domain" >
		<cfargument name="globaldsn" >
		<cfargument name="companydsn" >
		<cfargument name="companyname" >
		<cfargument name="subcomdsn" >
		<cfargument name="querydsn" >
		<cfargument name="transactiondsn" >
		<cfargument name="sitedsn" >
		<cfargument name="maintable" >
		<cfargument name="mainpk" >
		<cfargument name="dbsource" >
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






<cffunction name="emailFromSched" >
		<cfargument name="eformid" >
		<cfargument name="processid" >
		<cfargument name="pid" >
		<cfargument name="tablename" >
		<cfargument name="domain" >
		<cfargument name="globaldsn" >
		<cfargument name="companydsn" >
		<cfargument name="companyname" >
		<cfargument name="subcomdsn" >
		<cfargument name="querydsn" >
		<cfargument name="transactiondsn" >
		<cfargument name="sitedsn" >
		<cfargument name="maintable" >
		<cfargument name="mainpk" >
		<cfargument name="dbsource" >

		<cfset pStruct      = structnew() >
		<cfset pStruct.eformid		= eformid >
		<cfset pStruct.processid	= processid >
		<cfset pStruct.pid 			= pid >
		<cfset pStruct.tablename 	= tablename >
		<cfset pStruct.domain		= domain >
		<cfset pStruct.globaldsn	= globaldsn >
		<cfset pStruct.companydsn	= companydsn >
		<cfset pStruct.companyname	= companyname >
		<cfset pStruct.subcomdsn 	= subcomdsn >
		<cfset pStruct.querydsn 	= querydsn >
		<cfset pStruct.transactiondsn = transactiondsn >
		<cfset pStruct.sitedsn 		= sitedsn >
		<cfset pStruct.maintable 	= maintable >
		<cfset pStruct.mainpk 		= mainpk >
		<cfset pStruct.dbsource 	= dbsource >

<cfset routerid=url.routerid >



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
<cfset approverslist = "'#approverslist#'" >

<cfif session.dbms eq "MSSQL" >
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
<cfinvoke method="getMainTableData" returnvariable="theformname" argumentcollection="#pStruct#" >

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

	<cfmail from="#session.websiteemailadd#"
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
			</br>
			<a href="#session.domain#myapps/form/main/">Click here to view.</a>
			</br>
			Note: You need to sign on to your account to open the item.</br>
	</cfmail>

	<cfreturn "success" >
</cffunction>


<cffunction name="getMainTableData" returntype="String" >
		<cfargument name="eformid" >
		<cfargument name="processid" >
		<cfargument name="pid" >
		<cfargument name="tablename" >
		<cfargument name="domain" >
		<cfargument name="globaldsn" >
		<cfargument name="companydsn" >
		<cfargument name="companyname" >
		<cfargument name="subcomdsn" >
		<cfargument name="querydsn" >
		<cfargument name="transactiondsn" >
		<cfargument name="sitedsn" >
		<cfargument name="maintable" >
		<cfargument name="mainpk" >
		<cfargument name="dbsource" >

<cfset gettheForm = ORMExecuteQuery("SELECT A.EFORMNAME,
											B.TABLENAME AS TABLENAME,
											B.LEVELID AS LEVELID,
											C.COLUMNNAME AS COLUMNNAME,
											B.TABLETYPE AS TABLETYPE,
											C.COLUMNORDER AS COLUMNORDER,
											B.LINKTABLETO AS LINKTABLETO,
											B.LINKINGCOLUMN AS LINKINGCOLUMN
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
<cfset lookupLink = ArrayNew(1)  >
<cfset lookupTable = ArrayNew(1)  >
<cfset linkingTable = ArrayNew(1)  >
<cfset linkingColumn = ArrayNew(1)  >

<cfloop array="#gettheForm#" index="tableModel">
	<cfif trim(tableModel[4]) neq "" > <!---columnName with empty name is not qualified--->
		<cfset colModel = tableModel[3] & '__' & tableModel[2] & '__' & tableModel[4] & '__' & tableModel[5]>
		<cfset ArrayAppend(columnNameModel, colModel) >
		<cfset ArrayAppend(columnNameReal, tableModel[4]) >
		<cfif tableModel[5] eq "LookupCard" AND tableModel[6] eq 1 >
			<cfset ArrayAppend(lookupLink,tableModel[4]) >
			<cfset ArrayAppend(lookupTable,tableModel[2]) >
			<cfset ArrayAppend(linkingTable,tableModel[7]) >
			<cfset ArrayAppend(linkingColumn,tableModel[8]) >
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

		<cfinvoke component="routing" method="getDatasource" tablelevel="#theTableLevel#" returnvariable="theLevel" >

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
		<cfset ArrayAppend(whereArray,"#linkingTable[lookupInd]#.#linkingColumn[lookupInd]# = #lookupTable[lookupInd]#.#lookupLink[lookupInd]#") >
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
		<cfif getMainTableID[4] eq "true" >

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
					<cfset ArrayAppend( valueArr, decrypt( evaluate( colName ), session.ek ) ) >
				<cfcatch>
					<cfset ArrayAppend( propertyArr, columnNameReal[listInd] ) >
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




</cfcomponent>