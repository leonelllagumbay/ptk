Ext.define('Form.controller.form.usermanagercontroller', {
    extend: 'Ext.app.Controller',
	
	views: [
        'form.userMain',
		'form.userList',
    ],
	models: [
		'form.eformUserMainModel',
		'form.eformUserListModel',
		'form.userModel'
	],
	stores: [
		'form.eformUserMainStore',
		'form.eformUserListStore',
		'form.userStore'
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
			}
        });
    },
	
	
	
	
	openUsers: function(btn) {
		var cardlayout = btn.up('viewport');
		cardlayout.getLayout().setActiveItem(1);
		
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
		var cardlayout = btn.up('viewport');
		cardlayout.getLayout().setActiveItem(0);
			
	},
	
	grantAccess: function(btn) {
		var cardlayout = btn.up('viewport');
		var combobox = cardlayout.down('userlist combobox[name=userpid]');
		var thisGrid = cardlayout.down('userlist');
		
		var mainGrid = cardlayout.down('usermain');
		var selection = mainGrid.getView().getSelectionModel().getSelection()[0];
		
		var thepid = combobox.getValue();
		if(!thepid) {
			alert('Please select a user first.');
			return true;
		}
		
		var myMask = Ext.create('Ext.LoadMask',{
				target: thisGrid,
				msg: "Granting, please wait..."
			});
		myMask.show();
		
		Ext.ss.data.grantAccesseForm(selection.data.EFORMID,thepid, function(result) {
			myMask.hide();
			if(result == "success") {
				
				thisGrid.getStore().load();
			} else {
				alert('Unable to grant access.');
			}
			
		})
			
	},
	
	revokeAccess: function(btn) {
		var cardlayout = btn.up('viewport');
		var combobox = cardlayout.down('userlist combobox[name=userpid]');
		var thisGrid = cardlayout.down('userlist');
		
		var mainGrid = cardlayout.down('usermain');
		var selection = mainGrid.getView().getSelectionModel().getSelection()[0];
		var selectionB = thisGrid.getView().getSelectionModel().getSelection()[0];
		
		if(!selectionB) {
			alert('Please select a record to revoke access.');
			return true;
		}
		
		var myMask = Ext.create('Ext.LoadMask',{
				target: thisGrid,
				msg: "Revoking, please wait..."
			});
		myMask.show();
		
		Ext.ss.data.revokeAccesseForm(selection.data.EFORMID,selectionB.data.PERSONNELIDNO, function(result) {
			myMask.hide();
			if(result == "success") {
				
				thisGrid.getStore().load();
			} else {
				alert('Unable to revoke access.');
			}
			
		})	
	}
	
	 
});