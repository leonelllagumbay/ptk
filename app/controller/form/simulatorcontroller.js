Ext.define('Form.controller.form.simulatorcontroller', {
    extend: 'Ext.app.Controller',
    
	
	views: [ 
		'form.eformMainView',
		'form.defPrint',
		'form.eformEmailWindow',
		'form.eformDynamicApprovers'
	],
	models: [
		'form.eformMainModel',
		'form.eformNewModel',
		'form.eformPendingModel',
		'form.maineFormModel',
		'form.userModel'
	],
	stores: [
		'form.eformMainStore',
		'form.eformNewStore',
		'form.eformPendingStore',
		'form.maineFormStore',
		'form.userStore',
		'form.rolestore',
		'form.eformDynamicUser'
	],
	
    init: function() {
		console.log('init controller');
        this.control({
            'viewport': {
                render: this.onMainPanelRendered
            },
			'eformmainview button[action=neweforms]': {
				click: this.openNeweForms
			},
			'eformmainview button[action=pendingeforms]': {
				click: this.openPendingeForms
			},
			'eformmainview combobox[name=userpid]': { 
				select: this.changePID
			}, 
			'eformmainview button[action=backcallingpage]': {
				click: this.backToParent
			},
			'eformmainview': {
				cellclick: this.cellClicked
			},
			'eformmainview splitbutton[id=neweformid] menu': {
				click: this.splitOpenNewForm
			},
			'eformmainview splitbutton[id=pendingeformid] menu': {
				click: this.splitOpenNewForm
			},
			'eformemailwindow button[action=sendnow]': {
				click: this.sendEmailForm
			},
			'eformemailwindow button[action=printcontent]': {
				click: this.printeMailContent
			},
			'eformemailwindow checkboxfield[name=emailAsTable]': {
				change: this.setDataAsTable
			},
			'eformdynamicapprovers combobox[name=userpid]': {
				select: this.comboUserSelect
			},
			'eformdynamicapprovers combobox[name=userrole]': {
				select: this.comboRoleSelect
			},
			'eformdynamicapprovers button[action=add]': {
				click: this.addUser
			},
			'eformdynamicapprovers button[action=remove]': {
				click: this.removerUser
			},
			'eformdynamicapprovers button[action=continue]': {
				click: this.continueRoute
			}
        });
    },
    
    backToParent: function(btn) {
		/*var theHref = localStorage.getItem("formInvoker");
		window.location.href = theHref;*/
    	window.history.back();
	},
    
    printeMailContent: function(thisbtn) {
    	var theForm = thisbtn.up('form');
    	var htmlEditor=theForm.down('htmleditor');
    	htmlEditor.getWin().print();
    },
    
    setDataAsTable: function(checkBox,val) {
    	console.log(val);
    	var theForm = checkBox.up('form');
    	var htmlEdit= theForm.down('htmleditor');
    	
    	if(val==true) {
    		var eformid = theForm.down('hiddenfield[name=eformid]').getValue();	
    		var processid = theForm.down('hiddenfield[name=processid]').getValue();
    		console.log(eformid);
    		console.log(processid); 
    		Ext.ss.defmain.getFormAsTable(eformid,processid,function(result) {
    			htmlEdit.setValue(result);
    		});
    		
    	} else {
    		var autoForm = Ext.getCmp('autoeformididid');   
    		console.log(autoForm); 
    		var panelContent = autoForm.getPanelContent();
    		console.log(panelContent); 
    		htmlEdit.setValue(panelContent);
    	}
    },
    
    splitOpenNewForm: function(splitBtn,cmenu,b) {
    	var eformid   = cmenu.eformid;
		var actiontype = cmenu.actiontype; 
		var thisgrid = splitBtn.up('grid');
		if(actiontype == 'getneweforms' || actiontype == 'getpendingeforms') 
	    { 
			var myMask = Ext.create('Ext.LoadMask',{
				target: thisgrid,
				msg: "Opening, please wait..."
			});
		    myMask.show();
			
			Ext.ss.data.getTheFormsFromeFormid(eformid,actiontype, function(result) {
				myMask.hide();
				try {
					eval(result);
				} catch(err) {
					Ext.Msg.show({
		  				title: 'Technical problem.',
		  				msg: 'Our apology. We are having technical problems ' + err, 
		  				buttons: Ext.Msg.OK,
		  				icon: Ext.Msg.ERROR
		  			});
		  			console.log(result);
				}
			});
		} 
		else 
		{
			var myMask = Ext.create('Ext.LoadMask',{
				target: thisgrid,
				msg: "Opening, please wait..."
			});
		    myMask.show();
			Ext.ss.data.getTheFormsFromeFormid(eformid,actiontype, function(result) {
				myMask.hide();
				try {
					eval(result);
					Ext.ss.data.zeroapproveDisapprove(eformid,function(result) {
						console.log(result); 
					});
				} catch(err) {
					Ext.Msg.show({
		  				title: 'Technical problem.',
		  				msg: 'Our apology. We are having technical problems ' + err, 
		  				buttons: Ext.Msg.OK,
		  				icon: Ext.Msg.ERROR
		  			});
		  			console.log(result);
				}
			});
		}
    },
    
    cellClicked: function(theCell, td, cellIndex, record, tr, rowIndex, e, eOpts) {
        var clickedDataIndex = theCell.panel.headerCt.getHeaderAtIndex(cellIndex).dataIndex;
        var clickedColumnName = theCell.panel.headerCt.getHeaderAtIndex(cellIndex).text;
        var clickedCellValue = record.get(clickedDataIndex);
        
		
		if(clickedColumnName == 'New') 
	    { 
			var eformid   = record.data.A_EFORMID;
			var actiontype = 'getneweforms';
			
			var thisgrid = theCell.up('grid');
			var myMask = Ext.create('Ext.LoadMask',{
				target: thisgrid,
				msg: "Opening, please wait..."
			});
		    myMask.show();
			
			Ext.ss.data.getTheFormsFromeFormid(eformid,actiontype, function(result) {
				myMask.hide();
				try {
					eval(result);
				} catch(err) {
					Ext.Msg.show({
		  				title: 'Technical problem.',
		  				msg: 'Our apology. We are having technical problems ' + err, 
		  				buttons: Ext.Msg.OK,
		  				icon: Ext.Msg.ERROR
		  			});
		  			console.log(result)
				}
			});
		} 
		else if(clickedColumnName == 'Pending')
		{
			var eformid   = record.data.A_EFORMID;
			var actiontype = 'getpendingeforms';
			
			var thisgrid = theCell.up('grid');
			var myMask = Ext.create('Ext.LoadMask',{
				target: thisgrid,
				msg: "Opening, please wait..."
			});
		    myMask.show();
			
			Ext.ss.data.getTheFormsFromeFormid(eformid,actiontype, function(result) {
				myMask.hide();
				try {
					eval(result);
				} catch(err) {
					Ext.Msg.show({
		  				title: 'Technical problem.',
		  				msg: 'Our apology. We are having technical problems ' + err, 
		  				buttons: Ext.Msg.OK,
		  				icon: Ext.Msg.ERROR
		  			});
		  			console.log(result);
				}
			});
		} else if(clickedColumnName == 'Returned' || clickedColumnName == 'Name') {
			var eformid   = record.data.A_EFORMID;
			var actiontype = 'getmyeforms';
			
			var thisgrid = theCell.up('grid');
			var myMask = Ext.create('Ext.LoadMask',{
				target: thisgrid,
				msg: "Opening, please wait..."
			});
		    myMask.show();
			
			Ext.ss.data.getTheFormsFromeFormid(eformid,actiontype, function(result) {
				myMask.hide();
				try {
					eval(result);
					//clear approve or disapprove count here
					Ext.ss.data.zeroapproveDisapprove(eformid,function(result) {
						console.log(result); 
					});
				} catch(err) {
					Ext.Msg.show({
		  				title: 'Technical problem.',
		  				msg: 'Our apology. We are having technical problems ' + err, 
		  				buttons: Ext.Msg.OK,
		  				icon: Ext.Msg.ERROR
		  			});
		  			console.log(result);
				}
			});
		}
    },
    
    removerUser: function(btn) {
    	
		var mainGrid = Ext.ComponentQuery.query('eformmainview')[0];
		var selection = mainGrid.getView().getSelectionModel().getSelection()[0];
		var thisGrid = Ext.ComponentQuery.query('eformdynamicapprovers')[0];
		thisGrid = thisGrid.down('grid');
    	var selectionB = thisGrid.getView().getSelectionModel().getSelection();
		
		if(!selectionB.length) {
			alert('Please select a user to remove.');
			return true;
		}
		
		var myMask = Ext.create('Ext.LoadMask',{
				target: thisGrid,
				msg: "Adding, please wait..."
			});
		myMask.show();
		
		var dynamicApproverWin = Ext.ComponentQuery.query('eformdynamicapprovers')[0];
		var routerTempComp = dynamicApproverWin.down('textfield[name=templaterouterid]');
		
		var eformid = selection.data.A_EFORMID;
		
		for(cnnt=0;cnnt<selectionB.length;cnnt++) {
			var thepid = selectionB[cnnt].data.PERSONNELIDNO;
			Ext.ss.dynamicApprover.removeApprover(eformid,thepid,routerTempComp.getValue(), function(result) {
			myMask.hide();
				if(result == "success") {
					thisGrid.getStore().load({
						params: {
							eformid: eformid,
							routerid: routerTempComp.getValue()
						}
					});
				} else {
					alert('Unable to remove.');
				}
				
			});
		}
		
    },
    
    continueRoute: function(btn) {
    	var thisgrid = btn.up('eformdynamicapprovers');
    	var theGrid = thisgrid.down('grid');
		var myMask = Ext.create('Ext.LoadMask',{
				target: theGrid,
				msg: "Routing, please wait..."
			});
		myMask.show();
		var eformidComp = thisgrid.down('textfield[name=eformid]');
		var processidComp = thisgrid.down('textfield[name=processid]');
		var levelComp = thisgrid.down('textfield[name=level]');
		var tableComp = thisgrid.down('textfield[name=table]');  
		
		var agrid = Ext.getCmp(eformidComp.getValue()); //getCmp is rarely used function coz of its slow response
		
		Ext.ss.active.startRoute(eformidComp.getValue(),processidComp.getValue(),levelComp.getValue(),tableComp.getValue(), function(result) {
			console.log(result);
			thisgrid.close();	
			myMask.hide();
			if(result == 'success') {
				Ext.Msg.show({title: '',msg: 'Form route successful', buttons: Ext.Msg.OK});
				agrid.getStore().load();
			} else {
				Ext.Msg.show({title: 'Technical problem.',msg: 'Our apology. We are having technical problems : ' + result, buttons: Ext.Msg.OK,icon: Ext.Msg.ERROR});
			}
		 });
    },
    
    addUser: function(btn) {
		var combobox   	= Ext.ComponentQuery.query('eformdynamicapprovers combobox[name=userpid]')[0];
		var comboboxR 	= Ext.ComponentQuery.query('eformdynamicapprovers combobox[name=userrole]')[0];
		console.log(combobox);
		var theRole 	= comboboxR.getValue();
		var thepid 		= combobox.getValue();
		if(!thepid && !theRole) {
			alert('Please select a user first.');
			return true;
		}
		
		if(!theRole) {
			theRole = ' ';
		} else {
			thepid  = ' ';
		}
		
		var thisGrid = Ext.ComponentQuery.query('eformdynamicapprovers grid')[0];
		var mainGrid = Ext.ComponentQuery.query('eformmainview')[0];
		var selection = mainGrid.getView().getSelectionModel().getSelection()[0];
		
		var dynamicApproverWin = Ext.ComponentQuery.query('eformdynamicapprovers')[0];
		var routerTempComp = dynamicApproverWin.down('textfield[name=templaterouterid]');
		
		var myMask = Ext.create('Ext.LoadMask',{
				target: thisGrid,
				msg: "Adding, please wait..."
			});
		myMask.show();
		
		Ext.ss.dynamicApprover.addApprover(selection.data.A_EFORMID,thepid,theRole, routerTempComp.getValue(), function(result) { 
			myMask.hide();
			if(result == "success") {
				thisGrid.getStore().load({
					params: {
							eformid: selection.data.A_EFORMID,
							routerid: routerTempComp.getValue()
						}
				});
			} else {
				console.log(result);
			}
		});
			
	},
    
    comboUserSelect: function(combo, records) {
		var comboboxR = Ext.ComponentQuery.query('eformdynamicapprovers combobox[name=userrole]');
		comboboxR[0].setValue('');
	},
	
	comboRoleSelect: function(combo, records) {
		var comboboxU = Ext.ComponentQuery.query('eformdynamicapprovers combobox[name=userpid]');
		comboboxU[0].setValue('');
	},
	
	sendEmailForm: function(btn) {
		var theForm = btn.up('form');
		if(theForm.getForm().isValid()){
			theForm.getForm().submit({
				waitMsg: 'Sending, please wait...',
				timeout: 300000,
				reset: true,
			  		failure: function(form, action){
			  			//see app-wide error handler
			  		},
			  		success: function(form, action){
			  			Ext.Msg.show({
			  				msg: 'Done!',
			  				buttons: Ext.Msg.OK
			  			});
						
			  		}
			});	
		}
	}, 
	
	changePID: function(thiss, newVal) {
		var mainGrid = thiss.up('grid');
		var pid = newVal[0].data.usercode;
		Ext.ss.activate.changepid(pid, function(result) {
			console.log(result);
			mainGrid.getStore().load();
		});
		
	},
	
	openNeweForms: function(btn) {
		var thisgrid = btn.up('grid');
		var selection = thisgrid.getView().getSelectionModel().getSelection()[0];
		
		
		if(selection) { 
		
			var eformid   = selection.data.A_EFORMID;
			var actiontype = 'getneweforms';
			
			var myMask = Ext.create('Ext.LoadMask',{
				target: thisgrid,
				msg: "Opening, please wait..."
			});
		    myMask.show();
			
			Ext.ss.data.getTheFormsFromeFormid(eformid,actiontype, function(result) {
				myMask.hide();
				try {
					eval(result);
				} catch(err) {
					Ext.Msg.show({
		  				title: 'Technical problem.',
		  				msg: 'Our apology. We are having technical problems ' + err, 
		  				buttons: Ext.Msg.OK,
		  				icon: Ext.Msg.ERROR
		  			});
		  			console.log(result);
				}
			});
		} else {
			alert('No form selected. Please select an eForm.');
		}
	},
	
	openPendingeForms: function(btn) {
		var thisgrid = btn.up('grid');
		var selection = thisgrid.getView().getSelectionModel().getSelection()[0];
		
		
		if(selection) {
			
			var eformid   = selection.data.A_EFORMID;
			var actiontype = 'getpendingeforms';
			
			var myMask = Ext.create('Ext.LoadMask',{
					target: thisgrid,
					msg: "Opening, please wait..."
				});
			myMask.show();
			
			Ext.ss.data.getTheFormsFromeFormid(eformid,actiontype, function(result) {
				myMask.hide();
				try {
					eval(result);
				} catch(err) {
					Ext.Msg.show({
		  				title: 'Technical problem.',
		  				msg: 'Our apology. We are having technical problems ' + err, 
		  				buttons: Ext.Msg.OK,
		  				icon: Ext.Msg.ERROR
		  			});
		  			console.log(result);
				}
			});
		} else {
			alert('No form selected. Please select an eForm.');
		}
	},
	
	onMainPanelRendered: function(thiss) {
		console.log('panel ready test');
		var pName = window.location.pathname;
		var comCombo = thiss.down('combobox[name=userpid]');
		var bdgVal = getURLParameter('bdg');
		if(bdgVal == 'SIMULATOR') {
			//panel is simulator
		} else {
			//panel is main
			comCombo.hide();
		}
		eformid = getURLParameter('eformid');
		actiontype = getURLParameter('actiontype');
		if(eformid)
		{
			var myMask = Ext.create('Ext.LoadMask',{
				target: thiss,
				msg: "Opening, please wait..."
			});
			myMask.show();
			Ext.ss.data.getTheFormsFromeFormid(eformid,actiontype, function(result) {
				myMask.hide();
				
				try {
					eval(result);
				} catch(err) {
					Ext.Msg.show({
		  				title: 'Technical problem.',
		  				msg: 'Our apology. We are having technical problems ' + err, 
		  				buttons: Ext.Msg.OK,
		  				icon: Ext.Msg.ERROR
		  			});
		  			console.log(result);
				}
			});
		} 
		
	}
	 
});