Ext.define('Form.model.reminder.EventModel', {
	extend: 'Ext.data.Model',
	fields: [{
	        name: 'EventId',
	        mapping: 'id',
	        type: 'string'
	    },{
	        name: 'CalendarId',
	        mapping: 'cid',
	        type: 'int'
	    },{
	        name: 'Title',
	        mapping: 'title',
	        type: 'string'
	    },{
	        name: 'StartDate',
	        mapping: 'start',
	        type: 'date',
	        dateFormat: 'c'
	    },{
	        name: 'EndDate',
	        mapping: 'end',
	        type: 'date',
	        dateFormat: 'c'
	    },{
	        name: 'Location',
	        mapping: 'loc',
	        type: 'string'
	    },{
	        name: 'Notes',
	        mapping: 'notes',
	        type: 'string'
	    },{
	        name: 'Url',
	        mapping: 'url',
	        type: 'string'
	    },{
	        name: 'IsAllDay',
	        mapping: 'ad',
	        type: 'boolean'
	    },{
	        name: 'Reminder',
	        mapping: 'rem',
	        type: 'string'
	    },{
	        name: 'IsNew',
	        mapping: 'n',
	        type: 'boolean'
	    },{
	        name: 'TheQuery',
	        mapping: 'dquery',
	        type: 'string'
	    }]
});