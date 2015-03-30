<cfcomponent name="Forum" ExtDirect="true">
	<cffunction name="getMyForums" ExtDirect="true">
					
	<cfargument name="page" >
	<cfargument name="start" >
	<cfargument name="limit" >
	<cfargument name="sort" >
	<cfargument name="filter" >

	

<cftry>

	<cfif start gt 0 >
		<cfset start -= 1 >
		<cfset limit -= 1 >
	<cfelse>
		<cfset start += 1 >
		<cfset limit -= 1 >
	</cfif>
	
	
	<cfset dparams = StructNew() >
	<cfset dparams.page = page >
	<cfset dparams.start = start >
	<cfset dparams.limit = limit >
	<cfset dparams.sort = sort >
	<cfset dparams.filter = filter >
	
	
	
 	<cfinvoke component="IBOSE.Application.GridQuery" 
 	          method="buildQuery" 
 	          argumentcollection="#dparams#"
 	          returnvariable="dresult"
 	 >
 	 
	<!---start generate script  --->
	<cfif trim(dresult.where) neq "" AND trim(dresult.where) neq "()">
		<cfset dcond = " AND " & dresult.where >
	<cfelse>
		<cfset dcond = "" >
	</cfif>

	<cfset theQuery = "SELECT 	A.FORUMCODE, 
								A.DESCRIPTION, 
								A.COMPANYCODE, 
								A.PERSONNELIDNO, 
								A.ALLOWEMAILNOTIF, 
								A.DATELASTUPDATE,
								A.EFORUMEMAIL,
								B.UNREAD
					     FROM EGRGFORUM A LEFT JOIN EGINEFORUMCOUNT B ON (A.FORUMCODE = B.FORUMCODE)
					    WHERE ISACTIVE = 'true' AND (A.COMPANYCODE = '#session.companycode#' OR A.COMPANYCODE = '' OR A.COMPANYCODE IS NULL) #PreserveSingleQuotes(dcond)# AND A.FORUMCODE IN (SELECT FORUMCODE 
					      																													FROM EGRTFORUM
					     																												   WHERE APPLICANTNUMBER = '#session.chapa#' OR APPLICANTNUMBER IN (SELECT USERGRPIDFK 
					     																												   																	  FROM EGRGROLEINDEX 
					     																												   																	 WHERE USERGRPMEMBERSIDX = '#session.userid#')
						)
					 ORDER BY B.UNREAD DESC, #dresult.ORDERBY#">

	<cfquery name="qryDynamic" datasource="#session.global_dsn#" >
		#preservesinglequotes(theQuery)#
	</cfquery>
	  	
<!--- end generate script --->
	<cfset resultArr = ArrayNew(1) >
	<cfset rootstuct = StructNew() >
	<cfset rootstuct['totalCount'] = qryDynamic.recordcount >
	<!---Creates an array of structure to be converted to JSON using serializeJSON--->
	<cfloop query="qryDynamic" startrow="#start#" endrow="#start + limit#" >
		<cfset tmpresult = StructNew() > <!---Creates new structure in every loop to be added to the array--->
		<cfset tmpresult['FORUMCODE']      	= qryDynamic.FORUMCODE  >
		<cfset tmpresult['COMPANYCODE']     = qryDynamic.COMPANYCODE  >
		<cfset tmpresult['PERSONNELIDNO']   = qryDynamic.PERSONNELIDNO  >
		<cfset tmpresult['ALLOWEMAILNOTIF'] = qryDynamic.ALLOWEMAILNOTIF >
		<cfset tmpresult['DESCRIPTION']    	= qryDynamic.DESCRIPTION  >
		<cfset tmpresult['EFORUMEMAIL']    	= qryDynamic.EFORUMEMAIL  >
		<cfset tmpresult['UNREAD']    		= qryDynamic.UNREAD  >
		<cfset tmpresult['DATELASTUPDATE'] 	= DateFormat(qryDynamic.DATELASTUPDATE,"YYYY-MM-DD") & " " & TimeFormat(qryDynamic.DATELASTUPDATE,"HH:MM:DD")>
		<cfset ArrayAppend(resultArr, tmpresult) >
	</cfloop>
	
	<cfset rootstuct['topics'] = resultArr > 
	<cfreturn rootstuct />
<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message >
</cfcatch>
</cftry>	

</cffunction>
	
	

