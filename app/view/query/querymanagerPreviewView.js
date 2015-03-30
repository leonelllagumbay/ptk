Ext.define('Form.view.query.querymanagerPreviewView', { 
	extend: 'Ext.form.Panel',
	alias: 'widget.querymanagerpreviewview',
	title: 'eQuery Preview',
	width: '100%', 
	height: '100%',
	autoScroll: true,
	initComponent: function() {   
		this.tbar = [{
			text: 'Manage Query',
			action: 'managequery'
		},{
			text: 'Query List',
			action: 'querylist'
		}];
		this.callParent(arguments);
	}
});