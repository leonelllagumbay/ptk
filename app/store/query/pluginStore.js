Ext.define('Form.store.query.pluginStore', {
	extend: 'Ext.data.Store',
	fields: ['pluginname','plugincode'],
	data: [{
		pluginname: 'Cell Editing',
		plugincode: 'cellediting'
	},{
		pluginname: 'Row Editing',
		plugincode: 'rowediting'
	},{
		pluginname: 'Row Expander',
		plugincode: 'rowexpander'
	},{
		pluginname: 'Buffered Renderer',
		plugincode: 'bufferedrenderer'
	},{
		pluginname: 'Cell Editing and Row Expander',
		plugincode: 'cellediting rowexpander'
	},{
		pluginname: 'Buffered Renderer and Row Expander',
		plugincode: 'bufferedrenderer rowexpander'
	}]	
});
