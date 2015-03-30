<cfcomponent displayname="Info">
	<cffunction name="getMyPictureName" returnformat="plain" >
		<cfargument name="dpersonelidno" >
		<cfquery name="qryAvatar" datasource="#session.company_dsn#" maxrows="1">
			SELECT AVATAR
			  FROM ECRGMYIBOSE
			 WHERE PERSONNELIDNO = '#dpersonelidno#'
		</cfquery>
		<cfif qryAvatar.RecordCount gt 0 >
			<cfreturn qryAvatar.AVATAR >
		<cfelse>
			<cfreturn "no avatar" >
		</cfif>
	</cffunction> 
	
	<cffunction name="getMyProfileName" returnformat="plain" >
		<cfargument name="dpersonelidno" >
		<cfargument name="dcompanycode" >
		
		<!---get company source--->
		<!---get guid--->
		<cfquery name="qryCompanyDsn" datasource="#session.global_dsn#" maxrows="1">
			SELECT COMPANY_DSN
			  FROM EGRGCOMPANY
			 WHERE (COMPANYCODE   = '#dcompanycode#')
		</cfquery>
		
		<cfif qryCompanyDsn.RecordCount gt 0 >
			<cfquery name="qryGUID" datasource="#qryCompanyDsn.COMPANY_DSN#" maxrows="1">
				SELECT GUID
				  FROM ECRGMYIBOSE
				 WHERE PERSONNELIDNO = '#dpersonelidno#'
			</cfquery>
			<cfif qryAvatar.qryGUID gt 0 >
				<cfquery name="qryProfileName" datasource="#session.global_dsn#">
					SELECT PROFILENAME
					  FROM EGRGUSERMASTER
					 WHERE GUID = '#qryGUID.GUID#'
				</cfquery>
				
				<cfreturn qryProfileName.PROFILENAME >
			<cfelse>
				<cfreturn "" >
			</cfif>
		<cfelse>
			<cfreturn "no company dsn" >
		</cfif>
	</cffunction> 

</cfcomponent>