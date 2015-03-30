Ext.define('Form.model.form.defColumnModel', {
	extend: 'Ext.data.Model',
	fields: [
		'COLUMNID',
		'TABLEIDFK',  
		'COLUMNNAME',
		'FIELDLABEL',
		'FIELDLABELWIDTH',
		{
			name: 'COLUMNORDER',
			type: 'int'
		},
		'COLUMNTYPE',
		'XTYPE',
		'COLUMNGROUP',
		'FIELDLABELALIGN',
		{
			name: 'ALLOWBLANK',
			type: 'boolean'
		},
		{
			name: 'ISCHECKED',
			type: 'boolean'
		},
		'CSSCLASS',
		{
			name: 'ISDISABLED',
			type: 'boolean'
		},
		'HEIGHT',
		'WIDTH',
		{
			name: 'MININPUTVALUE',
			type: 'int'
		},
		{
			name: 'MAXINPUTVALUE',
			type: 'int'
		},
		{
			name: 'MINCHARLENGTH',
			type: 'int'
		},
		{
			name: 'MAXCHARLENGTH',
			type: 'int'
		},
		{
			name: 'ISHIDDEN',
			type: 'boolean'
		},
		'INPUTID',
		'MARGIN',
		'PADDING',
		'BORDER',
		'STYLE',
		{
			name: 'ISREADONLY',
			type: 'boolean'
		},
		'UNCHECKEDVALUE',
		'INPUTVALUE',
		'VALIDATIONTYPE',
		'VTYPETEXT',
		'RENDERER',
		{
			name: 'XPOSITION',
			type: 'int'
		},
		{
			name: 'YPOSITION',
			type: 'int'
		},
		'ANCHORPOSITION',
		'INPUTFORMAT',
		
		'CHECKITEMS',
		'NOOFCOLUMNS',
		'AUTOGENTEXT',
		'COMBOLOCALDATA',
		'COMBOREMOTEDATA',
		'EDITABLEONROUTENO', 
		
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
