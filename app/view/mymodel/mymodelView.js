Ext.define('Form.view.mymodel.mymodelView', { 
	extend: 'Ext.draw.Component',
	alias: 'widget.mymodelview',
	title: 'iBOS/e My Model',
	autoSize: true,
	width: '100%', 
	height: '100%',
	autoScroll: true,
	initComponent: function() {   
		this.items = [{
	        type: 'rect',
	        width: 300,
	        height: 50,
	        radius: 10,
	        fill: 'green',
	        //draggable: true,
	        opacity: 0.5,
	        stroke: 'red',
	        'stroke-width': 1
	    },{
	        type: 'circle',
	        radius: 90,
	        x: 100,
	        y: 100,
	        fill: 'blue'
	    },{
	        type: "ellipse",
	        radiusX: 100,
	        radiusY: 50,
	        x: 100,
	        y: 100,
	        fill: 'red'
	    },{
	        type: "path",
	        path: "M-66.6 26C-66.6 26 -75 22 -78.2 18.4C-81.4 14.8 -80.948 19.966 " +
	              "-85.8 19.6C-91.647 19.159 -90.6 3.2 -90.6 3.2L-94.6 10.8C-94.6 " +
	              "10.8 -95.8 25.2 -87.8 22.8C-83.893 21.628 -82.6 23.2 -84.2 " +
	              "24C-85.8 24.8 -78.6 25.2 -81.4 26.8C-84.2 28.4 -69.8 23.2 -72.2 " +
	              "33.6L-66.6 26z",
	        fill: "purple"
	    },{
	        type: "text",
	        text: "Hello, Sprite!",
	        fill: "green",
	        font: "18px monospace"
	    }
//	    ,{
//	        type: "image",
//	        src: "http://www.sencha.com/img/apple-touch-icon.png",
//	        width: 200,
//	        height: 200
//	    }
	    ];
		
		this.callParent(arguments);
	}
});