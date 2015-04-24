<cfcomponent name="data" ExtDirect="true">


		
<cffunction name="getInitForms" ExtDirect="true">
<cftry>

<!---query approver details and get an array of process id--->
	<cfset getprocessID = ORMExecuteQuery("SELECT count(*) AS TOTPROCESSID
	  								      FROM EGINFORMPROCESSDETAILS A,EGINROUTERDETAILS B,EGINAPPROVERDETAILS C
	 								      WHERE A.PROCESSDETAILSID = B.PROCESSIDFK 
	 								      		AND B.ROUTERDETAILSID = C.ROUTERIDFK 
	 								      		AND C.PERSONNELIDNO = '#client.chapa#'
	 								      		AND C.ISREAD = 'false' 
	 								      		AND C.ACTION = 'CURRENT'", true) >

	<cfset getprocessIDPending = ORMExecuteQuery("SELECT count(*) AS TOTPROCESSID
	  								      FROM EGINFORMPROCESSDETAILS A,EGINROUTERDETAILS B,EGINAPPROVERDETAILS C
	 								      WHERE A.PROCESSDETAILSID = B.PROCESSIDFK 
	 								      		AND B.ROUTERDETAILSID = C.ROUTERIDFK 
	 								      		AND C.PERSONNELIDNO = '#client.chapa#'
	 								      		AND C.ISREAD = 'true'
	 								      		AND C.ACTION = 'CURRENT'", true) >     
	 								      		


<cfset retArr = ArrayNew(1) >

<cfif getprocessID eq 0 >
	<cfset retArr[1] = "No New eForm">
<cfelseif getprocessID eq 1 >
	<cfset retArr[1] = "<span style='background-color: red; border-radius: 12px; color: white;'><b>&nbsp;#getprocessID#&nbsp;</b></span> New eForm">
<cfelse>
	<cfset retArr[1] = "<span style='background-color: red; border-radius: 12px; color: white;'><b>&nbsp;#getprocessID#&nbsp;</b></span> New eForms">
</cfif>

<cfif getprocessIDPending eq 0 >
	<cfset retArr[2] = "No Pending eForm">
<cfelseif getprocessIDPending eq 1 > 
	<cfset retArr[2] = "<span style='background-color: red; border-radius: 12px; color: white;'><b>&nbsp;#getprocessIDPending#&nbsp;</b></span> Pending eForm">
<cfelse>
	<cfset retArr[2] = "<span style='background-color: red; border-radius: 12px; color: white;'><b>&nbsp;#getprocessIDPending#&nbsp;</b></span> Pending eForms">
</cfif>

<cfreturn retArr >
<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message >
</cfcatch>			
</cftry>
</cffunction> 





<cffunction name="getTheFormsFromeFormid" ExtDirect="true"> 
<cfargument name="eformid" >
<cfargument name="actiontype" >
<cftry>
<cfif actiontype eq "getmyeforms" >
	<cfset processData = ORMExecuteQuery("SELECT GRIDSCRIPT FROM EGRGEFORMS WHERE EFORMID = '#eformid#'", true ) >
	<cfset processData = replace(processData,"action: 'approveformnow',hidden: false,","action: 'approveformnow',hidden: true,") > 
	<cfset processData = replace(processData,"action: 'disapproveformnow',hidden: false,","action: 'disapproveformnow',hidden: true,") > 
	<cfset processData = replace(processData,"action: 'openformnow',hidden: false,","action: 'openformnow',hidden: true,") > 
<cfelseif actiontype eq "getneweforms" >
	<cfset processData = ORMExecuteQuery("SELECT GRIDSCRIPT FROM EGRGEFORMS WHERE EFORMID = '#eformid#'", true ) >
	<cfset processData = replace(processData,"isnew: false,ispending: false","isnew: true,ispending: false") >
	<cfset processData = replace(processData,"action: 'addeform',hidden: false,","action: 'addeform',hidden: true,") >
	<cfset processData = replace(processData,"action: 'editeform',hidden: false,","action: 'editeform',hidden: true,") > 
	<cfset processData = replace(processData,"action: 'deleteeform',hidden: false,","action: 'deleteeform',hidden: true,") > 
	<cfset processData = replace(processData,"action: 'routeeform',hidden: false,","action: 'routeeform',hidden: true,") > 
<cfelseif actiontype eq "getpendingeforms" >
	<cfset processData = ORMExecuteQuery("SELECT GRIDSCRIPT FROM EGRGEFORMS WHERE EFORMID = '#eformid#'", true ) >
	<cfset processData = replace(processData,"isnew: false,ispending: false","isnew: false,ispending: true") >
	<cfset processData = replace(processData,"action: 'addeform',hidden: false,","action: 'addeform',hidden: true,") >
	<cfset processData = replace(processData,"action: 'editeform',hidden: false,","action: 'editeform',hidden: true,") > 
	<cfset processData = replace(processData,"action: 'deleteeform',hidden: false,","action: 'deleteeform',hidden: true,") > 
	<cfset processData = replace(processData,"action: 'routeeform',hidden: false,","action: 'routeeform',hidden: true,") > 
</cfif>




<cfreturn processData >
<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message >
</cfcatch>			
</cftry>
</cffunction>




<cffunction name="setIsreadTrue" ExtDirect="true" >
<cfargument name="eformid" >
<cfargument name="processid" >
<!---make the form isread as being read isread : true--->
<cftry>
	<cfset formRouterData = EntityLoad("EGINROUTERDETAILS", {PROCESSIDFK = #processid#}) >
	<cfloop array="#formRouterData#" index="routerIndex" > 
		<cfset formApproversData = EntityLoad("EGINAPPROVERDETAILS", {ROUTERIDFK =#routerIndex.getROUTERDETAILSID()#}) >
		<cfloop array="#formApproversData#" index="approverIndex" > 
			<cfset updateAction = EntityLoad("EGINAPPROVERDETAILS", {APPROVERDETAILSID =#approverIndex.getAPPROVERDETAILSID()#,ACTION='CURRENT',PERSONNELIDNO='#client.chapa#'}, true ) >
			<cfif isdefined("updateAction") >
				<cfset updateAction.setISREAD("true") >  
				<cfset EntitySave(updateAction) >
				<cfset ormflush() >
				<cfset updateCount = EntityLoad("EGINEFORMCOUNT", { EFORMID =#eformid#, PERSONNELIDNO = #client.chapa#}, true ) >
				<cfif isdefined("updateCount") >
					<cfif updateCount.getNEW() gt 0 >	
						<cfset currentCount = updateCount.getNEW() - 1 >
						<cfset updateCount.setNEW(currentCount) >
						<cfset currentCount = updateCount.getPENDING() + 1 >
						<cfset updateCount.setPENDING(currentCount) >
						<cfset EntitySave(updateCount) > 
						<cfset ormflush()>   
					</cfif> 
				</cfif>	
			</cfif>
			 
			
		</cfloop>
	</cfloop>
	
	
<!---execute after load process--->	
<cfset afterloadprocess = ORMExecuteQuery("SELECT AFTERLOAD
	  								       FROM EGRGEFORMS
	  								      WHERE EFORMID = '#eformid#'", true) >
<cfif afterloadprocess neq "NA" AND afterloadprocess neq "">
	<cfinclude template="../fielddefinition/afterload/#afterloadprocess#" > 
</cfif>	 
<!---end after load process, beforeload is found in actionform.cfc--->
						

<cfreturn "success" >
<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message >
</cfcatch>			
</cftry>	
</cffunction>



<cffunction name="zeroapproveDisapprove" ExtDirect="true" > 
<cfargument name="eformid" >
<cftry>
	<cfset updateCount = EntityLoad("EGINEFORMCOUNT", { EFORMID =#eformid#, PERSONNELIDNO = #client.chapa#}, true ) >
	<cfif isdefined("updateCount") >	
		<cfset updateCount.setAPPROVED("0") >
		<cfset updateCount.setDISAPPROVED("0") >
		<cfset EntitySave(updateCount) >  
		<cfset ormflush()> 
	<cfelse>
	</cfif> 	
	
	
<cfreturn "successZero" >
<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message >
</cfcatch>
</cftry>
</cffunction>


<cffunction name="deleteForm" ExtDirect="true" >
<cfargument name="eformid" >
<cfargument name="processid" > 
<cfargument name="level" >
<cfargument name="table" >
<cftry>
	
	<!---delete corrresponding process--->
	<cfquery name="rollbackProcessDetails" datasource="#client.global_dsn#" >
		DELETE FROM EGINFORMPROCESSDETAILS
		      WHERE PROCESSDETAILSID = '#processid#'
	</cfquery>
	
	<cftry>
		<cfset processDataB = EntityLoad("EGINROUTERDETAILS", {PROCESSIDFK=#processid#}, false ) >
		<cfloop array='#processDataB#' index='routerI' >
			<cfquery name="rollbackApproversDetails" datasource="#client.global_dsn#" >
				DELETE FROM EGINAPPROVERDETAILS
				      WHERE ROUTERIDFK = '#routerI.getROUTERDETAILSID()#'
			</cfquery>
		</cfloop>
	<cfcatch>
	</cfcatch>
	</cftry>
	
	<cfquery name="rollbackRouterDetails" datasource="#client.global_dsn#" >
		DELETE FROM EGINROUTERDETAILS
		      WHERE PROCESSIDFK = '#processid#'
	</cfquery>
	<!---end delete corrresponding process--->
	
	<!---delete Main table item , this item--->
	<cfif level eq "G" >
		<cfset level = "#client.global_dsn#" >
	<cfelseif level eq "C" >
		<cfset level = "#client.company_dsn#" >			
	<cfelseif level eq "S" >
		<cfset level = "#client.subco_dsn#" >
	<cfelseif level eq "Q" >
		<cfset level = "#client.query_dsn#" >
	<cfelseif level eq "T" >
		<cfset level = "#client.transact_dsn#" >
	<cfelseif level eq "SD" >
		<cfset level = "#client.site_dsn#" >
	<cfelse>
		
	</cfif>

	<cfquery name="deleteForm" datasource="#level#" >
		DELETE FROM #table#
		      WHERE EFORMID = '#eformid#' AND PROCESSID = '#processid#'
	</cfquery> 
	
	<!---delete scheduled task assigned to the form if any--->
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
<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message >
</cfcatch>
</cftry>	
</cffunction>

	
</cfcomponent>