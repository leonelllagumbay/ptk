Ext.define('cfbose.controller.Companylk', {
    extend: 'Ext.app.Controller',

	views: [
        'user.List',
		'user.Edit'
    ],
	
	stores: [
		'Users'
	],
	
	models: [
		'User'
	],
	
    init: function() {
        this.control({
            'viewport > panel': {
                render: this.onPanelRendered
            },
			'userlist': {
                itemdblclick: this.editUsera
            },
			'useredit button[action=save]': {
                click: this.updateUser
            }
        });
    },

    onPanelRendered: function() {
        console.log('The panel was rendered');
    },
	
	editUsera: function(grid, record) {
        var view = Ext.widget('useredit');

        view.down('form').loadRecord(record);
    },
	
	updateUser: function(button) {
        
		var win    = button.up('window'),
		    form   = win.down('form'),
			record = form.getRecord(),
			values = form.getValues();
			
		record.set(values);
		win.close();
		
		//synchronize the store after editing the record
		
		this.getUsersStore().sync();
		
    }
	
});