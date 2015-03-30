<cfcomponent name="File" ExtDirect="true">
	<cffunction name="readMyFolder" ExtDirect="true" >

		<cftry>
			<cfset topLevel = 1 >
		    <cfquery name="qryFolders" datasource="#session.global_dsn#">
				SELECT  A.FOLDERID AS FOLDERID,
						A.OBJECTIDFK AS OBJECTIDFK,
						A.FOLDERNAME AS FOLDERNAME,
						A.FOLDERHINT AS FOLDERHINT,
						A.PARENTFOLDERID AS PARENTFOLDERID,
						A.FOLDERORDER AS FOLDERORDER,
						A.FOLDERDEPTH AS FOLDERDEPTH,
						A.FOLDERURL AS FOLDERURL,
						A.EXTRAS AS EXTRAS,
						B.OBJECTNAME AS OBJECTNAME,
						B.OBJECTLOGO AS OBJECTLOGO
				  FROM  EGRGFOLDER A LEFT JOIN EGRGOBJECTTYPE B ON (A.OBJECTIDFK = B.OBJECTID)
				 WHERE  A.PERSONNELIDNO = '#session.chapa#'
				ORDER BY A.FOLDERDEPTH DESC, A.FOLDERORDER ASC
			</cfquery>

			<cfloop query="qryFolders" > <!---prepare ItemNo array for no. of menus and array map/link to this query results--->
				<cfif Not IsDefined("Item#qryFolders.FOLDERDEPTH#") >
					<cfset "Item#qryFolders.FOLDERDEPTH#" = 0 >
				</cfif>
				<cfif Not IsDefined("QueryRef#qryFolders.FOLDERDEPTH#") >
					<cfset "QueryRef#qryFolders.FOLDERDEPTH#" = ArrayNew(1) >
				</cfif>
				<cfif qryFolders.CurrentRow eq 1>
					<cfset topLevel = qryFolders.FOLDERDEPTH >
				</cfif>

				<cfset "Item#qryFolders.FOLDERDEPTH#" = Evaluate("Item#qryFolders.FOLDERDEPTH#") + 1>
				<cfset ArrayAppend(Evaluate("QueryRef#qryFolders.FOLDERDEPTH#"), qryFolders.CurrentRow ) >
			</cfloop> <!---end prepare--->

			<cfset itemName = ArrayNew(1) >
			<cfloop from="#topLevel#" to="1" step="-1" index="menuno" >
				<cfif Not IsDefined("Item#menuno#") > <!---is not directly linked--->
					<cfcontinue>
				</cfif>
				<cfloop from="1" to="#Evaluate('Item#menuno#')#" index="x">

					<cfset parentid = replace(qryFolders.PARENTFOLDERID[Evaluate("QueryRef#menuno#")[x]],"-","_","all") >
					<cfif Not IsDefined("Item#menuno#_#parentid#") >
						<cfset "Item#menuno#_#parentid#" = ArrayNew(1) >
					</cfif>

					<cfset uniqueid = replace(qryFolders.FOLDERID[Evaluate("QueryRef#menuno#")[x]],"-","_","all") >
					<cfset data = StructNew() >
					<cfset dtext = trim(qryFolders.FOLDERNAME[Evaluate('QueryRef#menuno#')[x]]) >
					<cfif dtext eq "" >
						<cfset dtext = "{Empty String}" >
					</cfif>
					<cfset data['text'] = dtext >

					<cfset diconcls = trim(qryFolders.OBJECTLOGO[Evaluate('QueryRef#menuno#')[x]]) >
					<cfif diconcls neq "" >
						<cfset data['iconCls'] = diconcls >
					</cfif>

					<cfset dhint = trim(qryFolders.FOLDERHINT[Evaluate('QueryRef#menuno#')[x]]) >
					<cfif dhint neq "" >
						<cfset data['qtip'] = dhint >
					</cfif>

					<cfset dlink = trim(qryFolders.FOLDERURL[Evaluate('QueryRef#menuno#')[x]]) >
					<cfif dlink neq "" >
						<cfset data['href'] = dlink>
					</cfif>
					<cfset data['leaf'] = "false">
					<cfset data['expanded'] = "false">
					<cfset data['editor'] = "textfield">

					<cfloop list="#qryFolders.EXTRAS[Evaluate('QueryRef#menuno#')[x]]#" delimiters=";" index="Litem" >
						<cfif ListLen(Litem,",") eq 2 >
							<cfset data['#ListGetAt(Litem,1,",")#'] = "#ListGetAt(Litem,2,",")#">
						</cfif>
					</cfloop>


					<cfif qryFolders.FOLDERDEPTH[Evaluate("QueryRef#menuno#")[x]] lt topLevel > <!---top level has no menu structure--->
						<cfif IsDefined("Item#menuno+1#_#uniqueid#") >
							<cfset data['children'] = Evaluate("Item#menuno+1#_#uniqueid#") >
						</cfif>
					</cfif>

					<cfset ArrayAppend(Evaluate("Item#menuno#_#parentid#"), data) >

					<cfif menuno eq 1 AND x eq Evaluate('Item#menuno#') > <!---is the last item--->
						<cfset itemName = Evaluate("Item#menuno#_#parentid#") >
					</cfif>

				</cfloop>

			</cfloop>

			<cfreturn itemName >









			<cfset retArray = ArrayNew(1) >
			<cfset retStruct = StructNew() >

			<cfset itemArr = ArrayNew(1) >

			<cfset itemStruct = StructNew() >
			<cfset itemStruct['text'] = "detention" >
			<cfset itemStruct['leaf'] = "true" >
			<cfset itemStruct['expanded'] = "true" >
			<cfset ArrayAppend(itemArr, itemStruct)>

			<cfset itemStruct = StructNew() >
			<cfset itemStruct['text'] = "homework" >
			<cfset itemStruct['expanded'] = "true" >
			<cfset itemStruct['leaf'] = "true" >
			<cfset ArrayAppend(itemArr, itemStruct)>

			<cfset itemStruct = StructNew() >
			<cfset itemStruct['text'] = "buy lottery tickets" >
			<cfset itemStruct['leaf'] = "true" >
			<cfset ArrayAppend(itemArr, itemStruct)>


			<cfset rootStruct = StructNew() >
			<cfset rootStruct['expanded'] = "true">
			<cfset rootStruct['success'] = "true">
			<cfset rootStruct['text'] = "Leonell A. Lagumbay">
			<cfset rootStruct['children'] = itemArr>

			<cfset ArrayAppend(retArray, rootStruct)>


			<cfreturn retArray >
		<cfcatch>
			<cfreturn cfcatch.detail & ' ' & cfcatch.message >
		</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="createMyFolder" ExtDirect="true" >
		<cfargument name="arg1" required="true" type="string" >

		<cftry>
			<cfset retArray = ArrayNew(1) >
			<cfreturn retArray >
		<cfcatch>
			<cfreturn cfcatch.detail & ' ' & cfcatch.message >
		</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="updateMyFolder" ExtDirect="true" >
		<cfargument name="arg1" required="true" type="string" >

		<cftry>
			<cfset retArray = ArrayNew(1) >
			<cfreturn retArray >
		<cfcatch>
			<cfreturn cfcatch.detail & ' ' & cfcatch.message >
		</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="destroyMyFolder" ExtDirect="true" >
		<cfargument name="arg1" required="true" type="string" >

		<cftry>
			<cfset retArray = ArrayNew(1) >
			<cfreturn retArray >
		<cfcatch>
			<cfreturn cfcatch.detail & ' ' & cfcatch.message >
		</cfcatch>
		</cftry>
	</cffunction>

</cfcomponent>