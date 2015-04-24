Ext.define('Form.view.form.eformStatusMap', {
	extend: 'Ext.draw.Component',
	alias: 'widget.eformstatusmap',
	title: 'Route Path',
	width: 4000,
	height: 5000,
	autoShow: true,
	viewBox: false,
	initComponent: function() {     
	     
	this.items = [{
        type: 'image',
        name: 'Name: Leonell A. Lagumbay \nPosition: Executive \nType: Auto',
        src: 'http://t2.gstatic.com/images?q=tbn:ANd9GcRb-hMuKtmV7ctrLGU4nOw01NkCYshvuiP_r8bNsz_WTK5KQwDQqg',
        width: 60,
        height: 60,
        listeners: {
            click: function(thiss) {
                alert(thiss.name);
            }
        },
        x: 60,
        y: 80
    },{
        type: 'path',
        fill: '#79BB3F',
        path: 'M120 95 L300 95 L300 85 L330 100 L300 115 L300 105  L120 105 Z'
    },{
        type: "text",
        text: "Leonell A. Lagumbay",
        fill: "green",
        font: "12px arial",
        x: 50,
        y: 70
    },{
        type: 'image',
        src: "http://fc02.deviantart.net/fs71/i/2012/331/b/2/pierre_leonell_by_rainmaker113-d5iewmh.png",
        width: 60,
        height: 60,
        x: 60,
        y: 180
    },{
        type: 'image',
        src: "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcQuL2ybZhuUJsG1Nb1Jx08hblhgdE23ZJ-X8FlQj4dl_WapSJAT",
        width: 60,
        height: 60,
        x: 60,
        y: 300
    },{
        type: "text",
        text: "Anne Hathaway",
        fill: "green",
        font: "12px arial",
        x: 50,
        y: 290
    },{
        type: 'path',
        fill: 'black',
        path: 'M120 315 L300 315 L300 305 L330 320 L300 335 L300 325  L120 325 Z'
    },{
        type: 'path',
        fill: 'black',
        path: 'M120 195 L300 195 L300 185 L330 200 L300 215 L300 205  L120 205 Z'
    },{
        type: "text",
        text: "James The Great",
        fill: "green",
        font: "12px arial",
        x: 50,
        y: 170
    },{
        type: 'rect',
        height: 90,
        width: 50,
        fill: '#0000FF',
        stroke: 'white',
        'stroke-width': 2,
        listeners: {
            click: function() {
                alert('Configure eForm Router');
            }
        },
        
        x: 330,
        y: 70
        
    },{
        type: 'rect',
        height: 90,
        width: 50,
		name: 'rect1',
        fill: '#0000FF',
        stroke: 'white',
        'stroke-width': 2,
        /*listeners: {
            click: function(thiss,eOpts) {
                alert('Configure eForm Router 2');
				
				//drawComponent.setWidth(100);
				thiss.surface.add({
				    type: 'circle',
				    fill: '#ffc',
				    radius: 100,
				    x: 100,
				    y: 100  
				}).show(true); 
            }
        }*/
        
        x: 330,
        y: 160
        
    },{
        type: 'rect',
        height: 100,
        width: 50,
        fill: 'yellow',
        stroke: 'white',
        'stroke-width': 2,
        x: 330,
        y: 250
        
    },{
        type: 'text',
        text: 'AND',
        fill: 'red',
        font: '20px Arial strong',
        x: 280,
        y: 150
    },{
        type: 'text',
        text: 'OR',
        fill: 'red',
        font: '20px Arial strong',
        x: 280,
        y: 260
    }];
		/*
		this.api = {
			load: Ext.ss.data.loadRec,
			submit: Ext.ss.data.submitRec  
	    };
		
		this.buttons = [{
			text: 'Load',
			action: 'load'
		},{
			text: 'Submit',
			action: 'submit'
		}];
		*/
		this.callParent(arguments);
	}

});
