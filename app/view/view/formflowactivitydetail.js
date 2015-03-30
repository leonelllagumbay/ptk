var maxapproversInRouter = 2;
var maxroutersInProcess = 2;
var processWidth = 300 + 550*maxroutersInProcess;
var processHeight = 200*maxapproversInRouter;
var processHeightMain = 200 + 200*maxapproversInRouter;
var xr1 = 300;
var yr1 = 120;
var xr2 = xr1 + 500;
var yr2 = 120;
var yr2b = 320;
var xr3 = xr2 + 500;
var yr3 = 120;

var ar1path = 'M' + (xr1-160) + ' ' + (yr1+72) + ' L' + (xr1-40) + ' ' + (yr1+72) + ' L' + (xr1-40) + ' ' + (yr1+62) + ' L' + (xr1-10) + ' ' + (yr1+77) + ' L' + (xr1-40) + ' ' + (yr1+92) + ' L'+ (xr1-40) + ' ' + (yr1+82) + ' L' + (xr1-160) + ' ' + (yr1+82) + ' Z'; //M(xr1-160) (yr1+72) L(xr1-40) (yr1+72) L(xr1-40) (yr1+62) L(xr1-10) (yr1+77) L(xr1-40) (yr1+92) L(xr1-40) (yr1+82) L(xr1-160) (yr1+82) Z
var ar2path = 'M' + (xr2-160) + ' ' + (yr2+72) + ' L' + (xr2-40) + ' ' + (yr2+72) + ' L' + (xr2-40) + ' ' + (yr2+62) + ' L' + (xr2-10) + ' ' + (yr2+77) + ' L' + (xr2-40) + ' ' + (yr2+92) + ' L'+ (xr2-40) + ' ' + (yr2+82) + ' L' + (xr2-160) + ' ' + (yr2+82) + ' Z'; 
var ar2pathb = 'M' + (xr2-440) + ' ' + (yr2+72) + ' L' + (xr2-320) + ' ' + (yr2+72) + ' L' + (xr2-320) + ' ' + (yr2+62) + ' L' + (xr2-290) + ' ' + (yr2+77) + ' L' + (xr2-320) + ' ' + (yr2+92) + ' L'+ (xr2-320) + ' ' + (yr2+82) + ' L' + (xr2-440) + ' ' + (yr2+82) + ' Z';

