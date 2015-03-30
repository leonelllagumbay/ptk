<cftry>
	 <cfif isDefined("form.filename")>
    	<cfset myfolder = "../../unDB/images/globalphoto/" >
    	<cfset destin = "#expandpath(myfolder)#" />
    	<cffile action   = "upload"
            fileField   = "filename"
            destination = "#destin#"
            mode = "777"
            result="fileuploadresult"
            nameconflict="MakeUnique">

        <cfset theimageserverfilename = fileuploadresult.serverfile >
        <cfif ucase(fileuploadresult.FILEWASSAVED) eq 'YES' >
			 <cfif isdefined('form.LASTNAME')>
             	<cfinvoke method="saverecord" theimageserverfilename="#theimageserverfilename#" />
             </cfif>
        <cfelse>
        </cfif>
	 <cfelse>
     </cfif>
<cfcatch type="Any">
  	<cfinvoke method="saverecord" theimageserverfilename="x">
</cfcatch>
</cftry>




<cffunction name="saverecord" access="public" output="true">
<cfargument name="theimageserverfilename">

<cfparam default="x" name="theimageserverfilename">

<cfset theguuiidd = dateformat(now(),"YYYYMMDD") & timeformat(now(),"HHMMSS") & createuuid() />
<cfset form.REFERENCECODE = theguuiidd >


<cfif trim(form.POSTGRADSCHOOL) neq "" >
	<cfquery name="checkExistence" datasource="#client.global_dsn#" maxrows="1">
	     SELECT SCHOOLNAME
	      FROM GLKSCHOOL
	     WHERE SCHOOLCODE = '#trim(form.POSTGRADSCHOOL)#';
	</cfquery>
	<cfif checkExistence.RecordCount EQ 0 >
	<cfset uniqueguuid = Right(CreateUUID(), 20) />
		<cfquery name="insertschoolpost" datasource="#client.global_dsn#">
	        INSERT INTO GLKSCHOOL (SCHOOLCODE, SCHOOLNAME)
	         VALUES (
	         <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.POSTGRADSCHOOL)#"/>,
	         <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.POSTGRADSCHOOL)#"/>);
	    </cfquery>
	</cfif>
</cfif>

<cfif trim(form.POSTGRADCOURSE) neq "" >
	<cfquery name="checkExistence2" datasource="#client.global_dsn#" >
	    SELECT DESCRIPTION
	      FROM GLKCOURSE
	     WHERE COURSECODE = '#trim(form.POSTGRADCOURSE)#';
	</cfquery>
	<cfif checkExistence2.RecordCount EQ 0>
	<cfset uniqueguuid = Right(CreateUUID(), 20) />
		<cfquery name="insertcoursepost" datasource="#client.global_dsn#">
	        INSERT INTO GLKCOURSE (COURSECODE, DESCRIPTION)
	         VALUES (
	         <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.POSTGRADCOURSE)#"/>,
	         <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.POSTGRADCOURSE)#"/>);
	    </cfquery>
	</cfif>
</cfif>

