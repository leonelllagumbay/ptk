Ext.define('Form.model.form.eformUserMainModel', {
	extend: 'Ext.data.Model',
	fields: [
		'EFORMID',
		'EFORMNAME',
		'DESCRIPTION',
		'EFORMGROUP',
		{
			name: 'DATELASTUPDATE',
			type: 'date'
		}
	]
});
