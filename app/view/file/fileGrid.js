var store2 = Ext.create('Ext.data.Store', {
    storeId:'simpsonsStore',
    fields:['name', 'email', 'phone'],
    data:{'items':[
        { 'name': 'Lisa',  "email":"lisa@simpsons.com",  "phone":"555-111-1224"  },
        { 'name': 'Bart',  "email":"bart@simpsons.com",  "phone":"555-222-1234" },
        { 'name': 'Homer', "email":"home@simpsons.com",  "phone":"555-222-1244"  },
        { 'name': 'Marge', "email":"marge@simpsons.com", "phone":"555-222-1254"  }
    ]},
    proxy: {
        type: 'memory',
        reader: {
            type: 'json',
            root: 'items'
        }
    }
});


Ext.define('Form.view.file.fileGrid', { 
	extend: 'Ext.grid.Panel',
	alias: 'widget.filegrid',
	width: '100%', 
	height: '100%',
	autoScroll: true,
	
	initComponent: function() {  
		this.store = store2;
		this.tbar = [{
			text: 'Upload File'
		},{
			text: 'Copy'
		},{
			text: 'Move'
		},{
			text: 'Rename'
		},{
			text: 'Delete'
		}];
		this.columns = [
		                { text: 'Name',  dataIndex: 'name' },
		                { text: 'Email', dataIndex: 'email', flex: 1 },
		                { text: 'Phone', dataIndex: 'phone' }
		            ];
		this.callParent(arguments);
	}
});