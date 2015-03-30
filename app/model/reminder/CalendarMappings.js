Ext.define('Form.model.reminder.CalendarMappings', {
	extend: 'Ext.data.Model', 
	fields: [{
	    CalendarId: {
	        name:    'CalendarId',
	        mapping: 'id',
	        type:    'int'
	    },
	    Title: {
	        name:    'Title',
	        mapping: 'title',
	        type:    'string'
	    },
	    Description: {
	        name:    'Description', 
	        mapping: 'desc',   
	        type:    'string' 
	    },
	    ColorId: {
	        name:    'ColorId',
	        mapping: 'color',
	        type:    'int'
	    },
	    IsHidden: {
	        name:    'IsHidden',
	        mapping: 'hidden',
	        type:    'boolean'
	    }
	}]

});