Ext.define('Form.view.view.formflowactivitydetail', {      
	extend: 'Ext.draw.Component',
	alias: 'widget.formflowform', 
	width: processWidth + 100,
	height: processHeightMain,
    title: 'Chat form test',
	autoShow: true,
	viewBox: false,
	initComponent: function() {     
	     
	this.items = [{
        type: "text",
        text: "Name: The Router - Automatic APPROVED on 12/12/2014",
        fill: "green",
        font: "14px arial",
        x: 5,
        y: 15
    },{
        type: 'rect',
        height: processHeight,
        width: 50,
        fill: 'yellow',
        stroke: 'white',
        'stroke-width': 2,
        x: xr1,
        y: yr1 
        
    },{
        type: "text",
        text: "0",
        fill: "black",
        font: "14px arial",
        x: xr1, 
        y: yr1-70 
    },{
        type: "text",
        text: "Until: 01/12/2014",
        fill: "black",
        font: "12px arial",
        x: xr1, 
        y: yr1-55 
    },{
        type: "text",
        text: "Date Completed: 01/10/2014",
        fill: "black",
        font: "12px arial",
        x: xr1, 
        y: yr1-40 
    },{
        type: "text",
        text: "At least: 4",
        fill: "black",
        font: "12px arial",
        x: xr1, 
        y: yr1-25 
    },{
        type: "text",
        text: "Status: DONE",
        fill: "black",
        font: "12px arial",
        x: xr1, 
        y: yr1-10 
    },{
        type: 'rect',
        height: processHeight,
        width: 50,
        fill: 'yellow',
        stroke: 'white',
        'stroke-width': 2,
        x: xr2, 
        y: yr2 
        
    },{
        type: "text",
        text: "1",
        fill: "black",
        font: "14px arial",
        x: xr2, 
        y: yr2-70 
    },{
        type: "text",
        text: "Until: 01/12/2014",
        fill: "black",
        font: "12px arial",
        x: xr2, 
        y: yr2-55 
    },{
        type: "text",
        text: "Date Completed: 01/10/2014",
        fill: "black",
        font: "12px arial",
        x: xr2, 
        y: yr2-40 
    },{
        type: "text",
        text: "At least: 4",
        fill: "black",
        font: "12px arial",
        x: xr2, 
        y: yr2-25 
    },{
        type: "text",
        text: "Status: DONE",
        fill: "black",
        font: "12px arial",
        x: xr2, 
        y: yr2-10  
    },{
        type: 'rect',
        height: processHeight,
        width: 50,
        fill: 'yellow',
        stroke: 'white',
        'stroke-width': 2,
        x: xr3, 
        y: yr3 
        
    },{
        type: "text",
        text: "2",
        fill: "black",
        font: "14px arial",
        x: xr3, 
        y: yr3-70 
    },{
        type: "text",
        text: "Until: 01/12/2014",
        fill: "black",
        font: "12px arial",
        x: xr3, 
        y: yr3-55 
    },{
        type: "text",
        text: "Date Completed: 01/10/2014",
        fill: "black",
        font: "12px arial",
        x: xr3, 
        y: yr3-40 
    },{
        type: "text",
        text: "At least: 4",
        fill: "black",
        font: "12px arial",
        x: xr3, 
        y: yr3-25 
    },{
        type: "text",
        text: "Status: DONE",
        fill: "black",
        font: "12px arial",
        x: xr3, 
        y: yr3-10 
    },{
        type: 'image',
        name: 'Name: Leonell A. Lagumbay \nPosition: Executive \nType: Auto',
        src: 'http://t2.gstatic.com/images?q=tbn:ANd9GcRb-hMuKtmV7ctrLGU4nOw01NkCYshvuiP_r8bNsz_WTK5KQwDQqg',
        width: 106,
        height: 106, 
        listeners: {
            click: function(thiss) {
                alert(thiss.name);
            }
        },
        x: xr1-270,
        y: yr1+20
    },{
        type: 'path',
        fill: 'black',
        path: ar1path  
    },{ 
        type: "text",
        text: "Leonell A. Lagumbay",
        fill: "green",
        font: "12px arial",
        x: xr1-270, 
        y: yr1+140 
    },{
        type: "text",
        text: "Programmer/Developer",
        fill: "green",
        font: "12px arial",
        x: xr1-270, 
        y: yr1+155 
    },{
        type: "text",
        text: "Originator",
        fill: "green",
        font: "12px arial",
        x: xr1-270, 
        y: yr1+170
    },{
        type: "text",
        text: "APPROVE",
        fill: "black",
        font: "12px arial",
        x: xr1-270,  
        y: yr1+10
    },{
        type: "text",
        text: "01/12/2014",
        fill: "green",
        font: "12px arial",
        x: xr1-160, 
        y: yr1+40
    },{
        type: "text",
        text: "Elapsed: 5 hours",
        fill: "green",
        font: "12px arial",
        x: xr1-160, 
        y: yr1+55
    },{
        type: 'image',
        name: 'Name: Leonora A. Lagumbay \nPosition: Executive \nType: Auto',
        src: 'http://t2.gstatic.com/images?q=tbn:ANd9GcRb-hMuKtmV7ctrLGU4nOw01NkCYshvuiP_r8bNsz_WTK5KQwDQqg',
        width: 106,
        height: 106, 
        listeners: {
            click: function(thiss) {
                alert(thiss.name);
            }
        },
        x: xr2-270,
        y: yr2+20
    },{
        type: 'path',
        fill: '#79BB3F',
        path: ar2path  
    },{
        type: 'path',
        fill: '#79BB3F',
        path: ar2pathb 
    },{ 
        type: "text",
        text: "Leonell A. Lagumbay",
        fill: "green",
        font: "12px arial",
        x: xr2-270, 
        y: yr2+140 
    },{
        type: "text",
        text: "Programmer/Developer",
        fill: "green",
        font: "12px arial",
        x: xr2-270, 
        y: yr2+155 
    },{
        type: "text",
        text: "Originator",
        fill: "green",
        font: "12px arial",
        x: xr2-270, 
        y: yr2+170
    },{
        type: "text",
        text: "PENDING",
        fill: "black",
        font: "12px arial",
        x: xr2-270,  
        y: yr2+10
    },{
        type: "text",
        text: "01/12/2014",
        fill: "green",
        font: "12px arial",
        x: xr2-160, 
        y: yr2+40
    },{
        type: "text",
        text: "Elapsed: 5 hours",
        fill: "green",
        font: "12px arial",
        x: xr2-160, 
        y: yr2+55
    },{
        type: 'image',
        name: 'Name: Leonora A. Lagumbay \nPosition: Executive \nType: Auto',
        src: 'http://t2.gstatic.com/images?q=tbn:ANd9GcRb-hMuKtmV7ctrLGU4nOw01NkCYshvuiP_r8bNsz_WTK5KQwDQqg',
        width: 106,
        height: 106, 
        listeners: {
            click: function(thiss) {
                alert(thiss.name);
            }
        },
        x: xr2-270,
        y: yr2b+20
    },{
        type: 'path',
        fill: '#79BB3F',
        path: 'M' + (xr2-160) + ' ' + (yr2b+72) + ' L' + (xr2-40) + ' ' + (yr2b+72) + ' L' + (xr2-40) + ' ' + (yr2b+62) + ' L' + (xr2-10) + ' ' + (yr2b+77) + ' L' + (xr2-40) + ' ' + (yr2b+92) + ' L'+ (xr2-40) + ' ' + (yr2b+82) + ' L' + (xr2-160) + ' ' + (yr2b+82) + ' Z'
    },{
        type: 'path',
        fill: '#79BB3F',
        path:  'M' + (xr2-440) + ' ' + (yr2b+72) + ' L' + (xr2-320) + ' ' + (yr2b+72) + ' L' + (xr2-320) + ' ' + (yr2b+62) + ' L' + (xr2-290) + ' ' + (yr2b+77) + ' L' + (xr2-320) + ' ' + (yr2b+92) + ' L'+ (xr2-320) + ' ' + (yr2b+82) + ' L' + (xr2-440) + ' ' + (yr2b+82) + ' Z'
    },{ 
        type: "text",
        text: "Leonell A. Lagumbay",
        fill: "green",
        font: "12px arial",
        x: xr2-270, 
        y: yr2b+140 
    },{
        type: "text",
        text: "Programmer/Developer",
        fill: "green",
        font: "12px arial",
        x: xr2-270, 
        y: yr2b+155 
    },{
        type: "text",
        text: "Originator",
        fill: "green",
        font: "12px arial",
        x: xr2-270, 
        y: yr2b+170
    },{
        type: "text",
        text: "PENDING",
        fill: "black",
        font: "12px arial",
        x: xr2-270,  
        y: yr2b+10
    },{
        type: "text",
        text: "01/12/2014",
        fill: "green",
        font: "12px arial",
        x: xr2-160, 
        y: yr2b+40
    },{
        type: "text",
        text: "Elapsed: 5 hours",
        fill: "green",
        font: "12px arial",
        x: xr2-160, 
        y: yr2b+55
    }];

		this.callParent(arguments);
	}

});
