<cfcomponent name="Navigator" ExtDirect="true">
	<cffunction name="getDatesToMarkArray" ExtDirect="true" >
		<cfargument name="startDate" required="true" type="string" >
		<cfargument name="endDate" required="true" type="string" >

		<cftry>
			<cfset retArray = ArrayNew(1) >
			<cfif Ucase(startDate) eq "TODAY" >
				<cfset startDate = dateformat(now(),"YYYY-MM-DD") >
			<cfelse>
				<cfset startDate = dateformat("#startDate#","YYYY-MM-DD") >
			</cfif>

			<cfif Ucase(endDate) eq "TODAY" >
				<cfset endDate = dateformat(now(),"YYYY-MM-DD") >
			<cfelse>
				<cfset endDate = dateformat("#endDate#","YYYY-MM-DD") >
			</cfif>


				<cfquery name="qryMsg" datasource="#session.company_dsn#">
	              	SELECT DATECREATED
	              	  FROM ECRGESTICKYNOTES
	             	 WHERE (DATECREATED >= '#startDate#'  AND DATECREATED <= '#endDate#') AND CREATEDBYUSERID = '#session.userid#';
	        	</cfquery>

				<cfloop query="qryMsg" >
					<cfset ArrayAppend(retArray, dateformat(qryMsg.DATECREATED, "mmmm dd, yyyy")) >
				</cfloop>

			<cfreturn retArray >
		<cfcatch>
			<cfreturn cfcatch.detail & ' ' & cfcatch.message >
		</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="getDateNotes" ExtDirect="true" >
		<cfargument name="selectedDate" required="true" type="date" >
		<cftry>
			<cfquery name="qrtMsg" datasource="#session.company_dsn#" maxrows="1">
              	SELECT BODY
              	  FROM ECRGESTICKYNOTES
             	 WHERE DATECREATED = '#selectedDate#' AND CREATEDBYUSERID = '#session.userid#';
        	</cfquery>

		<cfreturn qrtMsg.BODY >
		<cfcatch>
			<cfreturn cfcatch.detail & ' ' & cfcatch.message >
		</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="saveDateNotes" ExtDirect="true" >
		<cfargument name="msgBody" required="true" type="string" >
		<cfargument name="selectedDate" required="true" type="date" >
		<cftry>
			<cfquery name="qrtMsg" datasource="#session.company_dsn#" maxrows="1">
              	SELECT BODY
              	  FROM ECRGESTICKYNOTES
             	 WHERE DATECREATED = '#selectedDate#' AND CREATEDBYUSERID = '#session.userid#';
        	</cfquery>
        	<cfif qrtMsg.recordcount gt 0 >
        		<cfquery name="insMsg" datasource="#session.company_dsn#" maxrows="1">
					UPDATE ECRGESTICKYNOTES
					   SET BODY = <cfqueryparam cfsqltype="cf_sql_varchar" value="#msgBody#">
					 WHERE DATECREATED = '#selectedDate#' AND CREATEDBYUSERID = '#session.userid#';
	        	</cfquery>
        	<cfelse>
	        	<cfquery name="insMsg" datasource="#session.company_dsn#" maxrows="1">
					INSERT INTO ECRGESTICKYNOTES(BODY,DATECREATED, CREATEDBYUSERID)
					VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#msgBody#">,
							<cfqueryparam cfsqltype="cf_sql_date" value="#dateformat(selectedDate, 'YYYY-MM-DD')#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#session.userid#">
					);
	        	</cfquery>
        	</cfif>
		<cfreturn "true" >
		<cfcatch>
			<cfreturn cfcatch.detail & ' ' & cfcatch.message >
		</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="getMyApps" ExtDirect="true" >

		<!---<!---5th menu--->
		<cfset au = 1 >
		<cfset ar = 1 >
		<cfloop from="1" to="81" index="x">
			<cfset "Item5_#ar#" = ArrayNew(1) >
			<cfloop from="1" to="3" index="y" >
				<cfset data = StructNew() >
				<cfset data['text'] = "Item 5 #ar# #au#" >
				<cfset ArrayAppend(Evaluate("Item5_#ar#"), data) >
				<cfset au += 1 >
			</cfloop>
			<cfset ar += 1 >
		</cfloop>

		<!---4th menu--->
		<cfset au = 1 >
		<cfset ar = 1 >
		<cfloop from="1" to="27" index="x">
			<cfset "Item4_#ar#" = ArrayNew(1) >
			<cfloop from="1" to="3" index="y" >
				<cfset data = StructNew() >
				<cfset data['text'] = "Item 4 #ar# #au#" >
				<cfset data['menu'] = Evaluate("Item5_#au#") >
				<cfset ArrayAppend(Evaluate("Item4_#ar#"), data) >
				<cfset au += 1 >
			</cfloop>
			<cfset ar += 1 >
		</cfloop>

		<!---3rd menu--->
		<cfset au = 1 >
		<cfset ar = 1 >
		<cfloop from="1" to="9" index="x">
			<cfset "Item3_#ar#" = ArrayNew(1) >
			<cfloop from="1" to="3" index="y" >
				<cfset data = StructNew() >
				<cfset data['text'] = "Item 3 #ar# #au#" >
				<cfset data['menu'] = Evaluate("Item4_#au#") >
				<cfset ArrayAppend(Evaluate("Item3_#ar#"), data) >
				<cfset au += 1 >
			</cfloop>
			<cfset ar += 1 >
		</cfloop>



		<!---2nd menu--->
		<cfset au = 1 >
		<cfset ar = 1 >
		<cfloop from="1" to="3" index="x">
			<cfset "Item2_#ar#" = ArrayNew(1) >
			<cfloop from="1" to="3" index="y" >
				<cfset data = StructNew() >
				<cfset data['text'] = "Item 2 #ar# #au#" >
				<cfset data['menu'] = Evaluate("Item3_#au#") >
				<cfset ArrayAppend(Evaluate("Item2_#ar#"), data) >
				<cfset au += 1 >
			</cfloop>
			<cfset ar += 1 >
		</cfloop>



		<!---1st menu--->
		<cfset au = 1 >
		<cfset Item1_1 = ArrayNew(1) >
		<cfloop from="1" to="3" index="y" >
			<cfset data = StructNew() >
			<cfset data['text'] = "Item 1 1 #au#" >
			<cfset data['menu'] = Evaluate("Item2_#au#") >
			<cfset ArrayAppend(Item1_1, data) >
			<cfset au += 1 >
		</cfloop>--->


		<!---<cfreturn Item1_1 >--->
		<cfinvoke 	component="IBOSE.security.Access"
					method="getAppUsers"
					returnvariable="qryApps"
					columnlist="MENUID,MENUNAME,MENUHINT,MENULOGO,PARENTMENUID,SOURCELINK,STYLE,HIERARCHYLEVEL,EXTRAS"
					apptable="EGRGMENU"
					apptableid="MENUID"
					sessionchapa="#session.chapa#"
					sessionuserid="#session.userid#"
					accesstable="EGRTMENU"
					accesstablepid="APPLICANTNUMBER"
					apporderby="HIERARCHYLEVEL DESC, MENUORDER ASC"
					>

		<cfset topLevel = 1 >

		<cfloop query="qryApps" > <!---prepare ItemNo array for no. of menus and array map/link to this query results--->
			<cfif Not IsDefined("Item#qryApps.HIERARCHYLEVEL#") >
				<cfset "Item#qryApps.HIERARCHYLEVEL#" = 0 >
			</cfif>
			<cfif Not IsDefined("QueryRef#qryApps.HIERARCHYLEVEL#") >
				<cfset "QueryRef#qryApps.HIERARCHYLEVEL#" = ArrayNew(1) >
			</cfif>
			<cfif qryApps.CurrentRow eq 1>
				<cfset topLevel = qryApps.HIERARCHYLEVEL >
			</cfif>

			<cfset "Item#qryApps.HIERARCHYLEVEL#" = Evaluate("Item#qryApps.HIERARCHYLEVEL#") + 1>
			<cfset ArrayAppend(Evaluate("QueryRef#qryApps.HIERARCHYLEVEL#"), qryApps.CurrentRow ) >

		</cfloop> <!---end prepare--->

		<cfset itemName = ArrayNew(1) >
		<cfloop from="#topLevel#" to="1" step="-1" index="menuno" >
			<cfif Not IsDefined("Item#menuno#") > <!---is not directly linked--->
				<cfcontinue>
			</cfif>
			<cfloop from="1" to="#Evaluate('Item#menuno#')#" index="x">

				<cfset parentid = replace(qryApps.PARENTMENUID[Evaluate("QueryRef#menuno#")[x]],"-","_","all") >
				<cfif Not IsDefined("Item#menuno#_#parentid#") >
					<cfset "Item#menuno#_#parentid#" = ArrayNew(1) >
				</cfif>

				<cfset uniqueid = replace(qryApps.MENUID[Evaluate("QueryRef#menuno#")[x]],"-","_","all") >
				<cfset data = StructNew() >
				<cfset dtext = trim(qryApps.MENUNAME[Evaluate('QueryRef#menuno#')[x]]) >
				<cfif dtext eq "" >
					<cfset dtext = "{Empty String}" >
				</cfif>
				<cfset data['text'] = dtext >

				<cfset diconcls = trim(qryApps.MENULOGO[Evaluate('QueryRef#menuno#')[x]]) >
				<cfif diconcls neq "" >
					<cfset data['iconCls'] = diconcls >
				</cfif>

				<cfset dhint = trim(qryApps.MENUHINT[Evaluate('QueryRef#menuno#')[x]]) >
				<cfif dhint neq "" >
					<cfset data['tooltip'] = dhint >
				</cfif>

				<cfset dlink = trim(qryApps.SOURCELINK[Evaluate('QueryRef#menuno#')[x]]) >
				<cfif dlink neq "" >
					<cfset data['href'] = dlink>
				</cfif>

				<cfset dstyle = trim(qryApps.STYLE[Evaluate('QueryRef#menuno#')[x]]) >
				<cfif dstyle neq "" >
					<cfset data['style'] = dstyle>
				</cfif>

				<cfloop list="#qryApps.EXTRAS[Evaluate('QueryRef#menuno#')[x]]#" delimiters=";" index="Litem" >
					<cfif ListLen(Litem,",") eq 2 >
						<cfset data['#ListGetAt(Litem,1,",")#'] = "#ListGetAt(Litem,2,",")#">
					</cfif>
				</cfloop>


				<cfif qryApps.HIERARCHYLEVEL[Evaluate("QueryRef#menuno#")[x]] lt topLevel > <!---top level has no menu structure--->
					<cfif IsDefined("Item#menuno+1#_#uniqueid#") >
						<cfset data['menu'] = Evaluate("Item#menuno+1#_#uniqueid#") >
					</cfif>
				</cfif>

				<cfset ArrayAppend(Evaluate("Item#menuno#_#parentid#"), data) >

				<cfif menuno eq 1 AND x eq Evaluate('Item#menuno#') > <!---is the last item--->
					<cfset itemName = Evaluate("Item#menuno#_#parentid#") >
				</cfif>

			</cfloop>

		</cfloop>

		<cfreturn itemName >

	</cffunction>

	<cffunction name="getMyWorklist" ExtDirect="true" >
		<cfinvoke method="updateNPCounter" component="Status" >
		<cfset counter = 0>
		<cfinvoke method="countNew" component="Status" returnvariable="cNew">
		<cfinvoke method="countPending" component="Status" returnvariable="cPending">

		<cfinvoke method="countEachFormID" component="Status" returnvariable="countFormIDResult">
		<cfinvoke method="countAllForm" component="Status" returnvariable="theForms">

		<cfset Item1 = ArrayNew(1) >

		<cfset dataObj = StructNew() >
		<cfset dataObj['text'] = "Fill-up, Edit, and Route an eForm" >

			<cfset Item2 = ArrayNew(1) >
			<cfloop query="theForms" >
				<cfset dataObj2 = StructNew() >
				<cfset dataObj2['text'] = theForms.EFORMNAME >
				<cfset ArrayAppend(Item2, dataObj2) >
				<cfset dataObj2['href'] = "?bdg=MAINUSRAPPF5038527-9F22-9981-A084244087E398BD&eformid=#EFORMID#&actiontype=getmyeforms&myvar=hi" >
			</cfloop>

		<cfset dataObj['menu'] = Item2 >
		<cfset ArrayAppend(Item1, dataObj) >

		<cfif cNew.recordCount gt 0 >
			<cfif cNew.TOTNEW neq 0 >
				<cfset eformpluraln = 'eForm' >
				<cfif cNew.TOTNEW gt 1 >
					<cfset eformpluraln = 'eForms' >
				</cfif>
				<cfset dataObj = StructNew() >
				<cfset dataObj['text'] = "Review <b><span style='color: red;'>#cNew.TOTNEW#</span></b> New #eformpluraln#" >

					<cfset Item2 = ArrayNew(1) >
					<cfloop query="countFormIDResult" >


						<cfif countFormIDResult.NEW gt 0 >
							<cfset dataObj2 = StructNew() >
							<cfset dataObj2['text'] = "<b><span style='color: red;'>#countFormIDResult.NEW#</span></b> #countFormIDResult.EFORMNAME#" >
							<cfset ArrayAppend(Item2, dataObj2) >
							<cfset dataObj2['href'] = "?bdg=MAINUSRAPPF5038527-9F22-9981-A084244087E398BD&eformid=#EFORMID#&actiontype=getneweforms&myvar=hi" >
						</cfif>
						<cfif countFormIDResult.RETURNED gt 0 >
							<cfset dataObj2 = StructNew() >
							<cfset dataObj2['text'] = "<b><span style='color: red;'>#countFormIDResult.RETURNED#</span></b> (Returned) #countFormIDResult.EFORMNAME#" >
							<cfset ArrayAppend(Item2, dataObj2) >
							<cfset dataObj2['href'] = "?bdg=MAINUSRAPPF5038527-9F22-9981-A084244087E398BD&eformid=#EFORMID#&actiontype=getmyeforms&myvar=hi" >
						</cfif>
						<cfif countFormIDResult.APPROVED gt 0 >
							<cfset dataObj2 = StructNew() >
							<cfset dataObj2['text'] = "<b><span style='color: red;'>#countFormIDResult.APPROVED#</span></b> (Approved) #countFormIDResult.EFORMNAME#" >
							<cfset ArrayAppend(Item2, dataObj2) >
							<cfset dataObj2['href'] = "?bdg=MAINUSRAPPF5038527-9F22-9981-A084244087E398BD&eformid=#EFORMID#&actiontype=getmyeforms&myvar=hi" >
						</cfif>
						<cfif countFormIDResult.DISAPPROVED gt 0 >
							<cfset dataObj2 = StructNew() >
							<cfset dataObj2['text'] = "<b><span style='color: red;'>#countFormIDResult.DISAPPROVED#</span></b> (Disapproved) #countFormIDResult.EFORMNAME#" >
							<cfset ArrayAppend(Item2, dataObj2) >
							<cfset dataObj2['href'] = "?bdg=MAINUSRAPPF5038527-9F22-9981-A084244087E398BD&eformid=#EFORMID#&actiontype=getmyeforms&myvar=hi" >
						</cfif>
					</cfloop>

				<cfset dataObj['menu'] = Item2 >

				<cfset ArrayAppend(Item1, dataObj) >
			</cfif>
		</cfif>

		<cfif cPending.recordCount gt 0 >
			<cfif cPending.TOTPENDING neq 0 >
				<cfset eformpluraln = 'eForm' >
				<cfif cPending.TOTPENDING gt 1 >
					<cfset eformpluraln = 'eForms' >
				</cfif>
				<cfset dataObj = StructNew() >
				<cfset dataObj['text'] = "Review <b><span style='color: red;'>#cPending.TOTPENDING#</span></b> Pending #eformpluraln#" >

					<cfset Item2 = ArrayNew(1) >
					<cfloop query="countFormIDResult" >
						<cfif countFormIDResult.PENDING gt 0 >
							<cfset dataObj2 = StructNew() >
							<cfset dataObj2['text'] = "<b><span style='color: red;'>#countFormIDResult.PENDING#</span></b> #countFormIDResult.EFORMNAME#" >
							<cfset ArrayAppend(Item2, dataObj2) >
							<cfset dataObj2['href'] = "?bdg=MAINUSRAPPF5038527-9F22-9981-A084244087E398BD&eformid=#EFORMID#&actiontype=getpendingeforms&myvar=hi" >
						</cfif>
					</cfloop>

				<cfset dataObj['menu'] = Item2 >

				<cfset ArrayAppend(Item1, dataObj) >
			</cfif>
		</cfif>



		<cfreturn Item1 >

	</cffunction>

	<cffunction name="saveAttendance" ExtDirect="true" >
		<cfargument name="theTime" required="true" type="string" >
		<cfargument name="theDateType" required="true" type="string" >
		<cfargument name="theLatitude" required="true" type="string" >
		<cfargument name="theLongitude" required="true" type="string" >
		<cftry>
			<cfset todayDate = DateFormat(now(),'YYYY-MM-DD') >
			<cfquery name="recExists" datasource="#session.company_dsn#" maxrows="1">
				SELECT PERSONNELIDNO
				  FROM ECINMANUALDTR
				 WHERE PERSONNELIDNO = '#session.chapa#' AND DATEATTENDANCE = '#todayDate#'
			</cfquery>
			<cfif recExists.RecordCount lt 1 >
				<cfquery name="insertDTR" datasource="#session.company_dsn#">
					<cfif trim(theDateType) eq "IN" >
		              	INSERT INTO ECINMANUALDTR (PERSONNELIDNO,DATEATTENDANCE,TIMEIN, LATITUDE, LONGITUDE)
		              	  VALUES (
		              	  	<cfqueryparam cfsqltype="cf_sql_varchar" value="#session.chapa#">,
		              	  	<cfqueryparam cfsqltype="cf_sql_date" value="#todayDate#">,
		              	  	<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(theTime)#">,
		              	  	<cfqueryparam cfsqltype="cf_sql_varchar" value="#theLatitude#">,
		              	  	<cfqueryparam cfsqltype="cf_sql_varchar" value="#theLongitude#">
		              	  );
	              	 <cfelseif trim(theDateType) eq "OUT" >
	              	 	INSERT INTO ECINMANUALDTR (PERSONNELIDNO,DATEATTENDANCE,TIMEOUT, LATITUDE, LONGITUDE)
		              	  VALUES (
		              	  	<cfqueryparam cfsqltype="cf_sql_varchar" value="#session.chapa#">,
		              	  	<cfqueryparam cfsqltype="cf_sql_date" value="#todayDate#">,
		              	  	<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(theTime)#">,
		              	  	<cfqueryparam cfsqltype="cf_sql_varchar" value="#theLatitude#">,
		              	  	<cfqueryparam cfsqltype="cf_sql_varchar" value="#theLongitude#">
		              	  );
					</cfif>
	        	</cfquery>
        	<cfelse>
        		<cfquery name="insertDTR" datasource="#session.company_dsn#">
	        		<cfif trim(theDateType) eq "IN" >
		              	UPDATE ECINMANUALDTR
		              	  SET TIMEIN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(theTime)#">,
		              	  	  LATITUDE = <cfqueryparam cfsqltype="cf_sql_varchar" value="#theLatitude#">,
		              	  	  LONGITUDE = <cfqueryparam cfsqltype="cf_sql_varchar" value="#theLongitude#">
		              	 WHERE PERSONNELIDNO = '#session.chapa#' AND DATEATTENDANCE = '#todayDate#';
	              	 <cfelseif trim(theDateType) eq "OUT" >
	              	 	UPDATE ECINMANUALDTR
		              	  SET TIMEOUT = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(theTime)#">,
		              	  	  LATITUDE = <cfqueryparam cfsqltype="cf_sql_varchar" value="#theLatitude#">,
		              	  	  LONGITUDE = <cfqueryparam cfsqltype="cf_sql_varchar" value="#theLongitude#">
		              	 WHERE PERSONNELIDNO = '#session.chapa#' AND DATEATTENDANCE = '#todayDate#';
					</cfif>
				</cfquery>
			</cfif>

		<cfreturn "success" >
		<cfcatch>
			<cfreturn cfcatch.detail & ' ' & cfcatch.message >
		</cfcatch>
		</cftry>
	</cffunction>



	<cffunction name="getMyMessages" ExtDirect="true" >
		<cfquery name="qryMsg" datasource="#session.global_dsn#" >
			SELECT SUM(UNREAD) AS TOTALUNREAD
			  FROM EGINEFORUMCOUNT
			 WHERE PERSONNELIDNO = '#session.chapa#'
		</cfquery>
		<cfset outArr = ArrayNew(1) >
		<cfset outStruct = StructNew() >
		<cfset outStruct['xtype'] = "menuitem" >
		<cfif qryMsg.TOTALUNREAD neq 0 >
			<cfset outStruct['text'] = "<span style='background-color: red; border-radius: 12px; color: white;'><b>&nbsp;" & qryMsg.TOTALUNREAD & "&nbsp;</b></span> in eForums" >
		<cfelse>
			<cfset outStruct['text'] = "0 in eForums" >
		</cfif>
		<cfset outStruct['newlistno'] = qryMsg.TOTALUNREAD >
		<cfset outStruct['href'] = "./?bdg=EFORUMS17EE381C6A9C" >
		<cfset outStruct['name'] = "forumstatus" >

		<cfset ArrayAppend(outArr, outstruct) >
		<cfreturn outArr >
	</cffunction>



	<cffunction name="saveShortCut" ExtDirect="true" >
		<cfargument name="thename" required="true" type="string" >
		<cfargument name="thelink" required="true" type="string" >
		<cfargument name="thetype" required="true" type="string" >
		<cftry>
			<cfset todayDate = DateFormat(now(),'YYYY-MM-DD') >
			<cfset todayTime = TimeFormat(now(),'HH:MM:SS') >
				<cfquery name="insertShortcut" datasource="#session.company_dsn#">
					<cfif trim(thetype) eq "SHORTCUT" >
		              	INSERT INTO ECINSHORTCUT (PERSONNELIDNO,SHORTCUTNAME,SHORTCUTLINK,RECDATECREATED)
		              	  VALUES (
		              	  	<cfqueryparam cfsqltype="cf_sql_varchar" value="#session.chapa#">,
		              	  	<cfqueryparam cfsqltype="cf_sql_varchar" value="#thename#">,
		              	  	<cfqueryparam cfsqltype="cf_sql_varchar" value="#thelink#">,
		              	  	<cfqueryparam cfsqltype="cf_sql_timestamp" value="#todayDate# #todayTime#">
		              	  );
	              	 <cfelseif trim(thetype) eq "BOOKMARK" >
	              	 	INSERT INTO ECINBOOKMARK (PERSONNELIDNO,BOOKMARKNAME,BOOKMARKLINK,RECDATECREATED)
		              	  VALUES (
		              	  	<cfqueryparam cfsqltype="cf_sql_varchar" value="#session.chapa#">,
		              	  	<cfqueryparam cfsqltype="cf_sql_varchar" value="#thename#">,
		              	  	<cfqueryparam cfsqltype="cf_sql_varchar" value="#thelink#">,
		              	  	<cfqueryparam cfsqltype="cf_sql_timestamp" value="#todayDate# #todayTime#">
		              	  );
					</cfif>
	        	</cfquery>
		<cfreturn "success" >
		<cfcatch>
			<cfreturn cfcatch.detail & ' ' & cfcatch.message >
		</cfcatch>
		</cftry>
	</cffunction>


	<cffunction name="getMyShortcut" ExtDirect="true" >

		<cfquery name="qryShortCut" datasource="#session.company_dsn#" >
			SELECT SHORTCUTNAME, SHORTCUTLINK
			  FROM ECINSHORTCUT
			 WHERE PERSONNELIDNO = '#session.chapa#'
		  ORDER BY RECDATECREATED DESC;
		</cfquery>

		<cfset Item1 = ArrayNew(1) >
		<cfset dataObj = StructNew() >
		<cfset dataObj['text'] = "New shortcut" >
		<cfset dataObj['action'] = "newshortcut" >
		<cfset ArrayAppend(Item1, dataObj) >

		<cfloop query="qryShortCut" >
			<cfset dataObj = StructNew() >
			<cfset dataObj['text'] = qryShortCut.SHORTCUTNAME >
			<cfset dataObj['href'] = qryShortCut.SHORTCUTLINK >
			<cfset dataObj['id'] = qryShortCut.SHORTCUTNAME >

			<cfset Item2 = ArrayNew(1) >
			<cfset dataObj2 = StructNew() >
			<cfset dataObj2['text'] = "Remove" >
			<cfset dataObj2['action'] = qryShortCut.SHORTCUTNAME >
			<cfset ArrayAppend(Item2, dataObj2) >
			<cfset dataObj['menu'] = Item2 >

			<cfset ArrayAppend(Item1, dataObj) >
		</cfloop>

		<cfreturn Item1 >

	</cffunction>


	<cffunction name="getMyBookmark" ExtDirect="true" >

		<cfquery name="qryShortCut" datasource="#session.company_dsn#" >
			SELECT BOOKMARKNAME, BOOKMARKLINK
			  FROM ECINBOOKMARK
			 WHERE PERSONNELIDNO = '#session.chapa#'
		  ORDER BY RECDATECREATED DESC;
		</cfquery>

		<cfset Item1 = ArrayNew(1) >
		<cfset dataObj = StructNew() >
		<cfset dataObj['text'] = "New bookmark" >
		<cfset dataObj['action'] = "newbookmark" >

		<cfset ArrayAppend(Item1, dataObj) >
		<cfloop query="qryShortCut" >
			<cfset dataObj = StructNew() >
			<cfset dataObj['text'] = qryShortCut.BOOKMARKNAME >
			<cfset dataObj['href'] = qryShortCut.BOOKMARKLINK >
			<cfset dataObj['id'] = qryShortCut.BOOKMARKNAME >

			<cfset Item2 = ArrayNew(1) >
			<cfset dataObj2 = StructNew() >
			<cfset dataObj2['text'] = "Remove" >
			<cfset dataObj2['action'] = qryShortCut.BOOKMARKNAME >
			<cfset ArrayAppend(Item2, dataObj2) >
			<cfset dataObj['menu'] = Item2 >

			<cfset ArrayAppend(Item1, dataObj) >
		</cfloop>

		<cfreturn Item1 >

	</cffunction>


	<cffunction name="removeShortCut" ExtDirect="true" >
		<cfargument name="thename" required="true" type="string" >
		<cfargument name="thetype" required="true" type="string" >
		<cfquery name="deleteShortcut" datasource="#session.company_dsn#" >
			<cfif trim(thetype) eq "SHORTCUT" >
				DELETE FROM ECINSHORTCUT
				 WHERE PERSONNELIDNO = '#session.chapa#' AND SHORTCUTNAME = '#thename#'
		    <cfelseif trim(thetype) eq "BOOKMARK" >
		    	DELETE FROM ECINBOOKMARK
				 WHERE PERSONNELIDNO = '#session.chapa#' AND BOOKMARKNAME = '#thename#'
			</cfif>
		</cfquery>
		<cfreturn "success" >
	</cffunction>

	<cffunction name="getCompany" ExtDirect="true">
		<cfargument name="inputargs" >

		<cftry>

		<cfset page = inputargs.page />
		<cfset limit= inputargs.limit />
		<cfset start= inputargs.start />
		<cfif isdefined("inputargs.query") >
		<cfset query= inputargs.query />
		<cfelse>
		<cfset query= "" />
		</cfif>

		<cfif start gt 0 >
			<cfset start -= 1 >
			<cfset limit -= 1 >
		<cfelse>
			<cfset start += 1 >
			<cfset limit -= 1 >
		</cfif>

			<cfquery name="qryLookup" datasource="#session.global_dsn#">
				SELECT COMPANYCODE, DESCRIPTION
				  FROM GLKCOMPANY
				<cfif query NEQ "" >
				 WHERE DESCRIPTION LIKE '%#trim(query)#%'
				</cfif>
				ORDER BY DESCRIPTION ASC
			    ;
			</cfquery>

		    <cfquery name="countAll" datasource="#session.global_dsn#" >
		        SELECT COMPANYCODE
				  FROM GLKCOMPANY
				<cfif query NEQ "" >
				 WHERE DESCRIPTION LIKE '%#trim(query)#%'
				</cfif>
		        ;
		    </cfquery>


			<cfset totalcnt = countAll.recordcount >
		    <cfset resultArr = ArrayNew(1) >
		    <cfset rootstuct = StructNew() >

		    <cfset rootstuct['totalCount'] = totalcnt >
			<cfset rootstuct['success']    = "true" >
			<cfset cnt = 1 >
			  <cfloop query = "qryLookup" startrow="#start#" endrow="#limit#" >
			  	<cfset tmpresult = StructNew() >
				<cfset tmpresult['companycode']  = COMPANYCODE >
				<cfset tmpresult['companyname']  = DESCRIPTION >
				<cfset resultArr[cnt] = tmpresult    >
				<cfset cnt = cnt + 1 >
			  </cfloop>
			<cfset rootstuct['topics'] = resultArr >

			<cfreturn rootstuct />
		  <cfcatch>
		  	  <cfreturn cfcatch.Detail & ' ' & cfcatch.Message >
		  </cfcatch>
		  </cftry>
	</cffunction>

	<cffunction name="switchCompany" ExtDirect="true" >
		<cfargument name="scompanycode" required="true" type="string" >
		<cfscript>
			authObj = CreateObject("component","IBOSE.login.userauthentication");
			authObj.setupCompanySettings(trim(scompanycode));
		</cfscript>
		<cfreturn "true" >
	</cffunction>

</cfcomponent>