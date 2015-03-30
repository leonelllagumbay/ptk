Ext.define('Form.controller.form.usermanagercontroller', {
    extend: 'Ext.app.Controller',
	
	views: [
        'form.userMain',
		'form.userList',
    ],
	models: [
		'form.eformUserMainModel',
		'form.eformUserListModel',
		'form.userModel',
		'form.rolemodel'
	],
	stores: [
		'form.eformUserMainStore',
		'form.eformUserListStore',
		'form.userStore', 
		'form.rolestore'
	],
	
    init: function() {
		console.log('init controller');
        this.control({
            'usermain': {
				itemdblclick: this.openUsers
			},
			'userlist button[action=back]': {
				click: this.backToMain
			},
			'userlist button[action=add]': {
				click: this.grantAccess
			},
			'userlist button[action=delete]': {
				click: this.revokeAccess
			},
			'userlist combobox[name=userpid]': {
				select: this.comboUserSelect
			},
			'userlist combobox[name=userrole]': {
				select: this.comboRoleSelect
			}
        });
    },
	
	
	comboUserSelect: function(combo, records) {
		var comboboxR = Ext.ComponentQuery.query('userlist combobox[name=userrole]');
		comboboxR[0].setValue('');
	},
	
	comboRoleSelect: function(combo, records) {
		var comboboxU = Ext.ComponentQuery.query('combobox[name=userpid]');
		comboboxU[0].setValue('');
	},
	
	openUsers: function(btn) {
		var cardlayout = btn.up('viewport');
		
		var centerR = Ext.ComponentQuery.query('viewport panel[region=center], viewport')[0];
		centerR.getLayout().setActiveItem(1);
		
		var thisGrid = cardlayout.down('usermain');
		var selection = thisGrid.getView().getSelectionModel().getSelection()[0];
		
		var otherGrid = cardlayout.down('userlist');
		var theStore = otherGrid.getStore();
		theStore.load({
			params: {
				eformid: selection.data.EFORMID
			}
		});
		theStore.proxy.extraParams.eformid = selection.data.EFORMID;
		console.log(selection.data.EFORMID);
	},
	
	backToMain: function(btn) {
		var centerR = Ext.ComponentQuery.query('viewport panel[region=center], viewport')[0];
		centerR.getLayout().setActiveItem(0);
			
	},
	
	grantAccess: function(btn) {
		var cardlayout 	= btn.up('viewport');
		var combobox   	= cardlayout.down('userlist combobox[name=userpid]');
		var comboboxR 	= cardlayout.down('userlist combobox[name=userrole]');
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
		
		var thisGrid = cardlayout.down('userlist');
		var mainGrid = cardlayout.down('usermain');
		var selection = mainGrid.getView().getSelectionModel().getSelection()[0];
		
		var myMask = Ext.create('Ext.LoadMask',{
				target: thisGrid,
				msg: "Granting, please wait..."
			});
		myMask.show();
		
		Ext.ss.data.grantAccesseForm(selection.data.EFORMID,thepid,theRole, function(result) { 
			myMask.hide();
			if(result == "success") {
				thisGrid.getStore().load();
			} else {
				alert('Unable to grant access.');
			}
		});
			
	},
	
	revokeAccess: function(btn) {
		var cardlayout = btn.up('viewport');
		var combobox = cardlayout.down('userlist combobox[name=userpid]');
		var thisGrid = cardlayout.down('userlist');
		
		var mainGrid = cardlayout.down('usermain');
		var selection = mainGrid.getView().getSelectionModel().getSelection()[0];
		var selectionB = thisGrid.getView().getSelectionModel().getSelection();
		
		if(!selectionB.length) {
			alert('Please select a record to revoke access.');
			return true;
		}
		
		var myMask = Ext.create('Ext.LoadMask',{
				target: thisGrid,
				msg: "Revoking, please wait..."
			});
		myMask.show();
		var eformid = selection.data.EFORMID;
		for(cnnt=0;cnnt<selectionB.length;cnnt++) {
			Ext.ss.data.revokeAccesseForm(eformid,selectionB[cnnt].data.PERSONNELIDNO, function(result) {
			myMask.hide();
				if(result == "success") {
					
					thisGrid.getStore().load();
				} else {
					alert('Unable to revoke access.');
				}
				
			});
		}
		
	}
	
	 
});