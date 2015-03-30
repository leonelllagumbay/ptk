Ext.define('Form.store.form.tabletypestore', {
	extend: 'Ext.data.Store',
	model: 'Form.model.form.tabletypemodel',
	data: [{
		tabletypename: 'Global',
		tabletypecode: 'Global'
	},{
		tabletypename: 'Company',
		tabletypecode: 'Company'
	},{
		tabletypename: 'Info Card',
		tabletypecode: 'InfoCard'
	},{
		tabletypename: 'Lookup Card',
		tabletypecode: 'LookupCard'
	},{
		tabletypename: 'HR Table',
		tabletypecode: 'HR Table'
	},{
		tabletypename: 'Applicant Table',
		tabletypecode: 'Applicant Table'
	},{
		tabletypename: 'System Table',
		tabletypecode: 'System Table' 
	}]	
});
