<cfcomponent displayname="lookup" hint="Lookup function" output="true">
	

	<cffunction
			name="getcompanydsn"
			returntype="void"
			
	>
	<cftry>
		
		<cfquery name="qrycompanydsn" datasource="IBOSE_GLOBAL">
			SELECT COMPANY_DSN,  DESCRIPTION
			  FROM EGRGCOMPANY;  
		</cfquery>
	
	<cfif isdefined("qrycompanydsn") >
		<cfoutput>
		{
		"success": "true",
		"companylk": [
				<cfset ecounter = 1 >
				<cfset querylen = qrycompanydsn.recordcount >
				<cfloop query="qrycompanydsn">
					{
						"companycode": #SerializeJSON(COMPANY_DSN)#, 
						"companyname": #SerializeJSON(DESCRIPTION)#
					}
					<cfif querylen NEQ ecounter> 
						<cfoutput>,</cfoutput>
				    </cfif>
				    <cfset ecounter = ecounter + 1 >
				    
		        </cfloop>
		]
		}
		</cfoutput>
	<cfelse>
		<cfoutput>
		{
		"success": "true",
		"companylk": [{
						"companycode": #SerializeJSON("empty")#, 
						"companyname": #SerializeJSON("empty")#
					}]
		}
		</cfoutput>
	</cfif>
		<cfcatch>
			<cfoutput>
				"success": "true",
				"companylk": [{
						"companycode":"error", 
						"companyname": #SerializeJson(cfcatch.Detail & ' ' & cfcatch.Message)#
					}]
				}
			</cfoutput>
		</cfcatch>
	</cftry>
	</cffunction>

	<!---<cffunction
			name="getcompanydsn"
			
	>
	<cftry>
	<cfset companydsn = EntityLoad("egrgcompany") >
	
	<cfset companydsnlen = ArrayLen(companydsn) >
	
	
	
	<cfoutput>
	{
	"success": "true",
	"companylk": [
			<cfloop from="1" to="#companydsnlen#" index="ecounter">
				{
					"companycode": #SerializeJSON(companydsn[ecounter].getCompany_dsn())#, 
					"companyname": #SerializeJSON(companydsn[ecounter].getDescription())#
				}
				<cfif companydsnlen NEQ ecounter>
					<cfoutput>,</cfoutput>
			    </cfif>
			    
	        </cfloop>
	]}
	</cfoutput>
		<cfcatch>
			<cfoutput>
				"success": "true",
				"companylk": [{
						"companycode":"error", 
						"companyname": #SerializeJson(cfcatch.Detail & ' ' & cfcatch.Message)#
					}]
				}
			</cfoutput>
			<cfdump var="#companydsn#">
		</cfcatch>
	</cftry>
	</cffunction>--->
	
	<cffunction
			name="getcivilstatus"
			
	>
	<cftry>
		
		<cfquery name="qryCivilStatus" datasource="FBC_CBOSE">
			SELECT CIVILSTATUS, DESCRIPTION
			  FROM CLKCIVILSTATUS
		</cfquery>
	
	<cfif isdefined("qryCivilStatus") >
		<cfoutput>
		{
		"success": "true",
		"civilstatuslk": [
				<cfset ecounter = 1 >
				<cfset querylen = qryCivilStatus.recordcount >
				<cfloop query="qryCivilStatus">
					{
						"civilstatuscode": #SerializeJSON(CIVILSTATUS)#, 
						"civilstatusname": #SerializeJSON(DESCRIPTION)#
					}
					<cfif querylen NEQ ecounter>
						<cfoutput>,</cfoutput>
				    </cfif>
				    <cfset ecounter = ecounter + 1 >
				    
		        </cfloop>
		]
		}
		</cfoutput>
	<cfelse>
		<cfoutput>
		{
		"success": "true",
		"civilstatuslk": [{
						"civilstatuscode": #SerializeJSON("empty")#, 
						"civilstatusname": #SerializeJSON("empty")#
					}]
		}
		</cfoutput>
	</cfif>
		<cfcatch>
			<cfoutput>
				"success": "true",
				"civilstatuslk": [{
						"civilstatuscode":"error", 
						"civilstatusname": #SerializeJson(cfcatch.Detail & ' ' & cfcatch.Message)#
					}]
				}
			</cfoutput>
		</cfcatch>
	</cftry>
	</cffunction>
	
	<cffunction
			name="getcitizenship"
			
	>
	<cftry>
		
		<cfquery name="qrycitizenship" datasource="IBOSE_GLOBAL">
			SELECT CITIZENSHIP, DESCRIPTION
			  FROM GLKCITIZEN
		</cfquery>
	
	<cfif isdefined("qrycitizenship") >
		<cfoutput>
		{
		"success": "true",
		"citizenshiplk": [
				<cfset ecounter = 1 >
				<cfset querylen = qrycitizenship.recordcount >
				<cfloop query="qrycitizenship">
					{
						"citizenshipcode": #SerializeJSON(CITIZENSHIP)#, 
						"citizenshipname": #SerializeJSON(DESCRIPTION)#
					}
					<cfif querylen NEQ ecounter>
						<cfoutput>,</cfoutput>
				    </cfif>
				    <cfset ecounter = ecounter + 1 >
				    
		        </cfloop>
		]
		}
		</cfoutput>
	<cfelse>
		<cfoutput>
		{
		"success": "true",
		"citizenshiplk": [{
						"citizenshipcode": #SerializeJSON("empty")#, 
						"citizenshipname": #SerializeJSON("empty")#
					}]
		}
		</cfoutput>
	</cfif>
		<cfcatch>
			<cfoutput>
				"success": "true",
				"citizenshiplk": [{
						"citizenshipcode":"error", 
						"citizenshipname": #SerializeJson(cfcatch.Detail & ' ' & cfcatch.Message)#
					}]
				}
			</cfoutput>
		</cfcatch>
	</cftry>
	</cffunction>
	
	<cffunction
			name="getreligion"
			
	>
	<cftry>
		
		<cfquery name="qryreligion" datasource="IBOSE_GLOBAL">
			SELECT RELIGIONCODE, DESCRIPTION
			  FROM GLKRELIGION
		</cfquery>
	
	<cfif isdefined("qryreligion") >
		<cfoutput>
		{
		"success": "true",
		"religionlk": [
				<cfset ecounter = 1 >
				<cfset querylen = qryreligion.recordcount >
				<cfloop query="qryreligion">
					{
						"religioncode": #SerializeJSON(RELIGIONCODE)#, 
						"religionname": #SerializeJSON(DESCRIPTION)#
					}
					<cfif querylen NEQ ecounter>
						<cfoutput>,</cfoutput>
				    </cfif>
				    <cfset ecounter = ecounter + 1 >
				    
		        </cfloop>
		]
		}
		</cfoutput>
	<cfelse>
		<cfoutput>
		{
		"success": "true",
		"religionlk": [{
						"religioncode": #SerializeJSON("empty")#, 
						"religionname": #SerializeJSON("empty")#
					}]
		}
		</cfoutput>
	</cfif>
		<cfcatch>
			<cfoutput>
				"success": "true",
				"religionlk": [{
						"religioncode":"error", 
						"religionname": #SerializeJson(cfcatch.Detail & ' ' & cfcatch.Message)#
					}]
				}
			</cfoutput>
		</cfcatch>
	</cftry>
	</cffunction>
	
	<cffunction
			name="getschool"
			
	>
	<cftry>
		
		<cfquery name="qryschool" datasource="IBOSE_GLOBAL">
			SELECT SCHOOLCODE, SCHOOLNAME
			  FROM GLKSCHOOL
			<cfif isdefined("url.query") >
			 WHERE SCHOOLNAME LIKE '%#trim(url.query)#%'  
			</cfif>
		</cfquery>
	
	<cfif isdefined("qryschool") >
		<cfoutput>
		{
		"success": "true",
		"schoollk": [
				<cfset ecounter = 1 >
				<cfset querylen = qryschool.recordcount >
				<cfloop query="qryschool">
					{
						"schoolcode": #SerializeJSON(SCHOOLCODE)#, 
						"schoolname": #SerializeJSON(SCHOOLNAME)#
					}
					<cfif querylen NEQ ecounter>
						<cfoutput>,</cfoutput>
				    </cfif>
				    <cfset ecounter = ecounter + 1 >
				    
		        </cfloop>
		]
		}
		</cfoutput>
	<cfelse>
		<cfoutput>
		{
		"success": "true",
		"schoollk": [{
						"schoolcode": #SerializeJSON("empty")#, 
						"schoolname": #SerializeJSON("empty")#
					}]
		}
		</cfoutput>
	</cfif>
		<cfcatch>
			<cfoutput>
				"success": "true",
				"schoollk": [{
						"schoolcode":"error", 
						"schoolname": #SerializeJson(cfcatch.Detail & ' ' & cfcatch.Message)#
					}]
				}
			</cfoutput>
		</cfcatch>
	</cftry>
	</cffunction>
	
	<cffunction
			name="getfield"
			
	>
	<cftry>
		
		<cfquery name="qryfield" datasource="IBOSE_GLOBAL">
			SELECT DEGREECODE, DESCRIPTION
			  FROM GLKDEGREE
		</cfquery>
	
	<cfif isdefined("qryfield") >
		<cfoutput>
		{
		"success": "true",
		"fieldlk": [
				<cfset ecounter = 1 >
				<cfset querylen = qryfield.recordcount >
				<cfloop query="qryfield">
					{
						"fieldcode": #SerializeJSON(DEGREECODE)#, 
						"fieldname": #SerializeJSON(DESCRIPTION)#
					}
					<cfif querylen NEQ ecounter>
						<cfoutput>,</cfoutput>
				    </cfif>
				    <cfset ecounter = ecounter + 1 >
				    
		        </cfloop>
		]
		}
		</cfoutput>
	<cfelse>
		<cfoutput>
		{
		"success": "true",
		"fieldlk": [{
						"fieldcode": #SerializeJSON("empty")#, 
						"fieldname": #SerializeJSON("empty")#
					}]
		}
		</cfoutput>
	</cfif>
		<cfcatch>
			<cfoutput>
				"success": "true",
				"fieldlk": [{
						"fieldcode":"error", 
						"fieldname": #SerializeJson(cfcatch.Detail & ' ' & cfcatch.Message)#
					}]
				}
			</cfoutput>
		</cfcatch>
	</cftry>
	</cffunction>
	
	<cffunction
			name="getcourse"
			
	>
	<cftry>
		
		<cfquery name="qrycourse" datasource="IBOSE_GLOBAL">
			SELECT COURSECODE, DESCRIPTION
			  FROM GLKCOURSE
			<cfif isdefined("url.query") >
			 WHERE DESCRIPTION LIKE '%#trim(url.query)#%'
			</cfif>
		</cfquery>
	
	<cfif isdefined("qrycourse") >
		<cfoutput>
		{
		"success": "true",
		"courselk": [
				<cfset ecounter = 1 >
				<cfset querylen = qrycourse.recordcount >
				<cfloop query="qrycourse">
					{
						"coursecode": #SerializeJSON(COURSECODE)#, 
						"coursename": #SerializeJSON(DESCRIPTION)#
					}
					<cfif querylen NEQ ecounter>
						<cfoutput>,</cfoutput>
				    </cfif>
				    <cfset ecounter = ecounter + 1 >
				    
		        </cfloop>
		]
		}
		</cfoutput>
	<cfelse>
		<cfoutput>
		{
		"success": "true",
		"courselk": [{
						"coursecode": #SerializeJSON("empty")#, 
						"coursename": #SerializeJSON("empty")#
					}]
		}
		</cfoutput>
	</cfif>
		<cfcatch>
			<cfoutput>
				"success": "true",
				"courselk": [{
						"coursecode":"error", 
						"coursename": #SerializeJson(cfcatch.Detail & ' ' & cfcatch.Message)#
					}]
				}
			</cfoutput>
		</cfcatch>
	</cftry>
	</cffunction>
	
	<cffunction
			name="getgovexam"
			
	>
	<cftry>
		
		<cfquery name="qrygovexam" datasource="IBOSE_GLOBAL">
			SELECT EXAMCODE, TYPEOFEXAM
			  FROM GLKGOVEXAM;
		</cfquery>
	
	<cfif isdefined("qrygovexam") >
		<cfoutput>
		{
		"success": "true",
		"govexamlk": [
				<cfset ecounter = 1 >
				<cfset querylen = qrygovexam.recordcount >
				<cfloop query="qrygovexam">
					{
						"govexamcode": #SerializeJSON(EXAMCODE)#, 
						"govexamname": #SerializeJSON(TYPEOFEXAM)#
					}
					<cfif querylen NEQ ecounter>
						<cfoutput>,</cfoutput>
				    </cfif>
				    <cfset ecounter = ecounter + 1 >
				    
		        </cfloop>
		]
		}
		</cfoutput>
	<cfelse>
		<cfoutput>
		{
		"success": "true",
		"govexamlk": [{
						"govexamcode": #SerializeJSON("empty")#, 
						"govexamname": #SerializeJSON("empty")#
					}]
		}
		</cfoutput>
	</cfif>
		<cfcatch>
			<cfoutput>
				"success": "true",
				"govexamlk": [{
						"govexamcode":"error", 
						"govexamname": #SerializeJson(cfcatch.Detail & ' ' & cfcatch.Message)#
					}]
				}
			</cfoutput>
		</cfcatch>
	</cftry>
	</cffunction>
	
	<cffunction
			name="getcompany"
			 
	>
	<cftry>
		
		<cfquery name="qrycompany" datasource="IBOSE_GLOBAL">
			SELECT COMPANYCODE, DESCRIPTION
			  FROM GLKCOMPANY;
		</cfquery>
	
	<cfif isdefined("qrycompany") >
		<cfoutput>
		{
		"success": "true",
		"companylk": [
				<cfset ecounter = 1 >
				<cfset querylen = qrycompany.recordcount >
				<cfloop query="qrycompany">
					{
						"companycode": #SerializeJSON(COMPANYCODE)#, 
						"companyname": #SerializeJSON(DESCRIPTION)#
					}
					<cfif querylen NEQ ecounter>
						<cfoutput>,</cfoutput>
				    </cfif>
				    <cfset ecounter = ecounter + 1 >
				    
		        </cfloop>
		]
		}
		</cfoutput>
	<cfelse>
		<cfoutput>
		{
		"success": "true",
		"companylk": [{
						"companycode": #SerializeJSON("empty")#, 
						"companyname": #SerializeJSON("empty")#
					}]
		}
		</cfoutput>
	</cfif>
		<cfcatch>
			<cfoutput>
				"success": "true",
				"companylk": [{
						"companycode":"error", 
						"companyname": #SerializeJson(cfcatch.Detail & ' ' & cfcatch.Message)#
					}]
				}
			</cfoutput>
		</cfcatch>
	</cftry>
	</cffunction>
	
	<cffunction
			name="getdepartment"
			
	>
	<cftry>
		
		<cfquery name="qrydepartment" datasource="FBC_CBOSE">
			SELECT DEPARTMENTCODE, DESCRIPTION
			  FROM CLKDEPARTMENT;
		</cfquery>
	
	<cfif isdefined("qrydepartment") >
		<cfoutput>
		{
		"success": "true",
		"departmentlk": [
				<cfset ecounter = 1 >
				<cfset querylen = qrydepartment.recordcount >
				<cfloop query="qrydepartment">
					{
						"departmentcode": #SerializeJSON(DEPARTMENTCODE)#, 
						"departmentname": #SerializeJSON(DESCRIPTION)#
					}
					<cfif querylen NEQ ecounter>
						<cfoutput>,</cfoutput>
				    </cfif>
				    <cfset ecounter = ecounter + 1 >
				    
		        </cfloop>
		]
		}
		</cfoutput>
	<cfelse>
		<cfoutput>
		{
		"success": "true",
		"departmentlk": [{
						"departmentcode": #SerializeJSON("empty")#, 
						"departmentname": #SerializeJSON("empty")#
					}]
		}
		</cfoutput>
	</cfif>
		<cfcatch>
			<cfoutput>
				"success": "true",
				"departmentlk": [{
						"departmentcode":"error", 
						"departmentname": #SerializeJson(cfcatch.Detail & ' ' & cfcatch.Message)#
					}]
				}
			</cfoutput>
		</cfcatch>
	</cftry>
	</cffunction>
	
	<cffunction
			name="getposition"
			
	>
	<cftry>
		
		<cfquery name="qryposition" datasource="FBC_CBOSE">
			SELECT POSITIONCODE, DESCRIPTION
			  FROM CLKPOSITION;
		</cfquery>
	
	<cfif isdefined("qryposition") >
		<cfoutput>
		{
		"success": "true",
		"positionlk": [
				<cfset ecounter = 1 >
				<cfset querylen = qryposition.recordcount >
				<cfloop query="qryposition">
					{
						"positioncode": #SerializeJSON(POSITIONCODE)#, 
						"positionname": #SerializeJSON(DESCRIPTION)#
					}
					<cfif querylen NEQ ecounter>
						<cfoutput>,</cfoutput>
				    </cfif>
				    <cfset ecounter = ecounter + 1 >
				    
		        </cfloop>
		]
		}
		</cfoutput>
	<cfelse>
		<cfoutput>
		{
		"success": "true",
		"positionlk": [{
						"positioncode": #SerializeJSON("empty")#, 
						"positionname": #SerializeJSON("empty")#
					}]
		}
		</cfoutput>
	</cfif>
		<cfcatch>
			<cfoutput>
				"success": "true",
				"positionlk": [{
						"positioncode":"error", 
						"positionname": #SerializeJson(cfcatch.Detail & ' ' & cfcatch.Message)#
					}]
				}
			</cfoutput>
		</cfcatch>
	</cftry>
	</cffunction>
	
	<cffunction
			name="getlevel"
			returntype="void"
			
	>
	<cftry>
		
		<cfquery name="qrylevel" datasource="FBC_CBOSE">
			SELECT CODELEVEL, DESCRIPTION
			  FROM CLKLEVEL;
		</cfquery>
	
	<cfif isdefined("qrylevel") >
		<cfoutput>
		{
		"success": "true",
		"levellk": [
				<cfset ecounter = 1 >
				<cfset querylen = qrylevel.recordcount >
				<cfloop query="qrylevel">
					{
						"levelcode": #SerializeJSON(CODELEVEL)#, 
						"levelname": #SerializeJSON(DESCRIPTION)#
					}
					<cfif querylen NEQ ecounter>
						<cfoutput>,</cfoutput>
				    </cfif>
				    <cfset ecounter = ecounter + 1 >
				    
		        </cfloop>
		]
		}
		</cfoutput>
	<cfelse>
		<cfoutput>
		{
		"success": "true",
		"levellk": [{
						"levelcode": #SerializeJSON("empty")#, 
						"levelname": #SerializeJSON("empty")#
					}]
		}
		</cfoutput>
	</cfif>
		<cfcatch>
			<cfoutput>
				"success": "true",
				"levellk": [{
						"levelcode":"error", 
						"levelname": #SerializeJson(cfcatch.Detail & ' ' & cfcatch.Message)#
					}]
				}
			</cfoutput>
		</cfcatch>
	</cftry>
	</cffunction>
	
	<cffunction
			name="getcostcenter"
			returntype="void"
			
	>
	<cftry>
		
		<cfquery name="qrycostcenter" datasource="FBC_CBOSE">
			SELECT COSTCENTERCODE, DESCRIPTION
			  FROM CLKCOSTCENTERS;
		</cfquery>
	
	<cfif isdefined("qrycostcenter") >
		<cfoutput>
		{
		"success": "true",
		"costcenterlk": [
				<cfset ecounter = 1 >
				<cfset querylen = qrycostcenter.recordcount >
				<cfloop query="qrycostcenter">
					{
						"costcentercode": #SerializeJSON(COSTCENTERCODE)#, 
						"costcentername": #SerializeJSON(DESCRIPTION)#
					}
					<cfif querylen NEQ ecounter>
						<cfoutput>,</cfoutput>
				    </cfif>
				    <cfset ecounter = ecounter + 1 >
				    
		        </cfloop>
		]
		}
		</cfoutput>
	<cfelse>
		<cfoutput>
		{
		"success": "true",
		"costcenterlk": [{
						"costcentercode": #SerializeJSON("empty")#, 
						"costcentername": #SerializeJSON("empty")#
					}]
		}
		</cfoutput>
	</cfif>
		<cfcatch>
			<cfoutput>
				"success": "true",
				"costcenterlk": [{
						"costcentercode":"error", 
						"costcentername": #SerializeJson(cfcatch.Detail & ' ' & cfcatch.Message)#
					}]
				}
			</cfoutput>
		</cfcatch>
	</cftry>
	</cffunction>
	
	<cffunction
			name="getbrand"
			returntype="void"
			
	>
	<cftry>
		
		<cfquery name="qrybrand" datasource="FBC_CBOSE">
			SELECT CODE, DESCRIPTION
			  FROM CLKBRANDORCLIENT;
		</cfquery>
	
	<cfif isdefined("qrybrand") >
		<cfoutput>
		{
		"success": "true",
		"brandlk": [
				<cfset ecounter = 1 >
				<cfset querylen = qrybrand.recordcount >
				<cfloop query="qrybrand">
					{
						"brandcode": #SerializeJSON(CODE)#, 
						"brandname": #SerializeJSON(DESCRIPTION)#
					}
					<cfif querylen NEQ ecounter>
						<cfoutput>,</cfoutput>
				    </cfif>
				    <cfset ecounter = ecounter + 1 >
				    
		        </cfloop>
		]
		}
		</cfoutput>
	<cfelse>
		<cfoutput>
		{
		"success": "true",
		"brandlk": [{
						"brandcode": #SerializeJSON("empty")#, 
						"brandname": #SerializeJSON("empty")#
					}]
		}
		</cfoutput>
	</cfif>
		<cfcatch>
			<cfoutput>
				"success": "true",
				"brandlk": [{
						"brandcode":"error", 
						"brandname": #SerializeJson(cfcatch.Detail & ' ' & cfcatch.Message)#
					}]
				}
			</cfoutput>
		</cfcatch>
	</cftry>
	</cffunction>
	
	<cffunction
			name="getdivision"
			returntype="void"
			
	>
	<cftry>
		
		<cfquery name="qrydivision" datasource="FBC_CBOSE">
			SELECT DIVISIONCODE, DESCRIPTION
			  FROM CLKDIVISION;
		</cfquery>
	
	<cfif isdefined("qrydivision") >
		<cfoutput>
		{
		"success": "true",
		"divisionlk": [
				<cfset ecounter = 1 >
				<cfset querylen = qrydivision.recordcount >
				<cfloop query="qrydivision">
					{
						"divisioncode": #SerializeJSON(DIVISIONCODE)#, 
						"divisionname": #SerializeJSON(DESCRIPTION)#
					}
					<cfif querylen NEQ ecounter>
						<cfoutput>,</cfoutput>
				    </cfif>
				    <cfset ecounter = ecounter + 1 >
				    
		        </cfloop>
		]
		}
		</cfoutput>
	<cfelse>
		<cfoutput>
		{
		"success": "true",
		"divisionlk": [{
						"divisioncode": #SerializeJSON("empty")#, 
						"divisionname": #SerializeJSON("empty")#
					}]
		}
		</cfoutput>
	</cfif>
		<cfcatch>
			<cfoutput>
				"success": "true",
				"divisionlk": [{
						"divisioncode":"error", 
						"divisionname": #SerializeJson(cfcatch.Detail & ' ' & cfcatch.Message)#
					}]
				}
			</cfoutput>
		</cfcatch>
	</cftry>
	</cffunction>
	
	<cffunction
			name="getsection"
			returntype="void"
			
	>
	<cftry>
		
		<cfquery name="qrysection" datasource="FBC_CBOSE">
			SELECT SECTIONCODE, DESCRIPTION
			  FROM CLKSECTION;
		</cfquery>
	
	<cfif isdefined("qrysection") >
		<cfoutput>
		{
		"success": "true",
		"sectionlk": [
				<cfset ecounter = 1 >
				<cfset querylen = qrysection.recordcount >
				<cfloop query="qrysection">
					{
						"sectioncode": #SerializeJSON(SECTIONCODE)#, 
						"sectionname": #SerializeJSON(DESCRIPTION)#
					}
					<cfif querylen NEQ ecounter> 
						<cfoutput>,</cfoutput>
				    </cfif>
				    <cfset ecounter = ecounter + 1 >
				    
		        </cfloop>
		]
		}
		</cfoutput>
	<cfelse>
		<cfoutput>
		{
		"success": "true",
		"sectionlk": [{
						"sectioncode": #SerializeJSON("empty")#, 
						"sectionname": #SerializeJSON("empty")#
					}]
		}
		</cfoutput>
	</cfif>
		<cfcatch>
			<cfoutput>
				"success": "true",
				"sectionlk": [{
						"sectioncode":"error", 
						"sectionname": #SerializeJson(cfcatch.Detail & ' ' & cfcatch.Message)#
					}]
				}
			</cfoutput>
		</cfcatch>
	</cftry>
	</cffunction>
	
	<cffunction
			name="getemploymentstatus"
			returntype="void"
			
	>
	<cftry>
		
		<cfquery name="qryemploymentstatus" datasource="FBC_CBOSE">
			SELECT STATUSCODE, DESCRIPTION
			  FROM CLKSTATUSCODE;
		</cfquery>
	
	<cfif isdefined("qryemploymentstatus") >
		<cfoutput>
		{
		"success": "true",
		"employmentstatuslk": [
				<cfset ecounter = 1 >
				<cfset querylen = qryemploymentstatus.recordcount >
				<cfloop query="qryemploymentstatus">
					{
						"employmentstatuscode": #SerializeJSON(STATUSCODE)#, 
						"employmentstatusname": #SerializeJSON(DESCRIPTION)#
					}
					<cfif querylen NEQ ecounter> 
						<cfoutput>,</cfoutput>
				    </cfif>
				    <cfset ecounter = ecounter + 1 >
				    
		        </cfloop>
		]
		}
		</cfoutput>
	<cfelse>
		<cfoutput>
		{
		"success": "true",
		"employmentstatuslk": [{
						"employmentstatuscode": #SerializeJSON("empty")#, 
						"employmentstatusname": #SerializeJSON("empty")#
					}]
		}
		</cfoutput>
	</cfif>
		<cfcatch>
			<cfoutput>
				"success": "true",
				"employmentstatuslk": [{
						"employmentstatuscode":"error", 
						"employmentstatusname": #SerializeJson(cfcatch.Detail & ' ' & cfcatch.Message)#
					}]
				}
			</cfoutput>
		</cfcatch>
	</cftry>
	</cffunction>
	
	<cffunction
			name="getcauseofseparation"
			returntype="void"
			
	>
	<cftry>
		
		<cfquery name="qrycauseofseparation" datasource="FBC_CBOSE">
			SELECT CAUSEOFSEPARATIONCODE,  DESCRIPTION
			  FROM CLKCAUSEOFSEPARATION;  
		</cfquery>
	
	<cfif isdefined("qrycauseofseparation") >
		<cfoutput>
		{
		"success": "true",
		"causeofseparationlk": [
				<cfset ecounter = 1 >
				<cfset querylen = qrycauseofseparation.recordcount >
				<cfloop query="qrycauseofseparation">
					{
						"causeofseparationcode": #SerializeJSON(CAUSEOFSEPARATIONCODE)#, 
						"causeofseparationname": #SerializeJSON(DESCRIPTION)#
					}
					<cfif querylen NEQ ecounter> 
						<cfoutput>,</cfoutput>
				    </cfif>
				    <cfset ecounter = ecounter + 1 >
				    
		        </cfloop>
		]
		}
		</cfoutput>
	<cfelse>
		<cfoutput>
		{
		"success": "true",
		"causeofseparationlk": [{
						"causeofseparationcode": #SerializeJSON("empty")#, 
						"causeofseparationname": #SerializeJSON("empty")#
					}]
		}
		</cfoutput>
	</cfif>
		<cfcatch>
			<cfoutput>
				"success": "true",
				"causeofseparationlk": [{
						"causeofseparationcode":"error", 
						"causeofseparationname": #SerializeJson(cfcatch.Detail & ' ' & cfcatch.Message)#
					}]
				}
			</cfoutput>
		</cfcatch>
	</cftry>
	</cffunction>


</cfcomponent>