<cfloop from="1" to="#ListLen(form.COLLEGESCHOOL,",",true)#" index="ind">
	<cfif trim(ListGetAt(form.COLLEGESCHOOL,ind,",",true)) neq "">
		<cfif trim(ListGetAt(form.COLLEGESCHOOL,ind,",",true)) neq "" >
			<cfquery name="checkExistence3" datasource="#client.global_dsn#" maxrows="1" >
			    SELECT SCHOOLNAME
			      FROM GLKSCHOOL
			     WHERE SCHOOLCODE = '#trim(ListGetAt(form.COLLEGESCHOOL,ind,",",true))#';
			</cfquery>
			<cfif checkExistence3.RecordCount EQ 0>
			<cfset uniqueguuid = Right(CreateUUID(), 20) />
				<cfquery name="insertschoolcol" datasource="#client.global_dsn#">
			        INSERT INTO GLKSCHOOL (SCHOOLCODE, SCHOOLNAME)
			         VALUES (
			         <cfqueryparam cfsqltype="cf_sql_varchar" value="#uniqueguuid#"/>,
			         <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(ListGetAt(form.COLLEGESCHOOL,ind,",",true))#"/>);
			    </cfquery>
			</cfif>
		</cfif>

		<cfif trim(ListGetAt(form.COLLEGECOURSE,ind,",",true)) neq "" >
			<cfquery name="checkExistence4" datasource="#client.global_dsn#"  maxrows="1">
			    SELECT DESCRIPTION
			      FROM GLKCOURSE
			     WHERE COURSECODE = '#trim(ListGetAt(form.COLLEGECOURSE,ind,",",true))#';
			</cfquery>
			<cfif checkExistence4.RecordCount EQ 0>
			<cfset uniqueguuid = Right(CreateUUID(), 20) />
				<cfquery name="insertcoursecol" datasource="#client.global_dsn#">
			        INSERT INTO GLKCOURSE (COURSECODE, DESCRIPTION)
			         VALUES (
			         <cfqueryparam cfsqltype="cf_sql_varchar" value="#uniqueguuid#"/>,
			         <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(ListGetAt(form.COLLEGECOURSE,ind,",",true))#"/>);
			    </cfquery>
			</cfif>
		</cfif>
	</cfif>
</cfloop>



<cfif trim(form.VOCATIONALSCHOOL) neq "" >
	<cfquery name="checkExistence5" datasource="#client.global_dsn#" maxrows="1" >
	    SELECT SCHOOLNAME
	      FROM GLKSCHOOL
	     WHERE SCHOOLCODE = '#trim(form.VOCATIONALSCHOOL)#';
	</cfquery>
	<cfif checkExistence5.RecordCount EQ 0>
	<cfset uniqueguuid = Right(CreateUUID(), 20) />
		<cfquery name="insertschollvoc" datasource="#client.global_dsn#">
	        INSERT INTO GLKSCHOOL (SCHOOLCODE, SCHOOLNAME)
	         VALUES (
	         <cfqueryparam cfsqltype="cf_sql_varchar" value="#uniqueguuid#"/>,
	         <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.VOCATIONALSCHOOL)#"/>);
	    </cfquery>
	</cfif>
</cfif>

<cfif trim(form.VOCATIONALCOURSE) neq "" >
	<cfquery name="checkExistence6" datasource="#client.global_dsn#" maxrows="1">
	    SELECT DESCRIPTION
	      FROM GLKCOURSE
	     WHERE COURSECODE = '#trim(form.VOCATIONALCOURSE)#';
	</cfquery>
	<cfif checkExistence6.RecordCount EQ 0>
	<cfset uniqueguuid = Right(CreateUUID(), 20) />
		<cfquery name="insertcoursevoc" datasource="#client.global_dsn#">
	        INSERT INTO GLKCOURSE (COURSECODE, DESCRIPTION)
	         VALUES (
	         <cfqueryparam cfsqltype="cf_sql_varchar" value="#uniqueguuid#"/>,
	         <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.VOCATIONALCOURSE)#"/>);
	    </cfquery>
	</cfif>
</cfif>

<cfif trim(form.SECONDARYSCHOOL) neq "" >
	<cfquery name="checkExistence7" datasource="#client.global_dsn#" maxrows="1" >
	    SELECT SCHOOLNAME
	      FROM GLKSCHOOL
	     WHERE SCHOOLCODE = '#trim(form.SECONDARYSCHOOL)#';
	</cfquery>
	<cfif checkExistence7.RecordCount EQ 0>
	<cfset uniqueguuid = Right(CreateUUID(), 20) />
		<cfquery name="insertschoolsec" datasource="#client.global_dsn#">
	        INSERT INTO GLKSCHOOL (SCHOOLCODE, SCHOOLNAME)
	         VALUES (
	         <cfqueryparam cfsqltype="cf_sql_varchar" value="#uniqueguuid#"/>,
	         <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.SECONDARYSCHOOL)#"/>);
	    </cfquery>
	</cfif>
</cfif>

<cfif trim(form.SECONDARYCOURSE) neq "" >
	<cfquery name="checkExistence8" datasource="#client.global_dsn#" maxrows="1">
	    SELECT DESCRIPTION
	      FROM GLKCOURSE
	     WHERE COURSECODE = '#trim(form.SECONDARYCOURSE)#';
	</cfquery>
	<cfif checkExistence8.RecordCount EQ 0>
	<cfset uniqueguuid = Right(CreateUUID(), 20) />
		<cfquery name="insertsec" datasource="#client.global_dsn#">
	       INSERT INTO GLKCOURSE (COURSECODE, DESCRIPTION)
	        VALUES(
	        <cfqueryparam cfsqltype="cf_sql_varchar" value="#uniqueguuid#"/>,
	        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.SECONDARYCOURSE)#"/>);
	    </cfquery>
	</cfif>
</cfif>

<cftry>

<cfscript>

	    form.PHOTOIDNAME = theimageserverfilename;


    	guid = "G#dateformat(now(),'YYYYMMDD')##timeformat(now(),'HHMMSS')##right(createuuid(),5)#";
    	applicantnumber = "A#dateformat(now(),'YYYYMMDD')##timeformat(now(),'HHMMSS')##right(createuuid(),5)#";

    	onlineAppRef = CreateObject("component","OnlineApplication");

		onlineAppRef.insertIntoEgmfap(guid,applicantnumber);

		onlineAppRef.insertIntoEgin21personalinfo(guid,applicantnumber);

		onlineAppRef.insertIntoEgin21positnapld(guid,applicantnumber);

		if(trim(form.FATHERFULLNAME) != "" && ucase(trim(form.FATHERFULLNAME)) != "NA" && ucase(trim(form.FATHERFULLNAME)) != "N/A")
		{
			onlineAppRef.insertIntoEgin21familybkgrnd(guid,applicantnumber,"FATHER","FATHER",1);
		}
		if(trim(form.MOTHERFULLNAME) != "" && ucase(trim(form.MOTHERFULLNAME)) != "NA" && ucase(trim(form.MOTHERFULLNAME)) != "N/A")
		{
			onlineAppRef.insertIntoEgin21familybkgrnd(guid,applicantnumber,"MOTHER","MOTHER",1);
		}
		if(trim(form.SPOUSEFULLNAME) != "" && ucase(trim(form.SPOUSEFULLNAME)) != "NA" && ucase(trim(form.SPOUSEFULLNAME)) != "N/A") {
			onlineAppRef.insertIntoEgin21familybkgrnd(guid,applicantnumber,"SPOUSE","SPOUSE",1);
		}

		if(Isdefined("form.CHILDFULLNAME")) {
			for(a=1; a<=ListLen(form.CHILDFULLNAME,",",true); a++) {
				if(trim(ListGetAt(form.CHILDFULLNAME,a,",",true)) != "" && ucase(trim(ListGetAt(form.CHILDFULLNAME,a,",",true))) != "NA" && ucase(trim(ListGetAt(form.CHILDFULLNAME,a,",",true))) != "N/A") {
					onlineAppRef.insertIntoEgin21familybkgrnd(guid,applicantnumber,"CHILD","SON OR DAUGHTER", a);
				}
			}
		}

		if(Isdefined("form.BROFULLNAME")) {
			for(a=1; a<=ListLen(form.BROFULLNAME,",",true); a++) {
				if(trim(ListGetAt(form.BROFULLNAME,a,",",true)) != "" && ucase(trim(ListGetAt(form.BROFULLNAME,a,",",true))) != "NA" && ucase(trim(ListGetAt(form.BROFULLNAME,a,",",true))) != "N/A") {
					onlineAppRef.insertIntoEgin21familybkgrnd(guid,applicantnumber,"BRO","BRO OR SIS",a);
				}
			}
		}

		onlineAppRef.insertIntoEgin21education(guid,applicantnumber);

		if(Isdefined("form.EXTRAORGNAME")) {
			for(a=1; a<=ListLen(form.EXTRAORGNAME,",",true); a++) {
				if(trim(ListGetAt(form.EXTRAORGNAME,a,",",true)) != "" && ucase(trim(ListGetAt(form.EXTRAORGNAME,a,",",true))) != "NA" && ucase(trim(ListGetAt(form.EXTRAORGNAME,a,",",true))) != "N/A") {
					onlineAppRef.insertIntoEgin21empextra(guid,applicantnumber,a);
				}
			}
		}

		if(Isdefined("form.GOVEXAMPASSED")) {
			for(a=1; a<=ListLen(form.GOVEXAMPASSED,",",true); a++) {
				if(trim(ListGetAt(form.GOVEXAMPASSED,a,",",true)) != "" && ucase(trim(ListGetAt(form.GOVEXAMPASSED,a,",",true))) != "NA" && ucase(trim(ListGetAt(form.GOVEXAMPASSED,a,",",true))) != "N/A") {
					onlineAppRef.insertIntoEgin21exampass(guid,applicantnumber,a);
				}
			}
		}

		onlineAppRef.insertIntoEgin21achievements(guid,applicantnumber);

		onlineAppRef.insertIntoEgin21medhistory(guid,applicantnumber);

		if(Isdefined("form.SEMINARTOPIC")) {
			for(a=1; a<=ListLen(form.SEMINARTOPIC,",",true); a++) {
				if(trim(ListGetAt(form.SEMINARTOPIC,a,",",true)) != "" && ucase(trim(ListGetAt(form.SEMINARTOPIC,a,",",true))) != "NA" && ucase(trim(ListGetAt(form.SEMINARTOPIC,a,",",true))) != "N/A") {
					onlineAppRef.insertIntoEgin21training(guid,applicantnumber,a);
				}
			}
		}

		if(Isdefined("form.EMPHISTORYNAME")) {
			for(a=1; a<=ListLen(form.EMPHISTORYNAME,",",true); a++) {
				if(trim(ListGetAt(form.EMPHISTORYNAME,a,",",true)) != "" && ucase(trim(ListGetAt(form.EMPHISTORYNAME,a,",",true))) != "NA" && ucase(trim(ListGetAt(form.EMPHISTORYNAME,a,",",true))) != "N/A") {
					onlineAppRef.insertIntoEgin21workhistory(guid,applicantnumber,a);
				}
			}
		}


		onlineAppRef.insertIntoEgin21relative(guid,applicantnumber);

		if(Isdefined("form.SPECIALSKILLS")) {
			for(a=1; a<=ListLen(form.SPECIALSKILLS,",",true); a++) {
				if(trim(ListGetAt(form.SPECIALSKILLS,a,",",true)) != "" && ucase(trim(ListGetAt(form.SPECIALSKILLS,a,",",true))) != "NA" && ucase(trim(ListGetAt(form.SPECIALSKILLS,a,",",true))) != "N/A") {
					onlineAppRef.insertIntoEgin21miscinfo1(guid,applicantnumber,a);
				}
			}
		}


		onlineAppRef.insertIntoEgin21chareference(guid,applicantnumber);
		onlineAppRef.insertIntoEgin21empviol(guid,applicantnumber);

</cfscript>

  <cfif ucase(trim(form.SEQREFERENCE)) NEQ "NOREVERT" >
	 <cftry>
		<cfquery name="getMaxApplHoldTime" datasource="IBOSE_GLOBAL" maxrows="1">
			SELECT CONFIGVALUE
			  FROM EGRGRECRUITMENTCONFIG
			 WHERE NAME = 'MAXAPPLHOLDTIME'
		</cfquery>
		<cfif getMaxApplHoldTime.recordcount GT 0 >
			<cfset confvalue = getMaxApplHoldTime.CONFIGVALUE >
		<cfelse>
			<cfset confvalue = 50 >
		</cfif>
		<cfset startingDate = dateformat(dateadd('d',confvalue,now()), 'MM/DD/YYYY') >
		<cfset endingDate   = dateformat(dateadd('d',5,startingDate), 'MM/DD/YYYY') >
		<cfschedule
		    action = "update"
		    task = "#theguuiidd#"
			group="RECRUITMENT"
		    endDate = "#endingDate#"
		    endTime = "12:05 AM"
		    requestTimeOut = "420"
		    interval="daily"
		    startDate = "#startingDate#"
		    startTime = "10:00 PM"
		    url = "#client.domain#myapps/recruitment/scheduledtask/release.cfm?referencecode=#theguuiidd#globaldsn=IBOSE_GLOBAL"
		    operation="HTTPRequest"
		>
		<cfcatch type="any">
		</cfcatch>
	</cftry>
  </cfif>

    <cfoutput>
	{
	"success": true,
	"form": [{
		"detail": #serializejson("Your application has been filed and will be included in the database for proper screening of #client.companyname# Recruitment Team. Your reference code: #Right(theguuiidd, 8)#")#,
		"message": "Submission successful."
	}]
	}
	</cfoutput>
    <cfsetting showdebugoutput="no" >

<cfcatch type="any">

	<cfscript>
		onlineAppRef = CreateObject("component","OnlineApplication");
		result = onlineAppRef.rollBackInsertedGobalPool();
	</cfscript>
	<cfif theimageserverfilename neq "x">
		 <cfset myfolder = "../../unDB/images/globalphoto/#theimageserverfilename#" >
		 <cfset destin = "#expandpath(myfolder)#" />
		   <cftry>
				<cffile
			    	action = "delete"
			    	file = "#destin#">

		    <cfcatch>
		    	<cfoutput>
				{
				"form": [{
					"detail": #serializejson("#cfcatch.detail#")#,
					"message": #serializejson("#cfcatch.message#")#
				}]
				}
				</cfoutput>
		    </cfcatch>
		   </cftry>

	</cfif>
	<cfoutput>
	{
	"form": [{
		"detail": #serializejson("#cfcatch.detail#")#,
		"message": #serializejson("#cfcatch.message#")#
	}]
	}
	</cfoutput>

	<cfsetting showdebugoutput="no" >

</cfcatch>
</cftry>
</cffunction>

