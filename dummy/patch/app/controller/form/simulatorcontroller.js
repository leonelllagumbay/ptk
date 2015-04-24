Ext.define('Form.controller.form.simulatorcontroller', {
    extend: 'Ext.app.Controller',
	
	views: [ 
		'form.eformMainView',
		'form.defPrint',
		'form.eformEmailWindow'
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
		'form.userStore'
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
			'eformmainview': {
				itemdblclick: this.openForms
			},
			'eformmainview combobox[name=userpid]': { 
				change: this.changePID
			}, 
        });
    }, 
	
	changePID: function(thiss, newVal) {
		var mainGrid = thiss.up('grid');
		var newFormbutton = mainGrid.down('button[action=neweforms]'); 
		var pendingFormbutton = mainGrid.down('button[action=pendingeforms]');
		Ext.ss.activate.changepid(newVal, function(result) {
			console.log(result);
			newFormbutton.setText(result[0]);
			pendingFormbutton.setText(result[1]);
		});
	},
	
	openNeweForms: function(btn) {
		var thisgrid = btn.up('grid');
		var selection = thisgrid.getView().getSelectionModel().getSelection()[0];
		var eformid   = selection.data.EFORMID;
		var actiontype = 'getneweforms';
		
		if(selection) { 
			
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
				}
			});
		} else {
			alert('No form selected. Please select an eForm.');
		}
	},
	
	openPendingeForms: function(btn) {
		var thisgrid = btn.up('grid');
		var selection = thisgrid.getView().getSelectionModel().getSelection()[0];
		var eformid   = selection.data.EFORMID;
		var actiontype = 'getpendingeforms';
		
		var myMask = Ext.create('Ext.LoadMask',{
				target: thisgrid,
				msg: "Opening, please wait..."
			});
		myMask.show();
		
		if(selection) {
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
				}
			});
		} else {
			alert('No form selected. Please select an eForm.');
		}
	},
	
	openForms: function(thiss, record) {
		var eformid   = record.data.EFORMID;
		var actiontype = 'getmyeforms';
		var myMask = Ext.create('Ext.LoadMask',{
				target: thiss,
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
				console.log(result);
				Ext.Msg.show({
	  				title: 'Technical problem.',
	  				msg: 'Our apology. We are having technical problems ' + err, 
	  				buttons: Ext.Msg.OK,
	  				icon: Ext.Msg.ERROR
	  			});
			}
		});
		
	},
	onMainPanelRendered: function(thiss) {
		console.log('panel ready test');
		
	}
	 
});