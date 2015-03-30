Ext.define('Form.view.query.querydefinitionPreviewView', { 
	extend: 'Ext.form.Panel',
	alias: 'widget.querydefinitionpreviewview',
	title: 'eQuery Definition Preview',
	width: '100%', 
	height: '100%',
	autoScroll: true,
	initComponent: function() {   
		this.tbar = [{
			text: 'Query List',
			action: 'querylist'
		},{
			text: 'Query Details',
			action: 'querydetails'
		},{
			text: 'Query Column List',
			action: 'querycolumnlist'
		},{
			text: 'Query Column Definition',
			action: 'querycolumndefinition'
		}];

		this.callParent(arguments);
	}
});