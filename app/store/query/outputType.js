Ext.define('Form.store.query.outputType', {
	extend: 'Ext.data.Store',
	fields: ['outputtypename','outputtypecode'],
	data: [{
		outputtypename: 'Grid',
		outputtypecode: 'grid'
	},{
		outputtypename: 'Chart',
		outputtypecode: 'chart'
	},{
		outputtypename: 'Html',
		outputtypecode: 'html'
	},{
		outputtypename: 'Tree',
		outputtypecode: 'tree'
	},{
		outputtypename: 'Menu',
		outputtypecode: 'menu'
	},{
		outputtypename: 'RSS 2',
		outputtypecode: 'rss2'
	},{
		outputtypename: 'Figure',
		outputtypecode: 'figure'
	},{
		outputtypename: 'Form',
		outputtypecode: 'form'
	},{
		outputtypename: 'Other APIs',
		outputtypecode: 'api'
	}]	
});
