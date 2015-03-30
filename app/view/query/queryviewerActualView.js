Ext.define('Form.view.query.queryviewerActualView', { 
	extend: 'Ext.form.Panel',
	alias: 'widget.queryvieweractualview',
	title: 'eQuery Viewer',
	width: '100%', 
	height: '100%',
	autoScroll: true,
	initComponent: function() {  
		this.tbar = [{
			text: 'Back',
			action: 'back'
		}]
		this.callParent(arguments);
	}
});