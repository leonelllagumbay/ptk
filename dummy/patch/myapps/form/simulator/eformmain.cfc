<cfcomponent name="eformmain" ExtDirect="true">

<cffunction name="getInitialRecords" ExtDirect="true">
	<cfreturn "empty" >
</cffunction>
	
<cffunction name="getMainDetails" ExtDirect="true">
<cfargument name="datareference" >
<cftry>
<cfset jsonrepresent = StructNew() >
<cfset dataArr = arraynew(1) >

<cfset middlejson = structnew() >
<cfset middlejson['EFORMTABLEID'] = 'EFORMTABLEID' >
<cfset middlejson['PROCESSIDFK'] = 'PROCESSIDFK' >
<cfset middlejson['EFORMIDFK'] = datareference >
<cfset middlejson['MAINTABLEIDFK'] = 'MAINTABLEIDFK' >
<cfset middlejson['STATUS'] = 'STATUS' >
<cfset middlejson['RECCREATEDBY'] = 'RECCREATEDBY' >
<cfset middlejson['RECDATECREATED'] = 'RECDATECREATED' >
<cfset middlejson['DATELASTUPDATE'] = 'DATELASTUPDATE' >
<cfset middlejson['CHECKBOXSAMPLE'] = 'right' >
<cfset middlejson['COMBOBOXSAMPLE'] = 'COMBOBOXSAMPLE' >
<cfset middlejson['DATESAMPLE'] = Dateformat(now(), "YYYY-MM-DD") >
<cfset middlejson['DISPLAYSAMPLE'] = 'DISPLAYSAMPLE' >
<cfset middlejson['FILESAMPLE'] = 'FILESAMPLE' >
<cfset middlejson['HIDDENSAMPLE'] = 'HIDDENSAMPLE' >
<cfset middlejson['HTMLEDITORSAMPLE'] = 'HTMLEDITORSAMPLE' >
<cfset middlejson['NUMBERSAMPLE'] = 45 >
<cfset middlejson['RADIOSAMPLE'] = 'top' >
<cfset middlejson['TEXTSAMPLE'] = 'TEXTSAMPLE' >
<cfset middlejson['TEXTAREASAMPLE'] = 'TEXTAREASAMPLE' >
<cfset middlejson['TIMESAMPLE'] = '10:00 AM' >

<cfset dataArr[1] = middlejson >
<cfset jsonrepresent['success'] = "true" >
<cfset jsonrepresent['data'] = middlejson >
<cfreturn jsonrepresent />
<cfcatch>
	<cfreturn cfcatch.detail & ' - ' & cfcatch.message >
</cfcatch>
</cftry>
	<cfreturn "main details" >
</cffunction>

<cffunction name="addeForm" ExtDirect="true" ExtFormHandler="true">   
<cftry>

<cfset eformtableid = createuuid() >
<cfset processData = EntityNew("EGINEFORMTABLE") >   
<cfset processData.setEFORMTABLEID("#createuuid()#") >
<cfset processData.setPROCESSIDFK("#form.PROCESSIDFK#") >
<cfset processData.setEFORMIDFK("#form.EFORMIDFK#") >
<cfset processData.setMAINTABLEIDFK("#eformtableid#") >
<cfset processData.setSTATUS("#form.STATUS#") >
<cfset processData.setRECCREATEDBY("#client.userid#") > 
<cfset processData.setRECDATECREATED("#dateformat(now(), 'YYYY-MM-DD')#") >
<cfset processData.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')#") >

<cfset EntitySave(processData) >
<cfset ormflush()>

<cfquery name="inserttoeginsample" datasource="IBOSEDATA" >
	INSERT INTO EGINSAMPLE (ID, 
							CHECKBOXSAMPLE,
							COMBOBOXSAMPLE,
							DATESAMPLE,
							DISPLAYSAMPLE,
							FILESAMPLE,
							HIDDENSAMPLE,
							HTMLEDITORSAMPLE,
							NUMBERSAMPLE,
							RADIOSAMPLE,
							TEXTSAMPLE,
							TEXTSAMPLE,
							TEXTAREASAMPLE,
							TIMESAMPLE
							)
	VALUES ('#eformtableid#',
			'#form.CHECKBOXSAMPLE#',
			'#form.COMBOBOXSAMPLE#',
			'#form.DATESAMPLE#',   
			'#form.DISPLAYSAMPLE#',
			'#form.FILESAMPLE#',
			'#form.HIDDENSAMPLE#',
			'#form.HTMLEDITORSAMPLE#',
			'#form.NUMBERSAMPLE#',
			'#form.RADIOSAMPLE#',
			'#form.TEXTSAMPLE#',
			'#form.TEXTAREASAMPLE#',
			'#form.TIMESAMPLE#'
			)