<cffunction name="loadMyForums" ExtDirect="true">
	<cfargument name="eforumlinkcode" >
	<cfargument name="start" >
	
	<cfset outputStruct = StructNew() >
	<cfset outputArr = ArrayNew(1) >
	<!---*note: outputStruct.title has TITLE in JavaScript whereas outputStruct['title'] has title correct case.--->
	<!---query forum topic, 1 record--->
	<cfquery name="qryForumTopic" maxrows="1" datasource="#session.global_dsn#" >
		SELECT TOPIC,COMPANYCODE
		  FROM EGRGFORUM
		 WHERE FORUMCODE = <cfqueryparam cfsqltype="cf_sql_varchar" value="#eforumlinkcode#">
	</cfquery>
	
	<cfset outputStruct['xtype'] = "container" >
	<cfset outputStruct['padding'] = 7 >
	<cfset outputStruct['flex'] = 1 > 
	<cfset outputStruct['html'] = "#qryForumTopic.TOPIC#" >
	<cfset outputStruct['id'] = "#eforumlinkcode#" > 
	<cfset ArrayAppend(outputArr, outputStruct) >
	
	<cfset inputItems = StructNew() >
	<cfset inputItemsArr = ArrayNew(1) >
	
	<cfset inputItems['xtype'] = "displayfield" >
	<cfset inputItems['padding'] = 2 >
	<cfset inputItems['width'] = 50 >
	<cfset inputItems['height'] = 50 >
	<cfset inputItems['value'] = "<img title='#session.firstname# #session.lastname#' src='./resource/image/pics201/#lcase(session.companycode)#/#session.avatar#' height='50px' width='50px'></img>" >
	<cfset ArrayAppend(inputItemsArr, inputItems) >
	
	<cfset inputItems = StructNew() >
	<cfset inputItems['xtype'] = "container" >
	<cfset inputItems['layout'] = "vbox" >
	<cfset inputItems['flex'] = 1 > 
	<cfset inputItems['width'] = "100%" >
		<cfset htmledit = StructNew() >
		<cfset htmleditArr = ArrayNew(1) >
		<cfset htmledit['xtype'] = "htmleditor" >
		<cfset htmledit['padding'] = 7 >
		<cfset htmledit['width'] = "87%" >
		<cfset htmledit['height'] = 147 >
		<cfset ArrayAppend(htmleditArr,htmledit) >
		
		<cfset htmledit = StructNew() >
		<cfset htmledit['xtype'] = "button" >
		<cfset htmledit['margin'] = 7 >
		<cfset htmledit['action'] = "sendcomment" >
		<cfset htmledit['text'] = "Send Comment" >
		<cfset ArrayAppend(htmleditArr,htmledit) >
		
	<cfset inputItems['items'] = htmleditArr >
	<cfset ArrayAppend(inputItemsArr, inputItems) >

	<cfset outputStruct = StructNew() >
	<cfset outputStruct['xtype'] = "container" >
	<cfset outputStruct['padding'] = 7 >
	<cfset outputStruct['flex'] = 1 > 
	<cfset outputStruct['layout'] = "hbox" >
	<cfset outputStruct['items'] = inputItemsArr > 
	<cfset ArrayAppend(outputArr, outputStruct) >
	
	<cfinvoke method="prepComments" returnvariable="outputArr" eforumlinkcode="#eforumlinkcode#" start="#start#" >
	
	<cfquery name="udtforum" datasource="#session.global_dsn#" >
		UPDATE EGINEFORUMCOUNT
		  SET UNREAD = 0
		 WHERE FORUMCODE = '#eforumlinkcode#' AND PERSONNELIDNO = '#session.chapa#'
	</cfquery>
	
	<cfreturn outputArr >
	
</cffunction>


<cffunction name="prepComments" access="public" returntype="Array" ExtDirect="true">
	<cfargument name="eforumlinkcode" >
	<cfargument name="start" >
	<!---for comments...--->
	<cfif Not IsDefined("outputArr") >
		<cfset outputArr = ArrayNew(1) >
	</cfif>
	<cfif session.dbms eq "MSSQL" >
		<cfset tbn = session.company_dsn & ".dbo" >
	<cfelse>
	 	<cfset tbn = session.company_dsn >
	</cfif>
	<cfquery name="qryForumComment" datasource="#session.global_dsn#" >
		SELECT A.FORUMCOMMENT, A.PERSONNELIDNO, A.DATELASTUPDATE, B.FIRSTNAME, B.LASTNAME, C.AVATAR
		  FROM EGINFORUMCOMMENT A LEFT JOIN #tbn#.#session.maintable# B ON (A.PERSONNELIDNO=B.#session.mainpk#)
		       LEFT JOIN #tbn#.ECRGMYIBOSE C ON (A.PERSONNELIDNO = C.PERSONNELIDNO)
		 WHERE A.FORUMCODEFK = <cfqueryparam cfsqltype="cf_sql_varchar" value="#eforumlinkcode#">
		 ORDER BY A.DATELASTUPDATE DESC
		 <cfif Ucase(session.DBMS) EQ 'MSSQL'>
		  	 OFFSET #start# ROWS
	         FETCH NEXT 30 ROWS ONLY
	     <cfelse>
	         LIMIT #start#, 30
	     </cfif>
		 ; 
	</cfquery>
	<cfloop query="qryForumComment" >
		<cfset inputItems = StructNew() >
		<cfset inputItemsArr = ArrayNew(1) >
		
		<cfset inputItems['xtype'] = "displayfield" >
		<cfset inputItems['padding'] = 2 >
		<cfset inputItems['width'] = 50 >
		<cfset inputItems['height'] = 50 >
		
		
		<cfset inputItems['value'] = "<img title='#qryForumComment.FIRSTNAME# #qryForumComment.LASTNAME#' src='./resource/image/pics201/#lcase(session.companycode)#/#qryForumComment.AVATAR#' height='50px' width='50px'></img>" >
		<cfset ArrayAppend(inputItemsArr, inputItems) >
		
		
		<cfset inputItems = StructNew() >
		<cfset inputItems['xtype'] = "displayfield" >
		<cfset inputItems['padding'] = 7 >
		<cfset inputItems['flex'] = 1 > 
		<cfset inputItems['width'] = "90%" >
		
		<cfinvoke component="IBOSE.time.Time" 
				method="convertTimeToWords" 
				returnvariable="timeinwords"
				theTime="#qryForumComment.DATELASTUPDATE#" >
	
		<cfset inputItems['value'] = "#qryForumComment.FORUMCOMMENT# <p title='#qryForumComment.DATELASTUPDATE#' style='font-size: .9em;'>#timeinwords#</p>" >
		<cfset ArrayAppend(inputItemsArr, inputItems) >
		
		<cfset outputStruct = StructNew() >
		<cfset outputStruct['xtype'] = "container" >
		<cfset outputStruct['padding'] = 7 >
		<cfset outputStruct['flex'] = 1 > 
		<cfset outputStruct['layout'] = "hbox" >
		<cfset outputStruct['items'] = inputItemsArr > 
		<cfset ArrayAppend(outputArr, outputStruct) >
	
	</cfloop>
	
	<cfreturn outputArr >
	
