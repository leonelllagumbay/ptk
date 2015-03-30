Ext.define('Form.model.view.formroutermodel', {
	extend: 'Ext.data.Model',  
	fields: [
		'ROUTERID',
		'PROCESSIDFK',
		'ROUTERNAME',
		'DESCRIPTION',
		{
			name: 'EFORMSTAYTIME',
			type: 'float'
		},
		{
			name: 'FREQUENCYFOLLOUP',
			type: 'float'
		},
		{
			name: 'NOTIFYNEXTAPPROVERS',
			type: 'boolean'
		}, 
		{
			name: 'NOTIFYALLAPPROVERS',
			type: 'boolean'
		}, 
		{
			name: 'NOTIFYORIGINATOR',
			type: 'boolean'
		},
		'EXPIREDACTION',
		{
			name: 'APPROVEATLEAST',
			type: 'int'
		}, 
		{
			name: 'USECONDITIONS',
			type: 'boolean'
		}, 
		{
			name: 'AUTOAPPROVE',
			type: 'boolean'
		}, 
		{
			name: 'ROUTERORDER',
			type: 'int'
		}, 
		{
			name: 'ISLASTROUTER',
			type: 'boolean'
		}, 
		{
			name: 'MAXIMUMAPPROVERS',
			type: 'int'
		}, 
		{
			name: 'CANOVERRIDE',
			type: 'boolean'
		}, 
		'MOREEMAILADD',
		'RECCREATEDBY',
		{
			name: 'DATELASTUPDATE',
			type: 'date'
		}
		
	]
});

