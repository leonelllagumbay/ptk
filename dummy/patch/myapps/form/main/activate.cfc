<cfcomponent name="activate" ExtDirect="true"> 
	
<cffunction name="generateGrid" ExtDirect="true">
	<cfargument name="eformid" >
	<cftry>
		
		
		<cfset eFormName = ORMExecuteQuery("SELECT EFORMNAME FROM EGRGEFORMS WHERE EFORMID = '#eformid#'", true ) >
		
		<cfset getMainTableID = ORMExecuteQuery("SELECT B.TABLENAME AS TABLENAME, B.LEVELID AS LEVELID, C.COLUMNNAME AS COLUMNNAME
	  								      FROM EGRGEFORMS A,EGRGIBOSETABLE B,EGRGIBOSETABLEFIELDS C
	 								      WHERE EFORMID = '#eformid#' AND A.EFORMID = B.EFORMIDFK AND B.TABLEID = C.TABLEIDFK AND C.XTYPE = 'id'", true) >



		<cfif trim(getMainTableID[1]) neq "" >
			<cfset firsttable  = getMainTableID[1] >
			<cfset firstlevel  = getMainTableID[2] >
			<cfset firstcolumn = getMainTableID[3] >
		<cfelse>
			<cfthrow detail="Table has no id specified in table fields. At least one field type is an id type." >
		</cfif>

		<!---get the eformid--->
		<!---using this eformid get all the tables--->
		<!---in each table get the columns assigned--->
		 
		<cfset gridScript = "" >
		 
		<cfset columnnameArr = ArrayNew(1) >
		<cfset columnItemArr = ArrayNew(1) >
		
		<cfset formTableData = EntityLoad("EGRGIBOSETABLE", {EFORMIDFK = #eformid#}) >
		<cfset TOTALTABLES = ArrayLen(formTableData) >
		
		<cfloop array="#formTableData#" index="tableIndex" >
			<cfset TABLENAME = tableIndex.getTABLENAME() > 
			<cfset LEVELID = tableIndex.getLEVELID() >
			
			
			<cfset tableColumnData = EntityLoad("EGRGIBOSETABLEFIELDS", {TABLEIDFK = #tableIndex.getTABLEID()#}) >
			<cfset TOTALCOLUMNS = ArrayLen(tableColumnData) >
			
			
			
			<cfloop array="#tableColumnData#" index="columnIndex" >
				<cfset COLUMNNAME = columnIndex.getCOLUMNNAME() >
				<cfset COLUMNORDER = columnIndex.getCOLUMNORDER() >
				<cfset COLUMNTYPE = columnIndex.getCOLUMNTYPE() >
				<cfset XTYPE = columnIndex.getXTYPE() > 
				<cfset FIELDLABEL = columnIndex.getFIELDLABEL() > 
				<cfset ISHIDDEN = columnIndex.getISHIDDEN() >  
				<cfset ISREADONLY = columnIndex.getISREADONLY() >
				<cfset ISDISABLED = columnIndex.getISDISABLED() > 
				<cfset RENDERER = columnIndex.getRENDERER() > 
				<cfset WIDTH = columnIndex.getWIDTH() > 
				
				<cfset dataIndex = "#LEVELID#__#TABLENAME#__#COLUMNNAME#" >
				
				<cfset res = findnocase('%',WIDTH) >
				<cfif res EQ 0 AND trim(WIDTH) NEQ "">
					<cfset width = ",width: #WIDTH#" >
				<cfelseif trim(WIDTH) EQ "" >
					<cfset width = ",flex: 1" > 
				<cfelse>
					<cfset width = ",width: '#WIDTH#'" >
				</cfif>
				
				
				<cfset filter = "" >
				<cfif XTYPE EQ "datefield" >
					<cfif RENDERER eq "" >
					<cfset RENDERER ="Ext.util.Format.dateRenderer('n/j/Y')" >
					<cfset filter = ",filter: {
										type: 'date',
										format: 'Y-n-j'
									}" >
					<cfelse>
					</cfif>
				<cfelse>
				</cfif>
				
				<cfif XTYPE EQ "id" >
					<cfset XTYPE = "textfield">
				<cfelse> 
				</cfif>
				
				<cfif XTYPE EQ "hiddenfield" >
					<cfset ISHIDDEN = "true">
				<cfelse> 
				</cfif>
				
				<cfif XTYPE EQ "displayfield" AND COLUMNORDER EQ 0 >
					<cfset ISHIDDEN = "true">
				<cfelse> 
				</cfif>
				
				<cfset forColName = "{
										name: '#dataIndex#',
										type: '#COLUMNTYPE#'
									 }" >
												 
				<cfset ArrayAppend(columnnameArr, forColName) >
				
				<cfset forColItem = "{
										text: '#FIELDLABEL#',
										hidden: #ISHIDDEN#,
										dataIndex: '#dataIndex#',
										filterable: true,
										renderer: '#RENDERER#'
										#width#
										#filter#
	                                 }" >	
				<cfset ArrayAppend(columnItemArr, forColItem) >						 
				
			</cfloop> <!---end tableColumnData--->
		
		</cfloop> <!---end formTableData--->
		
		
		<cfset fields = ArrayToList(columnnameArr, ", ") >
		<cfset columns = ArrayToList(columnItemArr, ", ") >
		
		<cfset gridScript = " 
		Ext.define('autoeFormModel', {
			extend: 'Ext.data.Model',  
			fields: [
				#fields#,
				'#firstlevel#__#firsttable#__APPROVED',
				'#firstlevel#__#firsttable#__EFORMID',
				'#firstlevel#__#firsttable#__PROCESSID',
				'#firstlevel#__#firsttable#__ACTIONBY',
				'#firstlevel#__#firsttable#__PERSONNELIDNO',
				{
					name: '#firstlevel#__#firsttable#__RECDATECREATED',
					type: 'date'
				},
				{
					name: '#firstlevel#__#firsttable#__DATEACTIONWASDONE',
					type: 'date'
				},
				{
					name: '#firstlevel#__#firsttable#__DATELASTUPDATE',
					type: 'date'
				}
			]
		}); 
		
		var autoeFormStore = Ext.create('Ext.data.Store', {
			model: 'autoeFormModel',
			remoteFilter: true,
			remoteSort: true,
			simpleSortMode: true,
			sorters: [{
		            property: '#firstlevel#__#firsttable#__DATELASTUPDATE', 
		            direction: 'DESC'
		    }],
			filters: [{
					type: 'string',
		            dataIndex: '#firstlevel#__#firsttable#__#firstcolumn#'  
			}],
			pageSize: 50,
			autoSave: true,
			autoLoad: true,
			autoSync: true,
			
	        proxy: {
	        	extraParams: {
					eformid: '#eformid#',
					isnew: false,
					ispending: false
				},
				type: 'direct',
				paramOrder: ['page', 'start', 'limit', 'sort', 'filter', 'eformid', 'isnew', 'ispending'],
				api: {
			        read:    Ext.ss.defdata.ColumnReadNow,  
			        create:  Ext.ss.defdata.ColumnCreateNow,  
			        update:  Ext.ss.defdata.ColumnUpdateNow,  
			        destroy: Ext.ss.defdata.ColumnDestroyNow 
			    },
				paramsAsHash: false,
				filterParam: 'filter',
				sortParam: 'sort',
				limitParam: 'limit',
				idParam: 'ID',
				pageParam: 'page',
				reader: {
		            root: 'topics',
		            totalProperty: 'totalCount'
		        }
			}
		});
		
		var autoeFormGrid = Ext.create('Ext.grid.Panel',{
			alias: 'widget.eFormGrid',
			title: '#eFormName#',
			width: '100%',
			height: 500,
			multiSelect: true,
		    clicksToEdit: 2,
			selModel: {
				    pruneRemoved: false
			}, 
			viewConfig: {
			    forceFit: false,
				trackOver: false,
			    emptyText: '<h1 style=\'margin:20px\'>No matching results</h1>'
			},
			features: [{
				ftype: 'filters',
				encode: true, 
				local: false, 
			}],
			store: autoeFormStore,
			bbar: Ext.create('Ext.toolbar.Paging', {
				        store: autoeFormStore, 
				        displayInfo: true,
				        emptyMsg: 'No topics to display'
			}), 
			tbar: [{
			  	text: 'Add',
				action: 'addeform',
				handler: function(thiss) {
					alert('Adding');
				}
			  },{
			  	xtype: 'tbseparator'
			  },{
			  	text: 'Edit',
				action: 'editeform'
			  },{
			  	xtype: 'tbseparator'
			  },{
			  	text: 'Delete',
				action: 'deleteeform'
			  },{
			  	xtype: 'tbseparator'
			  },{
			  	text: 'View Path',
				action: 'viewpathroute'
			  },{
			  	xtype: 'tbseparator'
			  },{
			  	text: 'Route',
				action: 'routeeform'
			  }],
		columns: [{
            xtype: 'rownumberer', 
            width: 50,
            sortable: false
	       },
	       #columns#,
	       {
            text: 'Approved',
            dataIndex: '#firstlevel#__#firsttable#__APPROVED',
            width: '100'
	       },{
            text: 'eFormID',
            dataIndex: '#firstlevel#__#firsttable#__EFORMID',
            hidden: true
	       },{
            text: 'ProcessID',
            dataIndex: '#firstlevel#__#firsttable#__PROCESSID',
            hidden: true
	       },{
            text: 'ActonBy',
            dataIndex: '#firstlevel#__#firsttable#__ACTIONBY',
            hidden: true
	       },{
            text: 'PersonnelID',
            dataIndex: '#firstlevel#__#firsttable#__PERSONNELIDNO',
            hidden: true
	       },{
            text: 'Record Date Created',
            dataIndex: '#firstlevel#__#firsttable#__RECDATECREATED',
            hidden: true
	       },{
            text: 'Date Action Was Done',
            dataIndex: '#firstlevel#__#firsttable#__DATEACTIONWASDONE',
            hidden: true
	       },{
            text: 'Date Last Update', 
            dataIndex: '#firstlevel#__#firsttable#__DATELASTUPDATE',
            hidden: true
	       }
	       ]	 
			 
	});
	
	Ext.create('Ext.window.Window', {
	    height: '100%',
	    width: '100%',
	    layout: 'fit',
	    modal: true,
	    items: autoeFormGrid
	}).show();
	

	" >
<cfset processData = EntityLoad("EGRGEFORMS", #eformid#, true ) >
<cfset processData.setGRIDSCRIPT("#gridScript#") >
<cfset EntitySave(processData) >
<cfset ormflush()> 
	
	<cfinvoke method="generateForm" eformid="#eformid#" returnvariable="result" >

	
		<cfreturn gridScript >
	<cfcatch>
		<cfreturn cfcatch.detail & ' ' & cfcatch.message >
	</cfcatch>
	</cftry>
</cffunction>




<cffunction name="generateForm" ExtDirect="true"> 
	<cfargument name="eformid" >
	<!---<cftry>--->
	<cfset formScript = "" >
	<cfset fieldSetItems = "" >
	<cfset fieldItems = "" >
	<cfset fieldArr = ArrayNew(1) >
	<cfset validationArr = ArrayNew(1) >
	<cfset columnModelStore = ArrayNew(1) >
	<cfset groupStruct = structnew() >
	<cfset groupStruct.__ = ArrayNew(1) >
	<cfset groupStruct.__nogroup = ArrayNew(1) >
	<cfset Y__nogroup = 200 >
	<cfset formpadding = 5>
	<cfset formgroupmargin = 5>
	<cfset cntStore = 1 >
	<cfset cntVType = 1 >
	<cfset cntA = 1 >
	<cfset withfileField = "false" >
	<cfset fileCount = 0 >
	
	<cfset formProcessData = EntityLoad("EGRGEFORMS", {EFORMID = #eformid#}, true) >
	
		<cfset formtitle = formProcessData.getEFORMNAME() >
		<cfset formdescription = formProcessData.getDESCRIPTION() >
		<cfset formgroup = formProcessData.getEFORMGROUP() >
		<cfset formflowprocess = formProcessData.getFORMFLOWPROCESS() >
		<cfset formencrypted = formProcessData.getISENCRYPTED() >
		<cfset formviewas = formProcessData.getVIEWAS() >
		<cfset formpadding = formProcessData.getFORMPADDING() >
		<cfset formgroupmargin = formProcessData.getGROUPMARGIN() > 
		
		
		<cfset formTableData = EntityLoad("EGRGIBOSETABLE", {EFORMIDFK = #eformid#}) >
		
		<cfset TOTALTABLES = ArrayLen(formTableData) >
		
		<cfloop array="#formTableData#" index="tableIndex" >
			
			<cfset TABLENAME = tableIndex.getTABLENAME() > 
			<cfset LEVELID = tableIndex.getLEVELID() >
			
			<cfset tableColumnData = EntityLoad("EGRGIBOSETABLEFIELDS", {TABLEIDFK = #tableIndex.getTABLEID()#}, "COLUMNORDER ASC") >
			<cfset TOTALCOLUMNS = ArrayLen(tableColumnData) >
			
			<cfloop array="#tableColumnData#" index="columnIndex" >
				<cfset COLUMNID = columnIndex.getCOLUMNID() >
				<cfset TABLEIDFK = columnIndex.getTABLEIDFK() >
				<cfset COLUMNNAME = columnIndex.getCOLUMNNAME() >
				<cfset FIELDLABEL = columnIndex.getFIELDLABEL() >
				<cfset COLUMNORDER = columnIndex.getCOLUMNORDER() >
				<cfset COLUMNTYPE = columnIndex.getCOLUMNTYPE() >
				<cfset XTYPE = columnIndex.getXTYPE() >
				<cfset COLUMNGROUP = columnIndex.getCOLUMNGROUP() >
				<cfset FIELDLABELALIGN = columnIndex.getFIELDLABELALIGN() >
				<cfset FIELDLABELWIDTH = columnIndex.getFIELDLABELWIDTH() >
				<cfset ALLOWBLANK = columnIndex.getALLOWBLANK() >
				<cfset ISCHECKED = columnIndex.getISCHECKED() >
				<cfset CSSCLASS = columnIndex.getCSSCLASS() >
				<cfset ISDISABLED = columnIndex.getISDISABLED() >
				<cfset HEIGHT = columnIndex.getHEIGHT() >
				<cfset WIDTH = columnIndex.getWIDTH() >
				<cfset MININPUTVALUE = columnIndex.getMININPUTVALUE() >
				<cfset MAXINPUTVALUE = columnIndex.getMAXINPUTVALUE() >
				<cfset MINCHARLENGTH = columnIndex.getMINCHARLENGTH() >
				<cfset MAXCHARLENGTH = columnIndex.getMAXCHARLENGTH() >
				<cfset ISHIDDEN = columnIndex.getISHIDDEN() >
				<cfset INPUTID = "'#COLUMNID#'" >
				<cfset MARGIN = columnIndex.getMARGIN() >
				<cfset PADDING = columnIndex.getPADDING() >
				<cfset BORDER = columnIndex.getBORDER() >
				<cfset STYLE = columnIndex.getSTYLE() >
				<cfset ISREADONLY = columnIndex.getISREADONLY() >
				<cfset INPUTVALUE = columnIndex.getINPUTVALUE() >
				<cfset VALIDATIONTYPE = columnIndex.getVALIDATIONTYPE() >
				<cfset VTYPETEXT = columnIndex.getVTYPETEXT() >
				<cfset RENDERER = columnIndex.getRENDERER() >
				<cfset XPOSITION = columnIndex.getXPOSITION() >
				<cfset YPOSITION = columnIndex.getYPOSITION() >
				<cfset ANCHORPOSITION = columnIndex.getANCHORPOSITION() >
				<cfset INPUTFORMAT = columnIndex.getINPUTFORMAT() >
				
				<cfset NOOFCOLUMNS = columnIndex.getNOOFCOLUMNS() >
				<cfset CHECKITEMS = columnIndex.getCHECKITEMS() >
				<cfset UNCHECKEDVALUE = columnIndex.getUNCHECKEDVALUE() >
				
				<cfset COMBOLOCALDATA = columnIndex.getCOMBOLOCALDATA() >
				<cfset COMBOREMOTEDATA = columnIndex.getCOMBOREMOTEDATA() >
				
				
				<cfset EDITABLEONROUTENO = columnIndex.getEDITABLEONROUTENO() >
				<cfset AUTOGENTEXT = columnIndex.getAUTOGENTEXT() >
				<cfset RECCREATEDBY = columnIndex.getRECCREATEDBY() >
				<cfset RECDATECREATED = columnIndex.getRECDATECREATED() >
				<cfset DATELASTUPDATE = columnIndex.getDATELASTUPDATE() >
				
				
				
				
				
				
				<cfif trim(FIELDLABELALIGN) EQ "" >
					<cfset FIELDLABELALIGN = "100" >
				<cfelse>
					<cfset res = findnocase('%',FIELDLABELALIGN) >
					<cfif res EQ 0>
					<cfelse>
						<cfset FIELDLABELALIGN = "'FIELDLABELALIGN'" > 
					</cfif>
				</cfif> 
				
				<cfif trim(ANCHORPOSITION) EQ "" >
					<cfset ANCHORPOSITION = "" >
				<cfelse>
					<cfset ANCHORPOSITION = "anchor: '#ANCHORPOSITION#'," >
				</cfif> 
				
				<cfif trim(VTYPETEXT) EQ "" >
					<cfset VTYPETEXT = "" >
				<cfelse>
					<cfset VTYPETEXT = "vtypeText: '#VTYPETEXT#'," >
				</cfif>
				
				
				<cfif trim(MININPUTVALUE) EQ "" >
					<cfset MININPUTVALUE = "" >
				<cfelse>
					<cfset MININPUTVALUE = "minValue: #MININPUTVALUE#," >
				</cfif>
				
				<cfif trim(MAXINPUTVALUE) EQ "" >
					<cfset MAXINPUTVALUE = "" >
				<cfelse>
					<cfset MAXINPUTVALUE = "minValue: #MAXINPUTVALUE#," >
				</cfif>
				
				<cfif trim(HEIGHT) EQ "" >
					<cfset HEIGHT = "" >
				<cfelse>
					<cfset res = findnocase('%',HEIGHT) >
					<cfif res EQ 0>
						<cfset HEIGHT = "height: #HEIGHT#," >
					<cfelse>
						<cfset HEIGHT = "height: '#HEIGHT#'," > 
					</cfif>
				</cfif> 
				
				<cfif trim(WIDTH) EQ "" >
					<cfset WIDTH = "" >
				<cfelse>
					<cfset res = findnocase('%',WIDTH) >
					<cfif res EQ 0>
						<cfset WIDTH = "width: #WIDTH#," > 
					<cfelse>
						<cfset WIDTH = "width: '#WIDTH#'," > 
					</cfif>
				</cfif> 
				
				<cfif trim(FIELDLABELWIDTH) EQ "" >
					<cfset FIELDLABELWIDTH = "" >
				<cfelse>
					<cfset res = findnocase('%',FIELDLABELWIDTH) >
					<cfif res EQ 0>
						<cfset FIELDLABELWIDTH = "labelWidth: #FIELDLABELWIDTH#," > 
					<cfelse>
						<cfset FIELDLABELWIDTH = "labelWidth: '#FIELDLABELWIDTH#'," > 
					</cfif>
				</cfif> 
				
				<cfif trim(MARGIN) EQ "" >
					<cfset MARGIN = "'0 0 0 0'" >
				<cfelse>
					<cfset MARGIN = "'#MARGIN#'" >
				</cfif> 
				
				<cfif trim(PADDING) EQ "" >
					<cfset PADDING = "'5 5 5 5'" >
				<cfelse>
					<cfset PADDING = "'#PADDING#'" >
				</cfif> 
				
				<cfif trim(VALIDATIONTYPE) EQ "" >
					<cfset VALIDATIONTYPE = "" >
				<cfelseif VALIDATIONTYPE EQ "alpha" OR VALIDATIONTYPE EQ "alphanum" OR VALIDATIONTYPE EQ "email" OR VALIDATIONTYPE EQ "url" >
					<cfset VALIDATIONTYPE = "vtype: '#VALIDATIONTYPE#'," >
				<cfelse>
					<cfset res = find(":", VALIDATIONTYPE) >
					<cfif res GT 0 >
						<cfset title = left(VALIDATIONTYPE, res-1) >
						<cfset validationArr[cntVType] = "Ext.apply(Ext.form.field.VTypes, {
															#VALIDATIONTYPE# 
														  });" >
						<cfset cntVType = cntVType + 1 > 
						<cfset VALIDATIONTYPE = "vtype: '#title#'," >
					<cfelse>
						<cfset VALIDATIONTYPE = "vtype: '#VALIDATIONTYPE#'," > 
					</cfif>   
				</cfif>
				
				
				<cfif trim(COLUMNGROUP) EQ "" > 
					<cfset COLUMNGROUP = "nogroup" >
				</cfif>
				
				<cfset COLUMNGROUP = rereplace(COLUMNGROUP, "[^A-Za-z0-9_]", "_", "all") >
				
				<cftry>
					<cfset isArray = evaluate("items#COLUMNGROUP#") >
					<cfif isarray(isArray) >
						
					<cfelse>
						<cfset "items#COLUMNGROUP#"  = arraynew(1) >	
					</cfif>
				<cfcatch>
					<cfset "items#COLUMNGROUP#"  = arraynew(1) >
				</cfcatch>
				</cftry>
				
				
				<cftry>
					<cfset isVar = evaluate("Y__#COLUMNGROUP#") >
					<cfif XTYPE EQ "htmleditor" >
						<cfset origPos = isVar - 250>
					<cfelseif XTYPE EQ "checkboxgroup" OR XTYPE EQ "radiogroup">
						<cfset listlen = ListLen(CHECKITEMS,";") >
						<cfset totcol = NOOFCOLUMNS >
						<cfset divfactor = numberformat(listlen/totcol, "____") >
						<cfset origPos = isVar - 65 - 22*divfactor >
					<cfelse>
						<cfset origPos = isVar - 80>
					</cfif>
					<cfif origPos GT YPOSITION >
					<cfelse>
						<cfif XTYPE EQ "htmleditor" >
							<cfset "Y__#COLUMNGROUP#" = YPOSITION + 250>
						<cfelseif XTYPE EQ "checkboxgroup" OR XTYPE EQ "radiogroup">
							<cfset listlen = ListLen(CHECKITEMS,";") >
							<cfset totcol = NOOFCOLUMNS >
							<cfset divfactor = numberformat(listlen/totcol, "____") >
							<cfset "Y__#COLUMNGROUP#" = YPOSITION + 65 + 22*divfactor >
						<cfelse>
							<cfset "Y__#COLUMNGROUP#" = YPOSITION + 80>
						</cfif>
						
						
					</cfif>
				<cfcatch>
					<cfif XTYPE EQ "htmleditor" >
						<cfset "Y__#COLUMNGROUP#" = YPOSITION + 250>
					<cfelseif XTYPE EQ "checkboxgroup" OR XTYPE EQ "radiogroup">
						<cfset listlen = ListLen(CHECKITEMS,";") >
						<cfset totcol = NOOFCOLUMNS >
						<cfset divfactor = numberformat(listlen/totcol, "____") >
						<cfset "Y__#COLUMNGROUP#" = YPOSITION + 65 + 22*divfactor>
					<cfelse>
						<cfset "Y__#COLUMNGROUP#" = YPOSITION + 80>
					</cfif>
				</cfcatch>
				</cftry>
				
				
				<cfif trim(XPOSITION) EQ "" >
					<cfset XPOSITION = "" >
				<cfelse>
					<cfset XPOSITION = "x: #XPOSITION#," >
				</cfif> 
				
				<cfif trim(YPOSITION) EQ "" >
					<cfset YPOSITION = "" >
				<cfelse>
					<cfset YPOSITION = "y: #YPOSITION#," > 
				</cfif> 
				
				<cfif XTYPE EQ "textfield" > <!---textfield Default--->
					
					<cfset groupItems ="{
											fieldLabel: '#FIELDLABEL#',
								            name: '#LEVELID#__#TABLENAME#__#COLUMNNAME#',
								            #XPOSITION#
								            #YPOSITION#
								            #ANCHORPOSITION#
								            hidden: #ISHIDDEN#,
								            labelAlign: '#FIELDLABELALIGN#',
								            #FIELDLABELWIDTH#
								            allowBlank: #ALLOWBLANK#,
								            css: '#CSSCLASS#',
								            disabled: #ISDISABLED#,
								            #HEIGHT#
								            #WIDTH#
								            minLength: #MINCHARLENGTH#,
								            maxLength: #MAXCHARLENGTH#,
								            id: #INPUTID#,
								            margin: #MARGIN#,
								            padding: #PADDING#,
								            border: '#BORDER#',
								            style: '#STYLE#',
								            readOnly: #ISREADONLY#,
								            value: '#INPUTVALUE#',
								            #VALIDATIONTYPE#
								            #VTYPETEXT#
								            fieldStyle: '#INPUTFORMAT#'
								            
								        }" >
					
					<cfset arrayappend(evaluate("items#COLUMNGROUP#"), groupItems) >
					<cfset "groupStruct.__#COLUMNGROUP#" =  evaluate("items#COLUMNGROUP#") >  
					
				<cfelseif XTYPE EQ "datefield"> <!---datefield--->
					
					<cfset groupItems ="{
											xtype: 'datefield',
											fieldLabel: '#FIELDLABEL#',
								            name: '#LEVELID#__#TABLENAME#__#COLUMNNAME#',
								            #XPOSITION#
								            #YPOSITION#
								            #ANCHORPOSITION#
								            hidden: #ISHIDDEN#,
								            labelAlign: '#FIELDLABELALIGN#',
								            #FIELDLABELWIDTH#
								            allowBlank: #ALLOWBLANK#,
								            css: '#CSSCLASS#',
								            disabled: #ISDISABLED#,
								            #HEIGHT#
								            #WIDTH#
								            minLength: #MINCHARLENGTH#,
								            maxLength: #MAXCHARLENGTH#,
								            id: #INPUTID#,
								            margin: #MARGIN#,
								            padding: #PADDING#,
								            border: '#BORDER#',
								            style: '#STYLE#',
								            readOnly: #ISREADONLY#,
								            value: '#INPUTVALUE#',
								            #VALIDATIONTYPE#
								            #VTYPETEXT#
								            format: '#INPUTFORMAT#',
								            #MAXINPUTVALUE#
								            #MAXINPUTVALUE#
								            
								        }" >
					
					<cfset arrayappend(evaluate("items#COLUMNGROUP#"), groupItems) >
					<cfset "groupStruct.__#COLUMNGROUP#" =  evaluate("items#COLUMNGROUP#") >
				
				<cfelseif XTYPE EQ "timefield"> <!---timefield--->
					
					<cfset groupItems ="{
											xtype: 'timefield',
											fieldLabel: '#FIELDLABEL#',
								            name: '#LEVELID#__#TABLENAME#__#COLUMNNAME#',
								            #XPOSITION#
								            #YPOSITION#
								            #ANCHORPOSITION#
								            hidden: #ISHIDDEN#,
								            labelAlign: '#FIELDLABELALIGN#',
								            #FIELDLABELWIDTH#
								            allowBlank: #ALLOWBLANK#,
								            css: '#CSSCLASS#',
								            disabled: #ISDISABLED#,
								            #HEIGHT#
								            #WIDTH#
								            minLength: #MINCHARLENGTH#,
								            maxLength: #MAXCHARLENGTH#,
								            id: #INPUTID#,
								            margin: #MARGIN#,
								            padding: #PADDING#,
								            border: '#BORDER#',
								            style: '#STYLE#',
								            readOnly: #ISREADONLY#,
								            value: '#INPUTVALUE#',
								            #VALIDATIONTYPE#
								            #VTYPETEXT#
								            format: '#INPUTFORMAT#',
								            #MAXINPUTVALUE#
								            #MAXINPUTVALUE#
								            
								        }" >
					
					<cfset arrayappend(evaluate("items#COLUMNGROUP#"), groupItems) >
					<cfset "groupStruct.__#COLUMNGROUP#" =  evaluate("items#COLUMNGROUP#") >
				
				<cfelseif XTYPE EQ "numberfield"> <!---numberfield--->
					
					<cfset groupItems ="{
											xtype: 'numberfield',
											fieldLabel: '#FIELDLABEL#',
								            name: '#LEVELID#__#TABLENAME#__#COLUMNNAME#',
								            #XPOSITION#
								            #YPOSITION#
								            #ANCHORPOSITION#
								            hidden: #ISHIDDEN#,
								            labelAlign: '#FIELDLABELALIGN#',
								            #FIELDLABELWIDTH#
								            allowBlank: #ALLOWBLANK#,
								            css: '#CSSCLASS#',
								            disabled: #ISDISABLED#,
								            #HEIGHT#
								            #WIDTH#
								            id: #INPUTID#,
								            margin: #MARGIN#,
								            padding: #PADDING#,
								            border: '#BORDER#',
								            style: '#STYLE#',
								            readOnly: #ISREADONLY#,
								            value: '#INPUTVALUE#',
								            #VALIDATIONTYPE#
								            #VTYPETEXT#
								            format: '#INPUTFORMAT#',
								            #MAXINPUTVALUE#
								            #MAXINPUTVALUE#
								            
								        }" >
					
					<cfset arrayappend(evaluate("items#COLUMNGROUP#"), groupItems) >
					<cfset "groupStruct.__#COLUMNGROUP#" =  evaluate("items#COLUMNGROUP#") >
				
				<cfelseif XTYPE EQ "textareafield"> <!---textareafield--->
					
					<cfset groupItems ="{
											xtype: 'textareafield',
											fieldLabel: '#FIELDLABEL#',
								            name: '#LEVELID#__#TABLENAME#__#COLUMNNAME#',
								            #XPOSITION#
								            #YPOSITION#
								            #ANCHORPOSITION#
								            hidden: #ISHIDDEN#,
								            labelAlign: '#FIELDLABELALIGN#',
								            #FIELDLABELWIDTH#
								            allowBlank: #ALLOWBLANK#,
								            css: '#CSSCLASS#',
								            disabled: #ISDISABLED#,
								            #HEIGHT#
								            #WIDTH#
								            minLength: #MINCHARLENGTH#,
								            maxLength: #MAXCHARLENGTH#,
								            id: #INPUTID#,
								            margin: #MARGIN#,
								            padding: #PADDING#,
								            border: '#BORDER#',
								            style: '#STYLE#',
								            readOnly: #ISREADONLY#,
								            value: '#INPUTVALUE#',
								            #VALIDATIONTYPE#
								            #VTYPETEXT#
								            fieldStyle: '#INPUTFORMAT#'
								            
								        }" >
					
					<cfset arrayappend(evaluate("items#COLUMNGROUP#"), groupItems) >
					<cfset "groupStruct.__#COLUMNGROUP#" =  evaluate("items#COLUMNGROUP#") >  
					
				<cfelseif XTYPE EQ "htmleditor"> <!---htmleditor--->
					
					<cfset groupItems ="{
											xtype: 'htmleditor',
											fieldLabel: '#FIELDLABEL#',
								            name: '#LEVELID#__#TABLENAME#__#COLUMNNAME#',
								            #XPOSITION#
								            #YPOSITION#
								            #ANCHORPOSITION#
								            hidden: #ISHIDDEN#,
								            labelAlign: '#FIELDLABELALIGN#',
								            #FIELDLABELWIDTH#
								            allowBlank: #ALLOWBLANK#,
								            css: '#CSSCLASS#',
								            disabled: #ISDISABLED#,
								            #HEIGHT#
								            #WIDTH#
								            minLength: #MINCHARLENGTH#,
								            maxLength: #MAXCHARLENGTH#,
								            id: #INPUTID#,
								            margin: #MARGIN#,
								            padding: #PADDING#,
								            border: '#BORDER#',
								            style: '#STYLE#',
								            readOnly: #ISREADONLY#,
								            value: '#INPUTVALUE#',
								            #VALIDATIONTYPE#
								            #VTYPETEXT#
								            labelStyle: '#INPUTFORMAT#'
								            
								        }" >
					
					<cfset arrayappend(evaluate("items#COLUMNGROUP#"), groupItems) >
					<cfset "groupStruct.__#COLUMNGROUP#" =  evaluate("items#COLUMNGROUP#") >
					
				<cfelseif XTYPE EQ "displayfield"> <!---displayfield--->
					
					<cfset groupItems ="{
											xtype: 'displayfield',
											fieldLabel: '#FIELDLABEL#',
								            name: '#LEVELID#__#TABLENAME#__#COLUMNNAME#',
								            #XPOSITION#
								            #YPOSITION#
								            #ANCHORPOSITION#
								            hidden: #ISHIDDEN#,
								            labelAlign: '#FIELDLABELALIGN#',
								            #FIELDLABELWIDTH#
								            allowBlank: #ALLOWBLANK#,
								            css: '#CSSCLASS#',
								            disabled: #ISDISABLED#,
								            #HEIGHT#
								            #WIDTH#
								            id: #INPUTID#,
								            margin: #MARGIN#,
								            padding: #PADDING#,
								            border: '#BORDER#',
								            style: '#STYLE#',
								            readOnly: #ISREADONLY#,
								            value: '#INPUTVALUE#',
								            renderer: '#RENDERER#',
								            fieldStyle: '#INPUTFORMAT#'
								            
								        }" >
								        
					<cfset arrayappend(evaluate("items#COLUMNGROUP#"), groupItems) >
					<cfset "groupStruct.__#COLUMNGROUP#" =  evaluate("items#COLUMNGROUP#") >
					
				<cfelseif XTYPE EQ "filefield"> <!---filefield--->
					<cfset withfileField = "true" >
					<cfset fileCount = fileCount + 1 >
					
					<cfset groupItems ="{
											xtype: 'filefield',
											fieldLabel: '#FIELDLABEL#',
								            name: 'file#fileCount#',
								            #XPOSITION#
								            #YPOSITION#
								            #ANCHORPOSITION#
								            hidden: #ISHIDDEN#,
								            labelAlign: '#FIELDLABELALIGN#',
								            #FIELDLABELWIDTH#
								            allowBlank: #ALLOWBLANK#,
								            css: '#CSSCLASS#',
								            disabled: #ISDISABLED#,
								            #HEIGHT#
								            #WIDTH#
								            minLength: #MINCHARLENGTH#,
								            maxLength: #MAXCHARLENGTH#,
								            id: #INPUTID#,
								            margin: #MARGIN#,
								            padding: #PADDING#,
								            border: '#BORDER#',
								            style: '#STYLE#',
								            readOnly: #ISREADONLY#,
								            value: '#INPUTVALUE#',
								            #VALIDATIONTYPE#
								            #VTYPETEXT#
								            fieldStyle: '#INPUTFORMAT#'
								            
								        },{
								        	xtype: 'hiddenfield', 
								        	name: '#LEVELID#__#TABLENAME#__#COLUMNNAME#',
								        	value: 'forfileonlyaaazzz#TABLENAME#__#fileCount#'
								        }" >
								        
					<cfset arrayappend(evaluate("items#COLUMNGROUP#"), groupItems) >
					<cfset "groupStruct.__#COLUMNGROUP#" =  evaluate("items#COLUMNGROUP#") >
					
				<cfelseif XTYPE EQ "hiddenfield"> <!---hiddenfield--->
					
					<cfset groupItems ="{
											xtype: 'hiddenfield',
											fieldLabel: '#FIELDLABEL#',
								            name: '#LEVELID#__#TABLENAME#__#COLUMNNAME#',
								            #XPOSITION#
								            #YPOSITION#
								            #ANCHORPOSITION#
								            hidden: #ISHIDDEN#,
								            labelAlign: '#FIELDLABELALIGN#',
								            #FIELDLABELWIDTH#
								            allowBlank: #ALLOWBLANK#,
								            css: '#CSSCLASS#',
								            disabled: #ISDISABLED#,
								            #HEIGHT#
								            #WIDTH#
								            id: #INPUTID#,
								            margin: #MARGIN#,
								            padding: #PADDING#,
								            border: '#BORDER#',
								            style: '#STYLE#',
								            readOnly: #ISREADONLY#,
								            value: '#INPUTVALUE#',
								            fieldStyle: '#INPUTFORMAT#'
								            
								        }" >
								        
					 <cfset arrayappend(evaluate("items#COLUMNGROUP#"), groupItems) >
					 <cfset "groupStruct.__#COLUMNGROUP#" =  evaluate("items#COLUMNGROUP#") >
					
				<cfelseif XTYPE EQ "id"> <!---id textfield--->
				
					<cfset groupItems ="{
											fieldLabel: '#FIELDLABEL#',
								            name: '#LEVELID#__#TABLENAME#__#COLUMNNAME#',
								            #XPOSITION#
								            #YPOSITION#
								            #ANCHORPOSITION#
								            hidden: #ISHIDDEN#,
								            labelAlign: '#FIELDLABELALIGN#',
								            #FIELDLABELWIDTH#
								            allowBlank: #ALLOWBLANK#,
								            css: '#CSSCLASS#',
								            disabled: #ISDISABLED#,
								            #HEIGHT#
								            #WIDTH#
								            minLength: #MINCHARLENGTH#,
								            maxLength: #MAXCHARLENGTH#,
								            id: #INPUTID#,
								            margin: #MARGIN#,
								            padding: #PADDING#,
								            border: '#BORDER#',
								            style: '#STYLE#',
								            readOnly: #ISREADONLY#,
								            value: '#INPUTVALUE#',
								            #VALIDATIONTYPE#
								            #VTYPETEXT#
								            fieldStyle: '#INPUTFORMAT#'
								            
								        }" >
					
					<cfset arrayappend(evaluate("items#COLUMNGROUP#"), groupItems) >
					<cfset "groupStruct.__#COLUMNGROUP#" =  evaluate("items#COLUMNGROUP#") >  
				
				<cfelseif XTYPE EQ "checkboxgroup"> <!---checkboxgroup--->
					
					<cfset checkArr = ArrayNew(1) > 
					<cfif ListLen(CHECKITEMS, ";") GT 0 >
						<cfloop list="#CHECKITEMS#" index="checklist" delimiters=";" >
							<cfif ListLen(checklist, ",") EQ 2 > 
							<cfset arrayappend(checkArr, "{
															boxLabel: '#listgetat(checklist,1)#',
															name: '#LEVELID#__#TABLENAME#__#COLUMNNAME#',
															inputValue: '#listgetat(checklist,2)#',
															uncheckedvalue: '#UNCHECKEDVALUE#' 
							                              }") >
							<cfelse>
								
							</cfif>
						</cfloop> <!---end CHECKITEMS--->
					<cfelse>
					</cfif> <!---end ListLen--->
					
					<cfset checkItems  = ArrayToList(checkArr) >
					
					
					<cfset groupItems ="{
											xtype: 'checkboxgroup',
											vertical: true,
											fieldLabel: '#FIELDLABEL#',
								            #XPOSITION#
								            #YPOSITION#
								            #ANCHORPOSITION#
								            hidden: #ISHIDDEN#,
								            labelAlign: '#FIELDLABELALIGN#',
								            #FIELDLABELWIDTH#
								            allowBlank: #ALLOWBLANK#,
								            css: '#CSSCLASS#',
								            disabled: #ISDISABLED#,
								            #HEIGHT#
								            #WIDTH#
								            id: #INPUTID#,
								            margin: #MARGIN#,
								            padding: #PADDING#,
								            border: '#BORDER#',
								            style: '#STYLE#',
								            readOnly: #ISREADONLY#,
								            columns: #NOOFCOLUMNS#,
								            items: [
								            	#checkItems#
								            ]
								        }" >
					
					<cfset arrayappend(evaluate("items#COLUMNGROUP#"), groupItems) >
					<cfset "groupStruct.__#COLUMNGROUP#" =  evaluate("items#COLUMNGROUP#") >  
					
					<cfset arrayclear(checkArr) > 
					
				<cfelseif XTYPE EQ "radiogroup">  <!---radio group--->
					
					<cfset checkArr = ArrayNew(1) > 
					<cfif ListLen(CHECKITEMS, ";") GT 0 >
						<cfloop list="#CHECKITEMS#" index="checklist" delimiters=";" >
							<cfif ListLen(checklist, ",") EQ 2 > 
							<cfset arrayappend(checkArr, "{
															boxLabel: '#listgetat(checklist,1)#',
															name: '#LEVELID#__#TABLENAME#__#COLUMNNAME#',
															inputValue: '#listgetat(checklist,2)#',
															uncheckedvalue: '#UNCHECKEDVALUE#' 
							                              }") >
							<cfelse>
								
							</cfif>
						</cfloop> <!---end CHECKITEMS--->
					<cfelse>
					</cfif> <!---end ListLen--->
					
					<cfset checkItems  = ArrayToList(checkArr) >
					
					
					<cfset groupItems ="{
											xtype: 'radiogroup',
											vertical: true,
											fieldLabel: '#FIELDLABEL#',
								            #XPOSITION#
								            #YPOSITION#
								            #ANCHORPOSITION#
								            hidden: #ISHIDDEN#,
								            labelAlign: '#FIELDLABELALIGN#',
								            #FIELDLABELWIDTH#
								            allowBlank: #ALLOWBLANK#,
								            css: '#CSSCLASS#',
								            disabled: #ISDISABLED#,
								            #HEIGHT#
								            #WIDTH#
								            id: #INPUTID#,
								            margin: #MARGIN#,
								            padding: #PADDING#,
								            border: '#BORDER#',
								            style: '#STYLE#',
								            readOnly: #ISREADONLY#,
								            columns: #NOOFCOLUMNS#,
								            items: [
								            	#checkItems#
								            ]
								        }" >
					
					<cfset arrayappend(evaluate("items#COLUMNGROUP#"), groupItems) >
					<cfset "groupStruct.__#COLUMNGROUP#" =  evaluate("items#COLUMNGROUP#") >  
					
					<cfset arrayclear(checkArr) >
				
				<cfelseif XTYPE EQ "combobox"> <!---combobox--->
					
					<cfset querymode = 'local' >
					<cfif trim(COMBOLOCALDATA) NEQ "">
						 
						<cfset comboArr = ArrayNew(1) > 
						<cfif ListLen(COMBOLOCALDATA, ";") GT 0 >
							<cfloop list="#COMBOLOCALDATA#" index="combolist" delimiters=";" >
								<cfif ListLen(combolist, ",") EQ 2 > 
								<cfset arrayappend(comboArr, "{
																displayname: '#listgetat(combolist,1)#',
																codename: '#listgetat(combolist,2)#'
								                              }") >
								<cfelse>
									
								</cfif>
							</cfloop> <!---end CHECKITEMS--->
						<cfelse>
						</cfif> <!---end ListLen--->
					
					    <cfset comboLocaldataItems  = ArrayToList(comboArr) >
						<cfset columnModelStore[cntStore] = " 
							var #TABLENAME##COLUMNNAME# = Ext.create('Ext.data.Store', {
							    fields: ['displayname', 'codename'],
							    data : [
							    #comboLocaldataItems#
							    ]
							});" >
						
						<cfset arrayclear(comboArr) >
							
							
					<cfelseif trim(COMBOREMOTEDATA) NEQ "">
						
						<cfset theTable 				= "" >
						<cfset theDisplayColumns 		= "" >
						<cfset theValueColumn 			= "" >
						<cfset theColumnItDepends 		= "" >
						<cfset theColumnItDependsValue 	= "" >
						
						
						<cfif ListLen(COMBOREMOTEDATA, ";") GT 0 >
							<cfset theTable 				= ListGetAt(COMBOREMOTEDATA, 1, ";") >
							<cfset theDisplayColumns 		= ListGetAt(COMBOREMOTEDATA, 2, ";") >
							<cfset theValueColumn 			= ListGetAt(COMBOREMOTEDATA, 3, ";") >
							<cftry>
								<cfset theColumnItDepends 		= ListGetAt(COMBOREMOTEDATA, 4, ";") >
							<cfcatch>
								<cfset theColumnItDepends 		= " " >
							</cfcatch>
							</cftry>
							<cfset theColumnItDependsValue 	= " " > 
							
						<cfelse>
						</cfif> <!---end ListLen--->
						
						<cfset columnModelStore[cntStore] = "
							var #TABLENAME##COLUMNNAME# = Ext.create('Ext.data.Store', {
								fields: ['displayname', 'codename'],
								autoLoad: false,
								listeners: {
									beforeload: function(thiss,operation,eopts) {
											var theValue = new Array();
											var dependCol = '#theColumnItDepends#';
											if(dependCol != ' ') {
											dependCol = dependCol.split(',');
											for(thecntr=0;thecntr<dependCol.length;thecntr++) {
												var specCol = dependCol[thecntr]; 
												var resultQuery = eForm.query('field[name$=' + specCol + ']'); 
												if(resultQuery[0].inputValue) {
													var resultQueryB = eForm.query('field[name$=' + specCol + '][checked=true]'); 
													
													theValue.push(resultQueryB[0].inputValue);
												} else {
													theValue.push(resultQuery[0].value);
												} 
											}
											thiss.proxy.extraParams.columnDependValues = theValue.toString(); 
											} else {
												return true;
											}
											
									}
								},
								proxy: {
											type: 'direct',
											extraParams: {
												tablename: '#theTable#',
												columnDisplay: '#theDisplayColumns#',
												columnValue: '#theValueColumn#',
												columnDepends: '#theColumnItDepends#',
												columnDependValues: ' '
											},
											directFn: 'Ext.ss.lookup.formQueryLookup',
											paramOrder: ['limit', 'page', 'query', 'start', 'tablename', 'columnDisplay', 'columnValue','columnDepends','columnDependValues'],
											reader: {
												root: 'topics',
												totalProperty: 'totalCount'
											}
										}
									
							});" >
						<cfset querymode = 'remote' >
					<cfelse>
						<cfset columnModelStore[cntStore] = " 
							var #TABLENAME##COLUMNNAME# = Ext.create('Ext.data.Store', {
							    fields: ['displayname', 'codename'],
							    data : [
							    	{
							    		displayname: ' ',
							    		codename: ' '
							    	}
							    ]
							});" >
					</cfif>
					
					
					
					
					<cfset cntStore = cntStore + 1 >
					<cfset groupItems ="{
											xtype: 'combobox',
											displayField: 'displayname',
											valueField: 'codename', 
											queryMode: '#querymode#',
											store: #TABLENAME##COLUMNNAME#,
											minChars: 1,
											pageSize: 30,
											fieldLabel: '#FIELDLABEL#',
								            name: '#LEVELID#__#TABLENAME#__#COLUMNNAME#',
								            #XPOSITION#
								            #YPOSITION#
								            #ANCHORPOSITION#
								            hidden: #ISHIDDEN#,
								            labelAlign: '#FIELDLABELALIGN#',
								            #FIELDLABELWIDTH#
								            allowBlank: #ALLOWBLANK#,
								            css: '#CSSCLASS#',
								            disabled: #ISDISABLED#,
								            #HEIGHT#
								            #WIDTH#
								            minLength: #MINCHARLENGTH#,
								            maxLength: #MAXCHARLENGTH#,
								            id: #INPUTID#,
								            margin: #MARGIN#,
								            padding: #PADDING#,
								            border: '#BORDER#',
								            style: '#STYLE#',
								            readOnly: #ISREADONLY#,
								            value: '#INPUTVALUE#',
								            #VALIDATIONTYPE#
								            #VTYPETEXT#
								            fieldStyle: '#INPUTFORMAT#'
								            
								        }" >
					
					<cfset arrayappend(evaluate("items#COLUMNGROUP#"), groupItems) >
					<cfset "groupStruct.__#COLUMNGROUP#" =  evaluate("items#COLUMNGROUP#") >  
				
				<cfelse>   
				
				</cfif>
				
			<cfset cntA = cntA + 1 >	
			</cfloop> <!---end tableColumnData--->
		
		</cfloop> <!---end formTableData--->
		
		<cfset fields = ArrayToList(columnnameArr, ",") >
		<cfset columns = ArrayToList(columnItemArr, ",") >
		<cfset vtypes = ArrayToList(validationArr, " ") > <!---The Stores--->
		<cfset stores = ArrayToList(columnModelStore, " ") > <!---The VTypes--->
		
		<cfset tableGroupData =  ORMExecuteQuery("SELECT COLUMNGROUP, count(*) as test 
													FROM EGRGIBOSETABLEFIELDS
												   WHERE TABLEIDFK IN (SELECT TABLEID 
												   						 FROM EGRGIBOSETABLE
												   				        WHERE EFORMIDFK = '#eformid#') 
												GROUP BY COLUMNGROUP
												ORDER BY COLUMNORDER ASC") >
		
		<!---<cfset theGroupListArr = StructKeyArray(groupStruct) >--->
		
		<cfset theFieldSet = ArrayNew(1) >
		<cfset theItemArr = ArrayNew(1) >
		<cfset fcnt = 1 >
		
		<cfset fileParams = "{
				        		xtype: 'hiddenfield',
				        		name: 'withFile',
				        		value: '#withfileField#' 
				        	},
				        	{
				        		xtype: 'hiddenfield',
				        		name: 'fileCount',
				        		value: '#fileCount#'
				        	}">
		
	<cfif formviewas EQ "VBOXABS">
		<cfloop array="#tableGroupData#" index="theGroup" >
			
			<cfif trim(theGroup[1]) EQ "" >
				<cfset colGroup = "nogroup" >
			<cfelse>
				<cfset colGroup = rereplace(theGroup[1], "[^A-Za-z0-9_]", "_", "all") >
			</cfif>
			
			<cfset titleGroup = replace(colGroup,"nogroup"," ","all") >
			<cfset titleGroup = replace(titleGroup,"_"," ","all") >
			
			<cfset theItemArr = groupStruct['__#colGroup#'] >
			<cfset theItemList = ArrayToList(theItemArr, ",") >
			
			<cfset height = evaluate("Y__#colGroup#") >
			
			<cfset theFieldSet[fcnt] = "{
					xtype:'fieldset',  
		        	collapsible: true,
		        	margin: '#formgroupmargin#',
		        	height: #height#, 
		        	title: '#titleGroup#',
			        defaultType: 'textfield',
			        defaults: {anchor: '100%'},
			        layout: 'absolute',
			        
			        items :[
			        	#theItemList#, 
			        	#fileParams#
			        ]
			        }" >
			 <cfset fcnt = fcnt + 1 >
		</cfloop>
		
	<cfset groupFieldsAll = ArrayToList(theFieldSet, ",") >	
	
		<cfset formScript = "
							#stores#
							#vtypes#
							var eForm = Ext.create('Ext.form.Panel',{
								padding: '#formpadding#', 
							   	items: [
							    	#groupFieldsAll# 
								]," >
							
							
	<cfelseif formviewas EQ "VBOXABSPANEL" >
		<cfloop array="#tableGroupData#" index="theGroup" >
			
			<cfif trim(theGroup[1]) EQ "" >
				<cfset colGroup = "nogroup" >
			<cfelse>
				<cfset colGroup = rereplace(theGroup[1], "[^A-Za-z0-9_]", "_", "all") >
			</cfif>
			
			<cfset titleGroup = replace(colGroup,"nogroup"," ","all") >
			<cfset titleGroup = replace(titleGroup,"_"," ","all") >
			
			<cfset theItemArr = groupStruct['__#colGroup#'] >
			<cfset theItemList = ArrayToList(theItemArr, ",") >
			
			<cfset height = evaluate("Y__#colGroup#") >
			
			<cfset theFieldSet[fcnt] = "{
					xtype:'panel',  
		        	collapsible: true,
		        	margin: '#formgroupmargin#',
		        	height: #height#, 
		        	title: '#titleGroup#',
			        defaultType: 'textfield',
			        defaults: {anchor: '100%'},
			        layout: 'absolute',
			        
			        items :[
			        	#theItemList#, 
			        	#fileParams#
			        ]
			        }" >
			 <cfset fcnt = fcnt + 1 >
		</cfloop>
		
	<cfset groupFieldsAll = ArrayToList(theFieldSet, ",") >	
	
		<cfset formScript = "
							#stores#
							#vtypes#
							var eForm = Ext.create('Ext.form.Panel',{
								padding: '#formpadding#', 
							   	items: [
							    	#groupFieldsAll# 
								]," >
							
	
	<cfelseif formviewas EQ "HBOXABS" >
		<cfloop array="#tableGroupData#" index="theGroup" >
			
			<cfif trim(theGroup[1]) EQ "" >
				<cfset colGroup = "nogroup" >
			<cfelse>
				<cfset colGroup = rereplace(theGroup[1], "[^A-Za-z0-9_]", "_", "all") >
			</cfif>
			
			<cfset titleGroup = replace(colGroup,"nogroup"," ","all") >
			<cfset titleGroup = replace(titleGroup,"_"," ","all") >
			
			<cfset theItemArr = groupStruct['__#colGroup#'] >
			<cfset theItemList = ArrayToList(theItemArr, ",") >
			
			<cfset height = evaluate("Y__#colGroup#") >
			
			<cfset theFieldSet[fcnt] = "{
					xtype:'fieldset',  
		        	collapsible: true,
		        	margin: '#formgroupmargin#',
		        	height: #height#, 
		        	title: '#titleGroup#',
			        defaultType: 'textfield',
			        defaults: {anchor: '100%'},
			        columnWidth: #1/ArrayLen(tableGroupData)#,
			        layout: 'absolute',
			        
			        items :[
			        	#theItemList#, 
			        	#fileParams#
			        ]
			        }" >
			 <cfset fcnt = fcnt + 1 >
		</cfloop>
		
	<cfset groupFieldsAll = ArrayToList(theFieldSet, ",") >	
		<cfset formScript = "
							#stores#
							#vtypes#
							var eForm = Ext.create('Ext.form.Panel',{
								padding: '#formpadding#', 
							   	items: [
							    	#groupFieldsAll# 
								]," >
							
	<cfelseif formviewas EQ "HBOXABSPANEL" >
		<cfloop array="#tableGroupData#" index="theGroup" >
			
			<cfif trim(theGroup[1]) EQ "" >
				<cfset colGroup = "nogroup" >
			<cfelse>
				<cfset colGroup = rereplace(theGroup[1], "[^A-Za-z0-9_]", "_", "all") >
			</cfif>
			
			<cfset titleGroup = replace(colGroup,"nogroup"," ","all") >
			<cfset titleGroup = replace(titleGroup,"_"," ","all") >
			
			<cfset theItemArr = groupStruct['__#colGroup#'] >
			<cfset theItemList = ArrayToList(theItemArr, ",") >
			
			<cfset height = evaluate("Y__#colGroup#") >
			
			<cfset theFieldSet[fcnt] = "{
					xtype:'panel',  
		        	collapsible: true,
		        	margin: '#formgroupmargin#',
		        	height: #height#, 
		        	title: '#titleGroup#',
			        defaultType: 'textfield',
			        defaults: {anchor: '100%'},
			        columnWidth: #1/ArrayLen(tableGroupData)#,
			        layout: 'absolute',
			        
			        items :[
			        	#theItemList#, 
			        	#fileParams#
			        ]
			        }" >
			 <cfset fcnt = fcnt + 1 >
		</cfloop>
		
	<cfset groupFieldsAll = ArrayToList(theFieldSet, ",") >	
		<cfset formScript = "
							#stores#
							#vtypes#
							var eForm = Ext.create('Ext.form.Panel',{
								padding: '#formpadding#', 
							   	items: [
							    	#groupFieldsAll# 
								]," >
	
													
	<cfelseif formviewas EQ "VBOX">
		<cfloop array="#tableGroupData#" index="theGroup" >
			
			<cfif trim(theGroup[1]) EQ "" >
				<cfset colGroup = "nogroup" >
			<cfelse>
				<cfset colGroup = rereplace(theGroup[1], "[^A-Za-z0-9_]", "_", "all") >
			</cfif>
			
			<cfset titleGroup = replace(colGroup,"nogroup"," ","all") >
			<cfset titleGroup = replace(titleGroup,"_"," ","all") >
			
			<cfset theItemArr = groupStruct['__#colGroup#'] >
			<cfset theItemList = ArrayToList(theItemArr, ",") >
			
			<cfset height = evaluate("Y__#colGroup#") >
			
			<cfset theFieldSet[fcnt] = "{
					xtype:'fieldset',  
		        	collapsible: true,
		        	margin: '#formgroupmargin#',
		        	title: '#titleGroup#',
			        defaultType: 'textfield',
			        defaults: {anchor: '100%'},
			        layout: 'anchor',
			        width: '100%',
			        items :[
			        	#theItemList#, 
			        	#fileParams#
			        ]
			        }" >
			 <cfset fcnt = fcnt + 1 >
		</cfloop>
		
	<cfset groupFieldsAll = ArrayToList(theFieldSet, ",") >	
	
		<cfset formScript = "
							#stores#
							#vtypes#
							var eForm = Ext.create('Ext.form.Panel',{
								padding: '#formpadding#', 
							   	items: [
							    	#groupFieldsAll# 
								]," >
							
	<cfelseif formviewas EQ "VBOXPANEL">
		<cfloop array="#tableGroupData#" index="theGroup" >
			
			<cfif trim(theGroup[1]) EQ "" >
				<cfset colGroup = "nogroup" >
			<cfelse>
				<cfset colGroup = rereplace(theGroup[1], "[^A-Za-z0-9_]", "_", "all") >
			</cfif>
			
			<cfset titleGroup = replace(colGroup,"nogroup"," ","all") >
			<cfset titleGroup = replace(titleGroup,"_"," ","all") >
			
			<cfset theItemArr = groupStruct['__#colGroup#'] >
			<cfset theItemList = ArrayToList(theItemArr, ",") >
			
			<cfset height = evaluate("Y__#colGroup#") >
			
			<cfset theFieldSet[fcnt] = "{
					xtype:'panel',  
		        	collapsible: true,
		        	margin: '#formgroupmargin#',
		        	title: '#titleGroup#',
			        defaultType: 'textfield',
			        defaults: {anchor: '100%'},
			        layout: 'anchor',
			        width: '100%',
			        items :[
			        	#theItemList#, 
			        	#fileParams#
			        ]
			        }" >
			 <cfset fcnt = fcnt + 1 >
		</cfloop>
		
	<cfset groupFieldsAll = ArrayToList(theFieldSet, ",") >	
	
		<cfset formScript = "
							#stores#
							#vtypes#
							var eForm = Ext.create('Ext.form.Panel',{
								padding: '#formpadding#', 
							   	items: [
							    	#groupFieldsAll# 
								]," >						
	
	<cfelseif formviewas EQ "HBOX">
		<cfloop array="#tableGroupData#" index="theGroup" >
			
			<cfif trim(theGroup[1]) EQ "" >
				<cfset colGroup = "nogroup" >
			<cfelse>
				<cfset colGroup = rereplace(theGroup[1], "[^A-Za-z0-9_]", "_", "all") >
			</cfif>
			
			<cfset titleGroup = replace(colGroup,"nogroup"," ","all") >
			<cfset titleGroup = replace(titleGroup,"_"," ","all") >
			
			<cfset theItemArr = groupStruct['__#colGroup#'] >
			<cfset theItemList = ArrayToList(theItemArr, ",") >
			
			<cfset height = evaluate("Y__#colGroup#") >
			
			<cfset theFieldSet[fcnt] = "{
					xtype:'fieldset',  
		        	collapsible: true,
		        	margin: '#formgroupmargin#',
		        	title: '#titleGroup#',
			        defaultType: 'textfield',
			        defaults: {anchor: '100%'},
			        columnWidth: #1/ArrayLen(tableGroupData)#,
			        layout: 'anchor',
			        width: '100%',
			        items :[
			        	#theItemList#, 
			        	#fileParams#
			        ]
			        }" >
			 <cfset fcnt = fcnt + 1 >
		</cfloop>
		
	<cfset groupFieldsAll = ArrayToList(theFieldSet, ",") >	
	
		<cfset formScript = "
							#stores#
							#vtypes#
							var eForm = Ext.create('Ext.form.Panel',{
								padding: '#formpadding#', 
							   	items: [
							    	#groupFieldsAll# 
								]," >
	
	<cfelseif formviewas EQ "HBOXPANEL">
		<cfloop array="#tableGroupData#" index="theGroup" >
			
			<cfif trim(theGroup[1]) EQ "" >
				<cfset colGroup = "nogroup" >
			<cfelse>
				<cfset colGroup = rereplace(theGroup[1], "[^A-Za-z0-9_]", "_", "all") >
			</cfif>
			
			<cfset titleGroup = replace(colGroup,"nogroup"," ","all") >
			<cfset titleGroup = replace(titleGroup,"_"," ","all") >
			
			<cfset theItemArr = groupStruct['__#colGroup#'] >
			<cfset theItemList = ArrayToList(theItemArr, ",") >
			
			<cfset height = evaluate("Y__#colGroup#") >
			
			<cfset theFieldSet[fcnt] = "{
					xtype:'panel',  
		        	collapsible: true,
		        	margin: '#formgroupmargin#',
		        	title: '#titleGroup#',
			        defaultType: 'textfield',
			        defaults: {anchor: '100%'},
			        columnWidth: #1/ArrayLen(tableGroupData)#,
			        layout: 'anchor',
			        width: '100%',
			        items :[
			        	#theItemList#, 
			        	#fileParams#
			        ]
			        }" >
			 <cfset fcnt = fcnt + 1 >
		</cfloop>
		
	<cfset groupFieldsAll = ArrayToList(theFieldSet, ",") >	
	
		<cfset formScript = "
							#stores#
							#vtypes#
							var eForm = Ext.create('Ext.form.Panel',{
								padding: '#formpadding#', 
							   	items: [
							    	#groupFieldsAll# 
								]," >
							
	<cfelseif formviewas EQ "TABLE">
		<cfloop array="#tableGroupData#" index="theGroup" >
			
			<cfif trim(theGroup[1]) EQ "" >
				<cfset colGroup = "nogroup" >
			<cfelse>
				<cfset colGroup = rereplace(theGroup[1], "[^A-Za-z0-9_]", "_", "all") >
			</cfif>
			
			<cfset titleGroup = replace(colGroup,"nogroup"," ","all") >
			<cfset titleGroup = replace(titleGroup,"_"," ","all") >
			
			<cfset theItemArr = groupStruct['__#colGroup#'] >
			<cfset theItemList = ArrayToList(theItemArr, ",") >
			
			<cfset height = evaluate("Y__#colGroup#") >
			
			<cfset theFieldSet[fcnt] = "{
					xtype:'fieldset',  
		        	collapsible: true,
		        	margin: '#formgroupmargin#',
		        	title: '#titleGroup#',
			        defaultType: 'textfield',
			        defaults: {anchor: '100%'},
			        layout: 'column',
			        
			        items :[
			        	#theItemList#, 
			        	#fileParams#
			        ]
			        }" > 
			 <cfset fcnt = fcnt + 1 >
		</cfloop>
		
	<cfset groupFieldsAll = ArrayToList(theFieldSet, ",") >	
	
		<cfset formScript = "
							#stores#
							#vtypes#
							var eForm = Ext.create('Ext.form.Panel',{
								padding: '#formpadding#', 
								layout: 'anchor',
							   	items: [
							    	#groupFieldsAll# 
								]," >
	
	<cfelse>
		
	</cfif>	
	
	<cfset auxScript = "alias: 'widget.eFormForm',
						width: '100%', 
						height: '100%',autoScroll: true,
						defaults: {anchor: '100%'},
						defaultType: 'textfield',
						api: {
					   		load:   'Ext.ss.actionform.load',
					   		submit: 'Ext.ss.actionform.submit'
					   	},
					    buttons: [{
					    	text: 'Add',
					    	action: 'add',
					    	handler: function(thiss) {
					    		var theForm = thiss.up('form').getForm();
					    		if(theForm.isValid()) {
					    			theForm.submit({
					    				submitEmptyText: false,
					    				waitMsg: 'Submitting, please wait',
						    			params: {
						    				eformid: '#eformid#',
						    				action: 'add'
						    			},
						    			reset: true,
								  		failure: function(form, action){
								  			Ext.Msg.show({
								  				title: 'Technical problem.',
								  				msg: 'Our apology. We are having technical problems.',
								  				buttons: Ext.Msg.OK,
								  				icon: Ext.Msg.ERROR
								  			});
											console.log(action);
								  		},
								  		success: function(form, action){
								  			Ext.Msg.show({
								  				msg: 'Form add successful',
								  				buttons: Ext.Msg.OK
								  			});
											//var cardlayout = btn.up('viewport');
											//var thecolGrid = cardlayout.down('defcolumnview');
											//var colStore = thecolGrid.getStore();
											//colStore.load(); 
											console.log(action);
								  		}
						    		});
					    		} else {
					    			alert('Please provide correct value for each field!');
					    		}
					    		
					    	}
					    },{
					    	text: 'Save',
					    	action: 'save',
					    	handler: function(thiss) {
					    		var theForm = thiss.up('form').getForm();
					    		if(theForm.isValid()) {
					    			theForm.submit({
					    				submitEmptyText: false,
					    				waitMsg: 'Submitting, please wait',
						    			params: {
						    				eformid: '#eformid#',
						    				action: 'save'
						    			},
						    			reset: true,
								  		failure: function(form, action){
								  			Ext.Msg.show({
								  				title: 'Technical problem.',
								  				msg: 'Our apology. We are having technical problems.',
								  				buttons: Ext.Msg.OK,
								  				icon: Ext.Msg.ERROR
								  			});
											console.log(action);
								  		},
								  		success: function(form, action){
								  			Ext.Msg.show({
								  				msg: 'Form update successful',
								  				buttons: Ext.Msg.OK
								  			});
											//var cardlayout = btn.up('viewport');
											//var thecolGrid = cardlayout.down('defcolumnview');
											//var colStore = thecolGrid.getStore();
											//colStore.load(); 
											console.log(action);
								  		}
						    		});
					    		} else {
					    			alert('Please provide correct value for each field!');
					    		}
					    		
					    	}
					    },{
					    	text: 'Print',
					    	action: 'print',
					    	handler: function(thiss) {
					    		thiss.up('form').print();
					    	}
					    },{
					    	text: 'Approve',
					    	action: 'approve',
					    	handler: function(thiss) {
					    		var theForm = thiss.up('form').getForm();
					    		if(theForm.isValid()) {
					    			theForm.submit({
					    				submitEmptyText: false,
					    				waitMsg: 'Submitting, please wait',
						    			params: {
						    				eformid: '#eformid#',
						    				action: 'approve'
						    			},
						    			reset: true,
								  		failure: function(form, action){
								  			Ext.Msg.show({
								  				title: 'Technical problem.',
								  				msg: 'Our apology. We are having technical problems.',
								  				buttons: Ext.Msg.OK,
								  				icon: Ext.Msg.ERROR
								  			});
											console.log(action);
								  		},
								  		success: function(form, action){
								  			Ext.Msg.show({
								  				msg: 'Form approve successful',
								  				buttons: Ext.Msg.OK
								  			});
											//var cardlayout = btn.up('viewport');
											//var thecolGrid = cardlayout.down('defcolumnview');
											//var colStore = thecolGrid.getStore();
											//colStore.load(); 
											console.log(action);
								  		}
						    		});
					    		} else {
					    			alert('Please provide correct value for each field!');
					    		}
					    		
					    	}
					    },{
					    	text: 'Disapprove',
					    	action: 'disapprve',
					    	handler: function(thiss) {
					    		var theForm = thiss.up('form').getForm();
					    		if(theForm.isValid()) {
					    			theForm.submit({
					    				submitEmptyText: false,
					    				waitMsg: 'Submitting, please wait',
						    			params: {
						    				eformid: '#eformid#',
						    				action: 'disapprove'
						    			},
						    			reset: true,
								  		failure: function(form, action){
								  			Ext.Msg.show({
								  				title: 'Technical problem.',
								  				msg: 'Our apology. We are having technical problems.',
								  				buttons: Ext.Msg.OK,
								  				icon: Ext.Msg.ERROR
								  			});
											console.log(action);
								  		},
								  		success: function(form, action){
								  			Ext.Msg.show({
								  				msg: 'Form disapprove successful',
								  				buttons: Ext.Msg.OK
								  			});
											//var cardlayout = btn.up('viewport');
											//var thecolGrid = cardlayout.down('defcolumnview');
											//var colStore = thecolGrid.getStore();
											//colStore.load(); 
											console.log(action);
								  		}
						    		});
					    		} else {
					    			alert('Please provide correct value for each field!');
					    		}
					    		
					    	}
					    },{
					    	text: 'Return to Sender',
					    	action: 'returntosender',
					    	handler: function(thiss) {
					    		var theForm = thiss.up('form').getForm();
					    		if(theForm.isValid()) {
					    			theForm.submit({
					    				submitEmptyText: false,
					    				waitMsg: 'Submitting, please wait',
						    			params: {
						    				eformid: '#eformid#',
						    				action: 'returntosender'
						    			},
						    			reset: true,
								  		failure: function(form, action){
								  			Ext.Msg.show({
								  				title: 'Technical problem.',
								  				msg: 'Our apology. We are having technical problems.',
								  				buttons: Ext.Msg.OK,
								  				icon: Ext.Msg.ERROR
								  			});
											console.log(action);
								  		},
								  		success: function(form, action){
								  			Ext.Msg.show({
								  				msg: 'Return to sender successful',
								  				buttons: Ext.Msg.OK
								  			});
											//var cardlayout = btn.up('viewport');
											//var thecolGrid = cardlayout.down('defcolumnview');
											//var colStore = thecolGrid.getStore();
											//colStore.load(); 
											console.log(action);
								  		}
						    		});
					    		} else {
					    			alert('Please provide correct value for each field!');
					    		}
					    		
					    	}
					    },{
					    	text: 'Return to Originator',
					    	action: 'returntooriginator',
					    	handler: function(thiss) {
					    		var theForm = thiss.up('form').getForm();
					    		if(theForm.isValid()) {
					    			theForm.submit({
					    				submitEmptyText: false,
					    				waitMsg: 'Submitting, please wait',
						    			params: {
						    				eformid: '#eformid#',
						    				action: 'returntooriginator'
						    			},
						    			reset: true,
								  		failure: function(form, action){
								  			Ext.Msg.show({
								  				title: 'Technical problem.',
								  				msg: 'Our apology. We are having technical problems.',
								  				buttons: Ext.Msg.OK,
								  				icon: Ext.Msg.ERROR
								  			});
											console.log(action);
								  		},
								  		success: function(form, action){
								  			Ext.Msg.show({
								  				msg: 'Return to originator successful',
								  				buttons: Ext.Msg.OK
								  			});
											//var cardlayout = btn.up('viewport');
											//var thecolGrid = cardlayout.down('defcolumnview');
											//var colStore = thecolGrid.getStore();
											//colStore.load(); 
											console.log(action);
								  		}
						    		});
					    		} else {
					    			alert('Please provide correct value for each field!');
					    		}
					    		
					    	}
					    },{
					    	text: 'e-mail Form',
							action: 'emailform',
							handler: function(thiss) {
								var panelContent = thiss.up('form').getPanelContent();
								var emailForm = Ext.widget('eformemailwindow');
								var bodyEditor = emailForm.down('htmleditor');
								bodyEditor.setValue(panelContent);
								
								var windowTitle = thiss.up('window').title;
								var subjectF = emailForm.down('textfield[fieldLabel=Subject]');
								subjectF.setValue(windowTitle);
								emailForm.show();
							}
					    }]
					});
					
					
					Ext.create('Ext.window.Window', { 
					    height: '100%',
					    title: '#formtitle#',
					    width: '100%',
					    layout: 'fit',
					    items: eForm,
					    bbar: [{
					    	xtype: 'textfield',
					    	value: '',
					    	fieldLabel: 'Comments',
					    	width: '40%',
					    	padding: '4 10 4 4'
					    },{
							xtype: 'combobox',
							//store: 'form.userStore',
							displayField: 'username',
							valueField: 'usercode',
							minChars: 1,
							pageSize: 20,
							width: '40%',
							fieldLabel: 'View Comments',
							action: 'selecteduser',
							padding: '4 4 4 4'
					  }]
					}).show();" >
					
	<cfset formScript = formScript & ' ' & auxScript >	
		
		
		
	
	
		
	<cfset processDataB = EntityLoad("EGRGEFORMS", #eformid#, true ) >
	<cfset processDataB.setLAYOUTQUERY("#formScript#") >
	<cfset EntitySave(processDataB) >
	<cfset ormflush()>
	<!---<cfcatch>
		<cfreturn cfcatch.detail & ' ' & cfcatch.message >
	</cfcatch>
	</cftry>--->
</cffunction>

<cffunction name="previewGrid" ExtDirect="true">
	<cfargument name="eformid" >
	<cfargument name="actiontype" >
	<cfargument name="processid" >
	<cftry>
	<cfset formScript = "empty" >
	<cfset processData = EntityLoad("EGRGEFORMS", #eformid#, true ) >
	<cfset formScript = processData.getLAYOUTQUERY() > 
	
	<cfif actiontype eq "add" >
		<cfset formScript = replace(formScript, "action: 'save',hidden: false,", "action: 'save',hidden: true,") >
		<cfset formScript = replace(formScript, "action: 'print',hidden: false,", "action: 'print',hidden: true,") > 
		<cfset formScript = replace(formScript, "action: 'approve',hidden: false,", "action: 'approve',hidden: true,") >
		<cfset formScript = replace(formScript, "action: 'disapprve',hidden: false,", "action: 'disapprve',hidden: true,") >
		<cfset formScript = replace(formScript, "action: 'returntooriginator',hidden: false,", "action: 'returntooriginator',hidden: true,") >
		<cfset formScript = replace(formScript, "action: 'emailform',hidden: false,", "action: 'emailform',hidden: true,") > 
		<cfset formScript = replace(formScript, "fieldLabel: 'Comments',hidden: false,", "fieldLabel: 'Comments',hidden: true,") >
		<cfset formScript = replace(formScript, "xtype: 'combobox',name: 'commentslist',hidden: false,", "xtype: 'combobox',name: 'commentslist',hidden: true,") >
		
		
	<cfelseif actiontype eq "edit" >
		<cfset formScript = replace(formScript, "action: 'print',hidden: false,", "action: 'print',hidden: true,") > 
		<cfset formScript = replace(formScript, "action: 'approve',hidden: false,", "action: 'approve',hidden: true,") >
		<cfset formScript = replace(formScript, "action: 'disapprve',hidden: false,", "action: 'disapprve',hidden: true,") > 
		<cfset formScript = replace(formScript, "action: 'returntooriginator',hidden: false,", "action: 'returntooriginator',hidden: true,") >
		<cfset formScript = replace(formScript, "action: 'emailform',hidden: false,", "action: 'emailform',hidden: true,") >  
		<cfset formScript = replace(formScript, "xtype: 'filefield',value: '", "xtype: 'hiddenfield',value: '", "all" ) > 
		<cfset formScript = replace(formScript, "xtype: 'hiddenfield',//for file//", "xtype: 'textfield',submitValue: true,", "all" ) > 
		<cfset formScript = replace(formScript, "fieldLabel: 'Comments',hidden: false,", "fieldLabel: 'Comments',hidden: true,") >
		<cfset formScript = replace(formScript, "fieldLabel: '__PROCESSID',disabled: true,", "fieldLabel: '__PROCESSID',disabled: false,") >
		<cfset formScript = replace(formScript, "fieldLabel: '__APPROVED',disabled: true,", "fieldLabel: '__APPROVED',disabled: false,") >
	<cfelseif actiontype eq "open" >
		<cfset formScript = replace(formScript, "action: 'print',hidden: false,", "action: 'print',hidden: true,") > 
		<cfset formScript = replace(formScript, "action: 'emailform',hidden: false,", "action: 'emailform',hidden: true,") >   
		<cfset formScript = replace(formScript, "action: 'add',hidden: false,", "action: 'add',hidden: true,") > 
		<cfset formScript = replace(formScript, "action: 'save',hidden: false,", "action: 'save',hidden: true,") >
		<cfset formScript = replace(formScript, "xtype: 'filefield',value: '", "xtype: 'hiddenfield',value: '", "all" ) > 
		<cfset formScript = replace(formScript, "xtype: 'hiddenfield',//for file//", "xtype: 'displayfield',", "all" ) > 
		<cfset formScript = replace(formScript, "readOnly: false,value:", "readOnly: true,value:", "all" ) > 
		<cfset formScript = replace(formScript, "readOnly: false,inputValue:", "readOnly: true,inputValue:", "all" ) >   
		<cfset formScript = replace(formScript, "fieldLabel: '__PROCESSID',disabled: true,", "fieldLabel: '__PROCESSID',disabled: false,") >
		<cfset formScript = replace(formScript, "fieldLabel: '__APPROVED',disabled: true,", "fieldLabel: '__APPROVED',disabled: false,") >
		<cfset formScript = replace(formScript, "fieldLabel: '__PERSONNELIDNO',disabled: true,", "fieldLabel: '__PERSONNELIDNO',disabled: false,") > 
		<cfset formScript = replace(formScript, "fieldLabel: 'ROUTERDETAILSID',disabled: true,", "fieldLabel: 'ROUTERDETAILSID',disabled: false,") >
		<cfset formScript = replace(formScript, "fieldLabel: 'APPROVERDETAILSID',disabled: true,", "fieldLabel: 'APPROVERDETAILSID',disabled: false,") >
		
		<cfinvoke method="getColumnArray" returnvariable="colIDArr" eformid="#eformid#">
		
		
		<cfinvoke method="getCurrentRouterOrder" returnvariable="thisCurrentRouterOrder" processid="#processid#">
		
		<cfset currentRouterOrder = thisCurrentRouterOrder[1] >
		<cfloop from="1" to="#ArrayLen(colIDArr)#" index="arrCounter" >
			<cfset theColValueRouterOrder = colValueArr[arrCounter] >
			<cfset theColID = colIDArr[arrCounter] > 
				
			<cfif listfind(theColValueRouterOrder,currentRouterOrder,",")  > 
				<!---this is the editable on route part thing--->
				<cfset formScript = replace(formScript, "'#theColID#',readOnly: true", "'#theColID#',readOnly: false", "all" ) > 
			</cfif>
		
		</cfloop>
		
	<cfelseif actiontype eq "print" >
		<cfset formScript = replace(formScript, "action: 'add',hidden: false,", "action: 'add',hidden: true,") >
		<cfset formScript = replace(formScript, "action: 'save',hidden: false,", "action: 'save',hidden: true,") >
		<cfset formScript = replace(formScript, "action: 'approve',hidden: false,", "action: 'approve',hidden: true,") >
		<cfset formScript = replace(formScript, "action: 'disapprve',hidden: false,", "action: 'disapprve',hidden: true,") >
		<cfset formScript = replace(formScript, "action: 'returntooriginator',hidden: false,", "action: 'returntooriginator',hidden: true,") >
		<cfset formScript = replace(formScript, "xtype: 'filefield',value: '", "xtype: 'hiddenfield',value: '", "all" ) > 
		<cfset formScript = replace(formScript, "xtype: 'hiddenfield',//for file//", "xtype: 'displayfield',", "all" ) >  
		<cfset formScript = replace(formScript, "fieldLabel: 'Comments',hidden: false,", "fieldLabel: 'Comments',hidden: true,") >
		<cfset formScript = replace(formScript, "xtype: 'combobox',name: 'commentslist',hidden: false,", "xtype: 'combobox',name: 'commentslist',hidden: true,") >
		
		<cfset formScript = replace(formScript, "xtype: 'textfield',//used", "xtype: 'displayfield',//", "all" ) > 
		<cfset formScript = replace(formScript, "xtype: 'textareafield',", "xtype: 'displayfield',", "all" ) >
		<cfset formScript = replace(formScript, "xtype: 'combobox',", "xtype: 'displayfield',", "all" ) >
		<cfset formScript = replace(formScript, "xtype: 'datefield',", "xtype: 'displayfield',", "all" ) >
		<cfset formScript = replace(formScript, "xtype: 'timefield',", "xtype: 'displayfield',", "all" ) >
		<cfset formScript = replace(formScript, "xtype: 'htmleditor',", "xtype: 'displayfield',", "all" ) > 
		<cfset formScript = replace(formScript, "xtype: 'datefield',", "xtype: 'displayfield',", "all" ) >  
		<cfset formScript = replace(formScript, "xtype: 'numberfield',", "xtype: 'displayfield',", "all" ) > 
		<cfset formScript = replace(formScript, "xtype: 'ID',", "xtype: 'displayfield',", "all" ) >   
		
	<cfelse>
		
	</cfif>
	
	
	

	<cfreturn formScript >
	<cfcatch>
		<cfreturn cfcatch.detail & ' ' & cfcatch.message >
	</cfcatch>
	</cftry>
</cffunction>


<cffunction name="changepid" ExtDirect="true" >
<cfargument name="newPID" >
<!---query approver details and get an array of process id--->
	<cfset getprocessID = ORMExecuteQuery("SELECT count(*) AS TOTPROCESSID
	  								      FROM EGINFORMPROCESSDETAILS A,EGINROUTERDETAILS B,EGINAPPROVERDETAILS C
	 								      WHERE A.PROCESSDETAILSID = B.PROCESSIDFK 
	 								      		AND B.ROUTERDETAILSID = C.ROUTERIDFK 
	 								      		AND C.PERSONNELIDNO = '#newPID#'
	 								      		AND C.ISREAD = 'false'
	 								      		AND C.ACTION = 'CURRENT'", true) >

	<cfset getprocessIDPending = ORMExecuteQuery("SELECT count(*) AS TOTPROCESSID
	  								      FROM EGINFORMPROCESSDETAILS A,EGINROUTERDETAILS B,EGINAPPROVERDETAILS C
	 								      WHERE A.PROCESSDETAILSID = B.PROCESSIDFK 
	 								      		AND B.ROUTERDETAILSID = C.ROUTERIDFK 
	 								      		AND C.PERSONNELIDNO = '#newPID#'
	 								      		AND C.ISREAD = 'true'
	 								      		AND C.ACTION = 'CURRENT'", true) > 


<cfset retArr = ArrayNew(1) >
<cfset client.chapa = newPID >

<cfif getprocessID eq 0 >
	<cfset retArr[1] = "No New eForm">
<cfelseif getprocessID eq 1 >
	<cfset retArr[1] = "<span style='background-color: red; border-radius: 12px; color: white;'><b>&nbsp;#getprocessID#&nbsp;</b></span> New eForm">
<cfelse>
	<cfset retArr[1] = "<span style='background-color: red; border-radius: 12px; color: white;'><b>&nbsp;#getprocessID#&nbsp;</b></span> New eForms">
</cfif>

<cfif getprocessIDPending eq 0 >
	<cfset retArr[2] = "No Pending eForm">
<cfelseif getprocessID eq 1 >
	<cfset retArr[2] = "<span style='background-color: red; border-radius: 12px; color: white;'><b>&nbsp;#getprocessIDPending#&nbsp;</b></span> Pending eForm">
<cfelse>
	<cfset retArr[2] = "<span style='background-color: red; border-radius: 12px; color: white;'><b>&nbsp;#getprocessIDPending#&nbsp;</b></span> Pending eForms">
</cfif>

<cfreturn retArr >

</cffunction>






		
<cffunction name="getColumnArray" returntype="Array" >
<cfargument name="eformid" >
<cfset colIDArr = ArrayNew(1) >
<cfset colValueArr = ArrayNew(1) >
<cfset gettheForm = ORMExecuteQuery("SELECT C.COLUMNID AS COLUMNID, 
											C.EDITABLEONROUTENO AS EDITABLEONROUTENO
	  								  FROM EGRGEFORMS A,EGRGIBOSETABLE B,EGRGIBOSETABLEFIELDS C
	  								WHERE EFORMID = '#eformid#' 
	  										AND A.EFORMID = B.EFORMIDFK 
	  										AND B.TABLEID = C.TABLEIDFK
	  										AND C.EDITABLEONROUTENO <> ''", false) >

<cfloop array="#gettheForm#" index="tableModel">
	<cfset ArrayAppend(colIDArr, tableModel[1]) >
	<cfset ArrayAppend(colValueArr, tableModel[2]) >
</cfloop>


<cfreturn colIDArr >
</cffunction>



<cffunction name="getCurrentRouterOrder" returntype="Array"  >
<cfargument name="processid" >
<cfset getprocessID = ORMExecuteQuery("SELECT B.ROUTERORDER AS ROUTERORDER
	  								      FROM EGINFORMPROCESSDETAILS A,EGINROUTERDETAILS B,EGINAPPROVERDETAILS C
	 								      WHERE A.PROCESSDETAILSID = B.PROCESSIDFK 
	 								      		AND B.ROUTERDETAILSID = C.ROUTERIDFK 
	 								      		AND C.PERSONNELIDNO = '#client.chapa#'
	 								      		AND C.ACTION = 'CURRENT'
	 								      		AND A.PROCESSDETAILSID = '#processid#'", false) >


<cfreturn getprocessID>
</cffunction>


</cfcomponent>