</cfquery>

<cfset returnStruct = StructNew() >
<cfset returnStruct['success'] = "true" >
<cfset returnStruct['data']=form.EFORMNAME >
<cfreturn returnStruct >
<cfcatch>
	<cftry>
	<cfset processData = EntityLoad("EGINEFORMTABLE", {MAINTABLEIDFK = #eformtableid#}, true) >
	<cfset entityDelete(processData) >
	<cfcatch></cfcatch>
	</cftry>
	<cfquery name="inserttoeginsample" datasource="IBOSEDATA" >
		DELETE FROM EGINSAMPLE
		 WHERE ID = '#eformtableid#'
	</cfquery>
	
	
	<cfreturn cfcatch.detail & ' ' & cfcatch.message >
</cfcatch>
</cftry>
</cffunction>



<cffunction name="submitMaineForm" ExtDirect="true" ExtFormHandler="true">   
<cftry>

<cfset processData = EntityNew("EGRGEFORMS") >  
<cfset processData.setEFORMID("#createuuid()#") >
<cfset processData.setEFORMNAME("#form.EFORMNAME#") >
<cfset processData.setDESCRIPTION("#form.DESCRIPTION#") >
<cfset processData.setEFORMGROUP("#form.EFORMGROUP#") >
<cfset processData.setFORMFLOWPROCESS("#form.FORMFLOWPROCESS#") >
<cfset processData.setLAYOUTQUERY("_") >
<cfset processData.setVIEWAS("#form.VIEWAS#") >
<cfset processData.setBEFORELOAD("#form.BEFORELOAD#") >
<cfset processData.setAFTERLOAD("#form.AFTERLOAD#") >
<cfset processData.setBEFORESUBMIT("#form.BEFORESUBMIT#") >
<cfset processData.setAFTERSUBMIT("#form.AFTERSUBMIT#") >
<cfset processData.setBEFOREAPPROVE("#form.BEFOREAPPROVE#") >
<cfset processData.setAFTERAPPROVE("#form.AFTERAPPROVE#") >
<cfset processData.setONCOMPLETE("#form.ONCOMPLETE#") >
<cfset processData.setCOMPANYCODE("#client.companycode#") >
<cfset processData.setRECCREATEDBY("#client.userid#") > 
<cfset processData.setRECDATECREATED("#dateformat(now(), 'YYYY-MM-DD')#") >
<cfset processData.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')#") >

<cfset EntitySave(processData) >
<cfset ormflush()>

<cfset returnStruct = StructNew() >
<cfset returnStruct['success'] = "true" >
<cfset returnStruct['data']=form.EFORMNAME >
<cfreturn returnStruct >
<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message >
</cfcatch>
</cftry>
</cffunction>

<cffunction name="DestroyNow" ExtDirect="true">
<cfargument name="datatodestroy" >
<cftry>
	
<cfif isArray(datatodestroy) >
<cfset arrayLen = ArrayLen(datatodestroy) >
    <cfloop from="1" to="#arrayLen#" index="dataIdx" step="1"  >
		<cfset processDataA = EntityLoad("EGRGIBOSETABLE", {EFORMIDFK = #datatodestroy[dataIdx].EFORMID# } ) >
		<cfif ArrayLen(processDataA) EQ 0 >
		    <cfset processData = EntityLoad("EGRGEFORMS", #datatodestroy[dataIdx].EFORMID#, true ) >
			<cfset EntityDelete(processData) >
		<cfelse>
			<cfcontinue>
		</cfif> 
	</cfloop>
	
<cfelse>
	<cfset processDataA = EntityLoad("EGRGIBOSETABLE", {EFORMIDFK = #datatodestroy.EFORMID# } ) >
	<cfif ArrayLen(processDataA) EQ 0 >
		<cfset processData = EntityLoad("EGRGEFORMS", #datatodestroy.EFORMID#, true ) >
		<cfset EntityDelete(processData) >
	<cfelse>
		<cfcontinue>
	</cfif>
</cfif>
<cfset ormflush()>

<cfreturn "success" >

<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message >
</cfcatch>
</cftry>
</cffunction>



<cffunction name="ReadNow" ExtDirect="true"> 
	<cfargument name="page" >
	<cfargument name="start" >
	<cfargument name="limit" >
	<cfargument name="sort" >
	<cfargument name="filter" >
	<cfargument name="eformid" >
		
 	<cfset where             = "()" >
	 
	 	    <cfset where             = " (" >
            <cfset tmpdatafield      = "" >
            <cfset tmpfilteroperator = "0" >
			
			<cftry>
			<cfset filter = deserializejson(filter) >	<!---Deserialize JSON string coz Router forgets to do the work on filter but not on sort--->
			<cfloop array=#filter# index="filterdata">
            	<cftry>
					<cfset filterdatafield = filterdata.field />
					<cfcatch>
						<cfbreak>
					</cfcatch>
				</cftry>
            
            	<cfset filterdatafield = filterdata.field />
				<cfset filterdatafield = replace(filterdatafield, "_", ".") >
				<cfset filtervalue     = filterdata.value />
				<cfset filtertype      = filterdata.type />
				<cfif tmpdatafield EQ "" >
                <cfset tmpdatafield = filterdatafield >	
                <cfelseif tmpdatafield NEQ filterdatafield >
                	<cfset where = "#where# ) AND ( " >
                <cfelseif tmpdatafield EQ filterdatafield >
                	<cfif tmpfilteroperator EQ 0>
                    	<cfset where = "#where# AND " >
                    <cfelse>
                    	<cfset where = "#where# OR " >
                    </cfif>
				</cfif>
                
                <cfif ucase(filtertype) EQ "STRING" >
					<cfset where = "#where##filterdatafield#  LIKE '%#filtervalue#%'" >
				<cfelseif  ucase(filtertype) EQ "NUMERIC" >
					<cfset filtercondition = filterdata.comparison >
					<cfset expression = "#Ucase(Trim(filtercondition))#" >
               			<cfif expression  EQ "LT">
						   	<cfset where = "#where##filterdatafield#  < #filtervalue#">
						<cfelseif expression EQ "GT"> 	   
							<cfset where = "#where##filterdatafield#  > #filtervalue#">
						<cfelseif expression EQ "EQ"> 	   	
							<cfset where = "#where##filterdatafield#  = #filtervalue#">
						<cfelse>
					</cfif>
				<cfelseif  ucase(filtertype) EQ "DATE" >
					<cfset filtercondition = filterdata.comparison >
					<cfset expression = "#Ucase(Trim(filtercondition))#" >
					
						<cfset filtervalue = CreateODBCDateTime(filtervalue) />
               			<cfif expression  EQ "LT">
	               			<cfset where = "#where##filterdatafield#  < #filtervalue#">
						<cfelseif expression EQ "GT"> 	   
							<cfset where = "#where##filterdatafield#  > #filtervalue#">
						<cfelseif expression EQ "EQ"> 	   	
							<cfset where = "#where##filterdatafield#  = #filtervalue#">
						<cfelse>
							<cfset where = "#where##filterdatafield#  = #filtervalue#">
					    </cfif>
				<cfelse>
					<!---boolean--->
					<cfset where = "#where##filterdatafield#  LIKE '%#filtervalue#%'" >
				</cfif>
                <cfset tmpdatafield      = filterdatafield >
			</cfloop>
            	<cfcatch>
					<!---Do nothing here since filter is not a valid JSON string--->
				</cfcatch>
            </cftry>
            
            <cfset where = "#where#)" >
			<cfset where = Replace(where, "''", "'" , "all") />
			
			<cfif trim(where) NEQ "()">
				<cfset WHERE =  "WHERE #PreserveSingleQuotes(where)# AND COMPANYCODE = '#client.companycode#'" >
			<cfelse>
				<cfset WHERE = "WHERE COMPANYCODE = '#client.companycode#'" >
			</cfif> 
	
	  <!--- Order By Arguments/Contents --->
	  <cfset thecnt = 1 >
	  <cfloop array=#sort# index="sortdata">
	  	  <cfset ORDERBY = "#replace(sortdata.property, '_', '.')# #sortdata.direction#" >
	  	  <cfif thecnt EQ ArrayLen(sort) >
		  <cfelse>
	  	  	<cfset ORDERBY = ORDERBY & ',' >
		  </cfif>
		  <cfset thecnt = thecnt + 1 >
	  </cfloop>
	  <!--- End Order By Arguments/Contents --->



<cfset processData =ORMExecuteQuery("SELECT A.EFORMID, 
											A.EFORMNAME, 
											A.DESCRIPTION,
											A.EFORMGROUP,
											A.FORMFLOWPROCESS,
											A.ISENCRYPTED,
											A.DATELASTUPDATE,
											C.NEW,
											C.PENDING,
											C.RETURNED,
											C.APPROVED,
											C.DISAPPROVED
											
										FROM EGRGEFORMS AS A LEFT JOIN A.EGRTEFORMS AS B LEFT JOIN B.EGINEFORMCOUNT AS C
											#WHERE# AND B.PERSONNELIDNO = '#client.chapa#'
										ORDER BY #ORDERBY#", false, {offset=#start#, maxResults=#limit#, timeout=60} ) >

<cfset countAll = ORMExecuteQuery("FROM EGRGEFORMS #WHERE#" )> 

	<cfset resultArr = ArrayNew(1) >
	
	<cfset rootstuct = StructNew() >
	<cfset rootstuct['totalCount'] = ArrayLen(countAll) >
	
	<!---query approver details and get an array of process id--->
										   
	<!---Creates an array of structure to be converted to JSON using serializeJSON--->
	<cfloop array="#processData#" index="calIndex" >
		<cfset tmpresult = StructNew() > <!---Creates new structure in every loop to be added to the array--->
		
		<cftry>
			<cfset tmpresult['EFORMID']      	= calIndex[1] >
		<cfcatch>
			<cfset tmpresult['EFORMID']      	= "" >
		</cfcatch>
		</cftry>
		
		<cftry>
			<cfset tmpresult['EFORMNAME']      	= calIndex[2] >
		<cfcatch>
			<cfset tmpresult['EFORMNAME']      	= "" >
		</cfcatch>
		</cftry>
		
		<cftry>
			<cfset tmpresult['DESCRIPTION']      	= calIndex[3] >
		<cfcatch>
			<cfset tmpresult['DESCRIPTION']      	= "" >
		</cfcatch>
		</cftry>
		
		<cftry>
			<cfset tmpresult['EFORMGROUP']      	= calIndex[4] >
		<cfcatch>
			<cfset tmpresult['EFORMGROUP']      	= "" >
		</cfcatch>
		</cftry>
		
		<cftry>
			<cfset tmpresult['FORMFLOWPROCESS']      	= calIndex[5] >
		<cfcatch>
			<cfset tmpresult['FORMFLOWPROCESS']      	= "" >
		</cfcatch>
		</cftry>
		
		<cftry>
			<cfset tmpresult['ISENCRYPTED']      	= calIndex[6] >
		<cfcatch>
			<cfset tmpresult['ISENCRYPTED']      	= "false" >
		</cfcatch>
		</cftry>
		
		<cftry>
			<cfset tmpresult['DATELASTUPDATE']      	= calIndex[7] >
		<cfcatch>
			<cfset tmpresult['DATELASTUPDATE']      	= "0" >
		</cfcatch>
		</cftry>
		
		<cftry>
			<cfset tmpresult['NEWEFORMS']      	= calIndex[8] >
		<cfcatch>
			<cfset tmpresult['NEWEFORMS']      	= "0" >
		</cfcatch>
		</cftry>
		
		<cftry>
			<cfset tmpresult['PENDINGEFORMS']      	= calIndex[9] >
		<cfcatch>
			<cfset tmpresult['PENDINGEFORMS']      	= "0" >
		</cfcatch>
		</cftry>
		
		<cftry>
			<cfset tmpresult['TOTALRETURNED']      	= calIndex[10] >
		<cfcatch>
			<cfset tmpresult['TOTALRETURNED']      	= "0" >
		</cfcatch>
		</cftry>
		
		<cftry>
			<cfset tmpresult['APPROVEDFORMS']      	= calIndex[11] >
		<cfcatch>
			<cfset tmpresult['APPROVEDFORMS']      	= "0" > 
		</cfcatch>
		</cftry>
		
		<cftry>
			<cfset tmpresult['DISAPPROVEDFORMS']      	= calIndex[12] >
		<cfcatch>
			<cfset tmpresult['DISAPPROVEDFORMS']      	= "0" > 
		</cfcatch>
		</cftry>
		
		<cfset ArrayAppend(resultArr, tmpresult) >
	</cfloop>
	<cfset rootstuct['topics'] = resultArr > 
	<cfreturn rootstuct />	 
</cffunction>


	


</cfcomponent>