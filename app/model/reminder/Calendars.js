Ext.define('Form.model.reminder.Calendars', {
    statics: {
        getData: function(){
            return {
                "calendars":[{
                    "id":    1,
                    "title": "Home"
                },{
                    "id":    2,
                    "title": "Work"
                },{
                    "id":    3,
                    "title": "School"
                },{
                    "id":    4,
                    "title": "Sports"
                },{
                    "id":    5,
                    "title": "Family"
                }]
            };    
        }
    }
});