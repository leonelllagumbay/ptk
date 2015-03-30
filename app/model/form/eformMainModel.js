Ext.define('Form.model.form.eformMainModel', {
	extend: 'Ext.data.Model',
	fields: [
		'A_EFORMID',
		'A_EFORMNAME',
		'A_DESCRIPTION',
		'A_EFORMGROUP',
		'A_FORMFLOWPROCESS',
		'C_NEW',
		'C_PENDING',
		'C_RETURNED',
		'C_APPROVED',
		'C_DISAPPROVED',
		{
			name: 'A_ISENCRYPTED',
			type: 'boolean'
		},
		{
			name: 'A_DATELASTUPDATE',
			type: 'date'
		}
	]
});
