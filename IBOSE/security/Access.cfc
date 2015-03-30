<cfcomponent displayname="Access" >
	<cffunction name="hasAccessToApp" returntype="string">
		<cfargument name="columnInterest" >
		<cfargument name="tableOfInterest" >
		<cfargument name="appName" >
		<cfargument name="useridColumn" >
		
		<cfquery name="hasAccess" datasource="#session.global_dsn#" >
			SELECT #columnInterest#
			  FROM EGRGUSERAPPS
			 WHERE #columnInterest# = '#appName#' AND #useridColumn# = '#session.userid#';	
		</cfquery>
		
		<cfif hasAccess.recordCount gt 0 >
			<cfreturn 'true' >
		<cfelse>
			<cfreturn 'false' >
		</cfif>	
	</cffunction>
	
	<cffunction name="checkUserAppAccess" returntype="string">
		<cfargument name="theAppID" >
		<cfargument name="thePID" >
		
		<cfinvoke 	method="getAppUsers" 
					returnvariable="hasAccess" 
					columnlist="APPID"
					apptable="EGRGUSERAPP" 
					apptableid="APPID"
					sessionchapa="#thePID#" 
					sessionuserid="#session.userid#"
					accesstable="EGRTUSERAPP"
					accesstablepid="APPLICANTNUMBER"
					apporderby="APPID ASC"
					extracondition="APPID = '#theAppID#'"
					>
		
		<cfif hasAccess.recordCount gt 0 >
			<cfreturn 'true' >
		<cfelse>
			<cfreturn 'false' >
		</cfif>	
	</cffunction>
	
	
	<cffunction name="getAppUsers" returntype="Query" access="public" >
		<cfargument name="columnlist" > <!---column statement to select in app table--->
		<cfargument name="apptable" >   <!---app main table--->
		<cfargument name="apptableid" > <!---app id--->
		<cfargument name="sessionchapa" > <!---pid of user to check access to--->
		<cfargument name="sessionuserid" > <!---userid of user to check access to--->
		<cfargument name="accesstable" >   <!---RT table--- app id has same name with rt table app id fk --->
		<cfargument name="accesstablepid" > <!---RT table user pid that has access to app--->
		<cfargument name="apporderby" > <!---order statement--->
		<cfargument name="extracondition" required="false" >
		
		<!---*note: In user access table or RT table, Applicant Number and User Group ID is saved in only one column.
		       That is the reason why the following query was used.--->
		
		<cfquery name="qryApps" datasource="#session.global_dsn#" >
			SELECT #columnlist#
			  FROM #apptable#
			 WHERE #apptableid# IN (SELECT #apptableid# 
			                          FROM #accesstable#
			                         WHERE #accesstablepid# = '#sessionchapa#' OR #accesstablepid# IN (SELECT USERGRPIDFK FROM EGRGROLEINDEX WHERE USERGRPMEMBERSIDX = '#sessionuserid#')
			                  )
			       <cfif IsDefined("extracondition") >
				       <cfif trim(extracondition) neq '' >
				       		AND #preserveSingleQuotes(extracondition)#
				       </cfif>
			       </cfif>
			ORDER BY #apporderby#;
		</cfquery>
		
		<cfreturn qryApps >
	</cffunction>
	
	
	
</cfcomponent>