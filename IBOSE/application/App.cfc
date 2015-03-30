<cfcomponent name="App">

	<cffunction name="getApp" returntype="Query" >
		<!---select app to launch--->
		<cfif isdefined("url.bdg") >
			<cfif ucase(trim(url.bdg)) eq "DEFAULTVALUE" >
				<cfquery name="getAppDetails" datasource="#session.global_dsn#" maxrows="1">
					SELECT *
					  FROM EGRGUSERAPP
					 WHERE APPID = <cfqueryparam cfsqltype="cf_sql_varchar" value="DEFAULTVALUE">
				</cfquery>
			<cfelse>
				<cfquery name="getAppDetails" datasource="#session.global_dsn#" maxrows="1">
					SELECT *
					  FROM EGRGUSERAPP
					 WHERE APPID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(url.bdg)#">
				</cfquery>
			</cfif>
		<cfelse>
			<cfquery name="getAppDetails" datasource="#session.global_dsn#" maxrows="1">
				SELECT HOMEPAGE
				  FROM EGRGCOMPANYSETTINGS
				 WHERE COMPANYCODE = <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.companycode#">
			</cfquery>
		</cfif>
		<cfreturn getAppDetails >
	</cffunction>

	<cffunction name="getRegions" returntype="Query" >
		<cfargument name="appID" required="true" >
		<cfargument name="regionName" required="true" >

		<cfquery name="getAppRegions" datasource="#session.global_dsn#" maxrows="1">
			SELECT *
			  FROM EGRGAPPREGION
			 WHERE APPIDFK = <cfqueryparam cfsqltype="cf_sql_varchar" value="#appID#">
			       AND REGIONNAME = <cfqueryparam cfsqltype="cf_sql_varchar" value="#regionName#">
		</cfquery>
		<cfreturn getAppRegions >
	</cffunction>

</cfcomponent>