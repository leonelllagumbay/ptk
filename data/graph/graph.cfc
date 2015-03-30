<cfcomponent displayname="Function for generating data for graphing">
	
	<cffunction name="graphreason" returntype="void" output="true"> 
		
	<cfif isdefined('url.datefrom') AND isdefined('url.datefrom')  >	
		<cfif len(url.datefrom) GT 5 AND len(url.dateTO) GT 5>
			<cfset datefrom = trim(left(url.datefrom, 10)) > 
			<cfset datefrom = DateFormat(datefrom, 'YYYY-MM-DD') > 
			<!---<cfset datefrom = CreateODBCDateTime(datefrom) > --->
			
			<cfset dateto = trim(left(url.datefrom, 10)) >
			<cfset dateto = DateFormat(dateto, 'YYYY-MM-DD') > 
			<!---<cfset dateto = CreateODBCDateTime(dateto) > --->
			<cfset condition = "AND dateofaccomplishment BETWEEN '#datefrom#' AND '#dateto#'" >
		<cfelse>
			<cfset condition = "" >
		</cfif>
	<cfelse>
		<cfset condition = "" >
	</cfif>
	
    <cfquery name="qryReason1" datasource="IBOSE_GLOBAL">
	   SELECT count(REASONSFORLEAVING) AS TOTALA, REASONSFORLEAVING
		 FROM GINEXITINTERVIEWFORM
		WHERE REASONSFORLEAVING IS NOT NULL AND REASONSFORLEAVING != '' #preservesinglequotes(condition)#
     GROUP BY REASONSFORLEAVING; 
	</cfquery>
    

	
	<cfoutput>
		{
		"success": true,
		"reasongraph": [
          <cfset ecounter = 1 >
		  <cfset querylen = qryReason1.recordcount >
          
          <cfloop query="qryReason1" >
          {
          	"name": "#qryReason1.REASONSFORLEAVING#",
			"data": #qryReason1.TOTALA#
          }
                     <cfif querylen NEQ ecounter> 
						<cfoutput>,</cfoutput>
				    </cfif>
				    <cfset ecounter = ecounter + 1 >
          </cfloop>
          ]
          
       } 
     </cfoutput>
       
       
         <!--- {
			"name": "Local Job Opportunity",
			"data": #qryReason1.TOTALA#
		},{
			"name": "Overseas Job Opportunity",
			"data": #qryReason2.TOTALB#
		},{
			"name": "Salary",
			"data": #qryReason3.TOTALC#
		},{
			"name": "Benefits",
			"data": #qryReason4.TOTALD#
		},{
			"name": "Career Growth",
			"data": #qryReason5.TOTALE#
		},{
			"name": "Nature of Job",
			"data": #qryReason6.TOTALF#
		},{
			"name": "Relationship with Superior",
			"data": #qryReason7.TOTALG#
		},{
			"name": "Relationship with Co-workers",
			"data": #qryReason8.TOTALH#
		},{
			"name": "Company Systems",
			"data": #qryReason9.TOTALI#
		},{
			"name": "Company Atmosphere",
			"data": #qryReason10.TOTALJ#
		},{
			"name": "Studies",
			"data": #qryReason11.TOTALK#
		},{
			"name": "Put up own business",
			"data": #qryReason12.TOTALL#
		},{
			"name": "Health",
			"data": #qryReason13.TOTALM#
		},{
			"name": "Family",
			"data": #qryReason14.TOTALN#
		},{
			"name": "Migration/Relocation",
			"data": #qryReason15.TOTALO#
		},{
			"name": "Proximity",
			"data": #qryReason16.TOTALP#
		},{
			"name": "Work Load",
			"data": #qryReason17.TOTALQ#
		},{
			"name": "Work Schedule",
			"data": #qryReason18.TOTALR#
		},{
			"name": "Working Conditions",
			"data": #qryReason19.TOTALS#
		}]
		}
	</cfoutput>
	--->
	

	
	<cfsetting showdebugoutput="false">
	</cffunction>
	
	
	
	<cffunction name="graphimprovement" returntype="void" output="true"> 
		
	<cfif isdefined('url.datefrom') AND isdefined('url.datefrom')  >	
		<cfif len(url.datefrom) GT 5 AND len(url.dateTO) GT 5>
			<cfset datefrom = trim(left(url.datefrom, 10)) > 
			<cfset datefrom = DateFormat(datefrom, 'YYYY-MM-DD') > 
			<!---<cfset datefrom = CreateODBCDateTime(datefrom) > --->
			
			<cfset dateto = trim(left(url.datefrom, 10)) >
			<cfset dateto = DateFormat(dateto, 'YYYY-MM-DD') > 
			<!---<cfset dateto = CreateODBCDateTime(dateto) > --->
			<cfset condition = "AND dateofaccomplishment BETWEEN '#datefrom#' AND '#dateto#'" >
		<cfelse>
			<cfset condition = "" >
		</cfif>
	<cfelse>
		<cfset condition = "" >
	</cfif>
	
	
	
	
	
	<cfoutput>
		{
		"success": true,
		"improvementgraph": [
		 {
			"name": "Company Policies",
			<cfquery name="qryReason1" datasource="IBOSE_GLOBAL">
			   SELECT count(*) AS TOTALA, COMPPOLICIES AS THECOLUMN
				 FROM GINEXITINTERVIEWFORM
				WHERE COMPPOLICIES IS NOT NULL #preservesinglequotes(condition)#
			  GROUP BY COMPPOLICIES; 
			</cfquery>
			<cfloop query="qryReason1"> 
				<cfif THECOLUMN EQ "1" >
					"very_satisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "2">
					"satisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "3">
					"dissatisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "4">
					"very_dissatisfied": #TOTALA#
				</cfif>
			</cfloop>
	    },{
			"name": "Company Reputation",
			<cfquery name="qryReason2" datasource="IBOSE_GLOBAL">
			   SELECT count(*) AS TOTALA, compreputation AS THECOLUMN
				 FROM GINEXITINTERVIEWFORM
				WHERE compreputation IS NOT NULL #preservesinglequotes(condition)#
			  GROUP BY compreputation; 
			</cfquery>
			<cfloop query="qryReason2"> 
				<cfif THECOLUMN EQ "1" >
					"very_satisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "2">
					"satisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "3">
					"dissatisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "4">
					"very_dissatisfied": #TOTALA#
				</cfif>
			</cfloop>
	    },{
			"name": "Senior Leadership",
			<cfquery name="qryReason3" datasource="IBOSE_GLOBAL">
			   SELECT count(*) AS TOTALA, seniorlead AS THECOLUMN
				 FROM GINEXITINTERVIEWFORM
				WHERE seniorlead IS NOT NULL #preservesinglequotes(condition)#
			  GROUP BY seniorlead; 
			</cfquery>
			<cfloop query="qryReason3"> 
				<cfif THECOLUMN EQ "1" >
					"very_satisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "2">
					"satisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "3">
					"dissatisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "4">
					"very_dissatisfied": #TOTALA#
				</cfif>
			</cfloop>
	    },{
			"name": "Immediate Superior",
			<cfquery name="qryReason4" datasource="IBOSE_GLOBAL">
			   SELECT count(*) AS TOTALA, superiorimmed AS THECOLUMN
				 FROM GINEXITINTERVIEWFORM
				WHERE superiorimmed IS NOT NULL #preservesinglequotes(condition)#
			  GROUP BY superiorimmed; 
			</cfquery>
			<cfloop query="qryReason4"> 
				<cfif THECOLUMN EQ "1" >
					"very_satisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "2">
					"satisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "3">
					"dissatisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "4">
					"very_dissatisfied": #TOTALA#
				</cfif>
			</cfloop>
	    },{
			"name": "Co-workers",
			<cfquery name="qryReason5" datasource="IBOSE_GLOBAL">
			   SELECT count(*) AS TOTALA, coworkers AS THECOLUMN
				 FROM GINEXITINTERVIEWFORM
				WHERE coworkers IS NOT NULL #preservesinglequotes(condition)#
			  GROUP BY coworkers; 
			</cfquery>
			<cfloop query="qryReason5"> 
				<cfif THECOLUMN EQ "1" >
					"very_satisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "2">
					"satisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "3">
					"dissatisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "4">
					"very_dissatisfied": #TOTALA#
				</cfif>
			</cfloop>
	    },{
			"name": "Customers",
			<cfquery name="qryReason6" datasource="IBOSE_GLOBAL">
			   SELECT count(*) AS TOTALA, customers AS THECOLUMN
				 FROM GINEXITINTERVIEWFORM
				WHERE customers IS NOT NULL #preservesinglequotes(condition)#
			  GROUP BY customers; 
			</cfquery>
			<cfloop query="qryReason6"> 
				<cfif THECOLUMN EQ "1" >
					"very_satisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "2">
					"satisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "3">
					"dissatisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "4">
					"very_dissatisfied": #TOTALA#
				</cfif>
			</cfloop>
	    },{
			"name": "Salary",
			<cfquery name="qryReason7" datasource="IBOSE_GLOBAL">
			   SELECT count(*) AS TOTALA, salary AS THECOLUMN
				 FROM GINEXITINTERVIEWFORM
				WHERE salary IS NOT NULL #preservesinglequotes(condition)#
			  GROUP BY salary; 
			</cfquery>
			<cfloop query="qryReason7"> 
				<cfif THECOLUMN EQ "1" >
					"very_satisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "2">
					"satisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "3">
					"dissatisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "4">
					"very_dissatisfied": #TOTALA#
				</cfif>
			</cfloop>
	    },{
			"name": "Benefits",
			<cfquery name="qryReason8" datasource="IBOSE_GLOBAL">
			   SELECT count(*) AS TOTALA, benefits AS THECOLUMN
				 FROM GINEXITINTERVIEWFORM
				WHERE benefits IS NOT NULL #preservesinglequotes(condition)#
			  GROUP BY benefits; 
			</cfquery>
			<cfloop query="qryReason8"> 
				<cfif THECOLUMN EQ "1" >
					"very_satisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "2">
					"satisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "3">
					"dissatisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "4">
					"very_dissatisfied": #TOTALA#
				</cfif>
			</cfloop>
	    },{
			"name": "Performance Mngt",
			<cfquery name="qryReason9" datasource="IBOSE_GLOBAL">
			   SELECT count(*) AS TOTALA, perfmgnt AS THECOLUMN
				 FROM GINEXITINTERVIEWFORM
				WHERE perfmgnt IS NOT NULL #preservesinglequotes(condition)#
			  GROUP BY perfmgnt; 
			</cfquery>
			<cfloop query="qryReason9"> 
				<cfif THECOLUMN EQ "1" >
					"very_satisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "2">
					"satisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "3">
					"dissatisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "4">
					"very_dissatisfied": #TOTALA#
				</cfif>
			</cfloop>
	    },{
			"name": "Recognition",
			<cfquery name="qryReason10" datasource="IBOSE_GLOBAL">
			   SELECT count(*) AS TOTALA, recognition AS THECOLUMN
				 FROM GINEXITINTERVIEWFORM
				WHERE recognition IS NOT NULL #preservesinglequotes(condition)#
			  GROUP BY recognition; 
			</cfquery>
			<cfloop query="qryReason10"> 
				<cfif THECOLUMN EQ "1" >
					"very_satisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "2">
					"satisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "3">
					"dissatisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "4">
					"very_dissatisfied": #TOTALA#
				</cfif>
			</cfloop>
	    },{
			"name": "Work",
			<cfquery name="qryReason11" datasource="IBOSE_GLOBAL">
			   SELECT count(*) AS TOTALA, workk AS THECOLUMN
				 FROM GINEXITINTERVIEWFORM
				WHERE workk IS NOT NULL #preservesinglequotes(condition)#
			  GROUP BY workk; 
			</cfquery>
			<cfloop query="qryReason11"> 
				<cfif THECOLUMN EQ "1" >
					"very_satisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "2">
					"satisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "3">
					"dissatisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "4">
					"very_dissatisfied": #TOTALA#
				</cfif>
			</cfloop>
	    },{
			"name": "Resources",
			<cfquery name="qryReason12" datasource="IBOSE_GLOBAL">
			   SELECT count(*) AS TOTALA, resourcespeople AS THECOLUMN
				 FROM GINEXITINTERVIEWFORM
				WHERE resourcespeople IS NOT NULL #preservesinglequotes(condition)#
			  GROUP BY resourcespeople; 
			</cfquery>
			<cfloop query="qryReason12"> 
				<cfif THECOLUMN EQ "1" >
					"very_satisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "2">
					"satisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "3">
					"dissatisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "4">
					"very_dissatisfied": #TOTALA#
				</cfif>
			</cfloop>
	    },{
			"name": "Employee Comm",
			<cfquery name="qryReason13" datasource="IBOSE_GLOBAL">
			   SELECT count(*) AS TOTALA, empcommu AS THECOLUMN
				 FROM GINEXITINTERVIEWFORM
				WHERE empcommu IS NOT NULL #preservesinglequotes(condition)#
			  GROUP BY empcommu; 
			</cfquery>
			<cfloop query="qryReason13"> 
				<cfif THECOLUMN EQ "1" >
					"very_satisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "2">
					"satisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "3">
					"dissatisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "4">
					"very_dissatisfied": #TOTALA#
				</cfif>
			</cfloop>
	    },{
			"name": "Work Processes",
			<cfquery name="qryReason14" datasource="IBOSE_GLOBAL">
			   SELECT count(*) AS TOTALA, workprocess AS THECOLUMN
				 FROM GINEXITINTERVIEWFORM
				WHERE workprocess IS NOT NULL #preservesinglequotes(condition)#
			  GROUP BY workprocess; 
			</cfquery>
			<cfloop query="qryReason14"> 
				<cfif THECOLUMN EQ "1" >
					"very_satisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "2">
					"satisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "3">
					"dissatisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "4">
					"very_dissatisfied": #TOTALA#
				</cfif>
			</cfloop>
	    },{
			"name": "Career Opp",
			<cfquery name="qryReason15" datasource="IBOSE_GLOBAL">
			   SELECT count(*) AS TOTALA, careeropp AS THECOLUMN
				 FROM GINEXITINTERVIEWFORM
				WHERE careeropp IS NOT NULL #preservesinglequotes(condition)#
			  GROUP BY careeropp; 
			</cfquery>
			<cfloop query="qryReason15"> 
				<cfif THECOLUMN EQ "1" >
					"very_satisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "2">
					"satisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "3">
					"dissatisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "4">
					"very_dissatisfied": #TOTALA#
				</cfif>
			</cfloop>
	    },{
			"name": "Training",
			<cfquery name="qryReason16" datasource="IBOSE_GLOBAL">
			   SELECT count(*) AS TOTALA, traindevopp AS THECOLUMN
				 FROM GINEXITINTERVIEWFORM
				WHERE traindevopp IS NOT NULL #preservesinglequotes(condition)#
			  GROUP BY traindevopp; 
			</cfquery>
			<cfloop query="qryReason16"> 
				<cfif THECOLUMN EQ "1" >
					"very_satisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "2">
					"satisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "3">
					"dissatisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "4">
					"very_dissatisfied": #TOTALA#
				</cfif>
			</cfloop>
	    },{
			"name": "Work Balance",
			<cfquery name="qryReason17" datasource="IBOSE_GLOBAL">
			   SELECT count(*) AS TOTALA, worklifebal AS THECOLUMN
				 FROM GINEXITINTERVIEWFORM
				WHERE worklifebal IS NOT NULL #preservesinglequotes(condition)#
			  GROUP BY worklifebal; 
			</cfquery>
			<cfloop query="qryReason17"> 
				<cfif THECOLUMN EQ "1" >
					"very_satisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "2">
					"satisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "3">
					"dissatisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "4">
					"very_dissatisfied": #TOTALA#
				</cfif>
			</cfloop>
	    },{
			"name": "Working Conditions",
			<cfquery name="qryReason18" datasource="IBOSE_GLOBAL">
			   SELECT count(*) AS TOTALA, workcondition AS THECOLUMN
				 FROM GINEXITINTERVIEWFORM
				WHERE workcondition IS NOT NULL #preservesinglequotes(condition)#
			  GROUP BY workcondition; 
			</cfquery>
			<cfloop query="qryReason18"> 
				<cfif THECOLUMN EQ "1" >
					"very_satisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "2">
					"satisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "3">
					"dissatisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "4">
					"very_dissatisfied": #TOTALA#
				</cfif>
			</cfloop>
	    },{
			"name": "Overall Work",
			<cfquery name="qryReason19" datasource="IBOSE_GLOBAL">
			   SELECT count(*) AS TOTALA, overallwork AS THECOLUMN
				 FROM GINEXITINTERVIEWFORM
				WHERE overallwork IS NOT NULL #preservesinglequotes(condition)#
			  GROUP BY overallwork; 
			</cfquery>
			<cfloop query="qryReason19"> 
				<cfif THECOLUMN EQ "1" >
					"very_satisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "2">
					"satisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "3">
					"dissatisfied": #TOTALA#,
				<cfelseif THECOLUMN EQ "4">
					"very_dissatisfied": #TOTALA#
				</cfif>
			</cfloop>
	    }]
		
		}
	</cfoutput>
	
	
	<cfsetting showdebugoutput="false">
	</cffunction>
	
	
	<cffunction name="graphclearance" returntype="void" output="true"> 
		
	<cfif isdefined('url.datefrom') AND isdefined('url.dateto')  >	
		<cfif len(url.datefrom) GT 5 AND len(url.dateto) GT 5>
			<cfset datefrom = left(url.datefrom, 10) > 
			<cfset datefrom = DateFormat(datefrom, 'YYYY-MM-DD') > 
			
			<cfset dateto = left(url.dateto, 10) >
			<cfset dateto = DateFormat(dateto, 'YYYY-MM-DD') > 
			<cfset condition = "AND DATEACCOMPLISHED >= '#datefrom#' AND DATEACCOMPLISHED <= '#dateto#'" >
		<cfelse>
			<cfset condition = "" >
		</cfif>
	<cfelse>
		<cfset condition = "" >
	</cfif>
	
	<cfif isdefined("url.datatograph") >
		<cfif len(url.datatograph) GT 1 >
			<cfset DATA = trim(url.datatograph) >
		<cfelse>
			<cfset DATA = "LEVEL">
		</cfif>
	<cfelse>
		<cfset DATA = "LEVEL">
	</cfif>
	
    <cfquery name="qryReason1" datasource="IBOSE_GLOBAL">
	   SELECT count(#DATA#) AS TOTALA, #DATA# AS THEDATA
		 FROM EGINCLRMAIN
		WHERE #DATA# IS NOT NULL AND #DATA# != '' #preservesinglequotes(condition)#
     GROUP BY #DATA#; 
	</cfquery>
    

	
	<cfoutput>
		{
		"success": true,
		"clearancegraph": [
          <cfset ecounter = 1 >
		  <cfset querylen = qryReason1.recordcount >
          
          <cfloop query="qryReason1" >
          {
          	"name": "#qryReason1.THEDATA#",
			"data": #qryReason1.TOTALA#
          }
                     <cfif querylen NEQ ecounter> 
						<cfoutput>,</cfoutput>
				    </cfif>
				    <cfset ecounter = ecounter + 1 >
          </cfloop>
          ]
          
       } 
     </cfoutput>


	</cffunction>

</cfcomponent>