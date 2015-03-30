Ext.define('Form.controller.reminder.remindercontroller', {
    extend: 'Ext.app.Controller',
	
	views: [
		'reminder.App',
		'reminder.CalendarPanel',
        'reminder.reminderView',
        'reminder.Day',
        'reminder.AbstractCalendar',
        'reminder.DayBody',
        'reminder.DayHeader',
        'reminder.Month',
        'reminder.MonthDayDetail',
        'reminder.Week',
        'reminder.dd.DayDragZone',
        'reminder.dd.DayDropZone',
        'reminder.dd.DragZone',
        'reminder.dd.DropZone',
        'reminder.dd.StatusProxy',
        'reminder.form.field.CalendarCombo',
        'reminder.form.field.DateRange',
        'reminder.form.field.ReminderCombo',
        'reminder.form.EventDetails',
        'reminder.form.EventWindow',
        'reminder.template.BoxLayout',
        'reminder.template.DayBody',
        'reminder.template.DayHeader',
        'reminder.template.Month',
        'reminder.util.Date',
        'reminder.util.WeekEventRenderer'
    ],
	models: [
		'reminder.CalendarMappings',
		'reminder.CalendarModel',
		'reminder.Calendars',
		'reminder.EventMappings',
		'reminder.EventModel',
		'reminder.Events'
		
	],
	stores: [
		'reminder.MemoryCalendarStore',
		'reminder.MemoryEventStore'
	],
	
    init: function() {
		console.log('init controller');
        this.control({
            
			'reminderview button[action=viewtables]': {  
				
			}
			 
        });
    
	}
	
});