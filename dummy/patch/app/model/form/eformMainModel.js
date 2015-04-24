Ext.define('Form.model.form.eformMainModel', {
	extend: 'Ext.data.Model',
	fields: [
		'EFORMID',
		'EFORMNAME',
		'DESCRIPTION',
		'EFORMGROUP',
		'FORMFLOWPROCESS',
		'NEWEFORMS',
		'PENDINGEFORMS',
		'TOTALRETURNED',
		'APPROVEDFORMS',
		'DISAPPROVEDFORMS',
		{
			name: 'ISENCRYPTED',
			type: 'boolean'
		},
		{
			name: 'DATELASTUPDATE',
			type: 'date'
		}
	]
});
