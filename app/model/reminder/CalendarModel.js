Ext.define('Form.model.reminder.CalendarModel', {
	extend: 'Ext.data.Model',
	fields: [{
	        name:    'CalendarId',
	        mapping: 'id',
	        type:    'int'
	    },{
	        name:    'Title',
	        mapping: 'title',
	        type:    'string'
	    },{
	        name:    'Description', 
	        mapping: 'desc',   
	        type:    'string' 
	    },{
	        name:    'ColorId',
	        mapping: 'color',
	        type:    'int'
	    },{
	        name:    'IsHidden',
	        mapping: 'hidden',
	        type:    'boolean'
	    }]
});
