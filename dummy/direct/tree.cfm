		<cfquery name="qryApps" datasource="#session.global_dsn#" >
			SELECT MENUID,
				   MENUNAME,
				   MENUHINT,
				   PARENTMENUID,
				   SOURCELINK,
				   STYLE,
				   HIERARCHYLEVEL,
				   ACTIONSCRIPT
			  FROM EGRGMENU
			 WHERE MENUID IN (SELECT MENUID
			                    FROM EGRTMENU
			                   WHERE APPLICANTNUMBER = '#session.chapa#'
			                  )
			ORDER BY HIERARCHYLEVEL DESC, MENUORDER DESC;
		</cfquery>
		
		<cfset topLevel = 1 >
		
		<cfloop query="qryApps" >
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
			
			<cfoutput>Item#qryApps.HIERARCHYLEVEL#</cfoutput><br>
			<cfdump var="#Evaluate('Item#qryApps.HIERARCHYLEVEL#')#" ><br>
			<cfdump var="#Evaluate('QueryRef#qryApps.HIERARCHYLEVEL#')#" ><br>
		</cfloop>
		
		<cfset itemName = ArrayNew(1) >
		<cfloop from="#topLevel#" to="1" step="-1" index="menuno" >
			
			<cfloop from="1" to="#Evaluate('Item#menuno#')#" index="x">
				
				<cfset parentid = replace(qryApps.PARENTMENUID[Evaluate("QueryRef#menuno#")[x]],"-","_","all") >
				<cfif Not IsDefined("Item#menuno#_#parentid#") >
					<cfset "Item#menuno#_#parentid#" = ArrayNew(1) >
				</cfif>
				
				<cfset uniqueid = replace(qryApps.MENUID[Evaluate("QueryRef#menuno#")[x]],"-","_","all") >
				<cfset data = StructNew() >
				<cfset data['text'] = "#qryApps.MENUNAME[Evaluate('QueryRef#menuno#')[x]]#" >
				
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
		
		<cfdump var="#itemName#" >
			
		
