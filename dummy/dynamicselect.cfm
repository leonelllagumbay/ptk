<h1>Father</h1>
<cfset eformid = "C0C80CE6-9E0E-222A-4EB050D88D86E706" >

<cfquery name="gettheForm" datasource="IBOSEDATA" >
	SELECT A.EFORMNAME, B.TABLENAME AS TABLENAME, B.LEVELID AS LEVELID, C.COLUMNNAME AS COLUMNNAME 
	  								  FROM EGRGEFORMS A,EGRGIBOSETABLE B,EGRGIBOSETABLEFIELDS C
	  								WHERE EFORMID = '#eformid#' AND A.EFORMID = B.EFORMIDFK AND B.TABLEID = C.TABLEIDFK
</cfquery>

<cfquery name="getMainTableID" datasource="IBOSEDATA" maxrows="1">
	SELECT B.TABLENAME AS TABLENAME, B.LEVELID AS LEVELID, C.COLUMNNAME AS COLUMNNAME 
	  FROM EGRGEFORMS A JOIN EGRGIBOSETABLE B ON (A.EFORMID = B.EFORMIDFK)
	  					JOIN EGRGIBOSETABLEFIELDS C ON (B.TABLEID = C.TABLEIDFK)
	 WHERE EFORMID = '#eformid#' AND C.XTYPE = 'id'
</cfquery>

<cfif trim(getMainTableID.TABLENAME) neq "" >
<cfset firsttable  = getMainTableID.TABLENAME >
<cfelse>
	<cfthrow detail="Table has no id specified in table fields. At least one field type is an id type." >
</cfif>


<cfset columnNameModel = ArrayNew(1)  >

<cfloop query="gettheForm" >
	<cfset colModel = LEVELID & '__' & TABLENAME & '__' & COLUMNNAME >
	<cfset ArrayAppend(columnNameModel, colModel) >
</cfloop>



<cfset selectArray = ArrayNew(1) >
<cfset fromArray   = ArrayNew(1) >
<cfset whereArray  = ArrayNew(1) >
<cfset groupTable   = StructNew() >

<cfloop array="#columnNameModel#" index="formIndex" >
	
		<cfset theTableLevel = ListGetAt( formIndex, 1, "__" ) >
		<cfset theTableName  = ListGetAt( formIndex, 2, "__"  ) >
		<cfset theColumnName = ListGetAt( formIndex, 3, "__"  ) >
		
		<cfset dbms = "MYSQL" >
		<cfif dbms eq "MSSQL" >
			<cfif theTableLevel eq "G" >
				<cfset theLevel = "IBOSEDATA.dbo" >
			<cfelseif theTableLevel eq "C" >
				<cfset theLevel = "FBC_CBOSE.dbo" >			
			<cfelseif theTableLevel eq "S" >
				<cfset theLevel = "SUBCOM.dbo" >
			<cfelseif theTableLevel eq "Q" >
				<cfset theLevel = "QUERY.dbo" >
			<cfelseif theTableLevel eq "T" >
				<cfset theLevel = "TRANSACTION.dbo" >
			<cfelseif theTableLevel eq "SD" >
				<cfset theLevel = "SITE.dbo" >
			<cfelse>
				<cfset theLevel = theTableLevel & ".dbo" >
			</cfif>
		<cfelse>
			<cfif theTableLevel eq "G" >
				<cfset theLevel = "IBOSEDATA" >
			<cfelseif theTableLevel eq "C" >
				<cfset theLevel = "FBC_CBOSE" >			
			<cfelseif theTableLevel eq "S" >
				<cfset theLevel = "SUBCOM" >
			<cfelseif theTableLevel eq "Q" >
				<cfset theLevel = "QUERY" >
			<cfelseif theTableLevel eq "T" >
				<cfset theLevel = "TRANSACTION" >
			<cfelseif theTableLevel eq "SD" >
				<cfset theLevel = "SITE" >
			<cfelse>
				<cfset theLevel = theTableLevel >
			</cfif>
		</cfif>
			
		
		<cftry>
			<cfset isArray = evaluate("items#theTableName#") >
			<cfif isarray(isArray) >
				
			<cfelse>
				<cfset "items#theTableName#"  = arraynew(1) >	
			</cfif>
		<cfcatch>
			<cfset "items#theTableName#"  = arraynew(1) >
		</cfcatch>
		</cftry>
		
		<cftry>
			<cfset isArray = evaluate("itemVal#theTableName#") >
			<cfif isarray(isArray) >
				
			<cfelse>
				<cfset "itemVal#theTableName#"  = arraynew(1) >	
			</cfif>
		<cfcatch>
			<cfset "itemVal#theTableName#"  = arraynew(1) >
		</cfcatch>
		</cftry>
		
		<cftry>
			<cfset isArray = evaluate("itemDVal#theTableName#") >
			<cfif isarray(isArray) >
				
			<cfelse>
				<cfset "itemDVal#theTableName#"  = arraynew(1) >	
			</cfif>
		<cfcatch>
			<cfset "itemDVal#theTableName#"  = arraynew(1) >
		</cfcatch>
		</cftry>
		
		
		 <!---ex. FIRSTNAME.FIRSTNAME AS C__CMFPA__FIRSNAME--->
		<cfset ArrayAppend(selectArray,"#theTableName#.#theColumnName# AS #formIndex#") >
		<cfif StructKeyExists(groupTable, '#theTableName#') >
			
		<cfelse>
			<!---ex. IBOSE_GLOBAL.CMFPA CMFPA OR IBOSE_GLOBAL.DBO.CMFPA CMFPA---> 
			<cfset ArrayAppend(fromArray,"#theLevel#.#theTableName# #theTableName#") >
			
			<!---ex CMFPA.PERSONNELIDNO = GMFPEOPLE.PERSONNELIDNO   delimited by AND--->
			<cfset ArrayAppend(whereArray,"#firsttable#.PERSONNELIDNO = #theTableName#.PERSONNELIDNO") >
			<cfset groupTable['#theTableName#'] = "_" >
		</cfif>
		
</cfloop>

<cfset theSelection = ArrayToList(selectArray, ",") >
<cfset theTable      = ArrayToList(fromArray, ",") >
<cfset theCondition = ArrayToList(whereArray, " AND ") >

<cfset theQuery = "SELECT #theSelection# 
					FROM #theTable#
				   WHERE #theCondition#">
				 <!---  AND #firsttable#.PROCESSID = 'theprocessid'--->
				   
<cfquery name="qryDynamic" datasource="IBOSEDATA" >
	#preservesinglequotes(theQuery)#
</cfquery>
<cfdump var="#columnNameModel#" > 
<cfdump var="#selectArray#" > 
<cfdump var="#fromArray#" > 
<cfdump var="#whereArray#" > 
<cfdump var="#qryDynamic#" > 