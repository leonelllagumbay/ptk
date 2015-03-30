Ext.define('Form.controller.recruitment.setting.controller', {
    extend: 'Ext.app.Controller',
	stores: [
		'recruitment.setting.emailstore',
		'recruitment.setting.tatstore'
	],
	views: [
        'recruitment.setting.emailtemplateform',
		'recruitment.setting.emailtemplategrid',
		'recruitment.setting.maxtatform'
    ],
	models: [
		'recruitment.setting.emailmodel',
		'recruitment.setting.tatmodel'
	],
	
    init: function() {
		console.log('init controller');
        this.control({
            'writerform button[action=save]': {
                click: this.onSave
            },
			'writerform button[action=create]': {
                click: this.onCreate
            },
			'writerform button[action=reset]': {
                click: this.onReset
            },
			'writergrid button[action=delete]': {
                click: this.onDeleteClick
            },
			'writergrid': {
                selectionchange: this.onSelectChange
            },
			'maxtatform button[action=save]': {
                click: this.onSavetat 
            },
			'maxtatform': {
                expand: this.onExpand 
            }
		
        });
    },
	
	onExpand: function(p, opt) {
		p.getForm().load();
	},
	
	onSavetat: function(button){
		var panel = button.up('panel');
		var form = panel.getForm();
		if (form.isValid()) {
			var thefields = form.getFields();
			for(bcnt=0; bcnt<thefields.items.length; bcnt++) {
			  Ext.ss.setting.savemaxtat(thefields.items[bcnt].name, thefields.items[bcnt].value, function(result){
				if(bcnt == 20) {
				   	 Ext.Msg.show({
		  				title: 'Done!',
		  				msg: 'Done updating.',
		  				buttons: Ext.Msg.OK
		  			 });
				}
			  });
			}
		}
    },
	
	onSelectChange: function(selModel, selections){
		var res = Ext.ComponentQuery.query('writergrid');
        res[0].down('#delete').setDisabled(selections.length === 0);
		var resform = Ext.ComponentQuery.query('writerform');
		resform[0].setActiveRecord(selections[0] || null);
    },
	
	onDeleteClick: function(button){
		var confirm = window.confirm('Are you sure you want to delete the selected e-mail template?');
		if (confirm) {
			var win = button.up('grid');
			var selection = win.getView().getSelectionModel().getSelection()[0];
			if (selection) {
				Ext.ss.setting.destroysettings(selection.data.NAME, function(result){
					win.store.remove(selection);
				});
			}
		}
    },
	
	onSave: function(button){
        
		var panel = button.up('panel');
        var form = panel.getForm();
        if (form.isValid()) {
			var currentRec = form.getFieldValues();
			var name    = currentRec.NAME;
			var subject   = currentRec.SUBJECTTPL;
			var body = currentRec.BODYTPL;
			
            Ext.ss.setting.updatesettings(name, subject,body, function(result){
				var res = Ext.ComponentQuery.query('writergrid');
				var store = res[0].getStore();
				form.reset();
				store.load();
			});
        }
    },
	
	onCreate: function(button){
		var panel = button.up('panel');
        var form = panel.getForm();
        if (form.isValid()) {
			var currentRec = form.getFieldValues();
			var name    = currentRec.NAME;
			var subject = currentRec.SUBJECTTPL;
			var body    = currentRec.BODYTPL;
            
			Ext.ss.setting.createsettings(name, body, subject, function(result){
				if(result == 'Record already exist!') {
					Ext.Msg.show({
					     title:'Duplicate Entry!',
					     msg: 'You are inserting a record that has the same template name. Please use other template name.',
					     buttons: Ext.Msg.OK,
					     icon: Ext.Msg.ERROR
					});
				}
				var res = Ext.ComponentQuery.query('writergrid');
				var store = res[0].getStore();
				
				/*
				var data = {
					NAME: name,
					BODYTPL: body,
					SUBJECTTPL: subject
				}
				store.insert(0, data);
				*/
				form.reset();
				store.load();
			});
            
        }

    },
	
	onReset: function(button){
		var panel = button.up('panel');
        panel.setActiveRecord(null);
		panel.getForm().reset();
    },
	
	
	
	savechanges: function(editor, e){  
		var field  = e.field;
		var newval = e.value;
		var oldval = e.originalValue;
		var requisitionno = e.record.data.REQUISITIONNO;
		
		if (newval != oldval) {
			Ext.ss.data.updatenow(requisitionno, newval, field, function(result){
				if (result == 'success') {
					console.log(result);
					e.record.commit();
					return true;
				}
				else {
					return false;
				}
			});
		}
		return true;
		
	},
	
	postnow: function(button) {
		
		var win       = button.up('panel');
		var grid      = win.down('grid');
		var statusdisp  = win.down('displayfield');
		
		
		var selectedRecord = grid.getSelectionModel().getSelection();
		
		
				if(selectedRecord.length < 1) {
					statusdisp.setValue('<h2>Please select a record first.<h2>');
					Ext.Msg.show({
		  				title: 'No record selected!',
		  				msg: 'Please select a record.',
		  				buttons: Ext.Msg.OK,
		  				icon: Ext.Msg.WARNING
		  			});
					return true;
				}
		var requisitionno = '';
		var combobox  = win.down('combobox[name=posttype]');
		var type      = combobox.getValue();
		
		
		
		//post it here
		if (type) {
			var myMask = new Ext.LoadMask(grid, {msg:"Posting, please wait..."});
            myMask.show();
			for (var cntt = 0; cntt < selectedRecord.length; cntt++) {
				requisitionno = selectedRecord[cntt].data.REQUISITIONNO;
				Ext.ss.data.post(requisitionno, type, function(result){
					var themsg = '<h2>' + 'Requisition No :' + result.topics[0].requisitionno + ' ,Type: ' + result.topics[0].type + '</h2>';
					statusdisp.setValue(themsg);
					myMask.hide();
					var store = Ext.getStore('recruitment.jobposting.store');
			        store.load();
				});
			}
			return true;
		} else {
			statusdisp.setValue('<h2>Please select a post type first.</h2>');
			Ext.Msg.show({
  				title: 'No post type selected!',
  				msg: 'Please select a post type.',
  				buttons: Ext.Msg.OK,
  				icon: Ext.Msg.WARNING
  			});
			return true;
		}
	},
	
    onPanelRendered: function() {
        console.log('The panel was rendered');
    }
	
});