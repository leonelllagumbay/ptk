Ext.define('Form.store.form.viewasstore', {
	extend: 'Ext.data.Store',
	fields: ['viewasname', 'viewascode'],
	data: [{
		viewasname: 'Horizontal',
		viewascode: 'HBOX'
	},{
		viewasname: 'Horizontal Absolute',
		viewascode: 'HBOXABS'
	},{
		viewasname: 'Vertical',
		viewascode: 'VBOX'
	},{
		viewasname: 'Vertical Absolute',
		viewascode: 'VBOXABS'
	},{
		viewasname: 'Horizontal (Panel)',
		viewascode: 'HBOXPANEL'
	},{
		viewasname: 'Horizontal Absolute (Panel)',
		viewascode: 'HBOXABSPANEL'
	},{
		viewasname: 'Vertical (Panel)',
		viewascode: 'VBOXPANEL'
	},{
		viewasname: 'Vertical Absolute (Panel)',
		viewascode: 'VBOXABSPANEL'
	},{
		viewasname: 'Table', 
		viewascode: 'TABLE'
	}] 	
});
