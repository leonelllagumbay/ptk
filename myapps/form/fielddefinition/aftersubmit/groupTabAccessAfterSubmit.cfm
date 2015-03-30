
		<cfquery name="getRoleFromGroup" datasource="#session.global_dsn#"> 
			SELECT A.USERGRPMEMBERSIDX, B.USERID, B.GUID AS GUID  
			  FROM EGRGROLEINDEX A LEFT JOIN EGRGUSERMASTER B ON (A.USERGRPMEMBERSIDX = B.USERID)
			 WHERE USERGRPID_FK = '#form.G__EGRTTAB__APPLICANTNUMBER#'
		</cfquery>
		
		<cfif getRoleFromGroup.recordcount GT 0 >
			<cfloop query="getRoleFromGroup" >
				<cfquery name="getPIDfromMainTable" datasource="#session.company_dsn#" maxrows="1"> 
					SELECT #session.mainpk# AS PID 
					  FROM #session.maintable# 
					 WHERE GUID = '#getRoleFromGroup.GUID#' 
				</cfquery> 
				<cfif getPIDfromMainTable.recordcount GT 0 >
					<cftry>
						<cfquery name="grant" datasource="#session.global_dsn#" >
					    	INSERT INTO EGRTTAB (TABID, APPLICANTNUMBER, PERSONNELIDNO, EFORMID, PROCESSID, APPROVED, DATELASTUPDATE, RECDATECREATED)
					            VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.G__EGRTTAB__TABID#" >,
					            		<cfqueryparam cfsqltype="cf_sql_varchar" value="#getPIDfromMainTable.PID#" >,
					            		<cfqueryparam cfsqltype="cf_sql_varchar" value="#session.chapa#" >,
					            		<cfqueryparam cfsqltype="cf_sql_varchar" value="#eformid#" >,
					            		<cfqueryparam cfsqltype="cf_sql_varchar" value="#createUUID()#" >,
					            		<cfqueryparam cfsqltype="cf_sql_varchar" value="N" >,
					            		<cfqueryparam cfsqltype="cf_sql_timestamp" value="#dateformat(now(), 'YYYY-MM-DD')# #timeformat(now(), 'HH:MM:SS')#" >,
					            		<cfqueryparam cfsqltype="cf_sql_timestamp" value="#dateformat(now(), 'YYYY-MM-DD')# #timeformat(now(), 'HH:MM:SS')#" >
					                    );
					    </cfquery>
				    <cfcatch type="Any">
						<cfcontinue>
					</cfcatch>
					</cftry>
				<cfelse>
				</cfif> <!---end getPIDfromMainTable--->
			</cfloop> <!---end getRoleFromGroup--->
		<cfelse> 
		</cfif> <!---end getRoleFromGroup---> 
		
	