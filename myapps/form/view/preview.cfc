<cfcomponent name="data" ExtDirect="true">
	
<cffunction name="generateMap" ExtDirect="true" >
<cfargument name="processID" >
<cftry>

<cfset  xr1 = 300 >
<cfset  yr1 = 120 > 

<cfset  xr2 = 800 >
<cfset  yr2 = 120 >
<cfset  yr2b = 120 >

<cfset TOTALROUTERS = 0 >
<cfset MAXIMUMAPPROVERS = 1 >
<cfset routerHeight = 0 >

	<cfset formProcessData = EntityLoad("EGINFORMPROCESS", #processID#) >	 
	<cfloop array="#formProcessData#" index="processIndex" >
		<cfset EFORMLIFE     = processIndex.getEFORMLIFE() >
		<cfset EXPIREDACTION = processIndex.getEXPIREDACTION() >
		<cfset PROCESSNAME   = processIndex.getPROCESSNAME() > 
		
		 
		
		<cfset formRouterData = EntityLoad("EGINFORMROUTER", {PROCESSIDFK = #processID#}, "ROUTERORDER ASC") >
		<cfset TOTALROUTERS = ArrayLen(formRouterData) >
		
		
		
		
		<cfset routerDefinitions = ArrayNew(1) >
		<cfset cntr = 1 >
		<cfset approverDefinitions = ArrayNew(1) >
		<cfset acntr = 1 >
		<cfloop array="#formRouterData#" index="routerIndex" >
			
			<cfset ROUTERID = routerIndex.getROUTERID() >
			<cfset EFORMSTAYTIME = routerIndex.getEFORMSTAYTIME() >
			<cfset APPROVEATLEAST = routerIndex.getAPPROVEATLEAST() >
			<cfset AUTOAPPROVE = routerIndex.getAUTOAPPROVE() >
			<cfset ROUTERORDER = routerIndex.getROUTERORDER() >
			<cfset ISLASTROUTER = routerIndex.getISLASTROUTER() >
			<cfset CANOVERRIDE = routerIndex.getCANOVERRIDE() >
			<cfset USECONDITIONS = routerIndex.getUSECONDITIONS() >
			<cfset MAXA =  routerIndex.getMAXIMUMAPPROVERS() > 
			
			<cfif USECONDITIONS EQ "true" >
				<cfset APPROVEATLEAST = "Condition(s) applied" >
			<cfelse>
				<cfset APPROVEATLEAST = "Approve at least: #APPROVEATLEAST#" >
			</cfif> 
			
			<cfif cntr  EQ 1 >
			<cfloop array="#formRouterData#" index="routerIndexTemp" > 
				<cfset formApproversDataT = EntityLoad("EGINROUTERAPPROVERS", {ROUTERIDFK =#routerIndexTemp.getROUTERID()#}, "APPROVERORDER ASC" ) >
				<cfif ArrayLen(formApproversDataT) GT  MAXIMUMAPPROVERS> 
					<cfset MAXIMUMAPPROVERS = ArrayLen(formApproversDataT) >
				</cfif> <!---end formApproversData--->
			</cfloop>  
			</cfif>
			
			<cfset formApproversData = EntityLoad("EGINROUTERAPPROVERS", {ROUTERIDFK =#routerIndex.getROUTERID()#}, "APPROVERORDER ASC" ) >
				
			
			
			<cfloop array="#formApproversData#" index="approverIndex" > 
				<cfset APPROVERORDER = approverIndex.getAPPROVERORDER() >
				<cfset APPROVERNAME = approverIndex.getAPPROVERNAME() >
				<cfset CANVIEWROUTEMAP = approverIndex.getCANVIEWROUTEMAP() >
				<cfset CANOVERRIDE = approverIndex.getCANOVERRIDE() >
				<cfset PERSONNELIDNO = approverIndex.getPERSONNELIDNO() >
				<cfset USERGRPID = approverIndex.getUSERGRPID() >
				<cfset CONDITIONBELOW = approverIndex.getCONDITIONBELOW() >
				
				<cfif AUTOAPPROVE  EQ "true">
					<cfset arrowcolor = "black" >
				<cfelse>
					<cfif approverIndex.getCANOVERRIDE() EQ "true" OR routerIndex.getCANOVERRIDE() >
						<cfset arrowcolor = "blue" >
					<cfelse>
						<cfset arrowcolor = "##79BB3F" >
					</cfif>
					
				</cfif>
				
				<cfif USECONDITIONS EQ "true" >
					
				<cfelse>
					<cfset CONDITIONBELOW = "" >
				</cfif> 
				
				
				<cfif APPROVERNAME EQ "IS">
					<cfset thename = "Immediate Superior Name" >
					<cfset theposition = "IS Position" >
					<cfset thedepartment = "Immediate Superior" >
				<cfelseif APPROVERNAME EQ "DEPARTMENTCODE">
					<cfset thename = "Name using department code" >
					<cfset theposition = "Position" >
					<cfset thedepartment = "Department" >
				<cfelseif APPROVERNAME EQ "BACKTOSENDER">
					<cfset thename = "Name of the sender" >
					<cfset theposition = "Position of the sender" >
					<cfset thedepartment = "Back to Sender" >
				<cfelseif APPROVERNAME EQ "BACKTOORIGINATOR">
					<cfset thename = "Name of the originator" >
					<cfset theposition = "Position of the originator" >
					<cfset thedepartment = "Originator" >
				<cfelseif APPROVERNAME EQ "USERROLE">
					<cfset thename = "Name using user role" >
					<cfset theposition = "Position using user role" >
					<cfset thedepartment = "User Role" >
				<cfelseif APPROVERNAME EQ "SPECIFICNAME">
					<cfset thename = "Name with (#PERSONNELIDNO#)" >
					<cfset theposition = "Position" >
					<cfset thedepartment = "Specific Name" >
				<cfelseif APPROVERNAME EQ "DEPARTMENTHEAD">
					<cfset thename = "Name with department head" >
					<cfset theposition = "Position" >
					<cfset thedepartment = "Specific Name" >
				<cfelse>
					<cfset thename = "Name is not defined" >
					<cfset theposition = "Position" >
					<cfset thedepartment = "Unknown" >
				</cfif> 
				
				<cfset approverDefinitions[acntr] = "{
												        type: 'image',
												        name: '#PERSONNELIDNO#',
												        src: './myapps/form/view/unknownsmile.png',
												        width: 106,
												        height: 106,
												        listeners: {
												            click: function(thiss) {
												                alert(thiss.name);
												            }
												        },
												        x: #xr2-270#,
												        y: #yr2b+20#
												    },{
												        type: 'path',
												        fill: '#arrowcolor#',
												        path: 'M#xr2-160# #yr2b+72# L#xr2-40# #yr2b+72# L#xr2-40# #yr2b+62# L#xr2-10# #yr2b+77# L#xr2-40# #yr2b+92# L#xr2-40# #yr2b+82# L#xr2-160# #yr2b+82# Z'
												    },{ 
												        type: 'path',
												        fill: '#arrowcolor#', 
												        path:  'M#xr2-440# #yr2b+72# L#xr2-320# #yr2b+72# L#xr2-320# #yr2b+62# L#xr2-290# #yr2b+77# L#xr2-320# #yr2b+92# L#xr2-320# #yr2b+82# L#xr2-440# #yr2b+82# Z'
												    },{ 
												        type: 'text',
												        text: '#thename#',
												        fill: '#arrowcolor#',
												        font: '12px arial',
												        x: #xr2-270#, 
												        y: #yr2b+140# 
												    },{
												        type: 'text',
												        text: '#theposition#',
												        fill: '#arrowcolor#',
												        font: '12px arial',
												        x: #xr2-270#, 
												        y: #yr2b+155# 
												    },{
												        type: 'text',
												        text: '#thedepartment#',
												        fill: '#arrowcolor#',
												        font: '12px arial',
												        x: #xr2-270#, 
												        y: #yr2b+170#
												    },{
												        type: 'text',
												        text: 'STATUS',
												        fill: '#arrowcolor#',
												        font: '12px arial',
												        x: #xr2-270#,  
												        y: #yr2b+10#
												    },{
												        type: 'text',
												        text: 'Date Routed',
												        fill: '#arrowcolor#',
												        font: '12px arial',
												        x: #xr2-160#, 
												        y: #yr2b+40#
												    },{
												        type: 'text',
												        text: 'Elapsed Time',
												        fill: '#arrowcolor#',
												        font: '12px arial', 
												        x: #xr2-160#, 
												        y: #yr2b+55#
												    },{
												    	type: 'text',
												    	text: '#CONDITIONBELOW#',
												    	fill: '#arrowcolor#',
												        font: '20px arial',
												        x: #xr2-50#, 
												        y: #yr2b+180#
												    }" >   
			
			<cfset yr2b = yr2b + 200 >
			<cfset acntr = acntr + 1 >
			</cfloop> <!---end formApproversData--->
			
			
			<cfset routerHeight  = 200*MAXIMUMAPPROVERS >
			<cfif AUTOAPPROVE EQ "true" >
				<cfset routercolor = "black" >
			<cfelse>
				<cfif routerIndex.getCANOVERRIDE()  EQ "true" >
					<cfset routercolor = "blue" >  
				<cfelse>
					<cfset routercolor = "##79BB3F" >
				</cfif>
			</cfif>
			
			<cfset routerDefinitions[cntr] = "{
								        type: 'rect',
								        height: #routerHeight#,
								        width: 50,
								        fill: '#routercolor#',
								        stroke: 'white',
								        'stroke-width': 2,
								        x: #xr2#,
								        y: #yr2# 
								        
								    },{
								        type: 'text',
								        text: '#ROUTERORDER#',
								        fill: 'black',
								        font: '14px arial',
								        x: #xr2#, 
								        y: #yr2-70# 
								    },{
								        type: 'text',
								        text: 'Until: #EFORMSTAYTIME# days',
								        fill: 'black',
								        font: '12px arial',
								        x: #xr2#, 
								        y: #yr2-55# 
								    },{
								        type: 'text',
								        text: 'Date Completed: ',
								        fill: 'black',
								        font: '12px arial',
								        x: #xr2#, 
								        y: #yr2-40#
								    },{
								        type: 'text',
								        text: '#APPROVEATLEAST#',
								        fill: 'black',
								        font: '12px arial',
								        x: #xr2#, 
								        y: #yr2-25# 
								    },{
								        type: 'text',
								        text: 'Status: ',
								        fill: 'black',
								        font: '12px arial',
								        x: #xr2#, 
								        y: #yr2-10#  
								    }" > 
		
		<cfset xr2 = xr2 + 500 >
		
		
		<cfset cntr = cntr + 1 >
		
		<cfset  yr2 = 120 >
		<cfset  yr2b = 120 >
		</cfloop> <!---end formRouterData--->
		<cfset  xr2 = 800 >
		<cfset  yr2 = 120 >
		<cfset  yr2b = 120 >
			
		<cfset processWidth  =  500 + (500*TOTALROUTERS) > 
		<cfset processHeight = 200+(200*MAXIMUMAPPROVERS) >
		
		<cfset processTitle = "{
							        type: 'text',
							        text: 'Name: #PROCESSNAME# - #EXPIREDACTION# after #EFORMLIFE# days',
							        fill: 'green',
							        font: '14px arial',
							        x: 5,
							        y: 15
							    }" >
					
		<cfset legend =       "{
						        type: 'rect',
						        height: 10,
						        width: 50,
						        fill: 'black',
						        stroke: 'white',
						        'stroke-width': 2,
						        x: 500,
						        y: 2 
						        
						    },{
						        type: 'rect',
						        height: 10,
						        width: 50,
						        fill: 'green',
						        stroke: 'white',
						        'stroke-width': 2,
						        x: 700,
						        y: 2
						        
						    },{
						        type: 'rect',
						        height: 10,
						        width: 50,
						        fill: 'blue',
						        stroke: 'white',
						        'stroke-width': 2,
						        x: 500,
						        y: 15
						        
						    },{
						        type: 'rect',
						        height: 10,
						        width: 50,
						        fill: 'yellow',
						        stroke: 'white',
						        'stroke-width': 2,
						        x: 700,
						        y: 15
						        
						    },{
							        type: 'text',
							        text: '(Auto) Approve',
							        fill: 'black',
							        font: '12px arial',
							        x: 560,
							        y: 10
							   },{
							        type: 'text',
							        text: 'Cannot Override',
							        fill: 'black',
							        font: '12px arial',
							        x: 760,
							        y: 10
							   },{
							        type: 'text',
							        text: 'Can Override',
							        fill: 'black',
							        font: '12px arial',
							        x: 560,
							        y: 22
							   },{
							        type: 'text',
							        text: 'Originator',
							        fill: 'black',
							        font: '12px arial',
							        x: 760,
							        y: 22
							   }" >
		
		
		
		
	</cfloop> <!---end formProcessData---> 
	
	<cfset routerDraw = "" >
	<cfif isdefined("routerDefinitions") >
		<cfif ArrayLen(routerDefinitions) GT 0 >
			<cfset routerDraw = ArrayToList(routerDefinitions, ',') >
		<cfelse>
			<cfset routerDraw = "{
							        type: 'text',
							        text: 'No router',
							        fill: 'green',
							        font: '14px arial',
							        x: 5,
							        y: 45
							    }" >
		</cfif>
	<cfelse>
			<cfset routerDraw = "{
							        type: 'text',
							        text: 'No router',
							        fill: 'green',
							        font: '14px arial',
							        x: 5,
							        y: 45
							    }" > 
	</cfif>
	
	<cfset approverDraw = "" >
	<cfif isdefined("approverDefinitions") >
		<cfif ArrayLen(approverDefinitions) GT 0 > 
			<cfset approverDraw = ArrayToList(approverDefinitions,',') >
		<cfelse>
		</cfif>
	<cfelse>
		
	</cfif>
	
	<cfif TOTALROUTERS EQ 0 >
		<cfset originator = "{
							        type: 'text',
							        text: '0',
							        fill: 'black',
							        font: '14px arial',
							        x: #xr1#, 
							        y: #yr1-70# 
							    }" >
	<cfelse>
		
		<cfset originator = "{
						        type: 'rect',
						        height: #routerHeight#,
						        width: 50,
						        fill: 'yellow',
						        stroke: 'white',
						        'stroke-width': 2,
						        x: #xr1#,
						        y: #yr1# 
						        
						    },{
						        type: 'text',
						        text: '0',
						        fill: 'black',
						        font: '14px arial',
						        x: #xr1#, 
						        y: #yr1-70# 
						    },{
						        type: 'text',
						        text: '_',
						        fill: 'black',
						        font: '12px arial',
						        x: #xr1#, 
						        y: #yr1-55# 
						    },{
						        type: 'text',
						        text: '_',
						        fill: 'black',
						        font: '12px arial',
						        x: #xr1#, 
						        y: #yr1-40# 
						    },{
						        type: 'text',
						        text: '_',
						        fill: 'black',
						        font: '12px arial',
						        x: #xr1#, 
						        y: #yr1-25# 
						    },{
						        type: 'text',
						        text: '_',
						        fill: 'black',
						        font: '12px arial',
						        x: #xr1#, 
						        y: #yr1-10# 
						    },{
						        type: 'image',
						        name: 'Originator',
						        src: './myapps/form/view/unknownsmile.png',
						        width: 106,
						        height: 106, 
						        listeners: {
						            click: function(thiss) {
						                alert(thiss.name);
						            }
						        },
						        x: #xr1-270#,
						        y: #yr1+20#
						    },{
						        type: 'path',
						        fill: 'black',
						        path: 'M#xr1-160# #yr1+72# L#xr1-40# #yr1+72# L#xr1-40# #yr1+62# L#xr1-10# #yr1+77# L#xr1-40# #yr1+92# L#xr1-40# #yr1+82# L#xr1-160# #yr1+82# Z'
						    },{ 
						        type: 'text',
						        text: 'Name of the Originator',
						        fill: 'black',
						        font: '12px arial',
						        x: #xr1-270#, 
						        y: #yr1+140# 
						    },{
						        type: 'text',
						        text: 'Position',
						        fill: 'black',
						        font: '12px arial',
						        x: #xr1-270#, 
						        y: #yr1+155# 
						    },{
						        type: 'text',
						        text: 'Originator',
						        fill: 'black',
						        font: '12px arial',
						        x: #xr1-270#, 
						        y: #yr1+170#
						    },{
						        type: 'text',
						        text: 'ORIGINATOR',
						        fill: 'black',
						        font: '12px arial',
						        x: #xr1-270#,  
						        y: #yr1+10#
						    },{
						        type: 'text',
						        text: 'Date Sent',
						        fill: 'black',
						        font: '12px arial',
						        x: #xr1-160#, 
						        y: #yr1+40#
						    },{
						        type: 'text',
						        text: 'Elapsed Time',
						        fill: 'black',
						        font: '12px arial',
						        x: #xr1-160#, 
						        y: #yr1+55#
						    }" >
						    
	 </cfif> 
	
<cfset theScript = "Ext.create('Ext.window.Window',{
			closable: true,
			autoShow: true,
			autoDestroy: true,
		    height: '100%',
		    width: '100%',
		    layout: 'fit',
			items: [{
				xtype: 'panel',
				layout: {
					type: 'vbox',
					align: 'left'
				},
				autoScroll: true,
				name: 'paneldrawpanelwin',
				title: 'eForm Path Preview',
				items: [{
			        xtype: 'draw',
					width: #processWidth#,
					height: #processHeight#,
					autoShow: true,
					viewBox: false,
					items: [
						#legend#,
						#originator#,
						#processTitle#,
						#routerDraw#,
						#approverDraw#   
					]
			    }]

		  }]
		
		
});">
	 
	 <cfreturn theScript >
<cfcatch>
	<cfreturn cfcatch.detail & ' ' & cfcatch.message >
</cfcatch>
</cftry>
</cffunction>  
</cfcomponent>
