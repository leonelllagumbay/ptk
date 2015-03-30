Ext.define('Form.model.forum.forumListModel', {
	extend: 'Ext.data.Model',
	fields: [
		'FORUMCODE',
		'DESCRIPTION',
		'PERSONNELIDNO',
		'EFORUMEMAIL',
		{
			name: 'UNREAD',
			type: 'int'
		},
		{
			name: 'ALLOWEMAILNOTIF',
			type: 'boolean'
		},
		'COMPANYCODE',
		{
			name: 'DATELASTUPDATE',      
			type: 'date'
		}
	]
})