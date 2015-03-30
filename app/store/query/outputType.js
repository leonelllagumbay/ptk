Ext.define('Form.store.query.outputType', {
	extend: 'Ext.data.Store',
	fields: ['outputtypename','outputtypecode'],
	data: [{
		outputtypename: 'Grid',
		outputtypecode: 'grid'
	},{
		outputtypename: 'Grid View',
		outputtypecode: 'gridview'
	},{
		outputtypename: 'Chart',
		outputtypecode: 'chart'
	},{
		outputtypename: 'Html',
		outputtypecode: 'html'
	},{
		outputtypename: 'Figure',
		outputtypecode: 'figure'
	},{
		outputtypename: 'Form',
		outputtypecode: 'form'
	},{
		outputtypename: 'Tree',
		outputtypecode: 'tree'
	},{
		outputtypename: 'Menu',
		outputtypecode: 'menu'
	},{
		outputtypename: 'Table',
		outputtypecode: 'table'
	},{
		outputtypename: 'RSS 2',
		outputtypecode: 'rss2'
	},{
		outputtypename: 'Other APIs',
		outputtypecode: 'api'
	}]	
});
