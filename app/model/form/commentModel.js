Ext.define('Form.model.form.commentModel', {
	extend: 'Ext.data.Model',
	fields: [
		{name: 'title', mapping: 'name'},
        {name: 'lastPost', mapping: 'dateaction'}, 
        {name: 'excerpt', mapping: 'comments'} 
	]
});
