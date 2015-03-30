Ext.define('Form.view.query.queryManagerNewQueryForm', { 
	extend: 'Ext.window.Window',
	alias: 'widget.qmnewqueryform',
	initComponent: function() {  
		this.title = 'Add eQuery',
		this.width = 400,
		this.height = 140,
		this.items = [{
			layout: 'form',
			buttonAlign: 'center',
			bodyPadding: 10,
			items: [{
				xtype: 'textfield',
				fieldLabel: 'Name',
				name: 'name'
			},{
				xtype: 'textfield',
				fieldLabel: 'Description',
				name: 'description'
			}],
			buttons: [{
				text: 'Add',
				action: 'newquery'
			},{
				text: 'Cancel',
				action: 'newcancel'
			}]
		}]
		this.callParent(arguments);
	}
});