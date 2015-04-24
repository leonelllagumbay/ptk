Ext.define('MyApp.controller.Signature', {
    extend : 'Ext.app.Controller',
    
    //define the views
    views : ['SignatureCapture'],
    //define refs
    refs: [{
        ref: 'mySignature', 
        selector: 'panel[id="signature"]'
    }], 
    
    init : function() {
        this.control({
            
            'signatureCapture' : {
                afterrender : this.onPanelRendered
            },
            'viewport button[id=clear]' : {
                click : this.onClearSignature   
            }
            ,
            'viewport button[id=save]' : {
                click : this.onSaveSignature   
            }
        });
    },
 
    onClearSignature: function(button) {
        console.log('Clear Signature button clicked!');
        signPad.width = signPad.width;
        signPadContext.lineWidth = 3;
        saveButton.disable();
    },
    
    onSaveSignature: function() {
        console.log('Save Signature button clicked!');
        //Returns the content of the current canvas as an image that you can 
        //use as a source for another canvas or an HTML element 
        var data = signPad.toDataURL();
        var signatureData = data.replace(/^data:image\/(png|jpg);base64,/, "");
        
        //create an AJAX request
        Ext.Ajax.request({
            url : 'SaveSignature.java',
            method:'POST', 
            params : {
                'signatureData' : signatureData
            },
            scope : this,
            //method to call when the request is successful
            success : this.onSaveSuccess,
            //method to call when the request is a failure
            failure : this.onSaveFailure
        }); 
    },
      
    onPanelRendered: function(panel) {
        console.log('Signature Panel rendered, get ready to Sign!');
        
        var view = panel.up('viewport');
        saveButton = view.down('button[id=save]');
        
        //get the signature capture panel
        signPad = Ext.getDom("signaturePanel");
        if (signPad && signPad.getContext) {
            signPadContext = signPad.getContext('2d');
        }
 
        if (!signPad || !signPadContext) {
            alert('Error creating signature pad.');
            return;
        }
        
        signPad.width = this.getMySignature().getWidth();
        signPad.height = this.getMySignature().getHeight();
        
        //Mouse events
        signPad.addEventListener('mousedown', this.eventSignPad, false);
        signPad.addEventListener('mousemove', this.eventSignPad, false);
        signPad.addEventListener('mouseup', this.eventSignPad, false);
        
        //Touch screen events
        signPad.addEventListener('touchstart', this.eventTouchPad, false);
        signPad.addEventListener('touchmove', this.eventTouchPad, false);
        signPad.addEventListener('touchend', this.eventTouchPad, false);
        
        sign = new this.signCap();
        signPadContext.lineWidth = 3;
    },
    
    signCap: function()  {
        var sign = this;
        this.draw = false;
        this.start = false;
        
        this.mousedown = function(event) {
            signPadContext.beginPath();
            signPadContext.arc(event._x, event._y,1,0*Math.PI,2*Math.PI);
            signPadContext.fill();
            signPadContext.stroke();
            signPadContext.moveTo(event._x, event._y);
            sign.draw = true;
            saveButton.enable();
        };
 
        this.mousemove = function(event) {
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
            signPadContext.beginPath();
            signPadContext.arc(event._x, event._y,1,0*Math.PI,2*Math.PI);
            signPadContext.fill();
            signPadContext.stroke();
            signPadContext.moveTo(event._x, event._y);
            sign.start = true;
            saveButton.enable();
        };
 
        this.touchmove = function(event) {
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
    
    eventTouchPad: function(event) {
        
        var mySign = Ext.get("signature");
        //in the case of a mouse there can only be one point of click
        //but when using a touch screen you can touch at multiple places
        //at the same time. Here we are only concerned about the first
        //touch event. Next we get the canvas element's left and Top offsets 
        //and deduct them from the current coordinates to get the position
        //relative to the canvas 0,0 (x,y) reference.
        event._x = event.targetTouches[0].pageX - mySign.getX();
        event._y = event.targetTouches[0].pageY - mySign.getY();
        
        var func = sign[event.type];
        if (func) {
            func(event);
        }
        
    },
    
    onSaveFailure : function(err) {
        //Alert the user about communication error
        Ext.MessageBox.alert('Error occured during saving the signature', 'Please try again!');
    },
 
    onSaveSuccess : function(response, opts) {
        //Received response from the server
        response = Ext.decode(response.responseText);
        Ext.MessageBox.alert('Save Successful', 'File name is: ' + response.fileName);
    },
    
            
});