Ext.define('Form.model.form.defMainModel', {
	extend: 'Ext.data.Model',
	fields: [
		'EFORMID',
		'EFORMNAME',
		'DESCRIPTION',
		'EFORMGROUP',
		'FORMFLOWPROCESS',
		{
			name: 'ISENCRYPTED',
			type: 'boolean'
		},
		'LAYOUTQUERY',
		'VIEWAS',
		'FORMPADDING',
		'GROUPMARGIN',
		'BEFORELOAD',
		'AFTERLOAD',
		'BEFORESUBMIT',
		'AFTERSUBMIT',
		'BEFOREAPPROVE',
		'AFTERAPPROVE',
		'ONCOMPLETE',
		'ONBEFOREDELETE',
		'ONAFTERDELETE',
		'ONBEFOREROUTE',
		'ONAFTERROUTE',
		'COMPANYCODE',
		'AUDITTDSOURCE',
		'AUDITTNAME',
		'LOGDBSOURCE',
		'LOGTABLENAME',
		'LOGFILENAME',
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