Ext.define('Form.view.header.headerView', { 
	extend: 'Ext.container.Container',
	alias: 'widget.headerview',
	width: '100%',
    layout: {
        type: 'hbox',
        width: '100%',
    	height: '100%',
    },
    
	initComponent: function() {   
		
		this.items = [{
	        xtype: 'displayfield',
	        padding: '5 5 5 15',
	        width: 230,
	        height: 50,
	        name: 'companylogo'
		},{
	        xtype: 'displayfield',
	        padding: 5,
	        value: '',
	        width: 300,
	        height: 50
		},{
		    xtype: 'displayfield',
		    padding: 5,
	        value: '',
	        flex: 1
		},{
		    xtype: 'displayfield',
	        width: 70,
	        name: 'userprofilepic',
	        padding: '5 25 5 5',
	        value: 'No user profile pic',
	        height: 50
	        
		}],
		this.callParent(arguments);
		
	}
   
});