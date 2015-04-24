<cfcomponent name="data" ExtDirect="true">

	<cffunction name="startRoute" ExtDirect="true">  
		<cfargument name="eformid" >   
		<cfargument name="newprocessid" > 
		<cfargument name="theLevel" >
		<cfargument name="thetable" >
		
		
		<cftry>
			
			<cfset formFlowProcess = ORMExecuteQuery("SELECT FORMFLOWPROCESS FROM EGRGEFORMS WHERE EFORMID = '#eformid#'", true ) >
			  
			<cfset formProcessData = EntityLoad("EGINFORMPROCESS", #formFlowProcess#) >
			<cfif ArrayLen(formProcessData) LT 1 >
				<cfreturn "formflowprocessismissing" >
			</cfif>
			
			<cfset pidArray = ArrayNew(1) > <!---pid for email notifications--->
			
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
					<cfset instanceProcessDetails.setPROCESSIDFK(PROCESSID) >
					<cfset instanceProcessDetails.setEFORMLIFE(EFORMLIFE) >
					<cfset instanceProcessDetails.setEXPIREDACTION(EXPIREDACTION) >
					<cfset instanceProcessDetails.setCOMPANYCODE(COMPANYCODE) >
					<cfset instanceProcessDetails.setGROUPNAME(GROUPNAME) >
					<cfset instanceProcessDetails.setPROCESSNAME(PROCESSNAME) >
					<cfset instanceProcessDetails.setDESCRIPTION(DESCRIPTION) >
					<cfset instanceProcessDetails.setRECDATECREATED(dateformat(now(), "YYYY-MM-DD") & ' ' & timeformat(now(), "HH:MM:SS")) > 
					<cfset instanceProcessDetails.setRECCREATEDBY(client.userid) >
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
								<cfquery name="getMyIS" datasource="#client.company_dsn#" maxrows="1">
									SELECT SUPERIORCODE 
									  FROM #client.maintable#
									 WHERE #client.mainpk# = '#client.chapa#'
								</cfquery>
								<cfif getMyIS.recordcount GT 0>
									<cfquery name="getISofMyIS" datasource="#client.company_dsn#" maxrows="1">
										SELECT #client.mainpk# AS PERSONNELIDNO
										  FROM #client.maintable#
										 WHERE #client.mainpk# = '#getMyIS.SUPERIORCODE#'
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
										<cfquery name="getMyIS" datasource="#client.company_dsn#" maxrows="1">
											SELECT SUPERIORCODE 
											  FROM #client.maintable#
											 WHERE #client.mainpk# = '#pid#'
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
								<cfquery name="getMyDeptCode" datasource="#client.company_dsn#" maxrows="1">
									SELECT DEPARTMENTCODE 
									  FROM #client.maintable#
									 WHERE #client.mainpk# = '#client.chapa#'
								</cfquery>
								<cfif getMyDeptCode.recordcount GT 0>
									<cfquery name="getApproversDeptCode" datasource="#client.company_dsn#">
										SELECT #client.mainpk# AS PID
										  FROM #client.maintable#
										 WHERE DEPARTMENTCODE = '#getMyDeptCode.DEPARTMENTCODE#' AND #client.mainpk# != '#client.chapa#' 
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
											<cfquery name="getMyDeptCode" datasource="#client.company_dsn#" maxrows="1">
												SELECT DEPARTMENTCODE 
												  FROM #client.maintable#
												 WHERE #client.mainpk# = '#pid#'
											</cfquery>
											<cfif getMyDeptCode.recordcount GT 0>
												<cfquery name="getApproversDeptCode" datasource="#client.company_dsn#">
													SELECT #client.mainpk# AS PID
													  FROM #client.maintable#
													 WHERE DEPARTMENTCODE = '#getMyDeptCode.DEPARTMENTCODE#' AND #client.mainpk# != '#pid#' 
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
							
						<cfelseif APPROVERNAME EQ "BACKTOSENDER"> 
							
							<!---get router order--->
							<cfif ROUTERORDER EQ "1" >
							 	<cfset PERSONNELIDNO = '#client.chapa#' >
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
							
							<cfset ArrayAppend(PERSONNELIDNO,client.chapa) > 
							
						<cfelseif APPROVERNAME EQ "USERROLE">
							
							<cfquery name="getRoleFromGroup" datasource="#client.global_dsn#">
								SELECT A.USERGRPMEMBERSIDX, B.USERID, B.GUID AS GUID
								  FROM EGRGROLEINDEX A LEFT JOIN EGRGUSERMASTER B ON (A.USERGRPMEMBERSIDX = B.USERID)
								 WHERE USERGRPID_FK = '#USERGRPID#'
							</cfquery>
							<cfif getRoleFromGroup.recordcount GT 0 >
								<cfloop query="getRoleFromGroup" >
									<cfquery name="getPIDfromMainTable" datasource="#client.company_dsn#" maxrows="1">
										SELECT #client.mainpk# AS PID
										  FROM #client.maintable#
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
							
						<cfelse>
							
						</cfif> <!---end APPROVERNAME--->
							
						<!---create an instance of this approver under the above instantiated router--->
							
							<cfloop array="#PERSONNELIDNO#" index="pidIndex" >    <!---prevent sending multiple eform for one user  ---> 
									<cfset pidExist = EntityLoad("EGINAPPROVERDETAILS", { ROUTERIDFK =#routerdetailsid#, PERSONNELIDNO = #pidIndex#}, "APPROVERORDER ASC" ) >
									<cfif ArrayLen(pidExist) LT 1 >
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
										
										
										<cfif CANOVERRIDE eq "true" OR CANOVERRIDEB eq "true" OR  ROUTERORDER eq 1 OR CANOVERRIDE eq "YES" OR CANOVERRIDEB eq "YES"> 
											<!---those who will receive the eform first--->
											<cfset instanceApproverDetails.setDATESTARTED("#dateformat(now(), 'YYYY-MM-DD')# #timeformat(now(), 'HH:MM:SS')#") >
											<cfset instanceApproverDetails.setACTION("CURRENT") >
											<!---update counter, no need to delete on error--->
											<cfif AUTOAPPROVE neq "true" >
												<cfset updateCount = EntityLoad("EGINEFORMCOUNT", { EFORMID =#eformid#, PERSONNELIDNO = #pidIndex#}, true ) >
												<cfif isdefined("updateCount") >	
													<cfset currentCount = updateCount.getNEW() + 1 >
													<cfset updateCount.setNEW(currentCount) >
												<cfelse>
													<cfset updateCount = EntityNew("EGINEFORMCOUNT") >
													<cfset updateCount.setNEW("1") >
													<cfset updateCount.setEFORMID(eformid) >
													<cfset updateCount.setPERSONNELIDNO(pidIndex) >
													<cfset updateCount.setPENDING("0") >
													<cfset updateCount.setRETURNED("0") >
												</cfif> 	
												<cfset EntitySave(updateCount) >  
												<cfset ormflush()> 
												
												<cfif routerIndex.getNOTIFYORIGINATOR() eq "true">
													<cfset ArrayAppend(pidArray, pidIndex) >
												</cfif> 
												
											
											</cfif> <!---end AUTOAPPROVE--->
										<cfelse>
											<cfset instanceApproverDetails.setACTION("PENDING") >
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
									</cfif> <!---end pidExist--->
										
									 	
							</cfloop> <!---end PERSONNELIDNO--->
								<cfset ArrayClear(PERSONNELIDNO) >
							 <!---end approver instantiation--->
						    
						    <!---update eform table status--->
						    <cfif theLevel eq "G" >
								<cfset theLevel = "#client.global_dsn#" >
							<cfelseif theLevel eq "C" >
								<cfset theLevel = "#client.company_dsn#" >			
							<cfelseif theLevel eq "S" >
								<cfset theLevel = "#client.subco_dsn#" >
							<cfelseif theLevel eq "Q" >
								<cfset theLevel = "#client.query_dsn#" >
							<cfelseif theLevel eq "T" >
								<cfset theLevel = "#client.transact_dsn#" >
							<cfelseif theLevel eq "SD" >
								<cfset theLevel = "#client.site_dsn#" >
							<cfelse>
								
							</cfif>
							
							<cfset datetimenow = '#dateformat(now(), "YYYY-MM-DD")# #timeformat(now(), "HH:MM:SS")#' >
							
							<cfquery name="updateFormTable" datasource="#theLevel#" >
								UPDATE #thetable#
								   SET APPROVED          = <cfqueryparam cfsqltype="cf_sql_varchar" value="S" >,
								       DATEACTIONWASDONE =  <cfqueryparam cfsqltype="cf_sql_timestamp" value="#datetimenow#" >,
									   DATELASTUPDATE    =  <cfqueryparam cfsqltype="cf_sql_timestamp" value="#datetimenow#" >
							     WHERE PROCESSID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#newprocessid#" > AND 
								       EFORMID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#eformid#" >
							</cfquery>
							
						
					</cfloop> <!---end formApproversData--->
					
					<cfset moreemailcopy = routerIndex.getMOREEMAILADD() >
					
				</cfloop> <!---end formRouterData--->
			
			</cfloop> <!---end formProcessData--->
			
			<cfset countTable = EntityNew("EGINEFORMTABLE") >
			<cfset countTable.setPROCESSIDFK(newprocessid) >
			<cfset countTable.setEFORMIDFK(eformid) >
			<cfset EntitySave(countTable) >   
			<cfset ormflush() >
			
			<!---should be 100% error free--->
			<!---notify next approvers which is this approver(s)---> 
			<cfif ArrayLen(pidArray) gt 0>
				
				<cfinvoke 	method="notifyNextApprovers" 
							component="email" 
						  	returnvariable="resultemail"  
						  	pidArray="#pidArray#" 
						    eformid="#eformid#"
						  	processid="#newprocessid#"
						    extraRecipients="#moreemailcopy#"
						    status="PENDING"
						    >
						    
				<cfset subcomdsn = client.subco_dsn >
				<cfset querydsn = client.query_dsn >
				<cfset transactiondsn = client.transaction_dsn >
				<cfset sitedsn = client.site_dsn >
				
				<!---this is for make schedule for next approvers--->
				<cfset freqinhours = freqArray[1]*60*60 > <!---in seconds--->
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
					url        	 	 = "#client.domain#myapps/form/simulator/schedule.cfm?eformid=#eformid#&processid=#newprocessid#&action=checkprocess&domain=#client.domain#&companydsn=#client.company_dsn#&globaldsn=#client.global_dsn#&companyname=#client.companyname#&subcomdsn=#subcomdsn#&querydsn=#querydsn#&transactiondsn=#transactiondsn#&sitedsn=#sitedsn#&dbsource=#theLevel#&tablename=#theTable#&pid=#client.chapa#&routerid=#therouterdetailsid#"  
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
					startdate   	 = "#dateformat(endDateB, 'mm/dd/yy')#" 
					starttime   	 = "#timeformat(endDateB, 'short')#"   
					url        	 	 = "#client.domain#myapps/form/simulator/schedule.cfm?eformid=#eformid#&processid=#newprocessid#&action=followupemail&domain=#client.domain#&routerid=#therouterdetailsid#&companydsn=#client.company_dsn#&globaldsn=#client.global_dsn#&companyname=#client.companyname#&subcomdsn=#subcomdsn#&querydsn=#querydsn#&transactiondsn=#transactiondsn#&sitedsn=#sitedsn#" 
					requestTimeOut	 = "300"  
					enddate     	 = "#dateformat(endDate, 'mm/dd/yy')#" 
				    endtime          = "#timeformat(dateadd( 'h',1,endDate ), 'short')#"   
					
				> 
				<!---end make schedule for next approvers--->
				<!---retryCount		 = "3" 		--->    
			</cfif> 
			<!---end notifications --->	
			
			
				 
			<cfreturn "success" >
			
			<cfcatch>
				<cftry>
					<cfquery name="rollbackProcessDetails" datasource="#client.global_dsn#" >
						DELETE FROM EGINFORMPROCESSDETAILS
						      WHERE PROCESSDETAILSID = '#newprocessid#'
					</cfquery>
				<cfcatch>
				</cfcatch>
				</cftry>
				
				<cftry>
					<cfset processDataB = EntityLoad("EGINROUTERDETAILS", {PROCESSIDFK=#newprocessid#}, false ) >
					<cfloop array='#processDataB#' index='routerI' >
						<cfquery name="rollbackApproversDetails" datasource="#client.global_dsn#" >
							DELETE FROM EGINAPPROVERDETAILS
							      WHERE ROUTERIDFK = '#routerI.getROUTERDETAILSID()#'
						</cfquery>
					</cfloop>
				<cfcatch>
				</cfcatch>
				</cftry>
				
				<cftry>
					<cfquery name="rollbackRouterDetails" datasource="#client.global_dsn#" >
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
						   SET APPROVED          = <cfqueryparam cfsqltype="cf_sql_varchar" value="N" >,
						       DATEACTIONWASDONE =  <cfqueryparam cfsqltype="cf_sql_timestamp" value="#datetimenow#" >,
							   DATELASTUPDATE    =  <cfqueryparam cfsqltype="cf_sql_timestamp" value="#datetimenow#" >
					     WHERE PROCESSID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#newprocessid#" > AND 
						       EFORMID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#eformid#" >
					</cfquery>
				<cfcatch>
				</cfcatch>
				</cftry>
				<cfreturn cfcatch.detail & ' - ' & cfcatch.message >
			</cfcatch>
		</cftry>
	
	</cffunction>
	
	
	
	
	
	
	
	
	  
			
	<cffunction name="generateMap" ExtDirect="true" >  
	<cfargument name="eformid" >
	<cfargument name="processID" >
	<cfargument name="pidno" >
	<cftry>
	
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
				
				<cfif pidno neq client.chapa > <!---For approvers. Check if can view route map--->
					<cfset canviewMap = EntityLoad("EGINAPPROVERDETAILS", {ROUTERIDFK =#routerIndex.getROUTERDETAILSID()#, PERSONNELIDNO=#client.chapa#}, "APPROVERORDER ASC" ) >
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
						
					<cfelse>
						<cfset CONDITIONBELOW = "" >
					</cfif> 
					
					<cfquery name="getPersonal" datasource="#client.company_dsn#" maxrows="1" >
						SELECT A.FIRSTNAME AS FIRSTNAME, 
							   A.LASTNAME AS LASTNAME, 
							   A.MIDDLENAME AS MIDDLENAME,
							   B.AVATAR AS AVATAR,
							   C.DESCRIPTION AS POSITION,
							   D.DESCRIPTION AS DEPARTMENT
						  FROM CMFPA A LEFT JOIN ECRGMYIBOSE B ON (A.PERSONNELIDNO=B.PERSONNELIDNO)
						               LEFT JOIN CLKPOSITION C  ON (A.POSITIONCODE=C.POSITIONCODE)
						               LEFT JOIN CLKDEPARTMENT D ON (A.DEPARTMENTCODE=D.DEPARTMENTCODE)
						 WHERE A.PERSONNELIDNO = '#PERSONNELIDNO#'
					</cfquery>
					
					<cfset thename = getPersonal.FIRSTNAME & ' ' & getPersonal.MIDDLENAME & ' ' & getPersonal.LASTNAME > 
					<cfset theposition = getPersonal.POSITION >
					<cfset thedepartment = getPersonal.DEPARTMENT >  
					<cfset theavatar = "#client.domain#unDB/images/#client.companycode#/pics201/#getPersonal.AVATAR#" >
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
						<cfset theavatar = "unknownsmile.png" >
					</cfif>
					
					<cfquery name="getPersonalOrig" datasource="#client.company_dsn#" maxrows="1" >
						SELECT A.FIRSTNAME AS FIRSTNAME, 
							   A.LASTNAME AS LASTNAME, 
							   A.MIDDLENAME AS MIDDLENAME,
							   B.AVATAR AS AVATAR,
							   C.DESCRIPTION AS POSITION,
							   D.DESCRIPTION AS DEPARTMENT
						  FROM CMFPA A LEFT JOIN ECRGMYIBOSE B ON (A.PERSONNELIDNO=B.PERSONNELIDNO)
						               LEFT JOIN CLKPOSITION C  ON (A.POSITIONCODE=C.POSITIONCODE)
						               LEFT JOIN CLKDEPARTMENT D ON (A.DEPARTMENTCODE=D.DEPARTMENTCODE)
						 WHERE A.PERSONNELIDNO = '#pidno#'
					</cfquery>
					
					<cfset thenameO = getPersonalOrig.FIRSTNAME & ' ' & getPersonalOrig.MIDDLENAME & ' ' & getPersonalOrig.LASTNAME > 
					<cfset thepositionO = getPersonalOrig.POSITION >
					<cfset thedepartmentO = getPersonalOrig.DEPARTMENT >  
					<cfset theavatarO = "#client.domain#unDB/images/#client.companycode#/pics201/#getPersonalOrig.AVATAR#" >
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
						<cfset theavatarO = "unknownsmile.png" >
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