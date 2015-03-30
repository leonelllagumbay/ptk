Ext.define('Form.controller.form.Signature', {
    extend : 'Ext.app.Controller',
    
    //define the views
    views : [

	],
	
    
    init : function() {
        this.control({
            
        });
    },
    
    
 
    onClearSignature: function(button,canvasid,inputid) {
        var signPad = Ext.getDom(canvasid);
        signPad.width = signPad.width;
        var view = button.up('form');
        console.log(view);
        var saveButton = view.down('button[action=save' + inputid + ']');
        console.log(inputid);
		saveButton.disable();
    },
    
    onSaveSignature: function(btn,canvasid,inputid) {
        console.log('Save Signature button clicked!');
        //Returns the content of the current canvas as an image that you can 
        //use as a source for another canvas or an HTML element 
        var signPad = Ext.getDom(canvasid);
        btn.getEl().mask("Saving...");
        var formGrid = Ext.ComponentQuery.query('grid[alias=widget.eFormGrid]')[0];
        var selGridData = formGrid.getSelectionModel().getSelection()[0];
        var arrKeys = Object.keys(selGridData.data);
        var processid = "";
        for(b = 0; b < arrKeys.length; b++) {
        	if(arrKeys[b].search("__PROCESSID") != -1) {
        		processid = arrKeys[b];
        		break;
        	}
        }
        var strP = "selGridData.data." + processid;
        var theprocessid = eval(strP);
        console.log(theprocessid);
       
        var data = signPad.toDataURL();
        //var signatureData = data.replace(/^data:image\/(png|jpg);base64,/, "");
        
        //create a Direct request
        Ext.ss.Complements.saveSignature(data, theprocessid, inputid, function(resp) {
        	console.log(resp);
        	btn.getEl().unmask();
        	if(resp == "true") {
        		this.onSaveSuccess
        	} else {
        		this.onSaveFailure
        	}
        });

    },
      
    onPanelRendered: function(panel, canvasid, saveref, clearref, inputid) {
    	console.log('Signature Panel rendered, get ready to Sign!');
        
        var view = panel.up('form');
        
        var saveButton = view.down('button[action=' + saveref + ']');
        
        
        //get the signature capture panel
        var signPad = Ext.getDom(canvasid);
        console.log(signPad);
        
        if (signPad && signPad.getContext) {
            var signPadContext = signPad.getContext('2d');
        }
 
        if (!signPad || !signPadContext) {
            alert('Error creating signature pad.');
            return;
        }
        
        var mySignP = Ext.get('sp'+inputid);
        signPad.width = mySignP.getWidth();
        signPad.height = mySignP.getHeight();
        console.log('touchpad1');
        if(typeof signPadObj === 'undefined') {
        	signPadObj = new Object();
        }
        if(typeof saveBtn === 'undefined') {
        	saveBtn = new Object();
        }
        saveBtn[canvasid] = saveButton;
        signPadObj[canvasid] = signPadContext;
        
        sign = new this.signCap(saveButton, signPadContext);
        signPadContext.lineWidth = 2;
        //Mouse events
        signPad.addEventListener('mousedown', this.eventSignPad, false);
        signPad.addEventListener('mousemove', this.eventSignPad, false);
        signPad.addEventListener('mouseup', this.eventSignPad, false);
         console.log('touchpad2');
        //Touch screen events
        signPad.addEventListener('touchstart', this.eventSignPad, false);
        signPad.addEventListener('touchmove', this.eventSignPad, false);
        signPad.addEventListener('touchend', this.eventSignPad, false);
         console.log('touchpad3');
        
        
        try {
	        var formGrid = Ext.ComponentQuery.query('grid[alias=widget.eFormGrid]')[0];
	        var selGridData = formGrid.getSelectionModel().getSelection()[0];
	        var arrKeys = Object.keys(selGridData.data);
	        var processid = "";
	        for(b = 0; b < arrKeys.length; b++) {
	        	if(arrKeys[b].search("__PROCESSID") != -1) {
	        		processid = arrKeys[b];
	        		break;
	        	}
	        }
	        var strP = "selGridData.data." + processid;
	        var theprocessid = eval(strP);
	        
	        
	        Ext.ss.Complements.getSignature(theprocessid, inputid, function(resp) {
	        	var myImage = new Image();
				myImage.src = resp;
	        	signPadContext.drawImage(myImage, 0, 0);
	        	var theApproveB = Ext.ComponentQuery.query('button[action=approve]')[0];
	        	var theSaveB = Ext.ComponentQuery.query('button[action=save]')[0];
	        	var theAddB = Ext.ComponentQuery.query('button[action=add]')[0];
	        	
	        	var clearButton = view.down('button[action='+ clearref + ']');
	        	
	        	var resBool = (resp.length > 30 && !(theApproveB.hidden));
				if(resBool) {
					//disable the buttons
					if ((theSaveB.hidden) || (!(theAddB.hidden))) {
						saveButton.hide();
						clearButton.hide();
					} 
				} else {
					if (!(theAddB.hidden)) {
						saveButton.hide();
						clearButton.hide();
					} 
				}
	        });
        
        } catch(e) {
        	console.log('signature error');
        	console.log(e);
        	saveButton.hide();
			clearButton = view.down('button[action=' + clearref + ']');
			clearButton.hide();
        }
        

    },
    
    signCap: function(sb,signPadContext)  {
    	var saveButton = sb;
    	sign = this;
        this.draw = false;
        this.start = false;
        
        this.mousedown = function(event) {
        	var id = event.srcElement.id;
        	var signPadContext = signPadObj[id];
            signPadContext.beginPath();
            signPadContext.arc(event._x, event._y,1,0*Math.PI,2*Math.PI);
            signPadContext.fill();
            signPadContext.stroke();
            signPadContext.moveTo(event._x, event._y);
            sign.draw = true;
            var saveButton = saveBtn[id];
            saveButton.enable();
        };
 
        this.mousemove = function(event) {
        	var id = event.srcElement.id;
        	var signPadContext = signPadObj[id];
        	if (sign.draw) {
                signPadContext.lineTo(event._x, event._y);
                signPadContext.stroke();
            }
        };
 
        this.mouseup = function(event) {
            if (sign.draw) {
                sign.mousemove(event);
                sign.draw = false;
            }
        };
        
        this.touchstart = function(event) {
        	var id = event.srcElement.id;
        	var signPadContext = signPadObj[id];
            signPadContext.beginPath();
            signPadContext.arc(event._x, event._y,1,0*Math.PI,2*Math.PI);
            signPadContext.fill();
            signPadContext.stroke();
            signPadContext.moveTo(event._x, event._y);
            sign.start = true;
            var saveButton = saveBtn[id];
            saveButton.enable();
        };
 
        this.touchmove = function(event) {
        	var id = event.srcElement.id;
        	var signPadContext = signPadObj[id];
            event.preventDefault(); 
            if (sign.start) {
                signPadContext.lineTo(event._x, event._y);
                signPadContext.stroke();
            }
        };
 
        this.touchend = function(event) {
            if (sign.start) {
                sign.touchmove(event);
                sign.start = false;
            }
        };
    },
 
    eventSignPad: function(event) {
    	if (event.offsetX || event.offsetX == 0) {
            event._x = event.offsetX;
            event._y = event.offsetY;
        } else if (event.layerX || event.layerX == 0) {
            event._x = event.layerX;
            event._y = event.layerY;
        }
        
        var func = sign[event.type];
        if (func) {
            func(event);
        }
   
    },
    
    eventTouchPad: function(event,inputid) {
    	console.log('touchpadend1');
        var mySign = Ext.get("sp"+inputid);
        event._x = event.targetTouches[0].pageX - mySign.getX();
        event._y = event.targetTouches[0].pageY - mySign.getY();
        
        var func = sign[event.type];
        if (func) {
            func(event);
        }
        console.log('touchpadend');
    },
    
    onSaveFailure : function(err) {
        //Alert the user about communication error
        Ext.MessageBox.alert('Error occured during saving the signature', 'Please try again!');
    },
 
    onSaveSuccess : function(response, opts) {
        //Received response from the server
        //response = Ext.decode(response.responseText);
    }
    
            
});