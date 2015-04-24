Ext.define('View.model.view.formflowprocessmodel', {
	extend: 'Ext.data.Model',
	fields: [
		'PROCESSID',
		'PROCESSNAME',
		'GROUPNAME',
		'COMPANYCODE',
		'DESCRIPTION',
		{
			name: 'EFORMLIFE',
			type: 'int'
		},
		'EXPIREDACTION',
		'RECCREATEDBY',
		{
			name: 'DATELASTUPDATE',
			type: 'date'
		}
		
	]
});

