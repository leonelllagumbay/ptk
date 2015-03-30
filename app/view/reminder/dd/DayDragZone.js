/*
 * Internal drag zone implementation for the calendar day and week views.
 */
Ext.define('Form.view.reminder.dd.DayDragZone', {
    extend: 'Form.view.reminder.dd.DragZone',
    /**
    requires: [
        'Ext.calendar.data.EventMappings'
    ],
    **/

    ddGroup: 'DayViewDD',
    resizeSelector: '.ext-evt-rsz',

    getDragData: function(e) {
        var t = e.getTarget(this.resizeSelector, 2, true),
            p,
            rec;
        if (t) {
            p = t.parent(this.eventSelector);
            rec = this.view.getEventRecordFromEl(p);

            return {
                type: 'eventresize',
                ddel: p.dom,
                eventStart: rec.data[Form.model.reminder.EventMappings.getFields()[0].StartDate.name],
                eventEnd: rec.data[Form.model.reminder.EventMappings.getFields()[0].EndDate.name],
                proxy: this.proxy
            };
        }
        t = e.getTarget(this.eventSelector, 3);
        if (t) {
            rec = this.view.getEventRecordFromEl(t);
            return {
                type: 'eventdrag',
                ddel: t,
                eventStart: rec.data[Form.model.reminder.EventMappings.getFields()[0].StartDate.name],
                eventEnd: rec.data[Form.model.reminder.EventMappings.getFields()[0].EndDate.name],
                proxy: this.proxy
            };
        }

        // If not dragging/resizing an event then we are dragging on
        // the calendar to add a new event
        t = this.view.getDayAt(e.getPageX(), e.getPageY());
        if (t.el) {
            return {
                type: 'caldrag',
                dayInfo: t,
                proxy: this.proxy
            };
        }
        return null;
    }
});