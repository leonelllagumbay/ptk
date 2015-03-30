<cftry>
	
	<cfif form.action eq "insert" >
		<cfloop from="1" to="#ListLen(form.noofcasuals,',',true)#" index="listIndex" >
			<cfset dtype = ListGetAt(form.dutytype,listIndex,',',true)  >
			<cfset daten = ListGetAt(form.dateneeded,listIndex,',',true)  >
			<cfset nagency = ListGetAt(form.nameofagency,listIndex,',',true)  >
			<cfset ncasual = ListGetAt(form.noofcasuals,listIndex,',',true)  >
			<cfset hpd = ListGetAt(form.hoursperday,listIndex,',',true)  >
			<cfset nod = ListGetAt(form.noofdays,listIndex,',',true)  >
			<cfset rh = ListGetAt(form.reghr,listIndex,',',true)  >
			<cfset ot = ListGetAt(form.othr,listIndex,',',true)  >
			<cfset nh = ListGetAt(form.ndhr,listIndex,',',true)  >
			<cfset dnum = form.docnum >
			
			<cfquery name="isRecExist" datasource="#session.company_dsn#" >
				INSERT INTO ECINCRFEXTRA
				(DOCNUMBER, DUTYTYPE, DATENEEDED, NAMEOFAGENCY, NOOFCASUALS, NOOFHOURSPERDAY, NOOFDAYS, REGHR, OTHR, NDHR)
				VALUES
				(<cfqueryparam cfsqltype="cf_sql_varchar" value="#dnum#">, 
				 <cfqueryparam cfsqltype="cf_sql_varchar" value="#dtype#">, 
				 <cfqueryparam cfsqltype="cf_sql_date" value="#daten#">, 
				 <cfqueryparam cfsqltype="cf_sql_varchar" value="#nagency#">,
				 <cfqueryparam cfsqltype="cf_sql_integer" value="#ncasual#">,
				 <cfqueryparam cfsqltype="cf_sql_integer" value="#hpd#">,
				 <cfqueryparam cfsqltype="cf_sql_integer" value="#nod#">,
				 <cfqueryparam cfsqltype="cf_sql_integer" value="#rh#">,
				 <cfqueryparam cfsqltype="cf_sql_integer" value="#ot#">,
				 <cfqueryparam cfsqltype="cf_sql_integer" value="#nh#">
				);
			</cfquery>
		</cfloop>
		<cfoutput>#true#</cfoutput>
	<cfelseif form.action eq "getrec" >
		<cfif lcase(trim(form.personnelidno)) eq "#lcase(session.chapa)#" >
			<cfset strSeries = "false~" >
		<cfelse>
			<cfset strSeries = "true~" >
		</cfif>
		
		<cfset startCnt = 1 >
		<cfquery name="qryDuty" datasource="#session.company_dsn#" >
			SELECT DUTYTYPE, DATENEEDED, NAMEOFAGENCY, NOOFCASUALS, NOOFHOURSPERDAY, NOOFDAYS, REGHR, OTHR, NDHR
			  FROM ECINCRFEXTRA
			 WHERE DOCNUMBER = '#form.docnum#'
		</cfquery>
		<cfloop query="qryDuty">
			<cfset strSeries = strSeries & "#DUTYTYPE#,#dateformat(DATENEEDED, 'YYYY-MM-DD')#,#NAMEOFAGENCY#,#NOOFCASUALS#,#NOOFHOURSPERDAY#,#NOOFDAYS#,#REGHR#,#OTHR#,#NDHR#" >
	    	<cfif startCnt neq qryDuty.recordcount >
	    		<cfset strSeries = strSeries & "~" >
	    	</cfif>
	    	<cfset startCnt += 1 >
	    </cfloop>
	    <cfoutput>#strSeries#</cfoutput>
	<cfelse>
		<cfloop from="1" to="#ListLen(form.noofcasuals,',',true)#" index="listIndex" >
			<cfset dtype = ListGetAt(form.dutytype,listIndex,',',true)  >
			<cfset daten = ListGetAt(form.dateneeded,listIndex,',',true)  >
			<cfset nagency = ListGetAt(form.nameofagency,listIndex,',',true)  >
			<cfset ncasual = ListGetAt(form.noofcasuals,listIndex,',',true)  >
			<cfset hpd = ListGetAt(form.hoursperday,listIndex,',',true)  >
			<cfset nod = ListGetAt(form.noofdays,listIndex,',',true)  >
			<cfset rh = ListGetAt(form.reghr,listIndex,',',true)  >
			<cfset ot = ListGetAt(form.othr,listIndex,',',true)  >
			<cfset nh = ListGetAt(form.ndhr,listIndex,',',true)  >
			<cfset dnum = form.docnum >
			<cfset dpid = form.personnelidno  >
			
			<cfif ucase(trim(dpid)) eq ucase(session.chapa) >
			
				<cfif dtype eq "REGULAR" OR dtype eq "HOLIDAY">
					<cfquery name="isRecExist" datasource="#session.company_dsn#" >
						SELECT DOCNUMBER
						  FROM ECINCRFEXTRA
						 WHERE DUTYTYPE = '#dtype#'
						       AND DOCNUMBER = '#dnum#'
						       AND DATENEEDED = '#daten#'
						       AND NAMEOFAGENCY = '#nagency#'
					</cfquery>
					<cfif isRecExist.recordcount gt 0 >
						<cfquery name="udtTo" datasource="#session.company_dsn#" >
							UPDATE ECINCRFEXTRA
							SET NOOFCASUALS = <cfqueryparam cfsqltype="cf_sql_integer" value="#ncasual#">,
								NOOFHOURSPERDAY = <cfqueryparam cfsqltype="cf_sql_integer" value="#hpd#">,
								NOOFDAYS = <cfqueryparam cfsqltype="cf_sql_integer" value="#nod#">,
								REGHR = <cfqueryparam cfsqltype="cf_sql_integer" value="#rh#">,
								OTHR = <cfqueryparam cfsqltype="cf_sql_integer" value="#ot#">,
								NDHR = <cfqueryparam cfsqltype="cf_sql_integer" value="#nh#">
							WHERE  DUTYTYPE = '#dtype#'
							       AND DOCNUMBER = '#dnum#'
							       AND DATENEEDED = '#daten#'
							       AND NAMEOFAGENCY = '#nagency#';
						</cfquery>
					<cfelse>
						<cfquery name="insTo" datasource="#session.company_dsn#" >
							INSERT INTO ECINCRFEXTRA
							(DOCNUMBER, DUTYTYPE, DATENEEDED, NAMEOFAGENCY, NOOFCASUALS, NOOFHOURSPERDAY, NOOFDAYS, REGHR, OTHR, NDHR)
							VALUES
							(<cfqueryparam cfsqltype="cf_sql_varchar" value="#dnum#">, 
							 <cfqueryparam cfsqltype="cf_sql_varchar" value="#dtype#">, 
							 <cfqueryparam cfsqltype="cf_sql_date" value="#daten#">, 
							 <cfqueryparam cfsqltype="cf_sql_varchar" value="#nagency#">,
							 <cfqueryparam cfsqltype="cf_sql_integer" value="#ncasual#">,
							 <cfqueryparam cfsqltype="cf_sql_integer" value="#hpd#">,
							 <cfqueryparam cfsqltype="cf_sql_integer" value="#nod#">,
							 <cfqueryparam cfsqltype="cf_sql_integer" value="#rh#">,
							 <cfqueryparam cfsqltype="cf_sql_integer" value="#ot#">,
							 <cfqueryparam cfsqltype="cf_sql_integer" value="#nh#">
							);
						</cfquery>
					</cfif>
				<cfelse> <!---holiday - include duplicate entries--->
				
				</cfif>
			
			
			
			<cfelse>
			
			</cfif>
		</cfloop>
		<cfoutput>#true#</cfoutput>
	</cfif>
	

	
	<cfcatch>
		<cfoutput>#cfcatch.message# - #cfcatch.detail#</cfoutput>
	</cfcatch>
</cftry>

<cfsetting showdebugoutput="false">