</cffunction>


<cffunction name="saveMyComment" ExtDirect="true">
	<cfargument name="forumcode" >
	<cfargument name="forumcompanycode" >
	<cfargument name="commentval" >
	<cfargument name="pidofforumowner" >
	<cfargument name="notifyowner" >
	<cfargument name="forumdesc" >  
	<cfargument name="owneremail" >
	
	<cftry>
    	<cfset outStruct = StructNew() >
		<cfset datetimenow = '#dateformat(now(), "YYYY-MM-DD")# #timeformat(now(), "HH:MM:SS")#' >
		<cfquery name="qryForumComment" datasource="#session.global_dsn#" >
			INSERT INTO EGINFORUMCOMMENT ( FORUMCOMMENTCODE,FORUMCODEFK,FORUMCOMMENT,PERSONNELIDNO,DATELASTUPDATE )
			  VALUES (
			  	<cfqueryparam cfsqltype="cf_sql_varchar"   value="#CreateUuid()#">,
			  	<cfqueryparam cfsqltype="cf_sql_varchar"   value="#forumcode#">,
			  	<cfqueryparam cfsqltype="cf_sql_varchar"   value="#commentval#">,
			  	<cfqueryparam cfsqltype="cf_sql_varchar"   value="#session.chapa#">,
			  	<cfqueryparam cfsqltype="cf_sql_timestamp" value="#datetimenow#">
			  )  
		</cfquery>
		<cfquery name="qryForumUnread" datasource="#session.global_dsn#" maxrows="1" >
			SELECT UNREAD
			  FROM EGINEFORUMCOUNT
			 WHERE FORUMCODE = '#forumcode#' AND PERSONNELIDNO = '#session.chapa#'
		</cfquery>
		<cfif qryForumUnread.RecordCount gt 0 >
			<cfquery name="udtforum" datasource="#session.global_dsn#" >
				UPDATE EGINEFORUMCOUNT
				  SET UNREAD = #qryForumUnread.UNREAD + 1#
				 WHERE FORUMCODE = '#forumcode#' AND PERSONNELIDNO = '#session.chapa#'
			</cfquery>
		<cfelse>
			<cfquery name="inrtforum" datasource="#session.global_dsn#" >
				INSERT INTO EGINEFORUMCOUNT ( FORUMCODE,PERSONNELIDNO,UNREAD )
				VALUES (
				  	<cfqueryparam cfsqltype="cf_sql_varchar"   value="#forumcode#">,
				  	<cfqueryparam cfsqltype="cf_sql_varchar"   value="#session.chapa#">,
				  	<cfqueryparam cfsqltype="cf_sql_integer" value="1">
				  )  
			</cfquery>
		</cfif>
		
		<cfif notifyowner eq "true" AND trim(owneremail) neq "" >
			<cfmail from="#owneremail#" subject="eForum: #forumdesc#" to="#owneremail#" type="plain" >
				#session.firstname# #session.lastname# commented on #forumdesc#
				#commentval# 
				Sent #datetimenow#
			</cfmail>
		</cfif>
		
		<cfset outStruct['issuccess'] = "true" >
		<cfreturn outStruct >    
    <cfcatch type="Any" >
    	<cfset outStruct = StructNew() >
    	<cfset outStruct['issuccess'] = "false" >
		<cfreturn outStruct > 
    </cfcatch>
    </cftry>
</cffunction>



</cfcomponent>