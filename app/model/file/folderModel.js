Ext.define('Form.model.file.folderModel', {
	extend: 'Ext.data.Model',
	fields: [
		'FOLDERID',
		'OBJECTIDFK',
		'FOLDERNAME',
		'FOLDERHINT',
		'PARENTFOLDERID',
		'FOLDERORDER',
		'PERSONNELIDNO',
		'APPROVED',
		'ACTIONBY',
		'EFORMID',
		'PROCESSID',
		'EFORMID',
		{
			name: 'DATELASTUPDATE',
			type: 'date'
		},
		{
			name: 'DATEACTIONWASDONE',
			type: 'date'
		},
		{
			name: 'RECDATECREATED',
			type: 'date'
		},
		'children',
		'text',
		{
			name: 'expanded',
			type: 'bool'
		},
		{
			name: 'leaf',
			type: 'bool'
		}
		
	]
});
