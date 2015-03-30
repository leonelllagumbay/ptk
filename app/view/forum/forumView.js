Ext.define('Form.view.forum.forumView', { 
	extend: 'Ext.panel.Panel',
	alias: 'widget.forumview',
	title: 'eForums',
	width: '70%', 
	height: '100%',
	autoScroll: true,
	initComponent: function() {   
		
		this.items = [];
		
		this.callParent(arguments);
	}
});