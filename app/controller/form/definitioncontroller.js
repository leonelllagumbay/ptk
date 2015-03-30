Ext.define('Form.controller.form.definitioncontroller', {
    extend: 'Ext.app.Controller',
	
	views: [
        'form.defMainView',
		'form.defMainDetailsView',
		'form.defTableView',
		'form.defTableDetailsView',
		'form.defColumnView',
		'form.defColumnDetailsView',
		'form.defNewMainWindow',
		'form.defTableDetailsView',
		'form.defCopyTableTo',
		'form.defPrint',
		'form.eformEmailWindow'
    ],
	models: [
		'form.defMainModel',
		'form.defTableModel',
		'form.defColumnModel',
		'form.maingroupmodel',
		'form.mainprocessmodel',
		'form.filemodel',
		'form.tabletypemodel',
		'form.levelidmodel',
		'form.eformnamemodel',
		'form.fieldtypemodel',
		'form.columngroupmodel',
		'form.columntypemodel'
	],
	stores: [
		'form.defMainStore',
		'form.defTableStore',
		'form.defColumnStore',
		'form.maingroupstore',
		'form.mainprocessstore',
		'form.beforeloadstore',
		'form.afterloadstore',
		'form.beforesubmitstore',
		'form.aftersubmitstore',
		'form.beforeapprovestore',
		'form.afterapprovestore',
		'form.oncompletestore',
		'form.tabletypestore',
		'form.levelidstore',
		'form.eformnamestore',
		'form.fieldtypestore',
		'form.columngroupstore',
		'form.viewasstore',
		'form.columntypestore'
	],
	
    init: function() {
		console.log('init controller');
        this.control({
            
			'defmainview button[action=viewtables]': {  
				click: this.turnToTables
			},
			'defmainview button[action=neweform]': {  
				click: this.newMaineForm
			},
			'defmainview button[action=copyeform]': {  
				click: this.copyMaineForm
			},
			'defmainview button[action=deleteeform]': {
				click: this.deleteMaineForm
			}, 
			'defmainview button[action=generatescript]': {
				click: this.generateScript 
			},
			'defmainview button[action=formpreview]': {
				click: this.previewForm 
			},
			'defmainview button[action=printPanel]': {
				click: this.printPanelTest
			}, 
			
			
			'defnewmainwindow button[action=submit]': {
				click: this.submitMainRec
			},
			'deftableview button[action=backtoeformmanager]': {
				click: this.turnToeFormManager
			},
			'deftableview button[action=viewcolumns]': {
				click: this.turnToColumns
			}, 
			'deftableview button[action=newtable]': {
				click: this.openTableDetailsView
			},
			'deftableview button[action=copytable]': {
				click: this.copySelectedTable
			},
			'deftableview button[action=deletetable]': {
				click: this.deleteTable 
			},
			'deftableview button[action=copytableto]': {
				click: this.openCopyTableTo 
			},
			
			'defcopytableto button[action=submit]': {
				click: this.submitCopyTableTo 
			},
			
			
			'defcolumnview button[action=backtoeformtables]': {
				click: this.turnToTablesNoLoad
			},
			'deftabledetailsview button[action=submit]': {
				click: this.newTableDetailsView
			},
			
			'defcolumndetailsview button[action=backtoeformcolumns]': {
				click: this.backToeFormColumns
			},  
			'defcolumndetailsview button[action=submitRouter]': {
				click: this.submitColumnsDetails
			}, 
			'defcolumndetailsview button[action=saverouterdetail]': {
				click: this.updateColumnsDetails
			}, 
			
			'defcolumnview button[action=newcolumn]': {
				click: this.turnToColumnDetails
			},
			
			'defcolumnview button[action=editeform]': {
				click: this.turnToEditColumnDetails
			}, 
			
			'defcolumnview button[action=deletecolumn]': {
				click: this.deleteColumn
			},  
			'defcolumndetailsview combobox[name=XTYPE]': {
				change: this.fieldTypeChanged
			},
			'defcolumndetailsview radiogroup[name=SELECTDATA]': {
				change: this.comboSelected
			},
			'eformemailwindow button[action=sendnow]': {
				click: this.sendEmailForm
			},
			
			'defcolumnview button[action=generatescript]': {
				click: this.generateScriptC 
			},
			'defcolumnview button[action=formpreview]': {
				click: this.previewFormC
			},
			'defcolumnview button[action=applydefaultfields]': {
				click: this.applyDefaultFields
			},
			'defnewmainwindow button[action=showadvopt]': {
				click: this.showAdvancedOptions
			},
			'defnewmainwindow checkboxfield[name=ENABLEAUDITTRAIL]': {
				change: this.auditTrailChanged
			},
			'defnewmainwindow checkboxfield[name=ENABLEEFORMLOGGING]': {
				change: this.loggingChanged
			},
			'defnewmainwindow radiofield[action=loggingtofile]': {
				change: this.loggingToFile
			},
			'defnewmainwindow radiofield[action=loggingtodb]': {
				change: this.loggingToDB
			} 
			 
			 
        });
    
	},
	
	loggingToFile: function(radioF)
	{
		var formRef = radioF.up('form');
		if(radioF.value == true) //checked
		{ 
			formRef.down('textfield[name=LOGFILENAME]').el.show();
		}
		else
		{
			var logfilename = formRef.down('textfield[name=LOGFILENAME]');
			
			logfilename.setValue("");
			logfilename.el.hide();
		}
	},
	
	loggingToDB: function(radioDB)
	{
		var formRef = radioDB.up('form');
		if(radioDB.value == true) //checked
		{ 
			formRef.down('textfield[name=LOGDBSOURCE]').el.show();
			formRef.down('textfield[name=LOGTABLENAME]').el.show();
		}
		else
		{
			var logdbsource = formRef.down('textfield[name=LOGDBSOURCE]');
			var logdbtablename = formRef.down('textfield[name=LOGTABLENAME]');
			
			logdbsource.setValue("");
			logdbsource.el.hide();
			logdbtablename.setValue("");
			logdbtablename.el.hide();
		}
	},
	
	loggingChanged: function(chkblog) 
	{
		var formRef = chkblog.up('form');
		if(chkblog.value == true) //checked
		{ 
			formRef.down('radiofield[action=loggingtofile]').el.show();
			formRef.down('radiofield[action=loggingtodb]').el.show();
		}
		else
		{
			var logDSRef = formRef.down('radiofield[action=loggingtofile]');
			var logTNRef = formRef.down('radiofield[action=loggingtodb]');
			
			logDSRef.setValue(false);
			logTNRef.setValue(false);
			logDSRef.el.hide();
			logTNRef.el.hide();
		}
	},
	
	auditTrailChanged: function(chkb) 
	{
		var formRef = chkb.up('form');
		if(chkb.value == true) //checked
		{ 
			formRef.down('textfield[name=AUDITTDSOURCE]').el.show();
			formRef.down('textfield[name=AUDITTNAME]').el.show();
		}
		else
		{
			var auditDSRef = formRef.down('textfield[name=AUDITTDSOURCE]');
			var auditTNRef = formRef.down('textfield[name=AUDITTNAME]');
			
			auditDSRef.setValue("");
			auditTNRef.setValue("");
			auditDSRef.el.hide();
			auditTNRef.el.hide();
		}
	},
	
	showAdvancedOptions: function(btn) 
	{
		var formRef = btn.up('form');
		var auditTrailOpt = formRef.down('checkboxfield[name=ENABLEAUDITTRAIL]');
		auditTrailOpt.el.show();
		formRef.down('checkboxfield[name=ENABLEEFORMLOGGING]').el.show();
		btn.hide();
		console.log(auditTrailOpt);
	},
	
	applyDefaultFields: function(btn) {
		var confirm = window.confirm('Are you sure you want to restore the default fields?');
		if (!confirm) {
			return false;
		} 
		var cardlayout = btn.up('viewport');
		var tableView = cardlayout.down('deftableview');
		var selectedRecord = tableView.getSelectionModel().getSelection()[0];
		
		var tableID   = selectedRecord.data.TABLEID;
		var eformIDFk = selectedRecord.data.EFORMIDFK;
		var tableName = selectedRecord.data.TABLENAME;
		
		var CView = cardlayout.down('defcolumnview');
		var myMask = Ext.create('Ext.LoadMask',{
			target: CView,
			msg: "Restoring fields, please wait..."
		});
		myMask.show();
		Ext.ss.applydefaultfield.applyDefaultFields(tableID, eformIDFk, tableName, function(result) {
			myMask.hide();
			CView.getStore().load();
			console.log(result);
		});
	},
	
	sendEmailForm: function(btn) {
		var theForm = btn.up('form');
		if(theForm.getForm().isValid()){
			theForm.getForm().submit({
				waitMsg: 'Sending, please wait...',
				timeout: 300000,
				reset: true,
			  		//Failure see app-wide error handler
			  		success: function(form, action){
			  			Ext.Msg.show({
			  				msg: 'Done!',
			  				buttons: Ext.Msg.OK
			  			});
					}
			});	
		}
	},
	
	printPanelTest: function(btn) {
		var cardlayout = btn.up('viewport');
		var mainView = cardlayout.down('eForm');
		
		alert('printing');
	},
	
	generateScriptC: function(btn) {
		var cardlayout = btn.up('viewport');
		var CView = cardlayout.down('defcolumnview');

		var mainView = cardlayout.down('defmainview');
		var selectedRecord = mainView.getSelectionModel().getSelection()[0];
		if(selectedRecord) {
			var myMask = Ext.create('Ext.LoadMask',{
				target: CView,
				msg: "Generating, please wait..."
			});
			myMask.show();
			var eformid = selectedRecord.data.EFORMID;
			Ext.ss.activate.generateGrid(eformid, function(result) {
				myMask.hide();
				if (result != "success")
				{
					alert(result);
				}
			});
		} else {
			alert('Please select a record first!');
		}
		
	},
	
	previewFormC: function(btn) {
		var cardlayout = btn.up('viewport');
		var CView = cardlayout.down('defcolumnview');
		var mainView = cardlayout.down('defmainview');
		var selectedRecord = mainView.getSelectionModel().getSelection()[0];
		if(selectedRecord) {
			var myMask = Ext.create('Ext.LoadMask',{
				target: CView,
				msg: "Generating, please wait..."
			});
			myMask.show();
			
			var eformid = selectedRecord.data.EFORMID;
			Ext.ss.activate.previewGrid(eformid, function(result) {
				myMask.hide(); 
				try {
					eval(result);
				} catch(err) {
					alert(err); 
				}
			});
		} else {
			alert('Please select a record first!');
		}
	},
	
	generateScript: function(btn) {
		var cardlayout = btn.up('viewport');
		var mainView = cardlayout.down('defmainview');
		var selectedRecord = mainView.getSelectionModel().getSelection()[0];
		if(selectedRecord) {
			var myMask = Ext.create('Ext.LoadMask',{
				target: mainView,
				msg: "Generating, please wait..."
			});
			myMask.show();
			var eformid = selectedRecord.data.EFORMID;
			Ext.ss.activate.generateGrid(eformid, function(result) {
				myMask.hide();
				if (result != "success")
				{
					alert(result);
				}
			});
		} else {
			alert('Please select a record first!');
		}
	},
	
	previewForm: function(btn) {
		var cardlayout = btn.up('viewport');
		var mainView = cardlayout.down('defmainview');
		var selectedRecord = mainView.getSelectionModel().getSelection()[0];
		if(selectedRecord) {
			
	        var myMask = Ext.create('Ext.LoadMask',{
				target: mainView,
				msg: "Opening, please wait..."
			});
		    myMask.show();
			
			var eformid = selectedRecord.data.EFORMID;
			Ext.ss.activate.previewGrid(eformid, function(result) {
				myMask.hide(); 
				try {
					eval(result);
				} catch(err) {
					alert(err); 
				}
			});
		} else {
			alert('Please select a record first!');
		}
	},
	
	comboSelected: function(thiss, val) {
		var theForm = thiss.up('form');
		if(val.combodata == 'local') {
			theForm.items.items[40].setVisible(true);
			theForm.items.items[41].setVisible(false);
		} else {
			theForm.items.items[40].setVisible(false);
			theForm.items.items[41].setVisible(true);
		}
	},
	
	fieldTypeChanged: function(thiscombo, newval, oldval) {
		
		
		var theForm = thiscombo.up('form');
		console.log(theForm.items);
		if(newval == 'textfield') {
			theForm.items.items[29].setVisible(false);
			theForm.items.items[30].setVisible(false);
			theForm.items.items[31].setVisible(false);
			theForm.items.items[32].setVisible(true);
			theForm.items.items[33].setVisible(true);
			theForm.items.items[34].setVisible(false);
			theForm.items.items[35].setVisible(false);
			theForm.items.items[36].setVisible(false);
			theForm.items.items[37].setVisible(true);
			theForm.items.items[38].setVisible(true);
			theForm.items.items[39].setVisible(false); 
			theForm.items.items[40].setVisible(false);
			theForm.items.items[41].setVisible(false);
		} else if(newval == 'datefield') {
			theForm.items.items[29].setVisible(false);
			theForm.items.items[30].setVisible(true);
			theForm.items.items[31].setVisible(true);
			theForm.items.items[32].setVisible(true);
			theForm.items.items[33].setVisible(true);
			theForm.items.items[34].setVisible(false);
			theForm.items.items[35].setVisible(false);
			theForm.items.items[36].setVisible(false);
			theForm.items.items[37].setVisible(true);
			theForm.items.items[38].setVisible(true);
			theForm.items.items[39].setVisible(false); 
			theForm.items.items[40].setVisible(false);
			theForm.items.items[41].setVisible(false);
		} else if(newval == 'timefield') {
			theForm.items.items[29].setVisible(false);
			theForm.items.items[30].setVisible(true);
			theForm.items.items[31].setVisible(true);
			theForm.items.items[32].setVisible(true);
			theForm.items.items[33].setVisible(true);
			theForm.items.items[34].setVisible(false);
			theForm.items.items[35].setVisible(false);
			theForm.items.items[36].setVisible(false);
			theForm.items.items[37].setVisible(true);
			theForm.items.items[38].setVisible(true);
			theForm.items.items[39].setVisible(false);
			theForm.items.items[40].setVisible(false);
			theForm.items.items[41].setVisible(false);
		} else if(newval == 'numberfield') {
			theForm.items.items[29].setVisible(false);
			theForm.items.items[30].setVisible(true);
			theForm.items.items[31].setVisible(true);
			theForm.items.items[32].setVisible(false);
			theForm.items.items[33].setVisible(false);
			theForm.items.items[34].setVisible(false);
			theForm.items.items[35].setVisible(false);
			theForm.items.items[36].setVisible(false);
			theForm.items.items[37].setVisible(true);
			theForm.items.items[38].setVisible(true);
			theForm.items.items[39].setVisible(false);
			theForm.items.items[40].setVisible(false);
			theForm.items.items[41].setVisible(false);
		} else if(newval == 'checkboxgroup') {
			theForm.items.items[29].setVisible(true);
			theForm.items.items[30].setVisible(false);
			theForm.items.items[31].setVisible(false);
			theForm.items.items[32].setVisible(false);
			theForm.items.items[33].setVisible(false);
			theForm.items.items[34].setVisible(true);
			theForm.items.items[35].setVisible(true);
			theForm.items.items[36].setVisible(true);
			theForm.items.items[37].setVisible(false);
			theForm.items.items[38].setVisible(false);
			theForm.items.items[39].setVisible(false);
			theForm.items.items[40].setVisible(false);
			theForm.items.items[41].setVisible(false);
		} else if(newval == 'radiogroup') {
			theForm.items.items[29].setVisible(true);
			theForm.items.items[30].setVisible(false);
			theForm.items.items[31].setVisible(false);
			theForm.items.items[32].setVisible(false);
			theForm.items.items[33].setVisible(false);
			theForm.items.items[34].setVisible(true);
			theForm.items.items[35].setVisible(true);
			theForm.items.items[36].setVisible(true);
			theForm.items.items[37].setVisible(false);
			theForm.items.items[38].setVisible(false);
			theForm.items.items[39].setVisible(false);
			theForm.items.items[40].setVisible(false);
			theForm.items.items[41].setVisible(false);
		} else if(newval == 'textareafield') {
			theForm.items.items[29].setVisible(false);
			theForm.items.items[30].setVisible(false);
			theForm.items.items[31].setVisible(false);
			theForm.items.items[32].setVisible(true);
			theForm.items.items[33].setVisible(true);
			theForm.items.items[34].setVisible(false);
			theForm.items.items[35].setVisible(false);
			theForm.items.items[36].setVisible(false);
			theForm.items.items[37].setVisible(true);
			theForm.items.items[38].setVisible(true);
			theForm.items.items[39].setVisible(false); 
			theForm.items.items[40].setVisible(false);
			theForm.items.items[41].setVisible(false);
		} else if(newval == 'htmleditor') {
			theForm.items.items[29].setVisible(false);
			theForm.items.items[30].setVisible(false);
			theForm.items.items[31].setVisible(false);
			theForm.items.items[32].setVisible(true);
			theForm.items.items[33].setVisible(true);
			theForm.items.items[34].setVisible(false);
			theForm.items.items[35].setVisible(false);
			theForm.items.items[36].setVisible(false);
			theForm.items.items[37].setVisible(true);
			theForm.items.items[38].setVisible(true);
			theForm.items.items[39].setVisible(false); 
			theForm.items.items[40].setVisible(false);
			theForm.items.items[41].setVisible(false);
		} else if(newval == 'displayfield') {
			theForm.items.items[29].setVisible(false);
			theForm.items.items[30].setVisible(false);
			theForm.items.items[31].setVisible(false);
			theForm.items.items[32].setVisible(false);
			theForm.items.items[33].setVisible(false);
			theForm.items.items[34].setVisible(false);
			theForm.items.items[35].setVisible(false);
			theForm.items.items[36].setVisible(false);
			theForm.items.items[37].setVisible(false);
			theForm.items.items[38].setVisible(false); 
			theForm.items.items[39].setVisible(false); 
			theForm.items.items[40].setVisible(false);
			theForm.items.items[41].setVisible(false);
		} else if(newval == 'filefield') {
			theForm.items.items[29].setVisible(false);
			theForm.items.items[30].setVisible(false);
			theForm.items.items[31].setVisible(false);
			theForm.items.items[32].setVisible(true);
			theForm.items.items[33].setVisible(true);
			theForm.items.items[34].setVisible(false);
			theForm.items.items[35].setVisible(false);
			theForm.items.items[36].setVisible(false);
			theForm.items.items[37].setVisible(true);
			theForm.items.items[38].setVisible(true);
			theForm.items.items[39].setVisible(false); 
			theForm.items.items[40].setVisible(false);
			theForm.items.items[41].setVisible(false);
		} else if(newval == 'hiddenfield') {
			theForm.items.items[29].setVisible(false);
			theForm.items.items[30].setVisible(false);
			theForm.items.items[31].setVisible(false);
			theForm.items.items[32].setVisible(true);
			theForm.items.items[33].setVisible(true);
			theForm.items.items[34].setVisible(false);
			theForm.items.items[35].setVisible(false);
			theForm.items.items[36].setVisible(false);
			theForm.items.items[37].setVisible(true);
			theForm.items.items[38].setVisible(true);
			theForm.items.items[39].setVisible(false); 
			theForm.items.items[40].setVisible(false);
			theForm.items.items[41].setVisible(false);
		} else if(newval == 'combobox') {
			theForm.items.items[29].setVisible(false);
			theForm.items.items[30].setVisible(false);
			theForm.items.items[31].setVisible(false);
			theForm.items.items[32].setVisible(true);
			theForm.items.items[33].setVisible(true);
			theForm.items.items[34].setVisible(false);
			theForm.items.items[35].setVisible(false);
			theForm.items.items[36].setVisible(false);
			theForm.items.items[37].setVisible(true);
			theForm.items.items[38].setVisible(true);
			theForm.items.items[39].setVisible(true); 
		} else if(newval == 'id') {
			theForm.items.items[29].setVisible(false);
			theForm.items.items[30].setVisible(false);
			theForm.items.items[31].setVisible(false);
			theForm.items.items[32].setVisible(true);
			theForm.items.items[33].setVisible(true);
			theForm.items.items[34].setVisible(false);
			theForm.items.items[35].setVisible(false);
			theForm.items.items[36].setVisible(false);
			theForm.items.items[37].setVisible(true);
			theForm.items.items[38].setVisible(true);
			theForm.items.items[39].setVisible(false); 
			theForm.items.items[40].setVisible(false);
			theForm.items.items[41].setVisible(false);
		} else {
			theForm.items.items[29].setVisible(true);
			theForm.items.items[30].setVisible(true);
			theForm.items.items[31].setVisible(true);
			theForm.items.items[32].setVisible(true);
			theForm.items.items[33].setVisible(true);
			theForm.items.items[34].setVisible(true);
			theForm.items.items[35].setVisible(true);
			theForm.items.items[36].setVisible(true);
			theForm.items.items[37].setVisible(true);
			theForm.items.items[38].setVisible(true);
			theForm.items.items[39].setVisible(true); 
			theForm.items.items[40].setVisible(false);
			theForm.items.items[41].setVisible(false);
		}
	},
	
	turnToColumnDetails: function(btn) {
		var cardlayout = btn.up('viewport');
		var centerR = Ext.ComponentQuery.query('viewport panel[region=center], viewport')[0];
		centerR.getLayout().setActiveItem(4);
		var theFormButton = cardlayout.down('defcolumndetailsview button[action=saverouterdetail]');
		theFormButton.setDisabled(true);
		
	},
	
	turnToEditColumnDetails: function(btn) {
		var cardlayout = btn.up('viewport');
		
		var thecolGrid = cardlayout.down('defcolumnview');
		var selectedRecord = thecolGrid.getSelectionModel().getSelection()[0];
		if(selectedRecord) {
			var thecolForm = cardlayout.down('defcolumndetailsview');
			thecolForm.getForm().setValues(selectedRecord.data);
			var centerR = Ext.ComponentQuery.query('viewport panel[region=center], viewport')[0];
			centerR.getLayout().setActiveItem(4);
			
			var theFormButton = cardlayout.down('defcolumndetailsview button[action=saverouterdetail]');
			theFormButton.setDisabled(false);
		} else {
			alert('Please select a record first!');
		}
	},
	
	backToeFormColumns: function(btn) {
		var cardlayout = btn.up('viewport');
		var centerR = Ext.ComponentQuery.query('viewport panel[region=center], viewport')[0];
		centerR.getLayout().setActiveItem(3);
	},
	
	updateColumnsDetails: function(btn) {
		var theForm = btn.up('form');
		if(theForm.getForm().isValid()){
			theForm.getForm().submit({
				params: {
					actiontype: 'update'
				},
				waitMsg: 'Saving, please wait...',
				timeout: 300000,
				submitEmptyText: false,
				reset: false,
			  		failure: function(form, action){
			  			//see app-wide error handler
			  		},
			  		success: function(form, action){
			  			Ext.Msg.show({
			  				msg: 'Updated successfully!',
			  				buttons: Ext.Msg.OK
			  			});
						var cardlayout = btn.up('viewport');
						var thecolGrid = cardlayout.down('defcolumnview');
						var colStore = thecolGrid.getStore();
						colStore.load(); 
						
			  		}
			});	
		}
	},
	
	submitColumnsDetails: function(btn) {  
		var theForm = btn.up('form');
		
		var cardlayout = Ext.ComponentQuery.query('viewport');
		var eformTMgr = cardlayout[0].down('deftableview');
		var selectedRecord = eformTMgr.getSelectionModel().getSelection()[0];
		var tableid = selectedRecord.data.TABLEID;
		   
		if(theForm.getForm().isValid()){
			theForm.getForm().submit({
				params: {
					actiontype: 'add',
					tableid: tableid
				},
				waitMsg: 'Saving, please wait...',
				timeout: 300000,
				submitEmptyText: false,
				reset: true,
			  		failure: function(form, action){
			  			//see app-wide error handler
			  		},
			  		success: function(form, action){
			  			Ext.Msg.show({
			  				msg: 'Added successfully!',
			  				buttons: Ext.Msg.OK
			  			});
						var cardlayout = btn.up('viewport');
						var thecolGrid = cardlayout.down('defcolumnview');
						var colStore = thecolGrid.getStore();
						colStore.load({
							params: {
								tableid: tableid
							}
						});
						colStore.proxy.extraParams.tableid = tableid;
						
			  		}
			});	
		}
	},
	
	
	openCopyTableTo: function(btn) {
		var cwin = Ext.widget('defcopytableto');
		cwin.show();
	},
	
	submitCopyTableTo: function(btn) {
		var cardlayout = Ext.ComponentQuery.query('viewport');
		
		var eformMgr = cardlayout[0].down('deftableview');
		var selectedRecord = eformMgr.getSelectionModel().getSelection()[0];
		if (selectedRecord) {
			var theForm = btn.up('form');
			theForm.getForm().setValues(selectedRecord.data);
			
			if (theForm.getForm().isValid()) {
				theForm.getForm().submit({
					waitMsg: 'Copying, please wait...',
					timeout: 300000,
					reset: true,
					failure: function(form, action){
						//see app-wide error handler
					},
					success: function(form, action){
						Ext.Msg.show({
							msg: 'Copied successfully!',
							buttons: Ext.Msg.OK
						});
						
						btn.up('window').close();
					}
				});
			}
		} else {
			alert('Please select a record first!');
		}
		
	},
	
	copySelectedTable: function(btn) {
		var cardlayout = btn.up('viewport');
		var tableView = cardlayout.down('deftableview');
		var selectedRecord = tableView.getSelectionModel().getSelection()[0];
		if(selectedRecord) {
			var myMask = Ext.create('Ext.LoadMask',{
				target: tableView,
				msg: "Copying, please wait..."
			});
	        myMask.show();
			
			Ext.ss.defdata.TableCreateNow(selectedRecord.data, function(result) {
				myMask.hide();
				tableView.store.load();
			});
		} else {
			alert('Please select a record first!');
		}
	},
	
	openTableDetailsView: function(btn) {
		var twin = Ext.widget('deftabledetailsview');
		twin.show();
	},
	
	newTableDetailsView: function(btn) {
		var cardlayout = Ext.ComponentQuery.query('viewport');
		var eformMgr = cardlayout[0].down('defmainview');
		var selectedRecord = eformMgr.getSelectionModel().getSelection()[0];
		var eformid = selectedRecord.data.EFORMID;
		
		var theForm = btn.up('form');
		theForm.getForm().setValues({
			EFORMIDFK: eformid
		});
		
		if(theForm.getForm().isValid()){
			theForm.getForm().submit({
				waitMsg: 'Adding, please wait...',
				timeout: 300000,
				reset: true,
			  		failure: function(form, action){
			  			//see app-wide error handler
			  		},
			  		success: function(form, action){
			  			Ext.Msg.show({
			  				msg: 'Added successfully!',
			  				buttons: Ext.Msg.OK
			  			});
						
						var cardlayout = Ext.ComponentQuery.query('viewport');
						var tView = cardlayout[0].down('deftableview');
						
						var tableStore = tView.store;
						 tableStore.load({
						 	params: {
								eformid: eformid
							}
						 });
						 tableStore.proxy.extraParams.eformid = eformid;
			  		}
			});	
		}
	},
	
	deleteMaineForm: function(btn) {
		var confirm = window.confirm('Are you sure you want to delete the selected eForm? \nNote: eForms with attached tables cannot be removed.');
		if (confirm) {
			var thisgrid = btn.up('grid');
			var selection = thisgrid.getView().getSelectionModel().getSelection();
			if (selection) {
				thisgrid.store.remove(selection);
			}
		} 
	},
	
	deleteTable: function(btn) {
		var confirm = window.confirm('Are you sure you want to delete the selected eForm table? \nNote: eForm tables with attached columns cannot be removed.');
		if (confirm) {
			var thisgrid = btn.up('grid');
			var selection = thisgrid.getView().getSelectionModel().getSelection();
			if (selection) {
				thisgrid.store.remove(selection);
			}
		} 
	},
	
	deleteColumn: function(btn) {  
		var confirm = window.confirm('Are you sure you want to delete the selected table field/s?');
		if (confirm) {
			var thisgrid = btn.up('grid');
			var selection = thisgrid.getView().getSelectionModel().getSelection();
			if (selection) {
				thisgrid.store.remove(selection);
			}
		} 
	},
	
	copyMaineForm: function(btn) {
		var cardlayout = btn.up('viewport');
		var mainGrid = cardlayout.down('defmainview');
		var selectedRecord = mainGrid.getSelectionModel().getSelection()[0];
		if(selectedRecord) {
			var myMask = Ext.create('Ext.LoadMask',{
				target: mainGrid,
				msg: "Copying, please wait..."
			});
			myMask.show();
			
			mainGrid.store.insert(0, selectedRecord);
			
			Ext.ss.defdata.CreateNow(selectedRecord.data, function(result) {
				myMask.hide();
				mainGrid.store.load();
			});
		} else {
			alert('Please select a record first!');
		}
	},
	
	newMaineForm: function(btn) {
		var mwin = Ext.widget('defnewmainwindow');
		mwin.show();
	},
	
	turnToTables: function(btn) {
		var cardlayout = btn.up('viewport');
		
		
		var eformMgr = cardlayout.down('defmainview');
		var selectedRecord = eformMgr.getSelectionModel().getSelection()[0];
		
		if(selectedRecord) {
			var tableview = cardlayout.down('deftableview');
			var tableStore = tableview.store;
			tableStore.load({
				params: {
					eformid: selectedRecord.data.EFORMID
				}
				
			});
			tableStore.proxy.extraParams.eformid = selectedRecord.data.EFORMID;
			
			var centerR = Ext.ComponentQuery.query('viewport panel[region=center], viewport')[0];
			centerR.getLayout().setActiveItem(2);
			
			
		} else {
			alert('Please select a record first!');
		}
	},
	turnToeFormManager: function(btn) {
		var cardlayout = btn.up('viewport');
		var centerR = Ext.ComponentQuery.query('viewport panel[region=center], viewport')[0];
		centerR.getLayout().setActiveItem(0);
	},
	turnToTablesNoLoad: function(btn) {
		var cardlayout = btn.up('viewport');
		var centerR = Ext.ComponentQuery.query('viewport panel[region=center], viewport')[0];
		centerR.getLayout().setActiveItem(2);
	},
	turnToColumns: function(btn) {
		var cardlayout = btn.up('viewport');
		var eformMgr = cardlayout.down('deftableview');
		var selectedRecord = eformMgr.getSelectionModel().getSelection()[0];
		
		if(selectedRecord) {
			var columnview = cardlayout.down('defcolumnview');
			var colStore = columnview.store;
			colStore.load({
				params: {
					tableid: selectedRecord.data.TABLEID
				}
				
			});
			colStore.proxy.extraParams.tableid = selectedRecord.data.TABLEID;
			var centerR = Ext.ComponentQuery.query('viewport panel[region=center], viewport')[0];
			centerR.getLayout().setActiveItem(3); 
		} else {
			alert('Please select a record first!');
		}
	},
	
	submitMainRec: function(btn) {
		var theForm = btn.up('form');
		if(theForm.getForm().isValid()){
			theForm.getForm().submit({
				waitMsg: 'Adding, please wait...',
				timeout: 300000,
				reset: true,
			  		failure: function(form, action){
			  			//see app-wide error handler
			  		},
			  		success: function(form, action){
			  			Ext.Msg.show({
			  				msg: 'Added successfully!',
			  				buttons: Ext.Msg.OK
			  			});
						var mainView = Ext.widget('defmainview');
						 mainView.getStore().load();
			  		}
			});	
		}
	}
	
	 
});