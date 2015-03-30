Ext.define('Form.controller.mymodel.mymodelcontroller', {
    extend: 'Ext.app.Controller',
	views: [
        'mymodel.mymodelView'
    ],
	models: [
	],
	stores: [
	],
	init: function() {
		console.log('init my model controller');
        this.control({
            
			'mymodelview': {  
				render: this.myModelRendered
			}
		});
     },
     myModelRendered: function(a,b) {
    	 console.log('my model was rendered');
    	Ext.define('My.sample.Person', {
		    name: 'Unknown',
		    constructor: function(name) {
		        if (name) {
		            this.name = name;
		        }
		    },
		    eat: function(foodType) {
		        console.log(this.name + " is eating: " + foodType);
		    }
		});
    	
    	var aaron = new My.sample.Person('Aaron');
        aaron.eat("Salad"); // alert("Aaron is eating: Salad");
     }
});