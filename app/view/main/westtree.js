Ext.define('Form.view.main.westtree', {
	extend: 'Ext.tree.Panel',
	alias: 'widget.mainwesttree',
	rootVisible:  false,
	autoScroll: true,
	height: '100%',
	autoShow: true,
	initComponent: function() {
		this.store = 'main.westtreestore',
		this.bbar = [{
			xtype: 'button',
			text: 'Log out',
			action: 'logout'
		}],
		this.callParent(arguments);
	}
});

