Ext.define('Form.model.form.defTableModel', {
	extend: 'Ext.data.Model',
	fields: [
		'TABLEID',
		'EFORMIDFK',
		'TABLENAME',
		'DESCRIPTION',
		'LINKTABLETO',
		'LINKINGCOLUMN',
		'TABLETYPE',
		'LEVELID',
		'RECCREATEDBY',
		{
			name: 'RECDATECREATED',      
			type: 'date'
		},
		{
			name: 'DATELASTUPDATE',
			type: 'date'
		}
	]
})