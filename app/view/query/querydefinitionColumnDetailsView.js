Ext.define('Form.view.query.querydefinitionColumnDetailsView', { 
	extend: 'Ext.form.Panel',
	alias: 'widget.querydefinitioncolumndetailsview',
	title: 'eQuery Definition Column Details',
	width: '100%', 
	height: '100%',
	autoScroll: true,
	initComponent: function() {   
		this.tbar = [{
		  	text: 'Query List',
			action: 'querylist'
		  },{
		  	text: 'Query Column List',
			action: 'querycolumnlist'
		  },{
		  	text: 'Preview',
			action: 'previewquery'
	    }];
		this.defaults = {
				xtype: 'textfield',
				labelWidth: 150,
				padding: '8 0 0 50',
				width: 400
		};
		
		this.items = [{
			name: 'EVIEWFIELDCODE',
			xtype: 'hiddenfield',
			allowBlank: true
		},{
			fieldLabel: 'Output type',
			xtype: 'radiogroup',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Override database and default output type"
		            });
		        }
		    },
		    columns: 2,
		    items: [{
		    	boxLabel: 'string',
		    	name: 'OUTPUTTYPE',
			    inputValue: 'string'
		    },{
		    	boxLabel: 'boolean',
		    	name: 'OUTPUTTYPE',
			    inputValue: 'boolean'
		    },{
		    	boxLabel: 'date',
		    	name: 'OUTPUTTYPE',
			    inputValue: 'date'
		    },{
		    	boxLabel: 'int',
		    	name: 'OUTPUTTYPE',
			    inputValue: 'int'
		    },{
		    	boxLabel: 'float',
		    	name: 'OUTPUTTYPE',
			    inputValue: 'float'
		    }]
		},{
			name: 'COLUMNACTIVEITEM',
			fieldLabel: 'Active Item',
			maxLength: 30,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "A string component id or the numeric index of the component that should be initially activated within the container's layout on render. For example, activeItem: 'item-1' or activeItem: 0 (index 0 = the first item in the container's collection). activeItem only applies to layout styles that can display items one at a time (like Ext.layout.container.Card and Ext.layout.container.Fit)."
		            });
		        }
		    }
		},{
			fieldLabel: 'Align',
			xtype: 'radiogroup',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Sets the alignment of the header and rendered columns. Possible values are: 'left', 'center', and 'right'.\nDefaults to: 'left'"
		            });
		        }
		    },
		    columns: 3,
		    items: [{
		    	boxLabel: 'left',
		    	name: 'COLUMNALIGN',
			    inputValue: 'left'
		    },{
		    	boxLabel: 'right',
		    	name: 'COLUMNALIGN',
			    inputValue: 'right'
		    },{
		    	boxLabel: 'center',
		    	name: 'COLUMNALIGN',
			    inputValue: 'center'
		    }]
		},{
			name: 'CACTIONALTTEXT',
			fieldLabel: 'Alt text',
			maxLength: 40,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "The alt text to use for the image element.\nDefaults to: ''"
		            });
		        }
		    }
		},{
			name: 'COLUMNANCHORSIZE',
			fieldLabel: 'Anchor size',
			maxLength: 30,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Defines the anchoring size of container. Either a number to define the width of the container or an object with width and height fields."
		            });
		        }
		    }
		},{
			name: 'COLUMNAUTODESTROY',
			fieldLabel: 'Auto destroy',
			xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "If true the container will automatically destroy any contained component that is removed from it, else destruction must be handled manually. Defaults to: true"
		            });
		        }
		    }
		},{
			name: 'COLUMNAUTORENDER',
			fieldLabel: 'Auto render',
			xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "This config is intended mainly for non-floating Components which may or may not be shown. Instead of using renderTo in the configuration, and rendering upon construction, this allows a Component to render itself upon first show. If floating is true, the value of this config is omitted as if it is true.\nSpecify as true to have this Component render to the document body upon first show.\nSpecify as an element, or the ID of an element to have this Component render to a specific element upon first show.\nDefaults to: false"
		            });
		        }
		    }
		},{
			name: 'COLUMNAUTOSCROLL',
			fieldLabel: 'Auto scroll',
			xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "true to use overflow:'auto' on the components layout element and show scroll bars automatically when necessary, false to clip any overflowing content. This should not be combined with overflowX or overflowY. Defaults to: false"
		            });
		        }
		    }
		},{
			name: 'COLUMNAUTOSHOW',
			fieldLabel: 'Auto show',
			xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "true to automatically show the component upon creation. This config option may only be used for floating components or components that use autoRender. Defaults to: false"
		            });
		        }
		    }
		},{
			name: 'COLUMNBASECLS',
			fieldLabel: 'Base class',
			maxLength: 50,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "The base CSS class to apply to this panel's element. Defaults to: x-panel"
		            });
		        }
		    }
		},{
			name: 'COLUMNBORDER',
			fieldLabel: 'Border',
			maxLength: 11,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Specifies the border size for this component. The border can be a single numeric value to apply to all sides or it can be a CSS style specification for each style, for example: '10 5 3 10' (top, right, bottom, left)."
		            });
		        }
		    }
		},{
			name: 'COLUMNBUBBLEEVENTS',
			fieldLabel: 'Bubble events',
			maxLength: 50,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "An array of events that, when fired, should be bubbled to any parent container. See Ext.util.Observable.enableBubble."
		            });
		        }
		    }
		},{
			name: 'COLUMNCHILDELS',
			fieldLabel: 'Child elements',
			maxLength: 80,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "An array describing the child elements of the Component. Each member of the array is an object with these properties:\n\nname - The property name on the Component for the child element.\nitemId - The id to combine with the Component's id that is the id of the child element.\nid - The id of the child element.\nIf the array member is a string, it is equivalent to { name: m, itemId: m }."
		            });
		        }
		    }
		},{
			name: 'COLUMNCLS',
			fieldLabel: 'Class',
			maxLength: 50,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "An optional extra CSS class that will be added to this component's Element. This can be useful for adding customized styles to the component or any of its children using standard CSS rules. Defaults to: ''"
		            });
		        }
		    }
		},{
			name: 'COLUMNWIDTH',
			fieldLabel: 'Width',
			fieldLabel: 'Width ( The width of this component in pixels )',
			xtype: 'numberfield',
			width: 250,
			maxValue: 99999
		},{
			name: 'COLUMNCOLUMNS',
			fieldLabel: 'Columns',
			width: 700,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "An optional array of sub-column definitions. This column becomes a group, and houses the columns defined in the columns config.\n\nGroup columns may not be sortable. But they may be hideable and moveable. And you may move headers into and out of a group. Note that if all sub columns are dragged out of a group, the group is destroyed."
		            });
		        }
		    }
		},{
			name: 'COLUMNCOMPONENTCLS',
			fieldLabel: 'Component class',
			maxLength: 50,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "CSS Class to be added to a components root level element to give distinction to it via styling."
		            });
		        }
		    }
		},{
			name: 'COLUMNCONSTRAIN',
			fieldLabel: 'Constrain',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "True to constrain the panel within its containing element, false to allow it to fall outside of its containing element. By default floating components such as Windows will be rendered to document.body. To render and constrain the window within another element specify renderTo. Optionally the header only can be constrained using constrainHeader.\nDefault to false."
		            });
		        }
		    },
		    xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300
		},{
			name: 'COLUMNCONSTRAINTO',
			fieldLabel: 'Constrain to',
			maxLength: 35,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "A Region (or an element from which a Region measurement will be read) which is used to constrain the component. Only applies when the component is floating."
		            });
		        }
		    }
		},{
			name: 'COLUMNCONSTRAINTINSETS',
			fieldLabel: 'Constraint insets',
			maxLength: 20,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "An object or a string (in TRBL order) specifying insets from the configured constrain region within which this component must be constrained when positioning or sizing. example:\n\nconstraintInsets: '10 10 10 10' \/\/ Constrain with 10px insets from parent"
		            });
		        }
		    }
		},{
			name: 'COLUMNCONTENTEL',
			fieldLabel: 'Content element',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Specify an existing HTML element, or the id of an existing HTML element to use as the content for this component.\n\nThis config option is used to take an existing HTML element and place it in the layout element of a new component (it simply moves the specified DOM element after the Component is rendered to use as the content.\n\nNotes:\nThe specified HTML element is appended to the layout element of the component after any configured HTML has been inserted, and so the document will not contain this element at the time the render event is fired.\nThe specified HTML element used will not participate in any layout scheme that the Component may use. It is just HTML. Layouts operate on child items.\n\nAdd either the x-hidden or the x-hide-display CSS class to prevent a brief flicker of the content before it is rendered to the panel."
		            });
		        }
		    }
		},{
			name: 'COLUMNDATA',
			fieldLabel: 'Data',
			xtype: 'textareafield',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "The initial set of data to apply to the tpl to update the content area of the Component."
		            });
		        }
		    },
		    width: 750
		},{
			name: 'COLUMNDATAINDEX',
			fieldLabel: 'Data index',
			maxLength: 250,
			allowBlank: false,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "The name of the field in the grid's Ext.data.Store's Ext.data.Model definition from which to draw the column's value. Required."
		            });
		        }
		    }
		},{
			name: 'COLUMNDEFAULTALIGN',
			fieldLabel: 'Default align',
			maxLength: 10,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "The default Ext.Element#getAlignToXY anchor position value for this menu relative to its element of origin. Used in conjunction with showBy.\n\nDefaults to: \"tl-bl?\""
		            });
		        }
		    }
		},{
			name: 'COLUMNDEFAULTTYPE',
			fieldLabel: 'Default type',
			maxLength: 20,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "The default xtype of child Components to create in this Container when a child item is specified as a raw configuration object, rather than as an instantiated Component.\nDefaults to: \"panel\""
		            });
		        }
		    }
		},{
			name: 'COLUMNDEFAULTWIDTH',
			fieldLabel: 'Default width',
			xtype: 'numberfield',
			width: 250,
			maxValue: 9999,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Width of the header if no width or flex is specified.\nDefaults to: 100"
		            });
		        }
		    }
		},{
			name: 'COLUMNDEFAULTS',
			fieldLabel: 'Defaults',
			maxLength: 100,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "This option is a means of applying default settings to all added items whether added through the items config or via the add or insert methods.\n\nDefaults are applied to both config objects and instantiated components conditionally so as not to override existing properties in the item (see Ext.applyIf).\nIf the defaults option is specified as a function, then the function will be called using this Container as the scope (this reference) and passing the added item as the first parameter. Any resulting object from that call is then applied to the item as default properties.\nFor example, to automatically apply padding to the body of each of a set of contained Ext.panel.Panel items, you could pass: defaults: {bodyStyle:'padding:15px'}."
		            });
		        }
		    }
		},{
			name: 'COLUMNDETACHONREMOVE',
			fieldLabel: 'Detach on remove',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "True to move any component to the detachedBody when the component is removed from this container. This option is only applicable when the component is not destroyed while being removed, see autoDestroy and remove. If this option is set to false, the DOM of the component will remain in the current place until it is explicitly moved.\n\nDefaults to true"
		            });
		        }
		    },
		    xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300
		},{
			name: 'COLUMNDISABLED',
			fieldLabel: 'Disabled',
			xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "True to disable the field. Disabled Fields will not be submitted. Defaults to: false"
		            });
		        }
		    }
		},{
			name: 'COLUMNDISABLEDCLS',
			fieldLabel: 'Disabled class',
			maxLength: 50,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "CSS class to add when the Component is disabled.\nDefaults to: 'x-item-disabled'"
		            });
		        }
		    }
		},{
			name: 'COLUMNDRAGGABLE',
			fieldLabel: 'Draggable',
			maxLength: 30,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Specify as true to make a floating Component draggable using the Component's encapsulating element as the drag handle."
		            });
		        }
		    }
		},{
			name: 'COLUMNEDITRENDERER',
			fieldLabel: 'Edit renderer',
			maxLength: 200,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "A renderer to be used in conjunction with RowEditing. This renderer is used to display a custom value for non-editable fields.\nDefaults to: false"
		            });
		        }
		    }
		},{
			name: 'COLUMNEDITOR',
			fieldLabel: 'Editor',
			maxLength: 50,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "An optional xtype or config object for a Field to use for editing. Only applicable if the grid is using an Editing plugin."
		            });
		        }
		    }
		},{
			name: 'COLUMNEMPTYCELLTEXT',
			fieldLabel: 'Empty cell text',
			maxLength: 20,
			width: 500,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Default text (html tags are accepted) to display in the Panel body when the Store is empty. When specified, and the Store is empty, the text will be rendered inside a DIV with the CSS class \"x-grid-empty\"."
		            });
		        }
		    }
		},{
			name: 'COLUMNENABLECOLUMNHIDE',
			fieldLabel: 'Enable column hide',
			xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "False to disable column hiding within this grid.\n\nDefaults to: true"
		            });
		        }
		    }
		},{
			name: 'COLUMNFLOATING',
			fieldLabel: 'Floating',
			xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Specify as true to float the Component outside of the document flow using CSS absolute positioning.\n\nComponents such as Windows and Menus are floating by default.\n\nFloating Components that are programatically rendered will register themselves with the global ZIndexManager"
		            });
		        }
		    }
		},{
			name: 'COLUMNFOCUSONTOFRONT',
			fieldLabel: 'Focus on to front',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Specifies whether the floated component should be automatically focused when it is brought to the front.\n\nDefaults to true"
		            });
		        }
		    },
		    xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300
		},{
			name: 'COLUMNFORMBIND',
			fieldLabel: 'Form bind',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "When inside FormPanel, any component configured with formBind: true will be enabled/disabled depending on the validity state of the form. See Ext.form.Panel for more information and example.\n\nDefaults to false"
		            });
		        }
		    },
		    xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300
		},{
			name: 'COLUMNFRAME',
			fieldLabel: 'Frame (True to apply a frame to the panel. Default: false)',
			xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300
		},{
			name: 'COLUMNGROUPABLE',
			fieldLabel: 'Groupable',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "If the grid uses a Ext.grid.feature.Grouping, this option may be used to disable the header menu item to group by the column selected. By default, the header menu group option is enabled. Set to false to disable (but still show) the group option in the header menu for the column."
		            });
		        }
		    },
		    xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300
		},{
			name: 'COLUMNHANDLER',
			fieldLabel: 'Handler (A function called when the icon is clicked.)',
			xtype: 'textareafield',
			width: 800,
			height: 200
		},{
			name: 'COLUMNHEIGHT',
			fieldLabel: 'Height ( The height of this component in pixels )',
			xtype: 'numberfield',
			width: 250,
			maxValue: 99999
		},{
			name: 'COLUMNHIDDEN',
			fieldLabel: 'Hidden (true to hide the component)',
			xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300
		},{
			fieldLabel: 'Hide mode',
			xtype: 'radiogroup',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "A String which specifies how this Component's encapsulating DOM element will be hidden. Values may be:\n\n'display' : The Component will be hidden using the display: none style.\n'visibility' : The Component will be hidden using the visibility: hidden style.\n'offsets' : The Component will be hidden by absolutely positioning it out of the visible area of the document. This is useful when a hidden Component must maintain measurable dimensions. Hiding using display results in a Component having zero dimensions."
		            });
		        }
		    },
		    width: 500,
		    columns: 3,
		    items: [{
		    	boxLabel: 'display',
		    	name: 'COLUMNHIDEMODE',
			    inputValue: 'display'
		    },{
		    	boxLabel: 'visibility',
		    	name: 'COLUMNHIDEMODE',
			    inputValue: 'visibility'
		    },{
		    	boxLabel: 'offsets',
		    	name: 'COLUMNHIDEMODE',
			    inputValue: 'offsets'
		    }]
		},{
			name: 'COLUMNHIDEABLE',
			fieldLabel: 'Hideable',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "False to prevent the user from hiding this column.\n\nDefaults to: true"
		            });
		        }
		    },
		    xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300
		},{
			name: 'COLUMNHTML',
			fieldLabel: 'Html',
			width: 750,
			xtype: 'textareafield',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "An HTML fragment, or a DomHelper specification to use as the layout element content. The HTML content is added after the component is rendered, so the document will not contain this HTML at the time the render event is fired. This content is inserted into the body before any configured contentEl is appended."
		            });
		        }
		    }
		},{
			name: 'COLUMNICON',
			fieldLabel: 'Icon',
			maxLength: 100,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Path to image for an icon in the header. Used for displaying an icon to the left of a title."
		            });
		        }
		    }
		},{
			name: 'COLUMNICONCLS',
			fieldLabel: 'Icon class',
			maxLength: 50,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "CSS class for an icon in the header. Used for displaying an icon to the left of a title."
		            });
		        }
		    }
		},{
			name: 'COLUMNID',
			fieldLabel: 'Id',
			maxLength: 50,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "The unique id of this component instance.\n\nIt should not be necessary to use this configuration except for singleton objects in your application. Components created with an id may be accessed globally using Ext.getCmp.\n\nInstead of using assigned ids, use the itemId config, and ComponentQuery which provides selector-based searching for Sencha Components analogous to DOM querying. The Container class contains shortcut methods to query its descendant Components by selector."
		            });
		        }
		    }
		},{
			name: 'COLUMNITEMID',
			fieldLabel: 'Item id',
			maxLength: 50,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "An itemId can be used as an alternative way to get a reference to a component when no object reference is available. Instead of using an id with Ext.getCmp, use itemId with Ext.container.Container.getComponent which will retrieve itemId's or id's. Since itemId's are an index to the container's internal MixedCollection, the itemId is scoped locally to the container -- avoiding potential conflicts with Ext.ComponentManager which requires a unique id."
		            });
		        }
		    }
		},{
			name: 'COLUMNITEMS',
			fieldLabel: 'Items',
			width: 700,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "A single item, or an array of child Components to be added to this container"
		            });
		        }
		    }
		},{
			name: 'COLUMNLAYOUT',
			fieldLabel: 'Layout',
			maxLength: 50,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Important: In order for child items to be correctly sized and positioned, typically a layout manager must be specified through the layout configuration option.\nThe sizing and positioning of child items is the responsibility of the Container's layout manager which creates and manages the type of layout you have in mind. For example:\nIf the layout configuration is not explicitly specified for a general purpose container (e.g. Container or Panel) the default layout manager will be used which does nothing but render child components sequentially into the Container (no sizing or positioning will be performed in this situation).\nlayout may be specified as either as an Object or as a String"
		            });
		        }
		    }
		},{
			name: 'COLUMNLISTENERS',
			fieldLabel: 'Listeners',
			xtype: 'textareafield',
			width: 800,
			height: 200,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "A config object containing one or more event handlers to be added to this object during initialization. This should be a valid listeners config object as specified in the addListener example for attaching multiple handlers at once."
		            });
		        }
		    }
		},{
			name: 'COLUMNLOADER',
			fieldLabel: 'Loader',
			maxLength: 100,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "A configuration object or an instance of a Ext.ComponentLoader to load remote content for this Component.\n\nloader: {\n url: 'content.html',\n autoLoad: true\n}"
		            });
		        }
		    }
		},{
			name: 'COLUMNLOCKABLE',
			fieldLabel: 'Lockable',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "If the grid is configured with enableLocking, or has columns which are configured with a locked value, this option may be used to disable user-driven locking or unlocking of this column. This column will remain in the side into which its own locked configuration placed it."
		            });
		        }
		    },
		    xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300
		},{
			name: 'COLUMNLOCKED',
			fieldLabel: 'Locked',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "True to lock this column in place. Implicitly enables locking on the grid. See also Ext.grid.Panel.enableLocking.\nDefaults to: false"
		            });
		        }
		    },
		    xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300
		},{
			name: 'COLUMNMARGIN',
			fieldLabel: 'Margin',
			maxLength: 15,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Specifies the margin for this component. The margin can be a single numeric value to apply to all sides or it can be a CSS style specification for each style, for example: '10 5 3 10' (top, right, bottom, left)."
		            });
		        }
		    }
		},{
			name: 'COLUMNMAXHEIGHT',
			fieldLabel: 'Maximum height',
			xtype: 'numberfield',
			width: 250,
			maxValue: 99999
		},{
			name: 'COLUMNMAXWIDTH',
			fieldLabel: 'Maximum width',
			xtype: 'numberfield',
			width: 250,
			maxValue: 99999
		},{
			name: 'COLUMNMENUTEXT',
			fieldLabel: 'Menu text',
			maxLength: 100,
			width: 500,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Default text (html tags are accepted) to display in the Panel body when the Store is empty. When specified, and the Store is empty, the text will be rendered inside a DIV with the CSS class \"x-grid-empty\"."
		            });
		        }
		    }
		},{
			name: 'CACTIONMENUDISABLED',
			fieldLabel: 'Menu disabled',
			xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "True to disable the column header menu containing sort/hide options.\nDefaults to: false"
		            });
		        }
		    }
		},{
			name: 'COLUMNMINHEIGHT',
			fieldLabel: 'Minimum height',
			xtype: 'numberfield',
			width: 250,
			maxValue: 9999
		},{
			name: 'COLUMNMINWIDTH',
			fieldLabel: 'Minimum width',
			xtype: 'numberfield',
			width: 250,
			maxValue: 9999
		},{
			name: 'COLUMNOVERCLS',
			fieldLabel: 'Over class',
			maxLength: 50,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "An optional extra CSS class that will be added to this component's Element when the mouse moves over the Element, and removed when the mouse moves out. This can be useful for adding customized 'active' or 'hover' styles to the component or any of its children using standard CSS rules.\nDefaults to: ''"
		            });
		        }
		    }
		},{
			name: 'COLUMNOVERFLOWX',
			fieldLabel: 'Overflow x',
			maxLength: 7,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Possible values are: * 'auto' to enable automatic horizontal scrollbar (overflow-x: 'auto'). * 'scroll' to always enable horizontal scrollbar (overflow-x: 'scroll'). The default is overflow-x: 'hidden'. This should not be combined with autoScroll."
		            });
		        }
		    }
		},{
			name: 'COLUMNOVERFLOWY',
			fieldLabel: 'Overflow y',
			maxLength: 7,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Possible values are: * 'auto' to enable automatic vertical scrollbar (overflow-y: 'auto'). * 'scroll' to always enable vertical scrollbar (overflow-y: 'scroll'). The default is overflow-y: 'hidden'. This should not be combined with autoScroll."
		            });
		        }
		    }
		},{
			name: 'COLUMNPADDING',
			fieldLabel: 'Padding',
			maxLength: 15,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Specifies the padding for this component. The padding can be a single numeric value to apply to all sides or it can be a CSS style specification for each style, for example: '10 5 3 10' (top, right, bottom, left)."
		            });
		        }
		    }
		},{
			name: 'COLUMNPLUGINS',
			fieldLabel: 'Plugins',
			xtype: 'combobox',
			width: 700,
			queryMode: 'local',
			store: 'query.pluginStore', 
			displayField: 'pluginname',
			valueField: 'plugincode'
		},{
			fieldLabel: 'Region',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Defines the region inside border layout.\n\nnorth - Positions component at top.\nsouth - Positions component at bottom.\neast - Positions component at right.\nwest - Positions component at left.\ncenter - Positions component at the remaining space. There must be a component with region: \"center\" in every border layout."
		            });
		        }
		    },
			xtype: 'radiogroup',
			columns: 2,
		    items: [{
		    	boxLabel: 'north',
		    	name: 'COLUMNREGION',
			    inputValue: 'north'
		    },{
		    	boxLabel: 'south ',
		    	name: 'COLUMNREGION',
			    inputValue: 'south '
		    },{
		    	boxLabel: 'east',
		    	name: 'COLUMNREGION',
			    inputValue: 'east'
		    },{
		    	boxLabel: 'west',
		    	name: 'COLUMNREGION',
			    inputValue: 'west'
		    },{
		    	boxLabel: 'center',
		    	name: 'COLUMNREGION',
			    inputValue: 'center'
		    },{
		    	boxLabel: 'none',
		    	name: 'COLUMNREGION',
			    inputValue: ''
		    }]
		},{
			name: 'COLUMNRENDERDATA',
			fieldLabel: 'Render data',
			xtype: 'textareafield',
			maxLength: 30,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "The data used by renderTpl in addition to the following property values of the component:\n\nid\nui\nuiCls\nbaseCls\ncomponentCls\nframe"
		            });
		        }
		    }
		},{
			name: 'COLUMNRENDERSELECTORS',
			fieldLabel: 'Render selectors',
			maxLength: 100,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "An object containing properties specifying DomQuery selectors which identify child elements created by the render process.\n\nAfter the Component's internal structure is rendered according to the renderTpl, this object is iterated through, and the found Elements are added as properties to the Component using the renderSelector property name."
		            });
		        }
		    }
		},{
			name: 'COLUMNRENDERTO',
			fieldLabel: 'Render to',
			maxLength: 30,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Specify the id of the element, a DOM element or an existing Element that this component will be rendered into.\n\nNotes:\n\nDo not use this option if the Component is to be a child item of a Container. It is the responsibility of the Container's layout manager to render and manage its child items.\n\nWhen using this config, a call to render() is not required."
		            });
		        }
		    }
		},{
			name: 'COLUMNRENDERER',
			fieldLabel: 'Renderer',
			maxLength: 200,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "A renderer is an 'interceptor' method which can be used to transform data (value, appearance, etc.) before it is rendered."
		            });
		        }
		    }
		},{
			name: 'COLUMNRESIZABLE',
			fieldLabel: 'Resizable',
			maxLength: 50,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Specify as true to apply a Resizer to this Component after rendering."
		            });
		        }
		    }
		},{
			fieldLabel: 'Resize handles',
			xtype: 'radiogroup',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Only applies when resizable = true."
		            });
		        }
		    },
		    width: 500,
		    columns: 3,
		    items: [{
		    	boxLabel: 'north',
		    	name: 'COLUMNRESIZEHANDLES',
			    inputValue: 'n'
		    },{
		    	boxLabel: 'south',
		    	name: 'COLUMNRESIZEHANDLES',
			    inputValue: 's'
		    },{
		    	boxLabel: 'east',
		    	name: 'COLUMNRESIZEHANDLES',
			    inputValue: 'e'
		    },{
		    	boxLabel: 'west',
		    	name: 'COLUMNRESIZEHANDLES',
			    inputValue: 'w'
		    },,{
		    	boxLabel: 'northwest',
		    	name: 'COLUMNRESIZEHANDLES',
			    inputValue: 'nw'
		    },{
		    	boxLabel: 'southwest',
		    	name: 'COLUMNRESIZEHANDLES',
			    inputValue: 'sw'
		    },{
		    	boxLabel: 'southeast',
		    	name: 'COLUMNRESIZEHANDLES',
			    inputValue: 'se'
		    },{
		    	boxLabel: 'northeast',
		    	name: 'COLUMNRESIZEHANDLES',
			    inputValue: 'ne'
		    },{
		    	boxLabel: 'all',
		    	name: 'COLUMNRESIZEHANDLES',
			    inputValue: 'all'
		    }]
		},{
			name: 'COLUMNRTL',
			fieldLabel: 'Right to left',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "True to layout this component and its descendants in \"rtl\" (right-to-left) mode. Can be explicitly set to false to override a true value inherited from an ancestor."
		            });
		        }
		    },
		    xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300
		},{
			name: 'COLUMNSAVEDELAY',
			fieldLabel: 'Save delay',
			xtype: 'numberfield',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "A buffer to be applied if many state events are fired within a short period."
		            });
		        }
		    },
		    width: 250,
		    maxValue: 1000
		},{
			name: 'CACTIONSCOPE',
			fieldLabel: 'Scope',
			maxLength: 20,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "The scope (this reference) in which the handler, getClass, isDisabled and getTip fuctions are executed. Defaults to this Column."
		            });
		        }
		    }
		},{
			name: 'COLUMNSEALED',
			fieldLabel: 'Sealed',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Specify as true to constrain column dragging so that a column cannot be dragged into or out of this column."
		            });
		        }
		    },
		    xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300
		},{
			name: 'COLUMNSHADOW',
			fieldLabel: 'Shadow',
			xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Specifies whether the floating component should be given a shadow. Set to true to automatically create an Ext.Shadow, or a string indicating the shadow's display Ext.Shadow.mode. Set to false to disable the shadow."
		            });
		        }
		    }
		},{
			name: 'COLUMNSHADOWOFFSET',
			fieldLabel: 'Shadow offset (Number of pixels to offset the shadow.)',
			xtype: 'numberfield',
			width: 250,
			maxValue: 500
		},{
			name: 'COLUMNSHRINKWRAP',
			fieldLabel: 'Shrink wrap',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "In CSS terms, shrink-wrap width is analogous to an inline-block element as opposed to a block-level element. Some container layouts always shrink-wrap their children, effectively ignoring this property.\nDefaults to 2.\n\n0: Neither width nor height depend on content. This is equivalent to false.\n1: Width depends on content (shrink wraps), but height does not.\n2: Height depends on content (shrink wraps), but width does not. The default.\n3: Both width and height depend on content (shrink wrap). This is equivalent to true."
		            });
		        }
		    },
		    xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300
		},{
			name: 'COLUMNSORTABLE',
			fieldLabel: 'Sortable',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "False to disable sorting of this column. Whether local/remote sorting is used is specified in Ext.data.Store.remoteSort.\nDefaults to: false"
		            });
		        }
		    },
		    xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300
		},{
			name: 'COLUMNSTATEEVENTS',
			fieldLabel: 'State events',
			maxLength: 200,
			width: 500,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "An array of events that, when fired, should trigger this object to save its state. Defaults to none. stateEvents may be any type of event supported by this object, including browser or custom events (e.g., ['click', 'customerchange']).\nSee stateful for an explanation of saving and restoring object state."
		            });
		        }
		    }
		},{
			name: 'COLUMNSTATEID',
			fieldLabel: 'State id',
			maxLength: 50,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "The unique id for this object to use for state management purposes.\nSee stateful for an explanation of saving and restoring state."
		            });
		        }
		    }
		},{
			name: 'COLUMNSTATEFUL',
			fieldLabel: 'Stateful',
			maxLength: 50,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "A flag which causes the object to attempt to restore the state of internal properties from a saved state on startup. The object must have a stateId for state to be managed.\nAuto-generated ids are not guaranteed to be stable across page loads and cannot be relied upon to save and restore the same state for a object."
		            });
		        }
		    },
		    xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300
		},{
			name: 'CACTIONSTOPSELECTION',
			fieldLabel: 'Stop selection',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "Prevent grid selection upon mousedown.\nDefaults to: true"
		            });
		        }
		    },
		    xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300
		},{
			name: 'COLUMNSTYLE',
			fieldLabel: 'Style',
			maxLength: 255,
			width: 700,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "A custom style specification to be applied to this component's Element.\n\n{\n width: '95%',\n marginBottom: '10px'\n}"
		            });
		        }
		    }
		},{
			name: 'COLUMNSUSPENDLAYOUT',
			fieldLabel: 'Suspend layout',
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "If true, suspend calls to doLayout. Useful when batching multiple adds to a container and not passing them as multiple arguments or an array.\nDefaults to: false"
		            });
		        }
		    },
		    xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300
		},{
			name: 'COLUMNTDCLS',
			fieldLabel: 'Td class',
			maxLength: 50,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "A CSS class names to apply to the table cells for this column.\nDefaults to: ''"
		            });
		        }
		    }
		},{
			name: 'COLUMNTEXT',
			fieldLabel: 'Text',
			maxLength: 255,
			width: 500,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "The header text to be used as innerHTML (html tags are accepted) to display in the Grid. Note: to have a clickable header with no text displayed you can use the default of &#160; aka &nbsp;.\n\nDefaults to: '&#160;'"
		            });
		        }
		    }
		},{
			name: 'COLUMNTOFRONTONSHOW',
			fieldLabel: 'To front on show',
			xtype: 'combobox',
			queryMode: 'local',
			store: 'query.yesno', 
			displayField: 'yesnoname',
			valueField: 'yesnocode',
			width: 300,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "True to automatically call toFront when the show method is called on an already visible, floating component. Defaults to: true"
		            });
		        }
		    }
		},{
			name: 'COLUMNTOOLTIP',
			fieldLabel: 'Tool tip',
			maxLength: 255,
			width: 500,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "A tooltip message to be displayed on hover. Ext.tip.QuickTipManager must have been initialized.\n\nThe tooltip may also be determined on a row by row basis by configuring a getTip method."
		            });
		        }
		    }
		},{
			fieldLabel: 'Tool tip type',
			xtype: 'radiogroup',
			columns: 2,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "The type of tooltip to use. Either 'qtip' for QuickTips or 'title' for title attribute.\nDefaults to: \"qtip\""
		            });
		        }
		    },
			items: [{
				boxLabel: 'title',
		    	name: 'COLUMNTOOLTIPTYPE',
			    inputValue: 'title'
			},{
				boxLabel: 'qtip',
		    	name: 'COLUMNTOOLTIPTYPE',
			    inputValue: 'qtip'
			}]
		},{
			name: 'COLUMNTPL',
			fieldLabel: 'Template',
			maxLength: 100,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "An Ext.Template, Ext.XTemplate or an array of strings to form an Ext.XTemplate. Used in conjunction with the data and tplWriteMode configurations."
		            });
		        }
		    }
		},{
			name: 'COLUMNTPLWRITEMODE',
			fieldLabel: 'Template write mode',
			maxLength: 20,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "The Ext.(X)Template method to use when updating the content area of the Component. See Ext.XTemplate.overwrite for information on default mode.\nDefaults to: 'overwrite'"
		            });
		        }
		    }
		},{
			name: 'COLUMNUI',
			fieldLabel: 'UI',
			maxLength: 20,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "A UI style for a component. Defaults to: 'default'"
		            });
		        }
		    }
		},{
			name: 'CBOOLEANUNDEFINEDTEXT',
			fieldLabel: 'Undefined text',
			maxLength: 30,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "The string returned by the renderer when the column value is undefined.\nDefaults to: '&#160;'"
		            });
		        }
		    }
		},{
			name: 'COLUMNWEIGHT',
			fieldLabel: 'Weight',
			xtype: 'numberfield',
			maxValue: 9999,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "HeaderContainer overrides the default weight of 0 for all docked items to 100. This is so that it has more priority over things like toolbars.\nDefaults to: 100"
		            });
		        }
		    }
		},{
			name: 'COLUMNXTYPE',
			fieldLabel: 'Xtype',
			maxLength: 50,
			listeners: {
		        afterrender: function(cmp) {
		            cmp.getEl().set({
		                "title": "This property provides a shorter alternative to creating objects than using a full class name. Using xtype is the most common way to define component instances, especially in a container. For example, the items in a form containing text fields could be created explicitly like so:\n\nitems: [\nExt.create('Ext.form.field.Text', {\nfieldLabel: 'Foo'\n}),\nExt.create('Ext.form.field.Text', {\nfieldLabel: 'Bar'\n}),\nExt.create('Ext.form.field.Number', {\nfieldLabel: 'Num'\n})\n]\nBut by using xtype, the above becomes:\n\nitems: [\n{\nxtype: 'textfield',\nfieldLabel: 'Foo'\n},{\nxtype: 'textfield',\nfieldLabel: 'Bar'\n},\n{\nxtype: 'numberfield',\nfieldLabel: 'Num'\n}\n]\nWhen the xtype is common to many items, Ext.container.AbstractContainer.defaultType is another way to specify the xtype for all items that don't have an explicit xtype:\ndefaultType: 'textfield',\nitems: [\n{ fieldLabel: 'Foo' },\n{ fieldLabel: 'Bar' },\n{ fieldLabel: 'Num', xtype: 'numberfield' }]"
		            });
		        }
		    }
		},{
			name: 'COLUMNEXTRA',
			fieldLabel: 'Extra properties ({})',
			xtype: 'textareafield',
			width: 800,
			height: 200
		}];
		
		this.api = {
				load: Ext.qd.Form.LoadColumnDetail,
				submit: Ext.qd.Form.SubmitColumnDetail // The server-side must mark the submit handler as an 'ExtFormHandler'
		};
		
		this.paramOrder = ['fieldcode'];
		
		this.buttons = [{
			text: 'Save',
			action: 'save'
		},{
			text: 'Cancel',
			action: 'cancel'
		}];
		
		this.callParent(arguments);
	}
});