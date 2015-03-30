Ext.define('OnlineApplication.store.recruitment.applicationonline.genderstore', {
	extend: 'Ext.data.Store',
	model: 'OnlineApplication.model.recruitment.applicationonline.gendermodel',
	data: [{
		gendercode: 'M',
		gendername: 'Male'
	},{
		gendercode: 'F',
		gendername: 'Female'
	}]
});
