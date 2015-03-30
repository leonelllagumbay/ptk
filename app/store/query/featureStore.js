Ext.define('Form.store.query.featureStore', {
	extend: 'Ext.data.Store',
	fields: ['featurename','featurecode'],
	data: [{
		featurename: 'Summary',
		featurecode: 'summary'
	},{
		featurename: 'Grouping',
		featurecode: 'grouping'
	},{
		featurename: 'Grouping Summary',
		featurecode: 'groupingsummary'
	},{
		featurename: 'Row Body',
		featurecode: 'rowbody'
	},{
		featurename: 'Summary and Grouping',
		featurecode: 'summary grouping'
	},{
		featurename: 'Summary and Row Body',
		featurecode: 'summary rowbody'
	},{
		featurename: 'Grouping and Row Body',
		featurecode: 'grouping rowbody'
	},{
		featurename: 'Summary and Grouping Summary',
		featurecode: 'summary groupingsummary'
	},{
		featurename: 'Grouping Summary and Row Body',
		featurecode: 'groupingsummary rowbody'
	},{
		featurename: 'Summary, Grouping Summary, and Rowbody',
		featurecode: 'summary groupingsummary rowbody'
	}]	
});
