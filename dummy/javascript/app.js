Ext.Loader.setConfig({ 
    enabled: true
});
 
Ext.application({
    
    name: 'MyApp',
    
    appFolder: 'app',
    
    controllers: [
                  'Signature'
              ],
    
      launch: function() {
          Ext.create('Ext.container.Viewport', {
             margin: 10, 
             defaults: {
                margin: 10,
             }, 
               items: [{
                      xtype: 'label',
                      html: '<b>Capture signature using using HTML5 canvas</b>'
                  },
                   
                  {
                      xtype: 'signatureCapture',
                  },
                  {
                    xtype: 'button',
                    text: 'Save Signature',
                    id: 'save',
                    disabled: true,
                  },
                  {
                    xtype: 'button',
                    text: 'Clear Signature',
                    id: 'clear'
                }]
          });
      }
    
});
