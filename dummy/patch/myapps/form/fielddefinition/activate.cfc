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
					<cfset width = "width: #WIDTH#," >
				<cfelseif trim(WIDTH) EQ "" >
					<cfset width = "flex: 1," > 
				<cfelse>
					<cfset width = "width: '#WIDTH#'," >
				</cfif>
				
				
				<cfset filter = "" >
				<cfif XTYPE EQ "datefield" >
					<cfif trim(RENDERER) eq "" >
					<cfset RENDERER ="renderer: Ext.util.Format.dateRenderer('n/j/Y')," >
					<cfset filter = "filter: {type: 'date',format: 'Y-n-j'}," > 
					<cfelse>
						<cfset RENDERER ="renderer: #RENDERER#," >
					</cfif>
				<cfelse>
					<cfif trim(RENDERER) eq "" >
						<cfset RENDERER ="" >
					<cfelse>
						<cfset RENDERER ="renderer: #RENDERER#," >
					</cfif>
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
				
				<cfif XTYPE EQ "displayfield" AND trim(COLUMNNAME) EQ "" > <!---columnname set as display field with empty value will be hidden from the grid--->
					<cfset ISHIDDEN = "true">
				<cfelse> 
				</cfif>
				
				
				<cfif XTYPE EQ "filefield" >
					<cfif trim(RENDERER) eq "" >
						<cfset RENDERER ="renderer: function(value,p,record) {return Ext.String.format('<a target=\'_new\' href=\'{1}{0}\'>{0}</a>', value,record.data.thefilepath);}," >
					<cfelse>
						<cfset RENDERER ="renderer: #RENDERER#," >
					</cfif>
				<cfelse> 
				</cfif>
				
				
				<cfset forColName = "{name: '#dataIndex#',type: '#COLUMNTYPE#'}" >
												 
				<cfset ArrayAppend(columnnameArr, forColName) >
				
				<cfset forColItem = "{text: '#FIELDLABEL#',hidden: #ISHIDDEN#,dataIndex: '#dataIndex#',filterable: true,#RENDERER##width##filter#}" >	
				<cfset ArrayAppend(columnItemArr, forColItem) >						 
				
			</cfloop> <!---end tableColumnData--->
		
		</cfloop> <!---end formTableData--->
		
		
		<cfset fields = ArrayToList(columnnameArr, ", ") >
		<cfset columns = ArrayToList(columnItemArr, ", ") >
		  
