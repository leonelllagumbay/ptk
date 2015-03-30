Ext.define('OnlineApplication.store.recruitment.applicationonline.specialskillstore', {
	extend: 'Ext.data.Store',
	fields: ['skillcode','skillname'],
	data: [{
		skillcode: 'Basic',
		skillname: 'Basic'
	},{
		skillcode: 'Advanced',
		skillname: 'Advanced'
	},{
		skillcode: 'Expert',
		skillname: 'Expert'
	}]
});
