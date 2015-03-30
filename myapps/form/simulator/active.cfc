<cfcomponent name="active" ExtDirect="true">

	<cffunction name="startRoute" ExtDirect="true">
		<cfargument name="eformid" >
		<cfargument name="newprocessid" >
		<cfargument name="theLevel" >
		<cfargument name="thetable" >


		<cftry>

			<cfset formFlowProcess = ORMExecuteQuery("SELECT FORMFLOWPROCESS AS FORMFLOWPROCESS, ONBEFOREROUTE AS ONBEFOREROUTE, ONAFTERROUTE AS ONAFTERROUTE FROM EGRGEFORMS WHERE EFORMID = '#eformid#'", true ) >

			<!---execute before routing single form--->
			<cftry>
				<cfset ONBEFOREROUTE = formFlowProcess[2] >
				<cfset ONAFTERROUTE  = formFlowProcess[3] >
			<cfcatch>
				<cfset ONBEFOREROUTE = "NA" >
				<cfset ONAFTERROUTE  = "NA" >
			</cfcatch>
			</cftry>

			<cfif ONBEFOREROUTE neq "NA" AND trim(ONBEFOREROUTE) neq "">
				<cfinclude template="../fielddefinition/oncomplete/#ONBEFOREROUTE#" >
			</cfif>
			<!---end before routing--->

			<cfset formProcessData = EntityLoad("EGINFORMPROCESS", #formFlowProcess[1]#) >
			<cfif ArrayLen(formProcessData) LT 1 >
				<cfreturn "formflowprocessismissing" >
			</cfif>

			<cfset pidArray = ArrayNew(1) > <!---pid for email notifications--->
			<cfset countArrPid = ArrayNew(1) > <!---array of pid's for batch egineformcount--->
			<cfset countArrPending = ArrayNew(1) > <!---array of pid's for batch egineformcount for pending also. used in even workload distribution--->

			<cfloop array="#formProcessData#" index="processIndex" >

				<cfset PROCESSID     = processIndex.getPROCESSID() >
				<cfset EFORMLIFE     = processIndex.getEFORMLIFE() >
				<cfset EXPIREDACTION = processIndex.getEXPIREDACTION() >
				<cfset COMPANYCODE   = processIndex.getCOMPANYCODE() >
				<cfset GROUPNAME     = processIndex.getGROUPNAME() >
				<cfset PROCESSNAME   = processIndex.getPROCESSNAME() >
				<cfset DESCRIPTION   = processIndex.getDESCRIPTION() >
				<!---<cfset RECDATECREATED= processIndex.getRECDATECREATED() >--->
				<cfset RECCREATEDBY  = processIndex.getRECCREATEDBY() >
				<cfset DATELASTUPDATE= processIndex.getDATELASTUPDATE() >

				<!---create an instance of this process--->
					<cfset instanceProcessDetails = EntityNew("EGINFORMPROCESSDETAILS") >
					<cfset processdetailsid = newprocessid >
					<cfset instanceProcessDetails.setPROCESSDETAILSID(processdetailsid) >
                    <cfset instanceProcessDetails.setEFORMIDFK(eformid) >
					<cfset instanceProcessDetails.setPROCESSIDFK(PROCESSID) >
					<cfset instanceProcessDetails.setEFORMLIFE(EFORMLIFE) >
					<cfset instanceProcessDetails.setEXPIREDACTION(EXPIREDACTION) >
					<cfset instanceProcessDetails.setCOMPANYCODE(COMPANYCODE) >
					<cfset instanceProcessDetails.setGROUPNAME(GROUPNAME) >
					<cfset instanceProcessDetails.setPROCESSNAME(PROCESSNAME) >
					<cfset instanceProcessDetails.setDESCRIPTION(DESCRIPTION) >
					<cfset instanceProcessDetails.setRECDATECREATED(dateformat(now(), "YYYY-MM-DD") & ' ' & timeformat(now(), "HH:MM:SS")) >
					<cfset instanceProcessDetails.setRECCREATEDBY(session.userid) >
					<cfset instanceProcessDetails.setDATELASTUPDATE(dateformat(now(), "YYYY-MM-DD") & ' ' & timeformat(now(), "HH:MM:SS")) >

					<cfset EntitySave(instanceProcessDetails) >
					<cfset ormflush()>
				<!---end process instantiation--->
				<cfset freqArray = ArrayNew(1) >
				<cfset expirArray = ArrayNew(1) >
				<cfset therouterdetailsid = ArrayNew(1) >

				<cfset formRouterData = EntityLoad("EGINFORMROUTER", {PROCESSIDFK = #processIndex.getPROCESSID()#}, "ROUTERORDER ASC") >

				<cfloop array="#formRouterData#" index="routerIndex" >

					<cfset ROUTERID = routerIndex.getROUTERID() >
					<cfset PROCESSIDFK = routerIndex.getPROCESSIDFK() >
					<cfset ROUTERNAME = routerIndex.getROUTERNAME() >
					<cfset DESCRIPTION = routerIndex.getDESCRIPTION() >
					<cfset EFORMSTAYTIME = routerIndex.getEFORMSTAYTIME() >
					<cfset NOTIFYNEXTAPPROVERS = routerIndex.getNOTIFYNEXTAPPROVERS() >
					<cfset NOTIFYALLAPPROVERS = routerIndex.getNOTIFYALLAPPROVERS() >
					<cfset NOTIFYORIGINATOR = routerIndex.getNOTIFYORIGINATOR() >
					<cfset FREQUENCYFOLLOUP = routerIndex.getFREQUENCYFOLLOUP() >
					<cfset EXPIREDACTION = routerIndex.getEXPIREDACTION() >
					<cfset APPROVEATLEAST = routerIndex.getAPPROVEATLEAST() >
					<cfset USECONDITIONS = routerIndex.getUSECONDITIONS() >
					<cfset AUTOAPPROVE = routerIndex.getAUTOAPPROVE() >
					<cfset ROUTERORDER = routerIndex.getROUTERORDER() >
					<cfset ISLASTROUTER = routerIndex.getISLASTROUTER() >
					<cfset MAXIMUMAPPROVERS = routerIndex.getMAXIMUMAPPROVERS() >
					<cfset CANOVERRIDE = routerIndex.getCANOVERRIDE() >
					<cfset MOREEMAILADD = routerIndex.getMOREEMAILADD() >

					<cfset CANOVERRIDEB = CANOVERRIDE >

					<!---create an instance of this router under the above instantiated process--->
						<cfset instanceRouterDetails = EntityNew("EGINROUTERDETAILS") >
						<cfset routerdetailsid = createuuid() >
						<cfset instanceRouterDetails.setROUTERDETAILSID(routerdetailsid) >
						<cfset instanceRouterDetails.setROUTERIDFK(ROUTERID) >
						<cfset instanceRouterDetails.setPROCESSIDFK(processdetailsid) >
						<cfset instanceRouterDetails.setROUTERNAME(ROUTERNAME) >
						<cfset instanceRouterDetails.setDESCRIPTION(DESCRIPTION) >
						<cfset instanceRouterDetails.setEXPIRATIONDATE(dateadd("d",EFORMSTAYTIME, now() )) >
						<cfset instanceRouterDetails.setNOTIFYNEXTAPPROVERS(NOTIFYNEXTAPPROVERS) >
						<cfset instanceRouterDetails.setNOTIFYALLAPPROVERS(NOTIFYALLAPPROVERS) >
						<cfset instanceRouterDetails.setNOTIFYORIGINATOR(NOTIFYORIGINATOR) >
						<cfset instanceRouterDetails.setFREQUENCYFOLLOUP(FREQUENCYFOLLOUP) >
						<cfset instanceRouterDetails.setEXPIREDACTION(EXPIREDACTION) >
						<cfset instanceRouterDetails.setAPPROVEATLEAST(APPROVEATLEAST) >
						<cfset instanceRouterDetails.setUSECONDITIONS(USECONDITIONS) >
						<cfset instanceRouterDetails.setAUTOAPPROVE(AUTOAPPROVE) >
						<cfset instanceRouterDetails.setROUTERORDER(ROUTERORDER) >
						<cfset instanceRouterDetails.setISLASTROUTER(ISLASTROUTER) >
						<cfset instanceRouterDetails.setMAXIMUMAPPROVERS(MAXIMUMAPPROVERS) >
						<cfset instanceRouterDetails.setCANOVERRIDE(CANOVERRIDE) >
						<cfset instanceRouterDetails.setMOREEMAILADD(MOREEMAILADD) >
						<cfif AUTOAPPROVE eq "true" >
							<cfset instanceRouterDetails.setSTATUS("IGNORED") >
						<cfelse>
							<cfset instanceRouterDetails.setSTATUS("PENDING") >
						</cfif>
						<cfset instanceRouterDetails.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')# #timeformat(now(), 'HH:MM:SS')#") >
						<cfset instanceRouterDetails.setDATESTARTED("#dateformat(now(), 'YYYY-MM-DD')# #timeformat(now(), 'HH:MM:SS')#") >

						<cfset EntitySave(instanceRouterDetails) >
						<cfset ormflush()>
					<!---end router instantiation--->

					<cfif routerIndex.getNOTIFYNEXTAPPROVERS() eq "true">
						<cfset ArrayAppend(freqArray, FREQUENCYFOLLOUP) >
						<cfset ArrayAppend(expirArray, dateadd("d", EFORMSTAYTIME, now() ) ) >
						<cfset ArrayAppend(therouterdetailsid, routerdetailsid) >
					</cfif>

					<cfset iscurrent = 'false' > <!---flag used for dynamic routing--->

					<cfset formApproversData = EntityLoad("EGINROUTERAPPROVERS", {ROUTERIDFK =#routerIndex.getROUTERID()#}, "APPROVERORDER ASC" ) >
					<cfloop array="#formApproversData#" index="approverIndex" >

						<cfset APPROVERSID = approverIndex.getAPPROVERSID() >
						<cfset ROUTERIDFK = approverIndex.getROUTERIDFK() >
						<cfset PROCESSIDFK = approverIndex.getPROCESSIDFK() >
						<cfset APPROVERORDER = approverIndex.getAPPROVERORDER() >
						<cfset APPROVERNAME = approverIndex.getAPPROVERNAME() >
						<cfset CANVIEWROUTEMAP = approverIndex.getCANVIEWROUTEMAP() >
						<cfset CANOVERRIDE = approverIndex.getCANOVERRIDE() >
						<cfset PERSONNELIDNO = approverIndex.getPERSONNELIDNO() >
						<cfset USERGRPID = approverIndex.getUSERGRPID() >
						<cfset CONDITIONABOVE = approverIndex.getCONDITIONABOVE() >
						<cfset CONDITIONBELOW = approverIndex.getCONDITIONBELOW() >

						<cfset PERSONNELIDNO = ArrayNew(1) >


						<cfif APPROVERNAME EQ "IS">

							<!---get router order--->
							<cfif ROUTERORDER EQ "1" >
							 	<!---get immediate superior of the originator--->
								<cfquery name="getMyIS" datasource="#session.company_dsn#" maxrows="1">
									SELECT SUPERIORCODE
									  FROM #session.maintable#
									 WHERE #session.mainpk# = '#session.chapa#'
								</cfquery>
								<cfif getMyIS.recordcount GT 0>
									<cfquery name="getISofMyIS" datasource="#session.company_dsn#" maxrows="1">
										SELECT #session.mainpk# AS PERSONNELIDNO
										  FROM #session.maintable#
										 WHERE #session.mainpk# = '#getMyIS.SUPERIORCODE#'
									</cfquery>
									<cfif getISofMyIS.recordcount GT 0>
										<cfset ArrayAppend(PERSONNELIDNO,getISofMyIS.PERSONNELIDNO) >
									<cfelse>
									</cfif> <!---end getISofMyIS--->
								<cfelse>
								</cfif> <!---end getMyIS--->
							<cfelse>
								<!---get immediate superior of the this router - 1 --->
								<cfset routerOrdera = val(ROUTERORDER) - 1 >
								<cfset formRouterDataTemp = EntityLoad("EGINROUTERDETAILS", {PROCESSIDFK = #processdetailsid#, ROUTERORDER = #routerOrdera#}) >
								<cfloop array="#formRouterDataTemp#" index="routerIndexTemp" >
									<cfset formApproversDataTemp = EntityLoad("EGINAPPROVERDETAILS", {ROUTERIDFK =#routerIndexTemp.getROUTERDETAILSID()#}, "APPROVERORDER ASC" ) >
									<cfloop array="#formApproversDataTemp#" index="approverIndexTemp" >
										<cfset pid = approverIndexTemp.getPERSONNELIDNO() >
										<cfquery name="getMyIS" datasource="#session.company_dsn#" maxrows="1">
											SELECT SUPERIORCODE
											  FROM #session.maintable#
											 WHERE #session.mainpk# = '#pid#'
										</cfquery>
										<cfif getMyIS.recordcount GT 0>
												<cfset ArrayAppend(PERSONNELIDNO,getMyIS.SUPERIORCODE) >
										<cfelse>
										</cfif>
									</cfloop> <!---end formApproversDataTemp--->
								</cfloop> <!---end formRouterDataTemp--->
							</cfif> <!---end ROUTERORDER--->


						<cfelseif APPROVERNAME EQ "DEPARTMENTCODE">

							<!---get router order--->
							<cfif ROUTERORDER EQ "1" >
							 	<!---get department code of the originator--->
								<cfquery name="getMyDeptCode" datasource="#session.company_dsn#" maxrows="1">
									SELECT DEPARTMENTCODE
									  FROM #session.maintable#
									 WHERE #session.mainpk# = '#session.chapa#'
								</cfquery>
								<cfif getMyDeptCode.recordcount GT 0>
									<cfquery name="getApproversDeptCode" datasource="#session.company_dsn#">
										SELECT #session.mainpk# AS PID
										  FROM #session.maintable#
										 WHERE DEPARTMENTCODE = '#getMyDeptCode.DEPARTMENTCODE#' AND #session.mainpk# != '#session.chapa#'
									</cfquery>
									<cfif getApproversDeptCode.recordcount GT 0>
										<cfloop query="getApproversDeptCode">
											<cfset ArrayAppend(PERSONNELIDNO,getApproversDeptCode.PID) >
										</cfloop>
									<cfelse>
									</cfif> <!---end getApproversDeptCode--->
								<cfelse>
								</cfif> <!---end getMyDeptCode--->
							<cfelse>
								<!---get department code of the first approver of this router - 1--->
								<cfset routerOrdera = val(ROUTERORDER) - 1 >
								<cfset formRouterDataTemp = EntityLoad("EGINROUTERDETAILS", {PROCESSIDFK = #processdetailsid#, ROUTERORDER = #routerOrdera#}) >
								<cfloop array="#formRouterDataTemp#" index="routerIndexTemp" >
									<cfset formApproversDataTemp = EntityLoad("EGINAPPROVERDETAILS", {ROUTERIDFK =#routerIndexTemp.getROUTERDETAILSID()#}, "APPROVERORDER ASC" ) >
									<cfloop array="#formApproversDataTemp#" index="approverIndexTemp" >
										<cfset pid = approverIndexTemp.getPERSONNELIDNO() >
										<cfif pid NEQ "" >
											<cfquery name="getMyDeptCode" datasource="#session.company_dsn#" maxrows="1">
												SELECT DEPARTMENTCODE
												  FROM #session.maintable#
												 WHERE #session.mainpk# = '#pid#'
											</cfquery>
											<cfif getMyDeptCode.recordcount GT 0>
												<cfquery name="getApproversDeptCode" datasource="#session.company_dsn#">
													SELECT #session.mainpk# AS PID
													  FROM #session.maintable#
													 WHERE DEPARTMENTCODE = '#getMyDeptCode.DEPARTMENTCODE#' AND #session.mainpk# != '#pid#'
												</cfquery>
												<cfif getApproversDeptCode.recordcount GT 0>
													<cfloop query="getApproversDeptCode">
														<cfset ArrayAppend(PERSONNELIDNO,getApproversDeptCode.PID) >
													</cfloop> <!---end getApproversDeptCode--->
												<cfelse>
												</cfif> <!---end getApproversDeptCode--->
											<cfelse>
											</cfif> <!---end getMyDeptCode--->
											<cfbreak>
										<cfelse>
										</cfif>
									</cfloop>	<!---end formApproversDataTemp--->
								</cfloop> <!---end formRouterDataTemp--->
							</cfif> <!---end ROUTERORDER--->

						<cfelseif APPROVERNAME EQ "DEPARTMENTHEAD">

							<!---get router order--->
							<cfif ROUTERORDER EQ "1" >
							 	<!---get department code of the originator--->
								<cfquery name="getMyDeptCode" datasource="#session.company_dsn#" maxrows="1">
									SELECT DEPARTMENTCODE
									  FROM #session.maintable#
									 WHERE #session.mainpk# = '#session.chapa#'
								</cfquery>
								<cfif getMyDeptCode.recordcount GT 0>
									<cfquery name="getApproversDeptHead" datasource="#session.company_dsn#">
										SELECT DEPARTMENTHEAD AS PID
									  	  FROM CLKDEPARTMENT
										 WHERE DEPARTMENTCODE = '#getMyDeptCode.DEPARTMENTCODE#'
									</cfquery>
									<cfif getApproversDeptHead.recordcount GT 0>
										<cfloop query="getApproversDeptHead">
											<cfset ArrayAppend(PERSONNELIDNO,getApproversDeptHead.PID) >
										</cfloop>
									<cfelse>
									</cfif> <!---end getApproversDeptHead--->
								<cfelse>
								</cfif> <!---end getMyDeptCode--->
							<cfelse>
								<!---get department code of the first approver of this router - 1--->
								<cfset routerOrdera = val(ROUTERORDER) - 1 >
								<cfset formRouterDataTemp = EntityLoad("EGINROUTERDETAILS", {PROCESSIDFK = #processdetailsid#, ROUTERORDER = #routerOrdera#}) >
								<cfloop array="#formRouterDataTemp#" index="routerIndexTemp" >
									<cfset formApproversDataTemp = EntityLoad("EGINAPPROVERDETAILS", {ROUTERIDFK =#routerIndexTemp.getROUTERDETAILSID()#}, "APPROVERORDER ASC" ) >
									<cfloop array="#formApproversDataTemp#" index="approverIndexTemp" >
										<cfset pid = approverIndexTemp.getPERSONNELIDNO() >
										<cfif pid NEQ "" >
											<cfquery name="getMyDeptCode" datasource="#session.company_dsn#" maxrows="1">
												SELECT DEPARTMENTCODE
												  FROM #session.maintable#
												 WHERE #session.mainpk# = '#pid#'
											</cfquery>
											<cfif getMyDeptCode.recordcount GT 0>
												<cfquery name="getApproversDeptHead" datasource="#session.company_dsn#">
													SELECT DEPARTMENTHEAD AS PID
									  	  			  FROM CLKDEPARTMENT
													 WHERE DEPARTMENTCODE = '#getMyDeptCode.DEPARTMENTCODE#'
												</cfquery>
												<cfif getApproversDeptHead.recordcount GT 0>
													<cfloop query="getApproversDeptHead">
														<cfset ArrayAppend(PERSONNELIDNO,getApproversDeptHead.PID) >
													</cfloop> <!---end getApproversDeptHead--->
												<cfelse>
												</cfif> <!---end getApproversDeptHead--->
											<cfelse>
											</cfif> <!---end getMyDeptCode--->
											<cfbreak>
										<cfelse>
										</cfif>
									</cfloop>	<!---end formApproversDataTemp--->
								</cfloop> <!---end formRouterDataTemp--->
							</cfif> <!---end ROUTERORDER--->

						<cfelseif APPROVERNAME EQ "BACKTOSENDER">

							<!---get router order--->
							<cfif ROUTERORDER EQ "1" >
							 	<cfset ArrayAppend(PERSONNELIDNO,session.chapa) >
							<cfelse>
								<!---get department code of the first approver of this router - 1--->
								<cfset routerOrdera = val(ROUTERORDER) - 1 >
								<cfset formRouterDataTemp = EntityLoad("EGINROUTERDETAILS", {PROCESSIDFK = #processdetailsid#, ROUTERORDER = #routerOrdera#}) >
								<cfloop array="#formRouterDataTemp#" index="routerIndexTemp" >
									<cfset formApproversDataTemp = EntityLoad("EGINAPPROVERDETAILS", {ROUTERIDFK =#routerIndexTemp.getROUTERDETAILSID()#}, "APPROVERORDER ASC" ) >
									<cfloop array="#formApproversDataTemp#" index="approverIndexTemp" >
										<cfset ArrayAppend(PERSONNELIDNO,approverIndexTemp.getPERSONNELIDNO()) >
									</cfloop>
								</cfloop> <!---end formRouterDataTemp--->
							</cfif> <!---end ROUTERORDER--->

						<cfelseif APPROVERNAME EQ "BACKTOORIGINATOR">

							<cfset ArrayAppend(PERSONNELIDNO,session.chapa) >

						<cfelseif APPROVERNAME EQ "USERROLE">

							<cfquery name="getRoleFromGroup" datasource="#session.global_dsn#">
								SELECT A.USERGRPMEMBERSIDX, B.USERID, B.GUID AS GUID
								  FROM EGRGROLEINDEX A LEFT JOIN EGRGUSERMASTER B ON (A.USERGRPMEMBERSIDX = B.USERID)
								 WHERE USERGRPID_FK = '#USERGRPID#'
							</cfquery>
							<cfif getRoleFromGroup.recordcount GT 0 >
								<cfloop query="getRoleFromGroup" >
									<cfquery name="getPIDfromMainTable" datasource="#session.company_dsn#" maxrows="1">
										SELECT #session.mainpk# AS PID
										  FROM #session.maintable#
										 WHERE GUID = '#getRoleFromGroup.GUID#'
									</cfquery>
									<cfif getPIDfromMainTable.recordcount GT 0 >
										<cfset ArrayAppend(PERSONNELIDNO, getPIDfromMainTable.PID) >
									<cfelse>
									</cfif> <!---end getPIDfromMainTable--->
								</cfloop> <!---end getRoleFromGroup--->
							<cfelse>
							</cfif> <!---end getRoleFromGroup--->

						<cfelseif APPROVERNAME EQ "SPECIFICNAME">

							<cfset ArrayAppend(PERSONNELIDNO,approverIndex.getPERSONNELIDNO()) >


						<cfelseif APPROVERNAME EQ "TOBESPECIFIED">
						    <cfif iscurrent neq 'true' >
						    	<cfset PIDDYNAMICTEMP = ArrayNew(1) >
								<cfset formDynamicApprover = EntityLoad("EGINDYNAMICAPPROVERS", { EFORMIDFK = #eformid#,OWNER=#session.chapa# }, "PERSONNELIDNO ASC") >
								<cfloop array="#formDynamicApprover#" index="dynamicApproverIndex" >
									<cfset ArrayAppend(PIDDYNAMICTEMP, dynamicApproverIndex.getPERSONNELIDNO()) >
									<cfset iscurrent = 'true' >
								</cfloop>
							</cfif>

							<cfif ArrayLen(PIDDYNAMICTEMP) gt 0 >
								<cfset ArrayAppend(PERSONNELIDNO, PIDDYNAMICTEMP[1]) > <!---pop and insert value at a time--->
								<cfset ArrayDeleteAt(PIDDYNAMICTEMP,1) >
							</cfif>

						<cfelse>

						</cfif> <!---end APPROVERNAME--->

						<!---create an instance of this approver under the above instantiated router--->

							<cfloop array="#PERSONNELIDNO#" index="pidIndex" >    <!---prevent sending multiple eform for one user  --->
									<cfset pidExist = EntityLoad("EGINAPPROVERDETAILS", { ROUTERIDFK =#routerdetailsid#, PERSONNELIDNO = #pidIndex#}, "APPROVERORDER ASC" ) >
									<cfif ArrayLen(pidExist) LT 1 >

										<!---check if approver order exists--->
										<cfset approverOrderExists = EntityLoad("EGINAPPROVERDETAILS", { ROUTERIDFK =#routerdetailsid#, APPROVERORDER = #APPROVERORDER#} ) >
										<cfif ArrayLen(approverOrderExists) gt 0 >
											<cfset defendingPID = approverOrderExists[1].getPERSONNELIDNO() >
											<cfset challendingPID = pidIndex >
											<cfset defendingPIDCount = OrmExecuteQuery("SELECT SUM(A.RECEIVED) AS ABC, A.PERSONNELIDNO
									                                        FROM EGINEFORMCOUNT A WHERE A.EFORMID = '#eformid#'
									                                             AND A.PERSONNELIDNO = '#defendingPID#'
									                                             GROUP BY A.PERSONNELIDNO
							                                     ") >
		                                     <cfset challendingPIDCount = OrmExecuteQuery("SELECT SUM(A.RECEIVED) AS DEF, A.PERSONNELIDNO
													                                        FROM EGINEFORMCOUNT A WHERE A.EFORMID = '#eformid#'
													                                             AND A.PERSONNELIDNO = '#challendingPID#'
													                                             GROUP BY A.PERSONNELIDNO
											                                     ") >


		                                     <cfloop array="#defendingPIDCount#" index="defendingIndex">
		                                     	<cfset defendingcount = defendingIndex[1] >
                                             </cfloop>

                                             <cfif not isdefined("defendingcount") >
                                             	<cfset defendingcount = 0 >
                                             	<cfset updateCount = EntityNew("EGINEFORMCOUNT") >
												<cfset updateCount.setNEW("0") >
												<cfset updateCount.setEFORMID(eformid) >
												<cfset updateCount.setPERSONNELIDNO(defendingPID) >
												<cfset updateCount.setPENDING("0") >
												<cfset updateCount.setRETURNED("0") >
												<cfset updateCount.setAPPROVED("0") >
												<cfset updateCount.setDISAPPROVED("0") >
												<cfset updateCount.setRECEIVED("0") >
												<cfset updateCount.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')# #timeformat(now(), 'HH:MM:SS')#") >
												<cfset EntitySave(updateCount) >
												<cfset ormflush()>
                                             </cfif>


		                                     <cfloop array="#challendingPIDCount#" index="challendingIndex">
		                                     	<cfset challengingcount = challendingIndex[1] >
                                             </cfloop>

                                             <cfif not isdefined("challengingcount") >
                                             	<cfset challengingcount = 0 >
                                             	<cfset updateCount = EntityNew("EGINEFORMCOUNT") >
												<cfset updateCount.setNEW("0") >
												<cfset updateCount.setEFORMID(eformid) >
												<cfset updateCount.setPERSONNELIDNO(challendingPID) >
												<cfset updateCount.setPENDING("0") >
												<cfset updateCount.setRETURNED("0") >
												<cfset updateCount.setAPPROVED("0") >
												<cfset updateCount.setDISAPPROVED("0") >
												<cfset updateCount.setRECEIVED("0") >
												<cfset updateCount.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')# #timeformat(now(), 'HH:MM:SS')#") >
												<cfset EntitySave(updateCount) >
												<cfset ormflush()>
                                             </cfif>

		                                     <cfif defendingcount lt challengingcount >
                                                <cfcontinue>
                                             <cfelse> <!---challenging wins--->

                                                <cfset ArrayDelete(pidArray, defendingPID ) > <!---remove from email notif list--->
                                                <cfset ArrayDelete(countArrPid, defendingPID ) > <!---remove from eform counter--->
                                                <cfset ArrayDelete(countArrPending, defendingPID ) >

                                                <cfquery name="dQ" datasource="#session.global_dsn#" >
                                                    DELETE FROM EGINAPPROVERDETAILS
                                                     WHERE ROUTERIDFK = '#routerdetailsid#' AND APPROVERORDER = #APPROVERORDER#
                                                           AND PERSONNELIDNO = '#defendingPID#'
                                                </cfquery>

                                             </cfif>


										</cfif>
										<!---end check if approver order exists--->

										<cfset instanceApproverDetails = EntityNew("EGINAPPROVERDETAILS") >
										<cfset approverdetailsid = createuuid() >
										<cfset instanceApproverDetails.setAPPROVERDETAILSID(approverdetailsid) >
										<cfset instanceApproverDetails.setAPPROVERSIDFK(APPROVERSID) >
										<cfset instanceApproverDetails.setROUTERIDFK(routerdetailsid) >
										<cfset instanceApproverDetails.setAPPROVERORDER(APPROVERORDER) >
										<cfset instanceApproverDetails.setAPPROVERNAME(APPROVERNAME) >
										<cfset instanceApproverDetails.setCANVIEWROUTEMAP(CANVIEWROUTEMAP) >
										<cfset instanceApproverDetails.setCANOVERRIDE(CANOVERRIDE) >
										<cfset instanceApproverDetails.setPERSONNELIDNO(pidIndex) >
										<cfset instanceApproverDetails.setCONDITIONBELOW(CONDITIONBELOW) >
										<cfset instanceApproverDetails.setISREAD("false") >


										<cfif CANOVERRIDE eq "true" OR CANOVERRIDEB eq "true" OR  ROUTERORDER eq 1 OR CANOVERRIDE eq "YES" OR CANOVERRIDEB eq "YES" >
											<!---those who will receive the eform first--->
											<cfset instanceApproverDetails.setDATESTARTED("#dateformat(now(), 'YYYY-MM-DD')# #timeformat(now(), 'HH:MM:SS')#") >
											<cfset instanceApproverDetails.setACTION("CURRENT") >

											<!---update counter, no need to delete on error--->


											<cfif AUTOAPPROVE neq "true" >
												<cfset ArrayAppend(countArrPid, pidIndex ) >

												<cfif routerIndex.getNOTIFYORIGINATOR() eq "true">
													<cfset ArrayAppend(pidArray, pidIndex) >
												</cfif>
											</cfif> <!---end AUTOAPPROVE--->

										<cfelse>
											<cfset instanceApproverDetails.setACTION("PENDING") >
											<cfset ArrayAppend(countArrPending, pidIndex ) >
										</cfif>

										<cfif AUTOAPPROVE eq "true" >
											<cfset instanceApproverDetails.setDATESTARTED("#dateformat(now(), 'YYYY-MM-DD')# #timeformat(now(), 'HH:MM:SS')#") >
											<cfset instanceApproverDetails.setACTION("IGNORED") >
											<cfset instanceApproverDetails.setDATEACTIONWASDONE("#dateformat(now(), 'YYYY-MM-DD')# #timeformat(now(), 'HH:MM:SS')#") >
											<cfset instanceApproverDetails.setISREAD("false") >
										<cfelse>

										</cfif>

										<cfset EntitySave(instanceApproverDetails) >
										<cfset ormflush()>



										<cfbreak>
									<cfelse>
									</cfif><!---end pidExist--->


							</cfloop> <!---end PERSONNELIDNO--->
								<cfset ArrayClear(PERSONNELIDNO) >
							 <!---end approver instantiation--->




					</cfloop> <!---end formApproversData--->

					<cfset moreemailcopy = routerIndex.getMOREEMAILADD() >


				</cfloop> <!---end formRouterData--->



			</cfloop> <!---end formProcessData--->

			<!---batch count updater--->
			<cfloop array="#countArrPid#" index="countIndex" >
				<cfinvoke component="routing" method="updateFormCount" eformid="#eformid#" personnelidno="#countIndex#" theType="updateornew">
	  		</cfloop>
			<!---end batch count updater--->

			<cfloop array="#countArrPending#" index="countPendingIndex" >
				<cfinvoke component="routing" method="updateFormCount" eformid="#eformid#" personnelidno="#countPendingIndex#" theType="pendingadded">
			</cfloop>

			<!---update eform table status--->
			<cfinvoke component="routing" method="getDatasourceCF" tablelevel="#theLevel#" returnvariable="theLevel" >


			<cfset datetimenow = '#dateformat(now(), "YYYY-MM-DD")# #timeformat(now(), "HH:MM:SS")#' >

			<cfquery name="updateFormTable" datasource="#theLevel#" >
				UPDATE #thetable#
				   SET APPROVED          = <cfqueryparam cfsqltype="cf_sql_varchar"   value="S" >,
				       DATEACTIONWASDONE = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#datetimenow#" >,
					   DATELASTUPDATE    = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#datetimenow#" >
			     WHERE PROCESSID 		 = <cfqueryparam cfsqltype="cf_sql_varchar"   value="#newprocessid#" > AND
				       EFORMID 			 = <cfqueryparam cfsqltype="cf_sql_varchar"   value="#eformid#" >
			</cfquery>

			<cfset countTable = EntityNew("EGINEFORMTABLE") >
			<cfset countTable.setPROCESSIDFK(newprocessid) >
			<cfset countTable.setEFORMIDFK(eformid) >
			<cfset EntitySave(countTable) >
			<cfset ormflush() >

			<!---should be 100% error free--->
			<!---notify next approvers which is this approver(s)--->
			<cfif ArrayLen(pidArray) gt 0>

				<cfinvoke 	method			="notifyNextApprovers"
							component		="email"
						  	returnvariable	="resultemail"
						  	pidArray		="#pidArray#"
						    eformid			="#eformid#"
						  	processid		="#newprocessid#"
						    extraRecipients	="#moreemailcopy#"
						    status			="PENDING"
						    >

				<cfset subcomdsn = session.subco_dsn >
				<cfset querydsn = session.query_dsn >
				<cfset transactiondsn = session.transaction_dsn >
				<cfset sitedsn = session.site_dsn >

				<!---this is for make schedule for next approvers--->
				<cfset freqinhours = freqArray[1]*60*60 > <!---in seconds--->
				<cfset freqinhours = NumberFormat(freqinhours, "0") >
				<cfset endDateB    = expirArray[1] >
				<cfset therouterdetailsid = therouterdetailsid[1] >

				<!---make schedule for process--->
				<cfset endDate = dateadd("d",EFORMLIFE,now()) >
				<cfschedule
					action      	 = "update"
				    task        	 = "process#newprocessid#"
					operation   	 = "HTTPRequest"
					interval    	 = "daily"
					startdate   	 = "#dateformat(now(), 'mm/dd/yy')#"
					starttime   	 = "#timeformat(now(), 'short')#"
					url        	 	 = "#session.domain#myapps/form/simulator/scheduler/schedule.cfm?eformid=#eformid#&processid=#newprocessid#&action=checkprocess&domain=#session.domain#&companydsn=#session.company_dsn#&globaldsn=#session.global_dsn#&companyname=#session.companyname#&subcomdsn=#subcomdsn#&querydsn=#querydsn#&transactiondsn=#transactiondsn#&sitedsn=#sitedsn#&dbsource=#theLevel#&tablename=#theTable#&pid=#session.chapa#&routerid=#therouterdetailsid#&maintable=#session.maintable#&mainpk=#session.mainpk#&dbms=#session.dbms#&ek=#session.ek#&websiteemailadd=#session.websiteemailadd#"
					enddate     	 = "#dateformat(endDate, 'mm/dd/yy')#"
				    endtime          = "#timeformat(dateadd( 'h',1,endDate ), 'short')#"
					requestTimeOut	 = "300"

				> <!---a schedule to check the process--->  <!---retryCount		 ="3" --->
				<!---end make schedule for process--->



				<!---make schedule for next approvers--->
				<cfschedule
					action      	 = "update"
				    task        	 = "router#newprocessid#"
					operation   	 = "HTTPRequest"
					interval    	 = "#freqinhours#"
					startdate   	 = "#dateformat(now(), 'mm/dd/yy')#"
					starttime   	 = "#timeformat(now(), 'short')#"
					enddate   	     = "#dateformat(endDateB, 'mm/dd/yy')#"
					url        	 	 = "#session.domain#myapps/form/simulator/scheduler/schedule.cfm?eformid=#eformid#&processid=#newprocessid#&action=followupemail&domain=#session.domain#&routerid=#therouterdetailsid#&companydsn=#session.company_dsn#&globaldsn=#session.global_dsn#&companyname=#session.companyname#&subcomdsn=#subcomdsn#&querydsn=#querydsn#&transactiondsn=#transactiondsn#&sitedsn=#sitedsn#&maintable=#session.maintable#&mainpk=#session.mainpk#&dbms=#session.dbms#&ek=#session.ek#&websiteemailadd=#session.websiteemailadd#"
					requestTimeOut	 = "300"

				>
				<!---end make schedule for next approvers--->
				<!---retryCount = "3" 		cf10 or above only--->
			</cfif>
			<!---end notifications --->

			<!---execute after routing single form--->

			<cfif ONAFTERROUTE neq "NA" AND trim(ONAFTERROUTE) neq "">
				<cfinclude template="../fielddefinition/oncomplete/#ONAFTERROUTE#" >
			</cfif>

			<!---end after routing--->

			<cfreturn "success" >

			<cfcatch>

				<cftry>
					<cfquery name="rollbackProcessDetails" datasource="#session.global_dsn#" >
						DELETE FROM EGINFORMPROCESSDETAILS
						      WHERE PROCESSDETAILSID = '#newprocessid#'
					</cfquery>
				<cfcatch>
				</cfcatch>
				</cftry>

				<cftry>
					<cfset processDataB = EntityLoad("EGINROUTERDETAILS", {PROCESSIDFK=#newprocessid#}, false ) >
					<cfloop array='#processDataB#' index='routerI' >
						<cfquery name="rollbackApproversDetails" datasource="#session.global_dsn#" >
							DELETE FROM EGINAPPROVERDETAILS
							      WHERE ROUTERIDFK = '#routerI.getROUTERDETAILSID()#'
						</cfquery>
					</cfloop>
				<cfcatch>
				</cfcatch>
				</cftry>

				<cftry>
					<cfquery name="rollbackRouterDetails" datasource="#session.global_dsn#" >
						DELETE FROM EGINROUTERDETAILS
						      WHERE PROCESSIDFK = '#newprocessid#'
					</cfquery>
				<cfcatch>
				</cfcatch>
				</cftry>

				<cftry>
					<cfset datetimenow = '#dateformat(now(), "YYYY-MM-DD")# #timeformat(now(), "HH:MM:SS")#' >
					<cfquery name="updateFormTable" datasource="#theLevel#" >
						UPDATE #thetable#
						   SET APPROVED          = <cfqueryparam cfsqltype="cf_sql_varchar" 	value="N" >,
						       DATEACTIONWASDONE = <cfqueryparam cfsqltype="cf_sql_timestamp" 	value="#datetimenow#" >,
							   DATELASTUPDATE    = <cfqueryparam cfsqltype="cf_sql_timestamp" 	value="#datetimenow#" >
					     WHERE PROCESSID 		 = <cfqueryparam cfsqltype="cf_sql_varchar" 	value="#newprocessid#" > AND
						       EFORMID 			 = <cfqueryparam cfsqltype="cf_sql_varchar" 	value="#eformid#" >
					</cfquery>
				<cfcatch>
				</cfcatch>
				</cftry>
				<cflog file="eFormRouting" text="#cfcatch.detail#, #cfcatch.message#"  >
				<cfreturn cfcatch.detail & ' - ' & cfcatch.message >
			</cfcatch>
		</cftry>

	</cffunction>
	<!---end route--->









	<cffunction name="generateMap" ExtDirect="true" >
	<cfargument name="eformid" >
	<cfargument name="processID" >
	<cfargument name="pidno" >
	<cfargument name="theLevel" >
	<cfargument name="theTable" >

	<cfset argStruct = StructNew() >
	<cfset argStruct.eformid = eformid >
	<cfset argStruct.processID = processID >
	<cfset argStruct.personnelidno = pidno >
	<cfset argStruct.theLevel = theLevel >
	<cfset argStruct.theTable = theTable >

	<cftry>

	<!---perform first auto fixing the map : used when there are unnecessary noise on the map--->
		<!---a. Select the process using the process ID
		b. In this process, loop over the routers
		c. In that routers, loop over the approvers
		Concerns:
		1. If the last router is done -- others should no longer active
		2. If router approvers is done -- router status is done and the following router is either done or currents
		3. If the router is done -- its approver/s is done and the following router/s is either done or current
		4. If the router is auto approve -- its approvers are done
		--->
		<cfinvoke 	method		="fixProcess"
				 	component	="cleanup"
				    returnvariable="resultCleanup"
				    argumentcollection="#argStruct#"

					>

	<!---end map auto fixing--->

	<cfset  xr1 = 300 >
	<cfset  yr1 = 120 >

	<cfset  xr2 = 800 >
	<cfset  yr2 = 120 >
	<cfset  yr2b = 120 >

	<cfset TOTALROUTERS = 0 >
	<cfset MAXIMUMAPPROVERS = 1 >
	<cfset routerHeight = 0 >

		<cfset formProcessData = EntityLoad("EGINFORMPROCESSDETAILS", #processID#) >
		<cfloop array="#formProcessData#" index="processIndex" >
			<cfset PROCESSDETAILSID     = processIndex.getPROCESSDETAILSID() >
			<cfset PROCESSIDFK     = processIndex.getPROCESSIDFK() >
			<cfset EFORMLIFE     = processIndex.getEFORMLIFE() >
			<cfset EXPIREDACTION = processIndex.getEXPIREDACTION() >
			<cfset PROCESSNAME   = processIndex.getPROCESSNAME() >
			<cfset RECDATECREATED   = processIndex.getRECDATECREATED() >



			<cfset formRouterData = EntityLoad("EGINROUTERDETAILS", {PROCESSIDFK = #processID#}, "ROUTERORDER ASC") >
			<cfset TOTALROUTERS = ArrayLen(formRouterData) >


			<cfset routerDefinitions = ArrayNew(1) >
			<cfset cntr = 1 >
			<cfset approverDefinitions = ArrayNew(1) >
			<cfset acntr = 1 >
			<cfloop array="#formRouterData#" index="routerIndex" >
				<cfset ROUTERDETAILSID = routerIndex.getROUTERDETAILSID() >
				<cfset ROUTERIDFK = routerIndex.getROUTERIDFK() >
				<cfset EXPIRATIONDATE = routerIndex.getEXPIRATIONDATE() >
				<cfset APPROVEATLEAST = routerIndex.getAPPROVEATLEAST() >
				<cfset AUTOAPPROVE = routerIndex.getAUTOAPPROVE() >
				<cfset ROUTERORDER = routerIndex.getROUTERORDER() >
				<cfset ISLASTROUTER = routerIndex.getISLASTROUTER() >
				<cfset CANOVERRIDE = routerIndex.getCANOVERRIDE() >
				<cfset USECONDITIONS = routerIndex.getUSECONDITIONS() >
				<cfset STATUS = routerIndex.getSTATUS() >
				<cfset DATELASTUPDATEA = routerIndex.getDATELASTUPDATE() >
				<cfset MAXA =  routerIndex.getMAXIMUMAPPROVERS() >

				<cfif not isdefined("DATELASTUPDATEA") >
					<cfset DATELASTUPDATEA = "" >
				</cfif>

				<cfif not isdefined("STATUS") >
					<cfset STATUS = 'PENDING' >
				</cfif>

				<cfif isdefined("RECDATECREATED") >
					<cfif ArrayLen(formRouterData) eq routerIndex.getROUTERORDER() > <!---is process complete--->
						<cfif routerIndex.getSTATUS() eq "APPROVED" OR routerIndex.getSTATUS() eq "IGNORED" OR routerIndex.getSTATUS() eq "DISAPPROVED" >
							<cfset elapsedOrig = dateformat(routerIndex.getDATELASTUPDATE(), 'MM/DD/YYYY') & ' ' & timeformat(routerIndex.getDATELASTUPDATE(), "short")  >
						<cfelse>
							<cfset elapsedOrig = datetimetoago(RECDATECREATED) >
						</cfif>
					<cfelse>
						<cfset elapsedOrig = datetimetoago(RECDATECREATED) >
					</cfif>
				<cfelse>
					<cfset elapsedOrig = "" >
					<cfset RECDATECREATED = "" >
				</cfif>


				<cfif USECONDITIONS EQ "true" >
					<cfset APPROVEATLEAST = "Condition(s) applied" >
				<cfelse>
					<cfset APPROVEATLEAST = "Approve at least: #APPROVEATLEAST#" >
				</cfif>

				<cfif cntr  EQ 1 >
				<cfloop array="#formRouterData#" index="routerIndexTemp" >
					<cfset formApproversDataT = EntityLoad("EGINAPPROVERDETAILS", {ROUTERIDFK =#routerIndexTemp.getROUTERDETAILSID()#}, "APPROVERORDER ASC" ) >
					<cfif ArrayLen(formApproversDataT) GT  MAXIMUMAPPROVERS>
						<cfset MAXIMUMAPPROVERS = ArrayLen(formApproversDataT) >
					</cfif> <!---end formApproversData--->
				</cfloop>
				</cfif>

				<cfif pidno neq session.chapa > <!---For approvers. Check if can view route map--->
					<cfset canviewMap = EntityLoad("EGINAPPROVERDETAILS", {ROUTERIDFK =#routerIndex.getROUTERDETAILSID()#, PERSONNELIDNO=#session.chapa#}, "APPROVERORDER ASC" ) >
					<cfloop array="#canviewMap#" index="canviewIndex" >
						<cfset canviewroutemapCheck = canviewIndex.getCANVIEWROUTEMAP() >
						<cfif canviewroutemapCheck eq "false" >
							<cfreturn "cannotviewroutemap" >
						</cfif>
					</cfloop>
				</cfif>




				<cfset formApproversData = EntityLoad("EGINAPPROVERDETAILS", {ROUTERIDFK =#routerIndex.getROUTERDETAILSID()#}, "APPROVERORDER ASC" ) >



				<cfloop array="#formApproversData#" index="approverIndex" >
					<cfset APPROVERDETAILSID = approverIndex.getAPPROVERDETAILSID() >
					<cfset APPROVERSIDFK = approverIndex.getAPPROVERSIDFK() >
					<cfset APPROVERORDER = approverIndex.getAPPROVERORDER() >
					<cfset APPROVERNAME = approverIndex.getAPPROVERNAME() >
					<cfset CANVIEWROUTEMAP = approverIndex.getCANVIEWROUTEMAP() >
					<cfset CANOVERRIDE = approverIndex.getCANOVERRIDE() >
					<cfset PERSONNELIDNO = approverIndex.getPERSONNELIDNO() >
					<cfset CONDITIONBELOW = approverIndex.getCONDITIONBELOW() >
					<cfset DATESTARTED = approverIndex.getDATESTARTED() >
					<cfset ACTION = approverIndex.getACTION() >
					<cfset ISREAD = approverIndex.getISREAD() >
					<cfset DATELASTUPDATE = approverIndex.getDATELASTUPDATE() >

					<cfif isdefined("DATELASTUPDATE") >
						<cfset DATELASTUPDATE = dateformat(DATELASTUPDATE, 'MM/DD/YYYY') & ' ' & timeformat(DATELASTUPDATE, "short")  >
					<cfelse>
						<cfset DATELASTUPDATE = "" >
					</cfif>

					<cfif not isdefined("ACTION") >
						<cfset ACTION = "PENDING" >
					</cfif>

					<cfif isdefined("DATESTARTED") >
						<cfset elapsedtimeapprover = datetimetoago(DATESTARTED) >
						<cfset DATESTARTED = dateformat(DATESTARTED, "MM/DD/YYYY") & ' ' & timeformat(DATESTARTED, "short") >
					<cfelse>
						<cfset elapsedtimeapprover = "" >
						<cfset DATESTARTED = "" >
					</cfif>




					<cfif AUTOAPPROVE  EQ "true">
						<cfset arrowcolor = "black" >
						<cfset elapsedtimeapprover = DATELASTUPDATE >
					<cfelse>
						<cfif approverIndex.getCANOVERRIDE() EQ "true" OR routerIndex.getCANOVERRIDE() >
							<cfset arrowcolor = "blue" >
						<cfelse>
							<cfset arrowcolor = "##79BB3F" >
						</cfif>

					</cfif>

					<cfif ACTION eq "APPROVED" OR ACTION eq "IGNORED" OR ACTION eq "DISAPPROVED" OR ACTION eq "TIMEDOUT">
						<cfset arrowcolor = "black" >
						<cfset elapsedtimeapprover =  dateformat(DATELASTUPDATE, "MM/DD/YYYY") & ' ' & timeformat(DATELASTUPDATE, "short") >
					</cfif>

					<cfif USECONDITIONS EQ "true" >
						<cfif arraylen(formApproversData) eq APPROVERORDER >
							<cfset CONDITIONBELOW = "" >
						</cfif>
					<cfelse>
						<cfset CONDITIONBELOW = "" >
					</cfif>

					<cfquery name="getPersonal" datasource="#session.company_dsn#" maxrows="1" >
						SELECT A.FIRSTNAME AS FIRSTNAME,
							   A.LASTNAME AS LASTNAME,
							   A.MIDDLENAME AS MIDDLENAME,
							   B.AVATAR AS AVATAR,
							   C.DESCRIPTION AS POSITION,
							   D.DESCRIPTION AS DEPARTMENT
						  FROM #session.maintable# A LEFT JOIN ECRGMYIBOSE B ON (A.PERSONNELIDNO=B.PERSONNELIDNO)
						               LEFT JOIN CLKPOSITION C  ON (A.POSITIONCODE=C.POSITIONCODE)
						               LEFT JOIN CLKDEPARTMENT D ON (A.DEPARTMENTCODE=D.DEPARTMENTCODE)
						 WHERE A.#session.mainpk# = '#PERSONNELIDNO#'
					</cfquery>

					<cfset thename = getPersonal.FIRSTNAME & ' ' & getPersonal.MIDDLENAME & ' ' & getPersonal.LASTNAME >
					<cfset theposition = getPersonal.POSITION >
					<cfset thedepartment = getPersonal.DEPARTMENT >
					<cfset theavatar = "./resource/image/pics201/#lcase(session.companycode)#/#getPersonal.AVATAR#" >
					<cfif trim(thename) eq "" >
						<cfset thename = "(no name)" >
					</cfif>
					<cfif trim(theposition) eq "" >
						<cfset theposition = "(no position)" >
					</cfif>
					<cfif trim(thedepartment) eq "" >
						<cfset thedepartment = "(no department)" >
					</cfif>
					<cfif trim(theavatar) eq "" >
						<cfset theavatar = "./myapps/form/view/unknownsmile.png" >
					</cfif>

					<cfquery name="getPersonalOrig" datasource="#session.company_dsn#" maxrows="1" >
						SELECT A.FIRSTNAME AS FIRSTNAME,
							   A.LASTNAME AS LASTNAME,
							   A.MIDDLENAME AS MIDDLENAME,
							   B.AVATAR AS AVATAR,
							   C.DESCRIPTION AS POSITION,
							   D.DESCRIPTION AS DEPARTMENT
						  FROM #session.maintable# A LEFT JOIN ECRGMYIBOSE B ON (A.PERSONNELIDNO=B.PERSONNELIDNO)
						               LEFT JOIN CLKPOSITION C  ON (A.POSITIONCODE=C.POSITIONCODE)
						               LEFT JOIN CLKDEPARTMENT D ON (A.DEPARTMENTCODE=D.DEPARTMENTCODE)
						 WHERE A.#session.mainpk# = '#pidno#'
					</cfquery>

					<cfset thenameO = getPersonalOrig.FIRSTNAME & ' ' & getPersonalOrig.MIDDLENAME & ' ' & getPersonalOrig.LASTNAME >
					<cfset thepositionO = getPersonalOrig.POSITION >
					<cfset thedepartmentO = getPersonalOrig.DEPARTMENT >

					<cfset theavatarO = "./resource/image/pics201/#lcase(session.companycode)#/#getPersonalOrig.AVATAR#" >
					<cfif trim(thenameO) eq "" >
						<cfset thenameO = "(no name)" >
					</cfif>
					<cfif trim(thepositionO) eq "" >
						<cfset thepositionO = "(no position)" >
					</cfif>
					<cfif trim(thedepartmentO) eq "" >
						<cfset thedepartmentO = "(no department)" >
					</cfif>
					<cfif trim(theavatarO) eq "" >
						<cfset theavatarO = "./myapps/form/view/unknownsmile.png" >
					</cfif>

					<cfset approverDefinitions[acntr] = "{
													        type: 'image',
													        name: '#PERSONNELIDNO#',
													        src: '#theavatar#',
													        width: 106,
													        height: 106,
													        x: #xr2-270#,
													        y: #yr2b+20#
													    },{
													        type: 'path',
													        fill: '#arrowcolor#',
													        path: 'M#xr2-160# #yr2b+72# L#xr2-40# #yr2b+72# L#xr2-40# #yr2b+62# L#xr2-10# #yr2b+77# L#xr2-40# #yr2b+92# L#xr2-40# #yr2b+82# L#xr2-160# #yr2b+82# Z'
													    },{
													        type: 'path',
													        fill: '#arrowcolor#',
													        path:  'M#xr2-440# #yr2b+72# L#xr2-320# #yr2b+72# L#xr2-320# #yr2b+62# L#xr2-290# #yr2b+77# L#xr2-320# #yr2b+92# L#xr2-320# #yr2b+82# L#xr2-440# #yr2b+82# Z'
													    },{
													        type: 'text',
													        text: '#thename#',
													        fill: '#arrowcolor#',
													        font: '12px arial',
													        x: #xr2-270#,
													        y: #yr2b+140#
													    },{
													        type: 'text',
													        text: '#theposition#',
													        fill: '#arrowcolor#',
													        font: '12px arial',
													        x: #xr2-270#,
													        y: #yr2b+155#
													    },{
													        type: 'text',
													        text: '#thedepartment#',
													        fill: '#arrowcolor#',
													        font: '12px arial',
													        x: #xr2-270#,
													        y: #yr2b+170#
													    },{
													        type: 'text',
													        text: '#ACTION#',
													        fill: '#arrowcolor#',
													        font: '12px arial',
													        x: #xr2-270#,
													        y: #yr2b+10#
													    },{
													        type: 'text',
													        text: '#DATESTARTED#',
													        fill: '#arrowcolor#',
													        font: '12px arial',
													        x: #xr2-160#,
													        y: #yr2b+40#
													    },{
													        type: 'text',
													        text: '#elapsedtimeapprover#',
													        fill: '#arrowcolor#',
													        font: '12px arial',
													        x: #xr2-160#,
													        y: #yr2b+55#
													    },{
													    	type: 'text',
													    	text: '#CONDITIONBELOW#',
													    	fill: '#arrowcolor#',
													        font: '20px arial',
													        x: #xr2-50#,
													        y: #yr2b+180#
													    }" >

				<cfset yr2b = yr2b + 200 >
				<cfset acntr = acntr + 1 >
				</cfloop> <!---end formApproversData--->


				<cfset routerHeight  = 200*MAXIMUMAPPROVERS >
				<cfif AUTOAPPROVE EQ "true" >
					<cfset routercolor = "black" >
					<cfset STATUS = "IGNORED" >

				<cfelse>
					<cfif routerIndex.getCANOVERRIDE()  EQ "true" >
						<cfset routercolor = "blue" >
					<cfelse>
						<cfset routercolor = "##79BB3F" >
					</cfif>
				</cfif>

				<cfif STATUS eq 'APPROVED' OR STATUS eq 'DISAPPROVED' OR STATUS eq 'IGNORED'>
					<cfset routercolor = "black" >
					<cfset datedone = "#dateFormat(DATELASTUPDATEA, "MM/DD/YYYY")# #timeformat(DATELASTUPDATEA, "short")#" >
				<cfelse>
					<cfset datedone = "" >
				</cfif>

				<cfset routerDefinitions[cntr] = "{
									        type: 'rect',
									        height: #routerHeight#,
									        width: 50,
									        fill: '#routercolor#',
									        stroke: 'white',
									        'stroke-width': 2,
									        x: #xr2#,
									        y: #yr2#

									    },{
									        type: 'text',
									        text: '#ROUTERORDER#',
									        fill: 'black',
									        font: '14px arial',
									        x: #xr2#,
									        y: #yr2-70#
									    },{
									        type: 'text',
									        text: 'Until: #dateFormat(EXPIRATIONDATE, "MM/DD/YYYY")# #timeformat(EXPIRATIONDATE, "short")# ',
									        fill: 'black',
									        font: '12px arial',
									        x: #xr2#,
									        y: #yr2-55#
									    },{
									        type: 'text',
									        text: 'Date Done: #datedone#',
									        fill: 'black',
									        font: '12px arial',
									        x: #xr2#,
									        y: #yr2-40#
									    },{
									        type: 'text',
									        text: '#APPROVEATLEAST#',
									        fill: 'black',
									        font: '12px arial',
									        x: #xr2#,
									        y: #yr2-25#
									    },{
									        type: 'text',
									        text: 'Status: #STATUS#',
									        fill: 'black',
									        font: '12px arial',
									        x: #xr2#,
									        y: #yr2-10#
									    }" >

			<cfset xr2 = xr2 + 500 >


			<cfset cntr = cntr + 1 >

			<cfset  yr2 = 120 >
			<cfset  yr2b = 120 >
			</cfloop> <!---end formRouterData--->
			<cfset  xr2 = 800 >
			<cfset  yr2 = 120 >
			<cfset  yr2b = 120 >

			<cfset processWidth  =  500 + (500*TOTALROUTERS) >
			<cfset processHeight = 200+(200*MAXIMUMAPPROVERS) >

			<cfset endDate = dateadd("d",EFORMLIFE,now()) >
			<cfset endDate = dateformat(endDate, "MM/DD/YYYY") >

			<cfset processTitle = "{
								        type: 'text',
								        text: '#PROCESSNAME# | #EXPIREDACTION# on #endDate#',
								        fill: 'green',
								        font: '14px arial',
								        x: 5,
								        y: 15
								    }" >

			<cfset legend =       "{
							        type: 'rect',
							        height: 10,
							        width: 50,
							        fill: 'black',
							        stroke: 'white',
							        'stroke-width': 2,
							        x: 500,
							        y: 2

							    },{
							        type: 'rect',
							        height: 10,
							        width: 50,
							        fill: 'green',
							        stroke: 'white',
							        'stroke-width': 2,
							        x: 700,
							        y: 2

							    },{
							        type: 'rect',
							        height: 10,
							        width: 50,
							        fill: 'blue',
							        stroke: 'white',
							        'stroke-width': 2,
							        x: 500,
							        y: 15

							    },{
							        type: 'rect',
							        height: 10,
							        width: 50,
							        fill: 'yellow',
							        stroke: 'white',
							        'stroke-width': 2,
							        x: 700,
							        y: 15

							    },{
								        type: 'text',
								        text: '(Auto) Approve',
								        fill: 'black',
								        font: '12px arial',
								        x: 560,
								        y: 10
								   },{
								        type: 'text',
								        text: 'Cannot Override',
								        fill: 'black',
								        font: '12px arial',
								        x: 760,
								        y: 10
								   },{
								        type: 'text',
								        text: 'Can Override',
								        fill: 'black',
								        font: '12px arial',
								        x: 560,
								        y: 22
								   },{
								        type: 'text',
								        text: 'Originator',
								        fill: 'black',
								        font: '12px arial',
								        x: 760,
								        y: 22
								   }" >




		</cfloop> <!---end formProcessData--->

		<cfset routerDraw = "" >
		<cfif isdefined("routerDefinitions") >
			<cfif ArrayLen(routerDefinitions) GT 0 >
				<cfset routerDraw = ArrayToList(routerDefinitions, ',') >
			<cfelse>
				<cfset routerDraw = "{
								        type: 'text',
								        text: 'No router',
								        fill: 'green',
								        font: '14px arial',
								        x: 5,
								        y: 45
								    }" >
			</cfif>
		<cfelse>
				<cfset routerDraw = "{
								        type: 'text',
								        text: 'No router',
								        fill: 'green',
								        font: '14px arial',
								        x: 5,
								        y: 45
								    }" >
		</cfif>

		<cfset approverDraw = "" >
		<cfif isdefined("approverDefinitions") >
			<cfif ArrayLen(approverDefinitions) GT 0 >
				<cfset approverDraw = ArrayToList(approverDefinitions,',') >
			<cfelse>
			</cfif>
		<cfelse>

		</cfif>

		<cfif TOTALROUTERS EQ 0 >
			<cfset originator = "{
								        type: 'text',
								        text: '0',
								        fill: 'black',
								        font: '14px arial',
								        x: #xr1#,
								        y: #yr1-70#
								    }" >
		<cfelse>

			<cfset originator = "{
							        type: 'rect',
							        height: #routerHeight#,
							        width: 50,
							        fill: 'yellow',
							        stroke: 'white',
							        'stroke-width': 2,
							        x: #xr1#,
							        y: #yr1#

							    },{
							        type: 'text',
							        text: '0',
							        fill: 'black',
							        font: '14px arial',
							        x: #xr1#,
							        y: #yr1-70#
							    },{
							        type: 'text',
							        text: '',
							        fill: 'black',
							        font: '12px arial',
							        x: #xr1#,
							        y: #yr1-55#
							    },{
							        type: 'text',
							        text: '',
							        fill: 'black',
							        font: '12px arial',
							        x: #xr1#,
							        y: #yr1-40#
							    },{
							        type: 'text',
							        text: '',
							        fill: 'black',
							        font: '12px arial',
							        x: #xr1#,
							        y: #yr1-25#
							    },{
							        type: 'text',
							        text: '',
							        fill: 'black',
							        font: '12px arial',
							        x: #xr1#,
							        y: #yr1-10#
							    },{
							        type: 'image',
							        name: 'Originator',
							        src: '#theavatarO#',
							        width: 106,
							        height: 106,
							        x: #xr1-270#,
							        y: #yr1+20#
							    },{
							        type: 'path',
							        fill: 'black',
							        path: 'M#xr1-160# #yr1+72# L#xr1-40# #yr1+72# L#xr1-40# #yr1+62# L#xr1-10# #yr1+77# L#xr1-40# #yr1+92# L#xr1-40# #yr1+82# L#xr1-160# #yr1+82# Z'
							    },{
							        type: 'text',
							        text: '#thenameO#',
							        fill: 'black',
							        font: '12px arial',
							        x: #xr1-270#,
							        y: #yr1+140#
							    },{
							        type: 'text',
							        text: '#thepositionO#',
							        fill: 'black',
							        font: '12px arial',
							        x: #xr1-270#,
							        y: #yr1+155#
							    },{
							        type: 'text',
							        text: '#thedepartmentO#',
							        fill: 'black',
							        font: '12px arial',
							        x: #xr1-270#,
							        y: #yr1+170#
							    },{
							        type: 'text',
							        text: 'ORIGINATOR',
							        fill: 'black',
							        font: '12px arial',
							        x: #xr1-270#,
							        y: #yr1+10#
						    },{
						        type: 'text',
						        text: '#dateformat(RECDATECREATED, "MM/DD/YYY")# #timeformat(RECDATECREATED, "short")#',
						        fill: 'black',
						        font: '12px arial',
						        x: #xr1-160#,
						        y: #yr1+40#
						    },{
						        type: 'text',
						        text: '#elapsedOrig#',
						        fill: 'black',
						        font: '12px arial',
						        x: #xr1-160#,
						        y: #yr1+55#
						    }" >

	 </cfif>

<cfset theScript = "Ext.create('Ext.window.Window',{
			closable: true,
			autoShow: true,
			autoDestroy: true,
		    height: '100%',
		    width: '100%',
		    layout: 'fit',
			items: [{
				xtype: 'panel',
				layout: {
					type: 'vbox',
					align: 'left'
				},
				autoScroll: true,
				name: 'paneldrawpanelwin',
				title: 'eForm Status',
				items: [{
			        xtype: 'draw',
					width: #processWidth#,
					height: #processHeight#,
					autoShow: true,
					viewBox: false,
					items: [
						#legend#,
						#originator#,
						#processTitle#,
						#routerDraw#,
						#approverDraw#
					]
			    }]

		  }]


});">

	 <cfreturn theScript >
<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message >
</cfcatch>
</cftry>
</cffunction>


<cffunction name="datetimetoago" access="public" returntype="String" >
<cfargument name="thedatetime" >
<!---convert time to words--->
<cfset thedate = "#dateformat(thedatetime, "YYYY-MM-DD")# #timeformat(thedatetime, "HH:MM:SS")#" />

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