<cfset gridScript = "Ext.define('autoeFormModel', {extend: 'Ext.data.Model',fields: [#fields#,'#firstlevel#__#firsttable#__APPROVED','#firstlevel#__#firsttable#__EFORMID','#firstlevel#__#firsttable#__PROCESSID','#firstlevel#__#firsttable#__ACTIONBY','#firstlevel#__#firsttable#__PERSONNELIDNO','thefilepath',{name: '#firstlevel#__#firsttable#__RECDATECREATED',type: 'date'},{name: '#firstlevel#__#firsttable#__DATEACTIONWASDONE',type: 'date'},{name: '#firstlevel#__#firsttable#__DATELASTUPDATE',type: 'date'}]});  var autoeFormStore = Ext.create('Ext.data.Store', {model: 'autoeFormModel',remoteFilter: true,remoteSort: true,simpleSortMode: true,sorters: [{property: '#firstlevel#__#firsttable#__DATELASTUPDATE', direction: 'DESC' }],filters: [{type: 'string',dataIndex: '#firstlevel#__#firsttable#__#firstcolumn#'  }],pageSize: 50,autoSave: true,autoLoad: true,autoSync: true, proxy: {extraParams: {eformid: '#eformid#',isnew: false,ispending: false},type: 'direct',timeout: 300000,paramOrder: ['page', 'start', 'limit', 'sort', 'filter', 'eformid', 'isnew', 'ispending'],api: {read:    Ext.ss.defdata.ColumnReadNow,   create:  Ext.ss.defdata.ColumnCreateNow,  update:  Ext.ss.defdata.ColumnUpdateNow,  destroy: Ext.ss.defdata.ColumnDestroyNow  },paramsAsHash: false,filterParam: 'filter',sortParam: 'sort',limitParam: 'limit',idParam: 'ID',pageParam: 'page',reader: {root: 'topics', totalProperty: 'totalCount' }}});var autoeFormGrid = Ext.create('Ext.grid.Panel',{alias: 'widget.eFormGrid',title: '#eFormName#',id: '#eformid#',width: '100%',height: 500,multiSelect: true,clicksToEdit: 2,selModel: { pruneRemoved: false}, viewConfig: { forceFit: false,trackOver: false,emptyText: '<h1 style=\'margin:20px\'>No matching results</h1>'},features: [{ftype: 'filters',encode: true, local: false, }],store: autoeFormStore,bbar: Ext.create('Ext.toolbar.Paging', {store: autoeFormStore, displayInfo: true, emptyMsg: 'No topics to display'}), tbar: [{text: 'Add',action: 'addeform',hidden: false,handler: function(btn) {var eformGrid = btn.up('grid');var eformid = eformGrid.id;var processid = '_';var myMask = Ext.create('Ext.LoadMask',{target: eformGrid,msg: 'Opening, please wait...'});myMask.show();Ext.ss.activate.previewGrid(eformid, 'add',processid, function(result) { myMask.hide();eval(result);eForm.getForm().load({params: {eformid: eformid}})});} },{xtype: 'tbseparator'},{text: 'Edit',action: 'editeform',hidden: false,handler: function(btn) {var eformGrid = btn.up('grid');var selectedRecord = eformGrid.getSelectionModel().getSelection()[0];if(selectedRecord) {var eformid = selectedRecord.data.#firstlevel#__#firsttable#__EFORMID;var status = selectedRecord.data.#firstlevel#__#firsttable#__APPROVED;var processid = selectedRecord.data.#firstlevel#__#firsttable#__PROCESSID;var myMask = Ext.create('Ext.LoadMask',{target: eformGrid,msg: 'Opening, please wait...'});myMask.show();if(status != 'S') {Ext.ss.activate.previewGrid(eformid, 'edit',processid, function(result) { myMask.hide();eval(result);
var theForm = eForm.getForm();theForm.setValues(selectedRecord.data);});} else { myMask.hide();alert('This form is pending!');} } else {alert('Please select a record first!');}}},{xtype: 'tbseparator'},{text: 'Delete',action: 'deleteeform',hidden: false,handler: function(btn) { var eformGrid = btn.up('grid');var selectedRecord = eformGrid.getSelectionModel().getSelection()[0];if(selectedRecord) {var res = window.confirm('You are about to delete an eForm which has processed records. \n Would you like to continue?');if(!res) {return true;}var eformid = selectedRecord.data.#firstlevel#__#firsttable#__EFORMID;var processid = selectedRecord.data.#firstlevel#__#firsttable#__PROCESSID;var level = '#firstlevel#';var table = '#firsttable#';var myMask = Ext.create('Ext.LoadMask',{target: eformGrid,msg: 'Deleting, please wait...'}); myMask.show();Ext.ss.data.deleteForm(eformid,processid,level,table,function(result) {  myMask.hide();eformGrid.getStore().load();});} else {alert('Please select a record first!');}}},{xtype: 'tbseparator'},{text: 'Route',action: 'routeeform',hidden: false,handler: function(btn) {var thisgrid = btn.up('grid');var selection = thisgrid.getView().getSelectionModel().getSelection();if (selection.length != 0) {if (selection.length == 1) {var eform = 'eForm'} else {var eform = 'eForms'}var action = window.confirm('Route selected ' + eform + '?\nNote: Only eForms with status \'NEW\' will be routed.');if(action) {var myMask = Ext.create('Ext.LoadMask',{target: thisgrid,msg: 'Routing, please wait...'});for (var cntr=0; cntr<selection.length; cntr++) {var eformid = selection[cntr].data.#firstlevel#__#firsttable#__EFORMID;var processid = selection[cntr].data.#firstlevel#__#firsttable#__PROCESSID;var theLevel = '#firstlevel#';var thetable = '#firsttable#';var status = selection[cntr].data.#firstlevel#__#firsttable#__APPROVED;if(status == 'N' || status == '') {myMask.show();Ext.ss.active.startRoute(eformid,processid,theLevel,thetable, function(result) {console.log(result);myMask.hide();if(result == 'success') {Ext.Msg.show({title: '',msg: 'Form route successful', buttons: Ext.Msg.OK});thisgrid.getStore().load();} else {myMask.hide();Ext.Msg.show({title: 'Technical problem.',msg: 'Our apology. We are having technical problems : ' + result, buttons: Ext.Msg.OK,icon: Ext.Msg.ERROR});} });} else {myMask.hide(); }}}} else {alert('No form selected. Please select an eForm to route.');}} },{xtype: 'tbseparator'},{text: 'View Status',action: 'viewpathroute',hidden: false,handler: function(btn) {var thisgrid = btn.up('grid');var selection = thisgrid.getView().getSelectionModel().getSelection()[0];if (selection) {var eformid = selection.data.#firstlevel#__#firsttable#__EFORMID;var processid = selection.data.#firstlevel#__#firsttable#__PROCESSID;var status = selection.data.#firstlevel#__#firsttable#__APPROVED;var pidno = selection.data.#firstlevel#__#firsttable#__PERSONNELIDNO;var myMask = Ext.create('Ext.LoadMask',{target: thisgrid,msg: 'Opening, please wait...'});myMask.show();if(status != 'N' && status != '') {Ext.ss.active.generateMap(eformid,processid,pidno, function(result) {myMask.hide();try {eval(result);} catch(err) { if(result == 'cannotviewroutemap') {alert('Unable to view status');} else {alert('Please try again.')}}});} else { myMask.hide();Ext.Msg.show({title: '',msg: 'Please route the form first.', buttons: Ext.Msg.OK});}	} else {alert('No form selected. Please select an eForm first.');}} },{xtype: 'tbseparator'},{text: 'Open',action: 'openformnow',hidden: false,handler: function(btn) {var eformGrid = btn.up('grid');var selectedRecord = eformGrid.getSelectionModel().getSelection()[0];if(selectedRecord) {var myMask = Ext.create('Ext.LoadMask',{target: eformGrid,msg: 'Opening, please wait...'}); myMask.show();var eformid = selectedRecord.data.#firstlevel#__#firsttable#__EFORMID;var processid = selectedRecord.data.#firstlevel#__#firsttable#__PROCESSID;Ext.ss.activate.previewGrid(eformid, 'open',processid, function(result) { myMask.hide();eval(result);var theForm = eForm.getForm();theForm.setValues(selectedRecord.data);var querythisform = eForm.query('displayfield');
//set isread to true now except for pending
Ext.ss.data.setIsreadTrue(eformid,processid, function(result) {console.log(result); });});				
} else {alert('Please select a record first!');}}},{xtype: 'tbseparator' },{text: 'Approve',action: 'approveformnow',hidden: false,handler: function(thiss) {var res = window.confirm('Approve?'); if(!res) {return false; }var theGrid = thiss.up('grid');var selectedRecord = theGrid.getView().getSelectionModel().getSelection();if(selectedRecord.length > 0) {var myMask = Ext.create('Ext.LoadMask',{target: theGrid,msg: 'Approving, please wait...'});myMask.show();for(cntt=0;cntt<selectedRecord.length;cntt++) {var eformid    = selectedRecord[cntt].data.#firstlevel#__#firsttable#__EFORMID;var processid  = selectedRecord[cntt].data.#firstlevel#__#firsttable#__PROCESSID;var firstlevel = '#firstlevel#';var firsttable = '#firsttable#';var actiontype = 'approve';var pid  = selectedRecord[cntt].data.#firstlevel#__#firsttable#__PERSONNELIDNO;Ext.ss.actionform.gridApproveDisapprove(eformid,processid,firstlevel,firsttable,actiontype,pid, function(result) { myMask.hide();   theGrid.getStore().load(); var mainGrid = Ext.ComponentQuery.query('eformmainview'); mainGrid[0].getStore().load();   }); }} else {alert('Please select at least one record to approve.');} }},{xtype: 'tbseparator'},{text: 'Disapprove',action: 'disapproveformnow',hidden: false,handler: function(thiss) { var res = window.confirm('Disapprove?'); if(!res) {return false; }var theGrid = thiss.up('grid');var selectedRecord = theGrid.getView().getSelectionModel().getSelection();if(selectedRecord.length > 0) {var myMask = Ext.create('Ext.LoadMask',{target: theGrid,msg: 'Disapproving, please wait...'});myMask.show(); for(cntt=0;cntt<selectedRecord.length;cntt++) {var eformid    = selectedRecord[cntt].data.#firstlevel#__#firsttable#__EFORMID;var processid  = selectedRecord[cntt].data.#firstlevel#__#firsttable#__PROCESSID;var firstlevel = '#firstlevel#';var firsttable = '#firsttable#';var actiontype = 'disapprove'; var pid  = selectedRecord[cntt].data.#firstlevel#__#firsttable#__PERSONNELIDNO;Ext.ss.actionform.gridApproveDisapprove(eformid,processid,firstlevel,firsttable,actiontype,pid, function(result) { myMask.hide(); theGrid.getStore().load(); var mainGrid = Ext.ComponentQuery.query('eformmainview'); mainGrid[0].getStore().load();  });  }} else {alert('Please select at least one record to approve.');}	 }},{  xtype: 'tbfill' },{text: 'Print/email',action: 'emailnowxxx',handler: function(btn) {var eformGrid = btn.up('grid');var selectedRecord = eformGrid.getSelectionModel().getSelection()[0];if(selectedRecord) {var eformid = selectedRecord.data.#firstlevel#__#firsttable#__EFORMID;var processid = selectedRecord.data.#firstlevel#__#firsttable#__PROCESSID;var myMask = Ext.create('Ext.LoadMask',{target: eformGrid,msg: 'Opening, please wait...'}); myMask.show();Ext.ss.activate.previewGrid(eformid, 'print',processid, function(result) {  myMask.hide();eval(result);var theForm = eForm.getForm();theForm.setValues(selectedRecord.data); });} else {alert('Please select a record first!');}}}],columns: [{xtype: 'rownumberer', width: 50,sortable: false},{text: 'Approved',dataIndex: '#firstlevel#__#firsttable#__APPROVED',width: '100',filterable: true,renderer: function(value, metaData, record) {if(value == 'Y') { metaData.style = 'background-color: ##00FF00;';return 'APPROVED';} else if (value == 'D') {metaData.style = 'background-color: ##FF0000;';return 'DISAPPROVED';} else if (value == 'S') {metaData.style = 'background-color: ##FFFF00;';return 'PENDING';} else if (value == 'R') {metaData.style = 'background-color: ##CCCCFF;';return 'RETURNED';} else {return 'NEW';}return value;} },#columns#,{text: 'eFormID',dataIndex: '#firstlevel#__#firsttable#__EFORMID',hidden: true},{text: 'ProcessID',dataIndex: '#firstlevel#__#firsttable#__PROCESSID',hidden: true},{text: 'ActonBy',dataIndex: '#firstlevel#__#firsttable#__ACTIONBY',hidden: true},{text: 'PersonnelID',dataIndex: '#firstlevel#__#firsttable#__PERSONNELIDNO',hidden: true},{text: 'Record Date Created',dataIndex: '#firstlevel#__#firsttable#__RECDATECREATED',hidden: true},{text: 'Date Action Was Done',dataIndex: '#firstlevel#__#firsttable#__DATEACTIONWASDONE',hidden: true},{text: 'Date Last Update', dataIndex: '#firstlevel#__#firsttable#__DATELASTUPDATE',hidden: true},{text: 'Date Last Update', dataIndex: 'thefilepath',hidden: true}]});Ext.create('Ext.window.Window', {height: '100%',width: '100%',layout: 'fit',modal: true,items: autoeFormGrid}).show();" >


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
	
	<cfset itemsHIDDENITEMS = ArrayNew(1) > 
	
	
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
	<!---ff are disabled by default to prevent duplicate columns--->
	<cfset extraFields =",{
							xtype: 'hiddenfield',fieldLabel: '__APPROVED',disabled: true,
				            name: '#firstlevel#__#firsttable#__APPROVED',
							width: 200 
					    },{
							xtype: 'hiddenfield',fieldLabel: '__EFORMID',disabled: true,
				            name: '#firstlevel#__#firsttable#__EFORMID',
							width: 200 
					    },{
							xtype: 'hiddenfield',fieldLabel: '__PROCESSID',disabled: true,
				            name: '#firstlevel#__#firsttable#__PROCESSID',
							width: 200 
					    },{
							xtype: 'hiddenfield',fieldLabel: '__ACTIONBY',disabled: true,
				            name: '#firstlevel#__#firsttable#__ACTIONBY',
							width: 200 
					    },{
							xtype: 'hiddenfield',fieldLabel: '__PERSONNELIDNO',disabled: true,
				            name: '#firstlevel#__#firsttable#__PERSONNELIDNO',
							width: 200 
					    },{
							xtype: 'datefield',fieldLabel: '__RECDATECREATED',disabled: true,
							hidden: true,
				            name: '#firstlevel#__#firsttable#__RECDATECREATED',
				            submitFormat: 'Y-n-j', 
							width: 200 
					    },{
							xtype: 'datefield',fieldLabel: '__DATEACTIONWASDONE',disabled: true,
							hidden: true,
				            name: '#firstlevel#__#firsttable#__DATEACTIONWASDONE',
				            submitFormat: 'Y-n-j', 
							width: 200 
					    },{
							xtype: 'datefield',fieldLabel: '__DATELASTUPDATE',disabled: true,
							hidden: true,
				            name: '#firstlevel#__#firsttable#__DATELASTUPDATE',
				            submitFormat: 'Y-n-j', 
							width: 200 
					    }" >
					    
					    
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
				<cfset INPUTFORMATB = INPUTFORMAT >
				
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
				
				<cfif trim(INPUTFORMAT) EQ "" >
					<cfset INPUTFORMAT = "" >
				<cfelse>
					<cfset INPUTFORMAT = "format: '#INPUTFORMAT#'," >
				</cfif>
				
				<cfif trim(MININPUTVALUE) EQ "" >
					<cfset MININPUTVALUE = "" >
				<cfelse>
					<cfset MININPUTVALUE = "minValue: #MININPUTVALUE#," >
				</cfif>
				
				<cfif trim(MAXINPUTVALUE) EQ "" >
					<cfset MAXINPUTVALUE = "" >
				<cfelse>
					<cfset MAXINPUTVALUE = "maxValue: #MAXINPUTVALUE#," >
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
											xtype: 'textfield',//used to convert to display field 
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
								            margin: #MARGIN#,
								            padding: #PADDING#,
								            border: '#BORDER#',
								            style: '#STYLE#',
								            id: #INPUTID#,readOnly: #ISREADONLY#,value: '#INPUTVALUE#',
								            #VALIDATIONTYPE#
								            #VTYPETEXT#
								            fieldStyle: '#INPUTFORMATB#'
								            
								        }" >
					
					<cfset arrayappend(evaluate("items#COLUMNGROUP#"), groupItems) >
					<cfset "groupStruct.__#COLUMNGROUP#" =  evaluate("items#COLUMNGROUP#") >  
					
				<cfelseif XTYPE EQ "datefield"> <!---datefield--->
					<cfif ALLOWBLANK eq "true" >
						<cfset submitvalue = "false" >
					<cfelse>
						<cfset submitvalue = "true" >
					</cfif>  
					<cfset groupItems ="{xtype: 'datefield',fieldLabel: '#FIELDLABEL#',name: '#LEVELID#__#TABLENAME#__#COLUMNNAME#',#XPOSITION##YPOSITION##ANCHORPOSITION#hidden: #ISHIDDEN#,submitFormat: 'Y-n-j', labelAlign: '#FIELDLABELALIGN#',#FIELDLABELWIDTH#allowBlank: #ALLOWBLANK#,css: '#CSSCLASS#',disabled: #ISDISABLED#,#HEIGHT##WIDTH#minLength: #MINCHARLENGTH#,maxLength: #MAXCHARLENGTH#,submitValue: #submitvalue#,listeners: {change: function(thiss,newVal) {if(newVal) {thiss.submitValue = true;} else {thiss.submitValue = false;}}},margin: #MARGIN#,padding: #PADDING#,border: '#BORDER#',style: '#STYLE#',id: #INPUTID#,readOnly: #ISREADONLY#,value: '#INPUTVALUE#',#VALIDATIONTYPE##VTYPETEXT##INPUTFORMAT##MININPUTVALUE##MAXINPUTVALUE#}" >
					
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
								            margin: #MARGIN#,
								            padding: #PADDING#,
								            border: '#BORDER#',
								            style: '#STYLE#',
								            id: #INPUTID#,readOnly: #ISREADONLY#,value: '#INPUTVALUE#',
								            #VALIDATIONTYPE#
								            #VTYPETEXT#
								            #INPUTFORMAT#
								            #MININPUTVALUE#
								            #MAXINPUTVALUE#
								            
								        }" >
					
					<cfset arrayappend(evaluate("items#COLUMNGROUP#"), groupItems) >
					<cfset "groupStruct.__#COLUMNGROUP#" =  evaluate("items#COLUMNGROUP#") >
				
				<cfelseif XTYPE EQ "numberfield"> <!---numberfield--->
					<cfif ALLOWBLANK eq "true" >
						<cfset submitvalue = "false" >
					<cfelse>
						<cfset submitvalue = "true" >
					</cfif>
					
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
								            submitValue: #submitvalue#,
								            listeners: {
								            	change: function(thiss,newVal) {
								            		if(newVal) {
								            			thiss.submitValue = true;
								            		} else {
								            		 	thiss.submitValue = false;
								            		}
								            	}
								            },
								            margin: #MARGIN#,
								            padding: #PADDING#,
								            border: '#BORDER#',
								            style: '#STYLE#',
								            id: #INPUTID#,readOnly: #ISREADONLY#,value: '#INPUTVALUE#',
								            #VALIDATIONTYPE#
								            #VTYPETEXT#
								            #INPUTFORMAT#
								            #MININPUTVALUE# 
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
								            margin: #MARGIN#,
								            padding: #PADDING#,
								            border: '#BORDER#',
								            style: '#STYLE#',
								            id: #INPUTID#,readOnly: #ISREADONLY#,value: '#INPUTVALUE#',
								            #VALIDATIONTYPE#
								            #VTYPETEXT#
								            fieldStyle: '#INPUTFORMATB#'
								            
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
								            margin: #MARGIN#,
								            padding: #PADDING#,
								            border: '#BORDER#',
								            style: '#STYLE#',
								            id: #INPUTID#,readOnly: #ISREADONLY#,value: '#INPUTVALUE#',
								            #VALIDATIONTYPE#
								            #VTYPETEXT#
								            labelStyle: '#INPUTFORMATB#'
								            
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
								            margin: #MARGIN#,
								            padding: #PADDING#,
								            border: '#BORDER#',
								            style: '#STYLE#',
								            id: #INPUTID#,readOnly: #ISREADONLY#,value: '#INPUTVALUE#',
								            renderer: '#RENDERER#',
								            fieldStyle: '#INPUTFORMATB#'
								            
								        }" >
								        
					<cfset arrayappend(evaluate("items#COLUMNGROUP#"), groupItems) >
					<cfset "groupStruct.__#COLUMNGROUP#" =  evaluate("items#COLUMNGROUP#") >
					
				<cfelseif XTYPE EQ "filefield"> <!---filefield--->
					<cfset withfileField = "true" >
					<cfset fileCount = fileCount + 1 >
					
					<cfset groupItems ="{
											xtype: 'filefield',value: '#INPUTVALUE#',fieldLabel: '#FIELDLABEL#',name: 'file#fileCount#',#XPOSITION##YPOSITION##ANCHORPOSITION#
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
								            margin: #MARGIN#,
								            padding: #PADDING#,
								            border: '#BORDER#',
								            style: '#STYLE#',
								            id: #INPUTID#,readOnly: #ISREADONLY#,
								            #VALIDATIONTYPE#
								            #VTYPETEXT#
								            fieldStyle: '#INPUTFORMATB#'
								            
								        },{
								        	xtype: 'hiddenfield',//for file////please do not remove 
								        	name: '#LEVELID#__#TABLENAME#__#COLUMNNAME#',
								        	value: 'forfileonlyaaazzz#TABLENAME#__#fileCount#',
								        	fieldLabel: '#FIELDLABEL#', 
								        	#XPOSITION#
								            #YPOSITION#
								            #ANCHORPOSITION#
								            hidden: #ISHIDDEN#,
								            labelAlign: '#FIELDLABELALIGN#',
								            #FIELDLABELWIDTH#
								            css: '#CSSCLASS#',
								            disabled: #ISDISABLED#,
								            #HEIGHT#
								            #WIDTH#
								            minLength: #MINCHARLENGTH#,
								            maxLength: #MAXCHARLENGTH#,
								            margin: #MARGIN#,
								            padding: #PADDING#,
								            border: '#BORDER#',
								            style: '#STYLE#',
								            #VALIDATIONTYPE#
								            #VTYPETEXT#
								            fieldStyle: '#INPUTFORMATB#'
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
								            margin: #MARGIN#,
								            padding: #PADDING#,
								            border: '#BORDER#',
								            style: '#STYLE#',
								            id: #INPUTID#,readOnly: #ISREADONLY#,value: '#INPUTVALUE#',
								            fieldStyle: '#INPUTFORMATB#'
								            
								        }" >
								        
					 <cfset arrayappend(evaluate("items#COLUMNGROUP#"), groupItems) >
					 <cfset "groupStruct.__#COLUMNGROUP#" =  evaluate("items#COLUMNGROUP#") >
					
				<cfelseif XTYPE EQ "id"> <!---id textfield--->
				
					<cfset groupItems ="{
											xtype: 'textfield',//used to convert to display field 
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
								            margin: #MARGIN#,
								            padding: #PADDING#,
								            border: '#BORDER#',
								            style: '#STYLE#',
								            id: #INPUTID#,readOnly: #ISREADONLY#,value: '#INPUTVALUE#',
								            #VALIDATIONTYPE#
								            #VTYPETEXT#
								            fieldStyle: '#INPUTFORMATB#'
								            
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
															cls: #INPUTID#,readOnly: #ISREADONLY#,inputValue: '#listgetat(checklist,2)#',
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
															cls: #INPUTID#,readOnly: #ISREADONLY#,inputValue: '#listgetat(checklist,2)#',
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
					<cfset minchars = ''> 
					<cfset pagesize = '' >
					
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
						
						<cfset minchars = 'minChars: 1,'> 
						<cfset pagesize = 'pageSize: 30,' >
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
											timeout: 300000,
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
											#minchars#
											#pagesize#
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
								            margin: #MARGIN#,
								            padding: #PADDING#,
								            border: '#BORDER#', 
								            style: '#STYLE#',
								            id: #INPUTID#,readOnly: #ISREADONLY#,value: '#INPUTVALUE#',
								            #VALIDATIONTYPE#
								            #VTYPETEXT#
								            fieldStyle: '#INPUTFORMATB#'
								            
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
		
		<cfset listeners = "listeners: {
								beforeaction: function(thiss, action) {
								  var win = eForm.up('window');
								  var commentfield = win.down('textfield[name=commentsxxx]');
								  var commentValue = commentfield.getValue();
								  eForm.getForm().baseParams.comments = commentValue;
								 // Ext.apply(eForm.getForm().baseParams, {comments: commentValue});
								}
							}" >
		
	<cfset pointcnt = 1 >	
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
			
			<cfif pointcnt eq 1 >
			<cfelse>
				<cfset fileParams = "" >
				<cfset extraFields = "" >
			</cfif>
			
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
			        	#extraFields#
			        ]
			        }" >
			 <cfset fcnt = fcnt + 1 >
			 <cfset pointcnt = 2 >
		</cfloop>
		
	<cfset groupFieldsAll = ArrayToList(theFieldSet, ",") >	
	
		<cfset formScript = "
							#stores#
							#vtypes#
							var eForm = Ext.create('Ext.form.Panel',{
								padding: '#formpadding#', 
								baseParams: {
									comments: ''
								},
							   	items: [
							    	#groupFieldsAll# 
								],
								#listeners#," >
							
							
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
			
			<cfif pointcnt eq 1 >
			<cfelse>
				<cfset fileParams = "" >
				<cfset extraFields = "" >
			</cfif>
			
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
			        	#extraFields#
			        ]
			        }" >
			 <cfset fcnt = fcnt + 1 >
			 <cfset pointcnt = 2 >
		</cfloop>
		
	<cfset groupFieldsAll = ArrayToList(theFieldSet, ",") >	
	
		<cfset formScript = "
							#stores#
							#vtypes#
							var eForm = Ext.create('Ext.form.Panel',{
								padding: '#formpadding#', 
								baseParams: {
									comments: ''
								},
							   	items: [
							    	#groupFieldsAll# 
								],
								#listeners#," >
							
	
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
			
			<cfif pointcnt eq 1 >
			<cfelse>
				<cfset fileParams = "" >
				<cfset extraFields = "" >
			</cfif>
			
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
			        	#extraFields#
			        ]
			        }" >
			 <cfset fcnt = fcnt + 1 >
			 <cfset pointcnt = 2 >
		</cfloop>
		
	<cfset groupFieldsAll = ArrayToList(theFieldSet, ",") >	
		<cfset formScript = "
							#stores#
							#vtypes#
							var eForm = Ext.create('Ext.form.Panel',{
								padding: '#formpadding#', 
								baseParams: {
									comments: ''
								},
							   	items: [
							    	#groupFieldsAll# 
								],
								#listeners#," >
							
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
			
			<cfif pointcnt eq 1 >
			<cfelse>
				<cfset fileParams = "" >
				<cfset extraFields = "" >
			</cfif>
			
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
			        	#extraFields#
			        ]
			        }" >
			 <cfset fcnt = fcnt + 1 >
			 <cfset pointcnt = 2 >
		</cfloop>
		
	<cfset groupFieldsAll = ArrayToList(theFieldSet, ",") >	
		<cfset formScript = "
							#stores#
							#vtypes#
							var eForm = Ext.create('Ext.form.Panel',{
								padding: '#formpadding#', 
								baseParams: {
									comments: ''
								},
							   	items: [
							    	#groupFieldsAll# 
								],
								#listeners#," >
	
													
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
			
			<cfif pointcnt eq 1 >
			<cfelse>
				<cfset fileParams = "" >
				<cfset extraFields = "" >
			</cfif>
			
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
			        	#extraFields#
			        ]
			        }" >
			 <cfset fcnt = fcnt + 1 >
			 <cfset pointcnt = 2 >
		</cfloop>
		
	<cfset groupFieldsAll = ArrayToList(theFieldSet, ",") >	
	
		<cfset formScript = "
							#stores#
							#vtypes#
							var eForm = Ext.create('Ext.form.Panel',{
								padding: '#formpadding#', 
								baseParams: {
									comments: ''
								},
							   	items: [
							    	#groupFieldsAll# 
								],
								#listeners#," >
							
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
			
			<cfif pointcnt eq 1 >
			<cfelse>
				<cfset fileParams = "" >
				<cfset extraFields = "" >
			</cfif>
			
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
			        	#extraFields#
			        ]
			        }" >
			 <cfset fcnt = fcnt + 1 >
			 <cfset pointcnt = 2 >
		</cfloop>
		
	<cfset groupFieldsAll = ArrayToList(theFieldSet, ",") >	
	
		<cfset formScript = "
							#stores#
							#vtypes#
							var eForm = Ext.create('Ext.form.Panel',{
								padding: '#formpadding#', 
								baseParams: {
									comments: ''
								},
							   	items: [
							    	#groupFieldsAll# 
								],
								#listeners#," >	 					
	
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
			
			<cfif pointcnt eq 1 >
			<cfelse>
				<cfset fileParams = "" >
				<cfset extraFields = "" >
			</cfif>
			
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
			        	#extraFields#
			        ]
			        }" >
			 <cfset fcnt = fcnt + 1 >
			 <cfset pointcnt = 2 >
		</cfloop>
		
	<cfset groupFieldsAll = ArrayToList(theFieldSet, ",") >	
	
		<cfset formScript = "
							#stores#
							#vtypes#
							var eForm = Ext.create('Ext.form.Panel',{
								padding: '#formpadding#',
								baseParams: {
									comments: ''
								}, 
							   	items: [
							    	#groupFieldsAll# 
								],
								#listeners#," >
	
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
			
			<cfif pointcnt eq 1 >
			<cfelse>
				<cfset fileParams = "" >
				<cfset extraFields = "" >
			</cfif>
			
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
			        	#extraFields#
			        ]
			        }" >
			 <cfset fcnt = fcnt + 1 >
			 <cfset pointcnt = 2 >
		</cfloop>
		
	<cfset groupFieldsAll = ArrayToList(theFieldSet, ",") >	
	
		<cfset formScript = "
							#stores#
							#vtypes#
							var eForm = Ext.create('Ext.form.Panel',{
								padding: '#formpadding#', 
								baseParams: {
									comments: ''
								},
							   	items: [
							    	#groupFieldsAll# 
								],
								#listeners#," >
							
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
			
			<cfif pointcnt eq 1 >
			<cfelse>
				<cfset fileParams = "" >
				<cfset extraFields = "" >
			</cfif>
			
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
			        	#extraFields#
			        ]
			        }" > 
			 <cfset fcnt = fcnt + 1 >
			 <cfset pointcnt = 2 >
		</cfloop>
		
	<cfset groupFieldsAll = ArrayToList(theFieldSet, ",") >	
	
		<cfset formScript = "
							#stores#
							#vtypes#
							var eForm = Ext.create('Ext.form.Panel',{
								padding: '#formpadding#', 
								baseParams: {
									comments: ''
								},
								layout: 'anchor',
								id: 'id__#eformid#',
							   	items: [
							    	#groupFieldsAll# 
								],
								#listeners#," >
	
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
					   	paramOrder: ['eformid'],
					    buttons: [{
					    	text: 'Add',
					    	action: 'add',hidden: false,
					    	handler: function(thiss) {
					    		var theForm = thiss.up('form').getForm();
					    		console.log(theForm.getValues());
					    		if(theForm.isValid()) {
					    			theForm.submit({
					    				submitEmptyText: false,
					    				timeout: 300000,
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
								  			autoeFormGrid.getStore().load();
								  		}
						    		});
					    		} else {
					    			alert('Please provide correct value for each field!');
					    		}
					    		
					    	}
					    },{
					    	text: 'Save',
					    	action: 'save',hidden: false,
					    	handler: function(thiss) {
					    		var theForm = thiss.up('form').getForm();
					    		if(theForm.isValid()) {
					    			theForm.submit({
					    				submitEmptyText: false,
					    				timeout: 300000,
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
											autoeFormGrid.getStore().load();
								  		}
						    		});
					    		} else {
					    			alert('Please provide correct value for each field!');
					    		}
					    		
					    	}
					    },{
					    	text: 'Approve',
					    	action: 'approve',hidden: false,
					    	handler: function(thiss) {
					    	    var res = window.confirm('Approve?');
					    	    if(!res) {
					    	    	return false;
					    	    }
					    		var theForm = thiss.up('form').getForm();
					    		theForm.submit({
					    				submitEmptyText: false,
					    				timeout: 300000,
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
								  			formWindow.close();
								  			autoeFormGrid.getStore().load();
								  			var mainGrid = Ext.ComponentQuery.query('eformmainview');
								  			mainGrid[0].getStore().load();  
										}
						    		});
					    	}
					    },{
					    	text: 'Disapprove',
					    	action: 'disapprve',hidden: false,
					    	handler: function(thiss) {
					    		var res = window.confirm('Disapprove?');
					    	    if(!res) {
					    	    	return false;
					    	    }
					    		var theForm = thiss.up('form').getForm();
					    		if(theForm.isValid()) {
					    			theForm.submit({
					    				submitEmptyText: false,
					    				timeout: 300000,
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
											formWindow.close();
								  			autoeFormGrid.getStore().load();
								  			var mainGrid = Ext.ComponentQuery.query('eformmainview');
								  			mainGrid[0].getStore().load();  
								  		}
						    		});
					    		} else {
					    			alert('Please provide correct value for each field!');
					    		}
					    		
					    	}
					    },{text: 'Return to Originator',action: 'returntooriginator',hidden: false,handler: function(thiss) { var res = window.confirm('Return to Originator?');if(!res) {return false;   }var theForm = thiss.up('form').getForm();var approved = theForm.getValues().#firstlevel#__#firsttable#__APPROVED;if(approved == 'R') {alert('The form cannot be returned to the originator because he or she has no reponse yet.');return false; }if(theForm.isValid()) {theForm.submit({submitEmptyText: false,   timeout: 300000,waitMsg: 'Submitting, please wait',params: {eformid: '#eformid#',action: 'returntooriginator'},reset: true,failure: function(form, action){Ext.Msg.show({title: 'Technical problem.',msg: 'Our apology. We are having technical problems.',buttons: Ext.Msg.OK,icon: Ext.Msg.ERROR});console.log(action);},success: function(form, action){Ext.Msg.show({msg: 'Return to originator successful',buttons: Ext.Msg.OK});formWindow.close();autoeFormGrid.getStore().load();var mainGrid = Ext.ComponentQuery.query('eformmainview');mainGrid[0].getStore().load();  }});} else {alert('Please provide correct value for each field!');}}},{text: 'e-mail Form',action: 'emailform',hidden: false,handler: function(thiss) {var formPanel = thiss.up('form'); var panelContent = formPanel.getPanelContent();var emailForm = Ext.widget('eformemailwindow');var bodyEditor = emailForm.down('htmleditor');bodyEditor.setValue(panelContent);var windowTitle = thiss.up('window').title;var subjectF = emailForm.down('textfield[fieldLabel=Subject]');subjectF.setValue(windowTitle);emailForm.show();} },{text: 'Print',action: 'print',hidden: false,handler: function(thiss) { var formPanel = thiss.up('form');printerObj.print(formPanel);  } }] });var commentStore = Ext.create('Ext.data.Store', {fields: [{name: 'title', mapping: 'name'}, {name: 'lastPost', mapping: 'dateaction'},{name: 'excerpt', mapping: 'comments'}, {name: 'theaction', mapping: 'action'}],autoLoad: false,listeners: {beforeload: function(thiss,operation,eopts) {var selection = autoeFormGrid.getView().getSelectionModel().getSelection()[0];thiss.proxy.extraParams.personnelidno = selection.data.#firstlevel#__#firsttable#__PERSONNELIDNO; thiss.proxy.extraParams.processid     = selection.data.#firstlevel#__#firsttable#__PROCESSID; }},proxy: {type: 'direct',timeout: 300000,extraParams: {personnelidno: '__',processid: '__', },directFn: 'Ext.ss.lookup.getComment',paramOrder: ['limit', 'page', 'query', 'start', 'personnelidno', 'processid'],reader: {root: 'topics',totalProperty: 'totalCount'}  }});var formWindow = Ext.create('Ext.window.Window', { height: '100%', title: '#formtitle#',width: '100%',layout: 'fit', modal: true,items: eForm, bbar: [{xtype: 'textfield',fieldLabel: 'Comments',hidden: false,name: 'commentsxxx',value: '',width: '40%',maxlength: 250,padding: '4 10 4 4' },{xtype: 'combobox',name: 'commentslist',hidden: false,store: commentStore, typeAhead: false,minChars: 1,pageSize: 20,width: '40%',fieldLabel: 'View Comments',action: 'selecteduser',padding: '4 4 4 4',listConfig: {loadingText: 'Searching...', emptyText: 'No matching comments found.',/* Custom rendering template for each item*/getInnerTpl: function() {  return '<h3>{title} <span style=\'float: right; font-size: .7em;\'>{lastPost}<br>{theaction}</span><br/></h3>{excerpt}';  } },}]}).show();" > 
					
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
	<cftry>
	<cfset formScript = "empty" >
	<cfset processData = EntityLoad("EGRGEFORMS", #eformid#, true ) >
	<cfset formScript = processData.getLAYOUTQUERY() > 

	<cfreturn formScript >
	<cfcatch>
		<cfreturn cfcatch.detail & ' ' & cfcatch.message >
	</cfcatch>
	</cftry>
</cffunction>



</cfcomponent>