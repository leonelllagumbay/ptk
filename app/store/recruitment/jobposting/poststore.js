Ext.define('Form.store.recruitment.jobposting.poststore', {
	extend: 'Ext.data.Store',
	model: 'Form.model.recruitment.jobposting.postmodel',
	data: [{
		postcode: 'internal',
		postname: 'Post to Internal'
	},{
		postcode: 'company',
		postname: 'Post to Company'
	},{
		postcode: 'global',
		postname: 'Post to Global'
	},{
		postcode: 'internalcompany',
		postname: 'Post to Internal and Company'
	},{
		postcode: 'internalglobal',
		postname: 'Post to Internal and Global'
	},{
		postcode: 'companyglobal',
		postname: 'Post to Company and Global'
	},{
		postcode: 'all',
		postname: 'Post to All'
	}]
});
