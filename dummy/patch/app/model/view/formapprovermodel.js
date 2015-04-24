Ext.define('View.model.view.formapprovermodel', {
	extend: 'Ext.data.Model',
	fields: [
		'APPROVERSID',
		'ROUTERIDFK',
		'PROCESSIDFK',
		{
			name: 'APPROVERORDER',
			type: 'int'
		},
		'APPROVERNAME',
		{
			name: 'CANVIEWROUTEMAP',
			type: 'boolean'
		}, 
		{
			name: 'CANOVERRIDE',
			type: 'boolean'
		},
		{
			name: 'USERID',
			type: 'boolean'
		},
		'PERSONNELIDNO',
		'USERGRPID',
		'CONDITIONABOVE',
		'CONDITIONBELOW',
		'RECCREATEDBY',
		{
			name: 'DATELASTUPDATE',
			type: 'date'
		}
		
	]
});

