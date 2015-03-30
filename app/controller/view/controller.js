Ext.define('Form.controller.view.controller', {
    extend: 'Ext.app.Controller',
	views: [
        'view.formflowprocess',
		'view.formflowactivitydetail',
		'view.newprocesswin',
		'view.formrouter',
		'view.formrouterdetail',  
		'view.formrouterapprover',
		'view.newapproverwin'
    ],
	models: [
		'view.formflowprocessmodel', 
		'view.groupmodel',
		'view.linkmodel',
		'view.actionmodel',
		'view.formroutermodel',
		'view.formapprovermodel',
		'view.conditionmodel',
		'view.namemodel',
		'view.rolemodel'
	],
	stores: [
		'view.formflowprocessstore',
		'view.groupstore',
		'view.linkstore',
		'view.actionstore',
		'view.formrouterstore',
		'view.formapproverstore',
		'view.conditionstore',
		'view.namestore',
		'view.rolestore'
	],
	
    init: function() {
		console.log('init controller');
        this.control({
            
			'formflowform rect[name=rect1]': {
				click: this.drawRouter
				
			},
			
			'formflowform button[action=load]': {
				click: function(button) {
					var centerR = Ext.ComponentQuery.query('viewport panel[region=center], viewport')[0];
					centerR.getLayout().setActiveItem(0);
				}
			},
			
			'formGrid button[action=viewactivities]': {
				click: this.turnToProcessActivity
			},
			
			'formGrid button[action=newprocess]': {
				click: this.showNewProcessWindow
			},
			
			'formGrid button[action=copyprocess]': {
				click: this.copyProcess
			},
			
			'formGrid button[action=deleteprocess]': {
				click: this.deleteProcess
			},
			
			'formGrid button[action=viewsampdiagram]': {
				click: this.previewMap
			},
			
			'formRouter button[action=viewsampdiagram]': {
				click: this.previewMapR
			},
			
			'formApproverGrid button[action=viewsampdiagram]': {
				click: this.previewMapA
			},
			
			'formRouter button[action=backtoprocess]': {
				click: this.turnToMainProcess
			},
			
			'formRouter button[action=viewdetailedactivity]': {
				click: this.turnToDetailedActivity
			},
			'formRouter button[action=newrouter]': {
				click: this.newRouter
			},  
			'formRouter button[action=viewdetailesrouter]': {
				click: this.viewRouter
			},
			'formRouter button[action=deleterouter]': {
				click: this.deleteRouter
			},
			
			'processwin button[action=submit]': {
				click: this.saveProcess
			},
			'routerForm button[action=backtorouter]': {
				click: this.turnToProcessRouter
			},
			'routerForm button[action=submitRouter]': {
				click: this.submitRouterRec
			},
			
			'routerForm button[action=saverouterdetail]': {
				click: this.saveRouterRec
			},
			
			'formRouter button[action=viewapprovers]': {
				click: this.turnToApproverUser
			}, 
			
			'formApproverGrid button[action=newapprover]': {
				click: this.showNewApproverWindow
			},
			
			'formApproverGrid button[action=backtorouter]': {
				click: this.turnToProcessRouter
			}, 
			
			'formApproverGrid button[action=deleteapprover]': {
				click: this.deleteApprover
			},
			
			'approverwin button[action=submit]': {
				click: this.submitApprover
			}
			
			
		
        });
    },
	

	
	previewMap: function(btn) {
		var cardlayout = btn.up('viewport');
		var processGrid = cardlayout.down('formGrid');
		var selectedRecord = processGrid.getSelectionModel().getSelection()[0];
		if(selectedRecord) {
			var myMask = Ext.create('Ext.LoadMask',{
				target: processGrid,
				msg: "Opening, please wait..."
			});
		    myMask.show();
			Ext.aa.preview.generateMap(selectedRecord.data.PROCESSID, function(result) {
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
	
	previewMapR: function(btn) {
		var cardlayout = btn.up('viewport');
		var processGrid = cardlayout.down('formGrid');
		var selectedRecord = processGrid.getSelectionModel().getSelection()[0];
		if(selectedRecord) {
			var RView = cardlayout.down('formRouter');
			var myMask = Ext.create('Ext.LoadMask',{
				target: RView,
				msg: "Opening, please wait..."
			});
		    myMask.show();
			Ext.aa.preview.generateMap(selectedRecord.data.PROCESSID, function(result) {
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
	
	previewMapA: function(btn) {
		var cardlayout = btn.up('viewport');
		var processGrid = cardlayout.down('formGrid');
		var selectedRecord = processGrid.getSelectionModel().getSelection()[0];
		if(selectedRecord) {
			var AView = cardlayout.down('formApproverGrid');
			var myMask = Ext.create('Ext.LoadMask',{
				target: AView,
				msg: "Opening, please wait..."
			});
		    myMask.show();
			Ext.aa.preview.generateMap(selectedRecord.data.PROCESSID, function(result) {
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
	
	copyProcess: function(btn) {
	
		var cardlayout = btn.up('viewport');
		var processGrid = cardlayout.down('formGrid');
		var selectedRecord = processGrid.getSelectionModel().getSelection()[0];
		if(selectedRecord) {
			var myMask = new Ext.LoadMask(processGrid, {msg:"Copying, please wait..."});
	        myMask.show();
			
			processGrid.store.insert(0, selectedRecord);
			var PROCESSID = selectedRecord.data.PROCESSID;
			var GROUPNAME = selectedRecord.data.GROUPNAME;
			var PROCESSNAME = selectedRecord.data.PROCESSNAME;
			var DESCRIPTION = selectedRecord.data.DESCRIPTION;
			var EFORMLIFE = selectedRecord.data.EFORMLIFE;
			var EXPIREDACTION = selectedRecord.data.EXPIREDACTION;
			
			Ext.aa.data.CreateNow(PROCESSID, GROUPNAME, PROCESSNAME + '_copy', DESCRIPTION, EFORMLIFE, EXPIREDACTION, function(result) {
				myMask.hide();
				processGrid.store.load();
			});
		} else {
			alert('Please select a record first!');
		}
		
	},
	
	submitApprover: function(btn) {
		var win = btn.up('window');
		var theForm = win.down('form');
		var cardlayout = Ext.ComponentQuery.query('viewport');
		var formRouterGrid = cardlayout[0].down('formRouter');
		var selectedRecord = formRouterGrid.getSelectionModel().getSelection()[0];
		var processid = selectedRecord.data.PROCESSIDFK;
		var routerid  = selectedRecord.data.ROUTERID;
		if(theForm.getForm().isValid()){
			theForm.getForm().submit({
				waitMsg: 'Saving, please wait...',
				params: {
					PROCESSIDFK: processid,
					ROUTERIDFK: routerid
				},
				reset: true,
			  		failure: function(form, action){  
			  			//see app-wide error handler
			  		},
			  		success: function(form, action){
			  			Ext.Msg.show({
			  				msg: 'Added successfully!',
			  				buttons: Ext.Msg.OK
			  			});
						
						var approverGrid = cardlayout[0].down('formApproverGrid');
						var approverStore = approverGrid.getStore();
						
						approverStore.load({
							params: {
								processid: processid,
								routerid: routerid
							}
						});
						approverStore.proxy.extraParams.processid = processid;
						approverStore.proxy.extraParams.routerid = routerid;
						
						
			  		}
			});	
		}
	},
	
	saveRouterRec: function(btn) {
		var theForm = btn.up('form');
		var processid = theForm.getForm().getValues().PROCESSIDFK;
		if(theForm.getForm().isValid()){
			theForm.getForm().submit({
				params: {
					actiontype: 'update'
				},
				waitMsg: 'Saving, please wait...',
				reset: true,
			  		failure: function(form, action){  
			  			//see app-wide error handler
			  		},
			  		success: function(form, action){
			  			Ext.Msg.show({
			  				msg: 'Updated successfully!',
			  				buttons: Ext.Msg.OK
			  			});
						var cardlayout = btn.up('viewport');
						var therouterGrid = cardlayout.down('formRouter');
						var routerStore = therouterGrid.getStore();
						
						
						routerStore.load({
							params: {
								processid: processid
							}
						});
						routerStore.proxy.extraParams.processid = processid;
						
			  		}
			});	
		}
	},
	submitRouterRec: function(btn) {
		var theForm = btn.up('form');
		var processid = theForm.getForm().getValues().PROCESSIDFK;
		if(theForm.getForm().isValid()){
			theForm.getForm().submit({
				params: {
					actiontype: 'add'
				},
				waitMsg: 'Saving, please wait...',
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
						var therouterGrid = cardlayout.down('formRouter');
						var routerStore = therouterGrid.getStore();
						routerStore.load({
							params: {
								processid: processid
							}
						});
						routerStore.proxy.extraParams.processid = processid;
						
			  		}
			});	
		}
	},
	
	newRouter: function(btn) {
		var cardlayout = btn.up('viewport');
		var centerR = Ext.ComponentQuery.query('viewport panel[region=center], viewport')[0];
		centerR.getLayout().setActiveItem(2);
		
		var processGrid = cardlayout.down('formGrid');
		var selectedRecord = processGrid.getSelectionModel().getSelection()[0];
		var processid = selectedRecord.data.PROCESSID;
		
		var theprocessidtextField = cardlayout.down('routerForm textfield[name=PROCESSIDFK]');
		theprocessidtextField.setValue(processid);
		
		var theFormButton = cardlayout.down('routerForm button[action=saverouterdetail]');
		theFormButton.setDisabled(true);
		
	},
	
	viewRouter: function(btn) {
		var cardlayout = btn.up('viewport');
		var centerR = Ext.ComponentQuery.query('viewport panel[region=center], viewport')[0];
		centerR.getLayout().setActiveItem(2);
		
		var processGrid = cardlayout.down('formGrid');
		var selectedRecord = processGrid.getSelectionModel().getSelection()[0];
		var processid = selectedRecord.data.PROCESSID;
		
		var formRouterGrid = cardlayout.down('formRouter');
		var selectedRecord = formRouterGrid.getSelectionModel().getSelection()[0];
		var routerGridData = selectedRecord.data;
		//console.log(routerGridData);
		var therouterForm = cardlayout.down('routerForm');
		//console.log(therouterForm.getForm());
		therouterForm.getForm().setValues(routerGridData);
		
		var theFormButton = cardlayout.down('routerForm button[action=saverouterdetail]');
		theFormButton.setDisabled(false);
	},
	
	deleteProcess: function(btn) {
		var confirm = window.confirm('Are you sure you want to delete the selected process? \n Note: Process with routers cannot be removed.');
		if (confirm) {
			var thisgrid = btn.up('grid');
			var selection = thisgrid.getView().getSelectionModel().getSelection();
			if (selection) {
				thisgrid.store.remove(selection);
			}
		}
	},
	
	deleteRouter: function(btn) {
		var confirm = window.confirm('Are you sure you want to delete the selected router? \n Note: Routers with approvers cannot be removed.');
		if (confirm) {
			var thisgrid = btn.up('grid');
			var selection = thisgrid.getView().getSelectionModel().getSelection();
			if (selection) {
				thisgrid.store.remove(selection);
			}
		}
	},
	
	deleteApprover: function(btn) {
		var confirm = window.confirm('Are you sure you want to delete the selected approver?');
		if (confirm) {
			var thisgrid = btn.up('grid');
			var selection = thisgrid.getView().getSelectionModel().getSelection();
			if (selection) {
				thisgrid.store.remove(selection);
			}
		}
	},
	
	showNewProcessWindow: function(btn) {
		var pwin = Ext.widget('processwin');
		pwin.show();
	},
	
	showNewApproverWindow: function(btn) {
		var awin = Ext.widget('approverwin');
		awin.show();
	},
	
	saveProcess: function(btn) {
		var thisform = btn.up('window');
		var insideForm = thisform.down('form');
		if(insideForm.getForm().isValid()) {
			var goupname = thisform.down('combobox[name=GROUPNAME]').getValue();
			var procname = thisform.down('textfield[name=PROCESSNAME]').getValue();
			var description = thisform.down('textfield[name=DESCRIPTION]').getValue();
			var eformlife = thisform.down('numberfield[name=EFORMLIFE]').getValue();
			var expirationaction = thisform.down('combobox[name=EXPIREDACTION]').getValue();
				Ext.aa.data.newProcess(goupname, procname, description, eformlife, expirationaction, function(result) {
					thisform.close();
					var pgrid = Ext.widget('formGrid');  
					pgrid.store.load();
				});
			}
		
	},
	turnToProcessRouter: function(btn) {
		var centerR = Ext.ComponentQuery.query('viewport panel[region=center], viewport')[0];
		centerR.getLayout().setActiveItem(1);
	},
	
	viewApprovers: function(btn) {
		var centerR = Ext.ComponentQuery.query('viewport panel[region=center], viewport')[0];
		centerR.getLayout().setActiveItem(3);
	},
	
	turnToProcessActivity: function(button) {
		var processGrid = button.up('grid');
		var selectedRecord = processGrid.getSelectionModel().getSelection()[0];
		if (selectedRecord) {
			var processid = selectedRecord.data.PROCESSID;
			
			var cardlayout = button.up('viewport');
			var therouterGrid = cardlayout.down('formRouter');
			var routerStore = therouterGrid.getStore();
			routerStore.load({
				params: {
					processid: processid
				}
			});
			routerStore.proxy.extraParams.processid = processid;
			var centerR = Ext.ComponentQuery.query('viewport panel[region=center], viewport')[0];
			centerR.getLayout().setActiveItem(1);
		} else {
			alert('Please select a record first!');
		}
	},
	
	turnToApproverUser: function(button) {
		var cardlayout = Ext.ComponentQuery.query('viewport');
		var formRouterGrid = cardlayout[0].down('formRouter');
		var selectedRecord = formRouterGrid.getSelectionModel().getSelection()[0];
		
		if (selectedRecord) {
			var processid = selectedRecord.data.PROCESSIDFK;
			var routerid  = selectedRecord.data.ROUTERID;
			
			var formApproverGrid = cardlayout[0].down('formApproverGrid');
			var routerStore = formApproverGrid.getStore();
			routerStore.load({
				params: {
					processid: processid,
					routerid: routerid
				}
			});
			routerStore.proxy.extraParams.processid = processid;
			routerStore.proxy.extraParams.routerid = routerid;
			var centerR = Ext.ComponentQuery.query('viewport panel[region=center], viewport')[0];
			centerR.getLayout().setActiveItem(3);
		} else {
			alert('Please select a record first!');
		}
	},
	
	turnToMainProcess: function(button) {
		var centerR = Ext.ComponentQuery.query('viewport panel[region=center], viewport')[0];
		centerR.getLayout().setActiveItem(0);
	},
	
	turnToDetailedActivity: function(button) {
		var centerR = Ext.ComponentQuery.query('viewport panel[region=center], viewport')[0];
		centerR.getLayout().setActiveItem(2);
	},
	 
	drawRouter: function(rect) {
		
		console.log(rect);
	}
	 
});