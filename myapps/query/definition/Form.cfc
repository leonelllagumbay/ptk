
<cfcomponent
	name="Form"
	Persistent="false"
	ExtDirect="true"
	hint="3/31/15">

<cffunction name="Submit" ExtDirect="true" ExtFormHandler="true">
	<cfscript>
		dsource = EntityLoad("EGRGQRYGRID",{EQRYCODE="#trim(form.EQRYCODE)#"}, true);
		if(IsDefined("dsource")) {
			//update
		} else {
			//insert
			dsource = EntityNew("EGRGQRYGRID");
		}

		if(Not IsDefined("form.EQRYCODE") || form.EQRYCODE== "" ) dsource.setEQRYCODE(javacast("null",""));
		else dsource.setEQRYCODE(trim(form.EQRYCODE));

		if(Not IsDefined("form.OUTPUTTYPE") || form.OUTPUTTYPE== "" ) dsource.setOUTPUTTYPE(javacast("null",""));
		else dsource.setOUTPUTTYPE(trim(form.OUTPUTTYPE));

		if(Not IsDefined("form.ACTIVEITEM") || form.ACTIVEITEM== "" ) dsource.setACTIVEITEM(javacast("null",""));
		else dsource.setACTIVEITEM(trim(form.ACTIVEITEM));

		if(Not IsDefined("form.ALLOWDESELECT") || form.ALLOWDESELECT== "" ) dsource.setALLOWDESELECT(javacast("null",""));
		else dsource.setALLOWDESELECT(trim(form.ALLOWDESELECT));

		if(Not IsDefined("form.ANCHORSIZE") || form.ANCHORSIZE== "" ) dsource.setANCHORSIZE(javacast("null",""));
		else dsource.setANCHORSIZE(trim(form.ANCHORSIZE));

		if(Not IsDefined("form.ANIMCOLLAPSE") || form.ANIMCOLLAPSE== "" ) dsource.setANIMCOLLAPSE(javacast("null",""));
		else dsource.setANIMCOLLAPSE(trim(form.ANIMCOLLAPSE));

		if(Not IsDefined("form.AUTODESTROY") || form.AUTODESTROY== "" ) dsource.setAUTODESTROY(javacast("null",""));
		else dsource.setAUTODESTROY(trim(form.AUTODESTROY));

		if(Not IsDefined("form.AUTORENDER") || form.AUTORENDER== "" ) dsource.setAUTORENDER(javacast("null",""));
		else dsource.setAUTORENDER(trim(form.AUTORENDER));

		if(Not IsDefined("form.AUTOSCROLL") || form.AUTOSCROLL== "" ) dsource.setAUTOSCROLL(javacast("null",""));
		else dsource.setAUTOSCROLL(trim(form.AUTOSCROLL));

		if(Not IsDefined("form.AUTOSHOW") || form.AUTOSHOW== "" ) dsource.setAUTOSHOW(javacast("null",""));
		else dsource.setAUTOSHOW(trim(form.AUTOSHOW));

		if(Not IsDefined("form.BASECLS") || form.BASECLS== "" ) dsource.setBASECLS(javacast("null",""));
		else dsource.setBASECLS(trim(form.BASECLS));

		if(Not IsDefined("form.BBAR") || form.BBAR== "" ) dsource.setBBAR(javacast("null",""));
		else dsource.setBBAR(trim(form.BBAR));

		if(Not IsDefined("form.GVIEWBLOCKREFRESH") || form.GVIEWBLOCKREFRESH== "" ) dsource.setGVIEWBLOCKREFRESH(javacast("null",""));
		else dsource.setGVIEWBLOCKREFRESH(trim(form.GVIEWBLOCKREFRESH));

		if(Not IsDefined("form.BODYBORDER") || form.BODYBORDER== "" ) dsource.setBODYBORDER(javacast("null",""));
		else dsource.setBODYBORDER(trim(form.BODYBORDER));

		if(Not IsDefined("form.BODYCLS") || form.BODYCLS== "" ) dsource.setBODYCLS(javacast("null",""));
		else dsource.setBODYCLS(trim(form.BODYCLS));

		if(Not IsDefined("form.BODYPADDING") || form.BODYPADDING== "" ) dsource.setBODYPADDING(javacast("null",""));
		else dsource.setBODYPADDING(trim(form.BODYPADDING));

		if(Not IsDefined("form.BODYSTYLE") || form.BODYSTYLE== "" ) dsource.setBODYSTYLE(javacast("null",""));
		else dsource.setBODYSTYLE(trim(form.BODYSTYLE));

		if(Not IsDefined("form.BORDER") || form.BORDER== "" ) dsource.setBORDER(javacast("null",""));
		else dsource.setBORDER(trim(form.BORDER));

		if(Not IsDefined("form.BUBBLEEVENTS") || form.BUBBLEEVENTS== "" ) dsource.setBUBBLEEVENTS(javacast("null",""));
		else dsource.setBUBBLEEVENTS(trim(form.BUBBLEEVENTS));

		if(Not IsDefined("form.BUTTONALIGN") || form.BUTTONALIGN== "" ) dsource.setBUTTONALIGN(javacast("null",""));
		else dsource.setBUTTONALIGN(trim(form.BUTTONALIGN));

		if(Not IsDefined("form.BUTTONS") || form.BUTTONS== "" ) dsource.setBUTTONS(javacast("null",""));
		else dsource.setBUTTONS(trim(form.BUTTONS));

		if(Not IsDefined("form.CHILDELS") || form.CHILDELS== "" ) dsource.setCHILDELS(javacast("null",""));
		else dsource.setCHILDELS(trim(form.CHILDELS));

		if(Not IsDefined("form.CLS") || form.CLS== "" ) dsource.setCLS(javacast("null",""));
		else dsource.setCLS(trim(form.CLS));

		if(Not IsDefined("form.CLOSABLE") || form.CLOSABLE== "" ) dsource.setCLOSABLE(javacast("null",""));
		else dsource.setCLOSABLE(trim(form.CLOSABLE));

		if(Not IsDefined("form.CLOSEACTION") || form.CLOSEACTION== "" ) dsource.setCLOSEACTION(javacast("null",""));
		else dsource.setCLOSEACTION(trim(form.CLOSEACTION));

		if(Not IsDefined("form.COLLAPSEDIRECTION") || form.COLLAPSEDIRECTION== "" ) dsource.setCOLLAPSEDIRECTION(javacast("null",""));
		else dsource.setCOLLAPSEDIRECTION(trim(form.COLLAPSEDIRECTION));

		if(Not IsDefined("form.COLLAPSEDFIRST") || form.COLLAPSEDFIRST== "" ) dsource.setCOLLAPSEDFIRST(javacast("null",""));
		else dsource.setCOLLAPSEDFIRST(trim(form.COLLAPSEDFIRST));

		if(Not IsDefined("form.COLLAPSEMODE") || form.COLLAPSEMODE== "" ) dsource.setCOLLAPSEMODE(javacast("null",""));
		else dsource.setCOLLAPSEMODE(trim(form.COLLAPSEMODE));

		if(Not IsDefined("form.COLLAPSED") || form.COLLAPSED== "" ) dsource.setCOLLAPSED(javacast("null",""));
		else dsource.setCOLLAPSED(trim(form.COLLAPSED));

		if(Not IsDefined("form.COLLAPSEDCLS") || form.COLLAPSEDCLS== "" ) dsource.setCOLLAPSEDCLS(javacast("null",""));
		else dsource.setCOLLAPSEDCLS(trim(form.COLLAPSEDCLS));

		if(Not IsDefined("form.COLLAPSIBLE") || form.COLLAPSIBLE== "" ) dsource.setCOLLAPSIBLE(javacast("null",""));
		else dsource.setCOLLAPSIBLE(trim(form.COLLAPSIBLE));

		if(Not IsDefined("form.COLUMNLINES") || form.COLUMNLINES== "" ) dsource.setCOLUMNLINES(javacast("null",""));
		else dsource.setCOLUMNLINES(trim(form.COLUMNLINES));

		if(Not IsDefined("form.COLUMNWIDTH") || form.COLUMNWIDTH== "" ) dsource.setCOLUMNWIDTH(javacast("null",""));
		else dsource.setCOLUMNWIDTH(trim(form.COLUMNWIDTH));

		if(Not IsDefined("form.COMPONENTCLS") || form.COMPONENTCLS== "" ) dsource.setCOMPONENTCLS(javacast("null",""));
		else dsource.setCOMPONENTCLS(trim(form.COMPONENTCLS));

		if(Not IsDefined("form.COMPONENTLAYOUT") || form.COMPONENTLAYOUT== "" ) dsource.setCOMPONENTLAYOUT(javacast("null",""));
		else dsource.setCOMPONENTLAYOUT(trim(form.COMPONENTLAYOUT));

		if(Not IsDefined("form.QRYCONSTRAIN") || form.QRYCONSTRAIN== "" ) dsource.setQRYCONSTRAIN(javacast("null",""));
		else dsource.setQRYCONSTRAIN(trim(form.QRYCONSTRAIN));

		if(Not IsDefined("form.CONSTRAINHEADER") || form.CONSTRAINHEADER== "" ) dsource.setCONSTRAINHEADER(javacast("null",""));
		else dsource.setCONSTRAINHEADER(trim(form.CONSTRAINHEADER));

		if(Not IsDefined("form.QRYCONSTRAINTO") || form.QRYCONSTRAINTO== "" ) dsource.setQRYCONSTRAINTO(javacast("null",""));
		else dsource.setQRYCONSTRAINTO(trim(form.QRYCONSTRAINTO));

		if(Not IsDefined("form.CONSTRAINTINSETS") || form.CONSTRAINTINSETS== "" ) dsource.setCONSTRAINTINSETS(javacast("null",""));
		else dsource.setCONSTRAINTINSETS(trim(form.CONSTRAINTINSETS));

		if(Not IsDefined("form.CONTENTEL") || form.CONTENTEL== "" ) dsource.setCONTENTEL(javacast("null",""));
		else dsource.setCONTENTEL(trim(form.CONTENTEL));

		if(Not IsDefined("form.QRYDATA") || form.QRYDATA== "" ) dsource.setQRYDATA(javacast("null",""));
		else dsource.setQRYDATA(trim(form.QRYDATA));

		if(Not IsDefined("form.DEFAULTALIGN") || form.DEFAULTALIGN== "" ) dsource.setDEFAULTALIGN(javacast("null",""));
		else dsource.setDEFAULTALIGN(trim(form.DEFAULTALIGN));

		if(Not IsDefined("form.DEFAULTDOCKWEIGHTS") || form.DEFAULTDOCKWEIGHTS== "" ) dsource.setDEFAULTDOCKWEIGHTS(javacast("null",""));
		else dsource.setDEFAULTDOCKWEIGHTS(trim(form.DEFAULTDOCKWEIGHTS));

		if(Not IsDefined("form.DEFAULTTYPE") || form.DEFAULTTYPE== "" ) dsource.setDEFAULTTYPE(javacast("null",""));
		else dsource.setDEFAULTTYPE(trim(form.DEFAULTTYPE));

		if(Not IsDefined("form.DEFAULTS") || form.DEFAULTS== "" ) dsource.setDEFAULTS(javacast("null",""));
		else dsource.setDEFAULTS(trim(form.DEFAULTS));

		if(Not IsDefined("form.GVIEWDEFEREMPTYTEXT") || form.GVIEWDEFEREMPTYTEXT== "" ) dsource.setGVIEWDEFEREMPTYTEXT(javacast("null",""));
		else dsource.setGVIEWDEFEREMPTYTEXT(trim(form.GVIEWDEFEREMPTYTEXT));

		if(Not IsDefined("form.GVIEWDEFERINITIALREFRESH") || form.GVIEWDEFERINITIALREFRESH== "" ) dsource.setGVIEWDEFERINITIALREFRESH(javacast("null",""));
		else dsource.setGVIEWDEFERINITIALREFRESH(trim(form.GVIEWDEFERINITIALREFRESH));

		if(Not IsDefined("form.DEFERROWRENDER") || form.DEFERROWRENDER== "" ) dsource.setDEFERROWRENDER(javacast("null",""));
		else dsource.setDEFERROWRENDER(trim(form.DEFERROWRENDER));

		if(Not IsDefined("form.DETACHONREMOVE") || form.DETACHONREMOVE== "" ) dsource.setDETACHONREMOVE(javacast("null",""));
		else dsource.setDETACHONREMOVE(trim(form.DETACHONREMOVE));

		if(Not IsDefined("form.DISABLED") || form.DISABLED== "" ) dsource.setDISABLED(javacast("null",""));
		else dsource.setDISABLED(trim(form.DISABLED));

		if(Not IsDefined("form.DISABLESELECTION") || form.DISABLESELECTION== "" ) dsource.setDISABLESELECTION(javacast("null",""));
		else dsource.setDISABLESELECTION(trim(form.DISABLESELECTION));

		if(Not IsDefined("form.DISABLEDCLS") || form.DISABLEDCLS== "" ) dsource.setDISABLEDCLS(javacast("null",""));
		else dsource.setDISABLEDCLS(trim(form.DISABLEDCLS));

		if(Not IsDefined("form.DOCKEDITEMS") || form.DOCKEDITEMS== "" ) dsource.setDOCKEDITEMS(javacast("null",""));
		else dsource.setDOCKEDITEMS(trim(form.DOCKEDITEMS));

		if(Not IsDefined("form.DRAGGABLE") || form.DRAGGABLE== "" ) dsource.setDRAGGABLE(javacast("null",""));
		else dsource.setDRAGGABLE(trim(form.DRAGGABLE));

		if(Not IsDefined("form.EMPTYTEXT") || form.EMPTYTEXT== "" ) dsource.setEMPTYTEXT(javacast("null",""));
		else dsource.setEMPTYTEXT(trim(form.EMPTYTEXT));

		if(Not IsDefined("form.GVIEWENABLETEXTSELECTION") || form.GVIEWENABLETEXTSELECTION== "" ) dsource.setGVIEWENABLETEXTSELECTION(javacast("null",""));
		else dsource.setGVIEWENABLETEXTSELECTION(trim(form.GVIEWENABLETEXTSELECTION));

		if(Not IsDefined("form.ENABLECOLUMNHIDE") || form.ENABLECOLUMNHIDE== "" ) dsource.setENABLECOLUMNHIDE(javacast("null",""));
		else dsource.setENABLECOLUMNHIDE(trim(form.ENABLECOLUMNHIDE));

		if(Not IsDefined("form.ENABLECOLUMNMOVE") || form.ENABLECOLUMNMOVE== "" ) dsource.setENABLECOLUMNMOVE(javacast("null",""));
		else dsource.setENABLECOLUMNMOVE(trim(form.ENABLECOLUMNMOVE));

		if(Not IsDefined("form.ENABLECOLUMNRESIZE") || form.ENABLECOLUMNRESIZE== "" ) dsource.setENABLECOLUMNRESIZE(javacast("null",""));
		else dsource.setENABLECOLUMNRESIZE(trim(form.ENABLECOLUMNRESIZE));

		if(Not IsDefined("form.ENABLELOCKING") || form.ENABLELOCKING== "" ) dsource.setENABLELOCKING(javacast("null",""));
		else dsource.setENABLELOCKING(trim(form.ENABLELOCKING));

		if(Not IsDefined("form.FBAR") || form.FBAR== "" ) dsource.setFBAR(javacast("null",""));
		else dsource.setFBAR(trim(form.FBAR));

		if(Not IsDefined("form.FEATURES") || form.FEATURES== "" ) dsource.setFEATURES(javacast("null",""));
		else dsource.setFEATURES(trim(form.FEATURES));

		if(Not IsDefined("form.GVIEWFIRSTCLS") || form.GVIEWFIRSTCLS== "" ) dsource.setGVIEWFIRSTCLS(javacast("null",""));
		else dsource.setGVIEWFIRSTCLS(trim(form.GVIEWFIRSTCLS));

		if(Not IsDefined("form.FIXED") || form.FIXED== "" ) dsource.setFIXED(javacast("null",""));
		else dsource.setFIXED(trim(form.FIXED));

		if(Not IsDefined("form.FLOATABLE") || form.FLOATABLE== "" ) dsource.setFLOATABLE(javacast("null",""));
		else dsource.setFLOATABLE(trim(form.FLOATABLE));

		if(Not IsDefined("form.FLOATING") || form.FLOATING== "" ) dsource.setFLOATING(javacast("null",""));
		else dsource.setFLOATING(trim(form.FLOATING));

		if(Not IsDefined("form.FOCUSONTOFRONT") || form.FOCUSONTOFRONT== "" ) dsource.setFOCUSONTOFRONT(javacast("null",""));
		else dsource.setFOCUSONTOFRONT(trim(form.FOCUSONTOFRONT));

		if(Not IsDefined("form.FORCEFIT") || form.FORCEFIT== "" ) dsource.setFORCEFIT(javacast("null",""));
		else dsource.setFORCEFIT(trim(form.FORCEFIT));

		if(Not IsDefined("form.FORMBIND") || form.FORMBIND== "" ) dsource.setFORMBIND(javacast("null",""));
		else dsource.setFORMBIND(trim(form.FORMBIND));

		if(Not IsDefined("form.FRAME") || form.FRAME== "" ) dsource.setFRAME(javacast("null",""));
		else dsource.setFRAME(trim(form.FRAME));

		if(Not IsDefined("form.FRAMEHEADER") || form.FRAMEHEADER== "" ) dsource.setFRAMEHEADER(javacast("null",""));
		else dsource.setFRAMEHEADER(trim(form.FRAMEHEADER));

		if(Not IsDefined("form.GLYPH") || form.GLYPH== "" ) dsource.setGLYPH(javacast("null",""));
		else dsource.setGLYPH(trim(form.GLYPH));

		if(Not IsDefined("form.HEADER") || form.HEADER== "" ) dsource.setHEADER(javacast("null",""));
		else dsource.setHEADER(trim(form.HEADER));

		if(Not IsDefined("form.HEADEROVERCLS") || form.HEADEROVERCLS== "" ) dsource.setHEADEROVERCLS(javacast("null",""));
		else dsource.setHEADEROVERCLS(trim(form.HEADEROVERCLS));

		if(Not IsDefined("form.HEADERPOSITION") || form.HEADERPOSITION== "" ) dsource.setHEADERPOSITION(javacast("null",""));
		else dsource.setHEADERPOSITION(trim(form.HEADERPOSITION));

		if(Not IsDefined("form.HEIGHT") || form.HEIGHT== "" ) dsource.setHEIGHT(javacast("null",""));
		else dsource.setHEIGHT(trim(form.HEIGHT));

		if(Not IsDefined("form.HIDDEN") || form.HIDDEN== "" ) dsource.setHIDDEN(javacast("null",""));
		else dsource.setHIDDEN(trim(form.HIDDEN));

		if(Not IsDefined("form.HIDECOLLAPSETOOL") || form.HIDECOLLAPSETOOL== "" ) dsource.setHIDECOLLAPSETOOL(javacast("null",""));
		else dsource.setHIDECOLLAPSETOOL(trim(form.HIDECOLLAPSETOOL));

		if(Not IsDefined("form.HIDEHEADER") || form.HIDEHEADER== "" ) dsource.setHIDEHEADER(javacast("null",""));
		else dsource.setHIDEHEADER(trim(form.HIDEHEADER));

		if(Not IsDefined("form.HIDEMODE") || form.HIDEMODE== "" ) dsource.setHIDEMODE(javacast("null",""));
		else dsource.setHIDEMODE(trim(form.HIDEMODE));

		if(Not IsDefined("form.HTML") || form.HTML== "" ) dsource.setHTML(javacast("null",""));
		else dsource.setHTML(trim(form.HTML));

		if(Not IsDefined("form.ICON") || form.ICON== "" ) dsource.setICON(javacast("null",""));
		else dsource.setICON(trim(form.ICON));

		if(Not IsDefined("form.ICONCLS") || form.ICONCLS== "" ) dsource.setICONCLS(javacast("null",""));
		else dsource.setICONCLS(trim(form.ICONCLS));

		if(Not IsDefined("form.QRYID") || form.QRYID== "" ) dsource.setQRYID(javacast("null",""));
		else dsource.setQRYID(trim(form.QRYID));

		if(Not IsDefined("form.ITEMID") || form.ITEMID== "" ) dsource.setITEMID(javacast("null",""));
		else dsource.setITEMID(trim(form.ITEMID));

		if(Not IsDefined("form.GVIEWITEMCLS") || form.GVIEWITEMCLS== "" ) dsource.setGVIEWITEMCLS(javacast("null",""));
		else dsource.setGVIEWITEMCLS(trim(form.GVIEWITEMCLS));

		if(Not IsDefined("form.GVIEWITEMTPL") || form.GVIEWITEMTPL== "" ) dsource.setGVIEWITEMTPL(javacast("null",""));
		else dsource.setGVIEWITEMTPL(trim(form.GVIEWITEMTPL));

		if(Not IsDefined("form.ITEMS") || form.ITEMS== "" ) dsource.setITEMS(javacast("null",""));
		else dsource.setITEMS(trim(form.ITEMS));

		if(Not IsDefined("form.GVIEWLASTCLS") || form.GVIEWLASTCLS== "" ) dsource.setGVIEWLASTCLS(javacast("null",""));
		else dsource.setGVIEWLASTCLS(trim(form.GVIEWLASTCLS));

		if(Not IsDefined("form.LAYOUT") || form.LAYOUT== "" ) dsource.setLAYOUT(javacast("null",""));
		else dsource.setLAYOUT(trim(form.LAYOUT));

		if(Not IsDefined("form.LBAR") || form.LBAR== "" ) dsource.setLBAR(javacast("null",""));
		else dsource.setLBAR(trim(form.LBAR));

		if(Not IsDefined("form.LISTENERS") || form.LISTENERS== "" ) dsource.setLISTENERS(javacast("null",""));
		else dsource.setLISTENERS(trim(form.LISTENERS));

		if(Not IsDefined("form.GVIEWLOADMASK") || form.GVIEWLOADMASK== "" ) dsource.setGVIEWLOADMASK(javacast("null",""));
		else dsource.setGVIEWLOADMASK(trim(form.GVIEWLOADMASK));

		if(Not IsDefined("form.LOADER") || form.LOADER== "" ) dsource.setLOADER(javacast("null",""));
		else dsource.setLOADER(trim(form.LOADER));

		if(Not IsDefined("form.GVIEWLOADINGCLS") || form.GVIEWLOADINGCLS== "" ) dsource.setGVIEWLOADINGCLS(javacast("null",""));
		else dsource.setGVIEWLOADINGCLS(trim(form.GVIEWLOADINGCLS));

		if(Not IsDefined("form.GVIEWLOADINGHEIGHT") || form.GVIEWLOADINGHEIGHT== "" ) dsource.setGVIEWLOADINGHEIGHT(javacast("null",""));
		else dsource.setGVIEWLOADINGHEIGHT(trim(form.GVIEWLOADINGHEIGHT));

		if(Not IsDefined("form.GVIEWLOADINGTEXT") || form.GVIEWLOADINGTEXT== "" ) dsource.setGVIEWLOADINGTEXT(javacast("null",""));
		else dsource.setGVIEWLOADINGTEXT(trim(form.GVIEWLOADINGTEXT));

		if(Not IsDefined("form.LOCKEDGRIDCONFIG") || form.LOCKEDGRIDCONFIG== "" ) dsource.setLOCKEDGRIDCONFIG(javacast("null",""));
		else dsource.setLOCKEDGRIDCONFIG(trim(form.LOCKEDGRIDCONFIG));

		if(Not IsDefined("form.LOCKEDVIEWCONFIG") || form.LOCKEDVIEWCONFIG== "" ) dsource.setLOCKEDVIEWCONFIG(javacast("null",""));
		else dsource.setLOCKEDVIEWCONFIG(trim(form.LOCKEDVIEWCONFIG));

		if(Not IsDefined("form.MANAGEHEIGHT") || form.MANAGEHEIGHT== "" ) dsource.setMANAGEHEIGHT(javacast("null",""));
		else dsource.setMANAGEHEIGHT(trim(form.MANAGEHEIGHT));

		if(Not IsDefined("form.MARGIN") || form.MARGIN== "" ) dsource.setMARGIN(javacast("null",""));
		else dsource.setMARGIN(trim(form.MARGIN));

		if(Not IsDefined("form.GVIEWMARKDIRTY") || form.GVIEWMARKDIRTY== "" ) dsource.setGVIEWMARKDIRTY(javacast("null",""));
		else dsource.setGVIEWMARKDIRTY(trim(form.GVIEWMARKDIRTY));

		if(Not IsDefined("form.MAXHEIGHT") || form.MAXHEIGHT== "" ) dsource.setMAXHEIGHT(javacast("null",""));
		else dsource.setMAXHEIGHT(trim(form.MAXHEIGHT));

		if(Not IsDefined("form.MAXWIDTH") || form.MAXWIDTH== "" ) dsource.setMAXWIDTH(javacast("null",""));
		else dsource.setMAXWIDTH(trim(form.MAXWIDTH));

		if(Not IsDefined("form.MINBUTTONWIDTH") || form.MINBUTTONWIDTH== "" ) dsource.setMINBUTTONWIDTH(javacast("null",""));
		else dsource.setMINBUTTONWIDTH(trim(form.MINBUTTONWIDTH));

		if(Not IsDefined("form.MINHEIGHT") || form.MINHEIGHT== "" ) dsource.setMINHEIGHT(javacast("null",""));
		else dsource.setMINHEIGHT(trim(form.MINHEIGHT));

		if(Not IsDefined("form.MINWIDTH") || form.MINWIDTH== "" ) dsource.setMINWIDTH(javacast("null",""));
		else dsource.setMINWIDTH(trim(form.MINWIDTH));

		if(Not IsDefined("form.GVIEWMOUSEOVEROUTBUFFER") || form.GVIEWMOUSEOVEROUTBUFFER== "" ) dsource.setGVIEWMOUSEOVEROUTBUFFER(javacast("null",""));
		else dsource.setGVIEWMOUSEOVEROUTBUFFER(trim(form.GVIEWMOUSEOVEROUTBUFFER));

		if(Not IsDefined("form.NORMALGRIDCONFIG") || form.NORMALGRIDCONFIG== "" ) dsource.setNORMALGRIDCONFIG(javacast("null",""));
		else dsource.setNORMALGRIDCONFIG(trim(form.NORMALGRIDCONFIG));

		if(Not IsDefined("form.NORMALVIEWCONFIG") || form.NORMALVIEWCONFIG== "" ) dsource.setNORMALVIEWCONFIG(javacast("null",""));
		else dsource.setNORMALVIEWCONFIG(trim(form.NORMALVIEWCONFIG));

		if(Not IsDefined("form.OVERCLS") || form.OVERCLS== "" ) dsource.setOVERCLS(javacast("null",""));
		else dsource.setOVERCLS(trim(form.OVERCLS));

		if(Not IsDefined("form.OVERFLOWX") || form.OVERFLOWX== "" ) dsource.setOVERFLOWX(javacast("null",""));
		else dsource.setOVERFLOWX(trim(form.OVERFLOWX));

		if(Not IsDefined("form.OVERFLOWY") || form.OVERFLOWY== "" ) dsource.setOVERFLOWY(javacast("null",""));
		else dsource.setOVERFLOWY(trim(form.OVERFLOWY));

		if(Not IsDefined("form.GVIEWOVERITEMCLS") || form.GVIEWOVERITEMCLS== "" ) dsource.setGVIEWOVERITEMCLS(javacast("null",""));
		else dsource.setGVIEWOVERITEMCLS(trim(form.GVIEWOVERITEMCLS));

		if(Not IsDefined("form.OVERLAPHEADER") || form.OVERLAPHEADER== "" ) dsource.setOVERLAPHEADER(javacast("null",""));
		else dsource.setOVERLAPHEADER(trim(form.OVERLAPHEADER));

		if(Not IsDefined("form.PADDING") || form.PADDING== "" ) dsource.setPADDING(javacast("null",""));
		else dsource.setPADDING(trim(form.PADDING));

		if(Not IsDefined("form.PLACEHOLDER") || form.PLACEHOLDER== "" ) dsource.setPLACEHOLDER(javacast("null",""));
		else dsource.setPLACEHOLDER(trim(form.PLACEHOLDER));

		if(Not IsDefined("form.PLACEHOLDERCOLLAPSEHIDEMODE") || form.PLACEHOLDERCOLLAPSEHIDEMODE== "" ) dsource.setPLACEHOLDERCOLLAPSEHIDEMODE(javacast("null",""));
		else dsource.setPLACEHOLDERCOLLAPSEHIDEMODE(trim(form.PLACEHOLDERCOLLAPSEHIDEMODE));

		if(Not IsDefined("form.PLUGINS") || form.PLUGINS== "" ) dsource.setPLUGINS(javacast("null",""));
		else dsource.setPLUGINS(trim(form.PLUGINS));

		if(Not IsDefined("form.GVIEWPRESERVESCROLLONREFRESH") || form.GVIEWPRESERVESCROLLONREFRESH== "" ) dsource.setGVIEWPRESERVESCROLLONREFRESH(javacast("null",""));
		else dsource.setGVIEWPRESERVESCROLLONREFRESH(trim(form.GVIEWPRESERVESCROLLONREFRESH));

		if(Not IsDefined("form.RBAR") || form.RBAR== "" ) dsource.setRBAR(javacast("null",""));
		else dsource.setRBAR(trim(form.RBAR));

		if(Not IsDefined("form.REGION") || form.REGION== "" ) dsource.setREGION(javacast("null",""));
		else dsource.setREGION(trim(form.REGION));

		if(Not IsDefined("form.RENDERDATA") || form.RENDERDATA== "" ) dsource.setRENDERDATA(javacast("null",""));
		else dsource.setRENDERDATA(trim(form.RENDERDATA));

		if(Not IsDefined("form.RENDERSELECTORS") || form.RENDERSELECTORS== "" ) dsource.setRENDERSELECTORS(javacast("null",""));
		else dsource.setRENDERSELECTORS(trim(form.RENDERSELECTORS));

		if(Not IsDefined("form.RENDERTO") || form.RENDERTO== "" ) dsource.setRENDERTO(javacast("null",""));
		else dsource.setRENDERTO(trim(form.RENDERTO));

		if(Not IsDefined("form.RESIZABLE") || form.RESIZABLE== "" ) dsource.setRESIZABLE(javacast("null",""));
		else dsource.setRESIZABLE(trim(form.RESIZABLE));

		if(Not IsDefined("form.RESIZEHANDLES") || form.RESIZEHANDLES== "" ) dsource.setRESIZEHANDLES(javacast("null",""));
		else dsource.setRESIZEHANDLES(trim(form.RESIZEHANDLES));

		if(Not IsDefined("form.ROWLINES") || form.ROWLINES== "" ) dsource.setROWLINES(javacast("null",""));
		else dsource.setROWLINES(trim(form.ROWLINES));

		if(Not IsDefined("form.RTL") || form.RTL== "" ) dsource.setRTL(javacast("null",""));
		else dsource.setRTL(trim(form.RTL));

		if(Not IsDefined("form.SAVEDELAY") || form.SAVEDELAY== "" ) dsource.setSAVEDELAY(javacast("null",""));
		else dsource.setSAVEDELAY(trim(form.SAVEDELAY));

		if(Not IsDefined("form.GVIEWSELECTEDITEMCLS") || form.GVIEWSELECTEDITEMCLS== "" ) dsource.setGVIEWSELECTEDITEMCLS(javacast("null",""));
		else dsource.setGVIEWSELECTEDITEMCLS(trim(form.GVIEWSELECTEDITEMCLS));

		if(Not IsDefined("form.SCROLL") || form.SCROLL== "" ) dsource.setSCROLL(javacast("null",""));
		else dsource.setSCROLL(trim(form.SCROLL));

		if(Not IsDefined("form.SCROLLDELTA") || form.SCROLLDELTA== "" ) dsource.setSCROLLDELTA(javacast("null",""));
		else dsource.setSCROLLDELTA(trim(form.SCROLLDELTA));

		if(Not IsDefined("form.SEALEDCOLUMNS") || form.SEALEDCOLUMNS== "" ) dsource.setSEALEDCOLUMNS(javacast("null",""));
		else dsource.setSEALEDCOLUMNS(trim(form.SEALEDCOLUMNS));

		if(Not IsDefined("form.SELMODEL") || form.SELMODEL== "" ) dsource.setSELMODEL(javacast("null",""));
		else dsource.setSELMODEL(trim(form.SELMODEL));

		if(Not IsDefined("form.SELTYPE") || form.SELTYPE== "" ) dsource.setSELTYPE(javacast("null",""));
		else dsource.setSELTYPE(trim(form.SELTYPE));

		if(Not IsDefined("form.SHADOW") || form.SHADOW== "" ) dsource.setSHADOW(javacast("null",""));
		else dsource.setSHADOW(trim(form.SHADOW));

		if(Not IsDefined("form.SHADOWOFFSET") || form.SHADOWOFFSET== "" ) dsource.setSHADOWOFFSET(javacast("null",""));
		else dsource.setSHADOWOFFSET(trim(form.SHADOWOFFSET));

		if(Not IsDefined("form.SHRINKWRAP") || form.SHRINKWRAP== "" ) dsource.setSHRINKWRAP(javacast("null",""));
		else dsource.setSHRINKWRAP(trim(form.SHRINKWRAP));

		if(Not IsDefined("form.SHRINKWRAPDOCK") || form.SHRINKWRAPDOCK== "" ) dsource.setSHRINKWRAPDOCK(javacast("null",""));
		else dsource.setSHRINKWRAPDOCK(trim(form.SHRINKWRAPDOCK));

		if(Not IsDefined("form.SIMPLEDRAG") || form.SIMPLEDRAG== "" ) dsource.setSIMPLEDRAG(javacast("null",""));
		else dsource.setSIMPLEDRAG(trim(form.SIMPLEDRAG));

		if(Not IsDefined("form.SORTABLECOLUMNS") || form.SORTABLECOLUMNS== "" ) dsource.setSORTABLECOLUMNS(javacast("null",""));
		else dsource.setSORTABLECOLUMNS(trim(form.SORTABLECOLUMNS));

		if(Not IsDefined("form.STATEEVENTS") || form.STATEEVENTS== "" ) dsource.setSTATEEVENTS(javacast("null",""));
		else dsource.setSTATEEVENTS(trim(form.STATEEVENTS));

		if(Not IsDefined("form.STATEID") || form.STATEID== "" ) dsource.setSTATEID(javacast("null",""));
		else dsource.setSTATEID(trim(form.STATEID));

		if(Not IsDefined("form.STATEFUL") || form.STATEFUL== "" ) dsource.setSTATEFUL(javacast("null",""));
		else dsource.setSTATEFUL(trim(form.STATEFUL));

		if(Not IsDefined("form.GVIEWSTRIPEROWS") || form.GVIEWSTRIPEROWS== "" ) dsource.setGVIEWSTRIPEROWS(javacast("null",""));
		else dsource.setGVIEWSTRIPEROWS(trim(form.GVIEWSTRIPEROWS));

		if(Not IsDefined("form.STYLE") || form.STYLE== "" ) dsource.setSTYLE(javacast("null",""));
		else dsource.setSTYLE(trim(form.STYLE));

		if(Not IsDefined("form.SUBGRIDXTYPE") || form.SUBGRIDXTYPE== "" ) dsource.setSUBGRIDXTYPE(javacast("null",""));
		else dsource.setSUBGRIDXTYPE(trim(form.SUBGRIDXTYPE));

		if(Not IsDefined("form.SUSPENDLAYOUT") || form.SUSPENDLAYOUT== "" ) dsource.setSUSPENDLAYOUT(javacast("null",""));
		else dsource.setSUSPENDLAYOUT(trim(form.SUSPENDLAYOUT));

		if(Not IsDefined("form.SYNCROWHEIGHT") || form.SYNCROWHEIGHT== "" ) dsource.setSYNCROWHEIGHT(javacast("null",""));
		else dsource.setSYNCROWHEIGHT(trim(form.SYNCROWHEIGHT));

		if(Not IsDefined("form.TBAR") || form.TBAR== "" ) dsource.setTBAR(javacast("null",""));
		else dsource.setTBAR(trim(form.TBAR));

		if(Not IsDefined("form.QRYTITLE") || form.QRYTITLE== "" ) dsource.setQRYTITLE(javacast("null",""));
		else dsource.setQRYTITLE(trim(form.QRYTITLE));

		if(Not IsDefined("form.TITLEALIGN") || form.TITLEALIGN== "" ) dsource.setTITLEALIGN(javacast("null",""));
		else dsource.setTITLEALIGN(trim(form.TITLEALIGN));

		if(Not IsDefined("form.TITLECOLLAPSE") || form.TITLECOLLAPSE== "" ) dsource.setTITLECOLLAPSE(javacast("null",""));
		else dsource.setTITLECOLLAPSE(trim(form.TITLECOLLAPSE));

		if(Not IsDefined("form.TOFRONTONSHOW") || form.TOFRONTONSHOW== "" ) dsource.setTOFRONTONSHOW(javacast("null",""));
		else dsource.setTOFRONTONSHOW(trim(form.TOFRONTONSHOW));

		if(Not IsDefined("form.TOOLS") || form.TOOLS== "" ) dsource.setTOOLS(javacast("null",""));
		else dsource.setTOOLS(trim(form.TOOLS));

		if(Not IsDefined("form.TPL") || form.TPL== "" ) dsource.setTPL(javacast("null",""));
		else dsource.setTPL(trim(form.TPL));

		if(Not IsDefined("form.TPLWRITEMODE") || form.TPLWRITEMODE== "" ) dsource.setTPLWRITEMODE(javacast("null",""));
		else dsource.setTPLWRITEMODE(trim(form.TPLWRITEMODE));

		if(Not IsDefined("form.GVIEWTRACKOVER") || form.GVIEWTRACKOVER== "" ) dsource.setGVIEWTRACKOVER(javacast("null",""));
		else dsource.setGVIEWTRACKOVER(trim(form.GVIEWTRACKOVER));

		if(Not IsDefined("form.QRYUI") || form.QRYUI== "" ) dsource.setQRYUI(javacast("null",""));
		else dsource.setQRYUI(trim(form.QRYUI));

		if(Not IsDefined("form.VERTICALSCROLLER") || form.VERTICALSCROLLER== "" ) dsource.setVERTICALSCROLLER(javacast("null",""));
		else dsource.setVERTICALSCROLLER(trim(form.VERTICALSCROLLER));

		if(Not IsDefined("form.QRYVIEW") || form.QRYVIEW== "" ) dsource.setQRYVIEW(javacast("null",""));
		else dsource.setQRYVIEW(trim(form.QRYVIEW));

		if(Not IsDefined("form.VIEWCONFIG") || form.VIEWCONFIG== "" ) dsource.setVIEWCONFIG(javacast("null",""));
		else dsource.setVIEWCONFIG(trim(form.VIEWCONFIG));

		if(Not IsDefined("form.WIDTH") || form.WIDTH== "" ) dsource.setWIDTH(javacast("null",""));
		else dsource.setWIDTH(trim(form.WIDTH));

		if(Not IsDefined("form.XTYPE") || form.XTYPE== "" ) dsource.setXTYPE(javacast("null",""));
		else dsource.setXTYPE(trim(form.XTYPE));

		if(Not IsDefined("form.GRIDEXTRA") || form.GRIDEXTRA== "" ) dsource.setGRIDEXTRA(javacast("null",""));
		else dsource.setGRIDEXTRA(trim(form.GRIDEXTRA));

		if(Not IsDefined("form.STORESORTERS") || form.STORESORTERS== "" ) dsource.setSTORESORTERS(javacast("null",""));
		else dsource.setSTORESORTERS(trim(form.STORESORTERS));

		if(Not IsDefined("form.STOREFILTERS") || form.STOREFILTERS== "" ) dsource.setSTOREFILTERS(javacast("null",""));
		else dsource.setSTOREFILTERS(trim(form.STOREFILTERS));

		if(Not IsDefined("form.STOREPAGESIZE") || form.STOREPAGESIZE== "" ) dsource.setSTOREPAGESIZE(javacast("null",""));
		else dsource.setSTOREPAGESIZE(trim(form.STOREPAGESIZE));

		if(Not IsDefined("form.STORETIMEOUT") || form.STORETIMEOUT== "" ) dsource.setSTORETIMEOUT(javacast("null",""));
		else dsource.setSTORETIMEOUT(trim(form.STORETIMEOUT));

		if(Not IsDefined("form.STOREEXTRA") || form.STOREEXTRA== "" ) dsource.setSTOREEXTRA(javacast("null",""));
		else dsource.setSTOREEXTRA(trim(form.STOREEXTRA));

		if(Not IsDefined("form.STOREPROXYEXTRA") || form.STOREPROXYEXTRA== "" ) dsource.setSTOREPROXYEXTRA(javacast("null",""));
		else dsource.setSTOREPROXYEXTRA(trim(form.STOREPROXYEXTRA));

		if(Not IsDefined("form.SHAREABLE") || form.SHAREABLE== "" ) dsource.setSHAREABLE(javacast("null",""));
		else dsource.setSHAREABLE(trim(form.SHAREABLE));

		if(Not IsDefined("form.PRINTABLE") || form.PRINTABLE== "" ) dsource.setPRINTABLE(javacast("null",""));
		else dsource.setPRINTABLE(trim(form.PRINTABLE));

		if(Not IsDefined("form.EXPORTABLE") || form.EXPORTABLE== "" ) dsource.setEXPORTABLE(javacast("null",""));
		else dsource.setEXPORTABLE(trim(form.EXPORTABLE));

		if(Not IsDefined("form.APPENDABLEROW") || form.APPENDABLEROW== "" ) dsource.setAPPENDABLEROW(javacast("null",""));
		else dsource.setAPPENDABLEROW(trim(form.APPENDABLEROW));

		if(Not IsDefined("form.REMOVABLEROW") || form.REMOVABLEROW== "" ) dsource.setREMOVABLEROW(javacast("null",""));
		else dsource.setREMOVABLEROW(trim(form.REMOVABLEROW));

		if(Not IsDefined("form.EMAILABLE") || form.EMAILABLE== "" ) dsource.setEMAILABLE(javacast("null",""));
		else dsource.setEMAILABLE(trim(form.EMAILABLE));


		EntitySave(dsource);
		ormflush();

		dchart = EntityLoad("EGRGQRYCHART",{EQRYCODE="#trim(form.EQRYCODE)#"}, true);
		if(IsDefined("dchart")) {
			//update
		} else {
			//insert
			dchart = EntityNew("EGRGQRYCHART");
		}

		if(Not IsDefined("form.EQRYCODE") || form.EQRYCODE == "" ) dchart.setEQRYCODE(javacast("null",""));
		else dchart.setEQRYCODE(trim(form.EQRYCODE));

		if(Not IsDefined("form.CHARTLABEL") || form.CHARTLABEL == "" ) dchart.setCHARTLABEL(javacast("null",""));
		else dchart.setCHARTLABEL(trim(form.CHARTLABEL));

		if(Not IsDefined("form.BOXFILL") || form.BOXFILL == "" ) dchart.setBOXFILL(javacast("null",""));
		else dchart.setBOXFILL(trim(form.BOXFILL));

		if(Not IsDefined("form.BOXSTROKE") || form.BOXSTROKE == "" ) dchart.setBOXSTROKE(javacast("null",""));
		else dchart.setBOXSTROKE(trim(form.BOXSTROKE));

		if(Not IsDefined("form.BOXSTROKEWIDTH") || form.BOXSTROKEWIDTH == "" ) dchart.setBOXSTROKEWIDTH(javacast("null",""));
		else dchart.setBOXSTROKEWIDTH(trim(form.BOXSTROKEWIDTH));

		if(Not IsDefined("form.BOXZINDEX") || form.BOXZINDEX == "" ) dchart.setBOXZINDEX(javacast("null",""));
		else dchart.setBOXZINDEX(trim(form.BOXZINDEX));

		if(Not IsDefined("form.ITEMSPACING") || form.ITEMSPACING == "" ) dchart.setITEMSPACING(javacast("null",""));
		else dchart.setITEMSPACING(trim(form.ITEMSPACING));

		if(Not IsDefined("form.LABELCOLOR") || form.LABELCOLOR == "" ) dchart.setLABELCOLOR(javacast("null",""));
		else dchart.setLABELCOLOR(trim(form.LABELCOLOR));

		if(Not IsDefined("form.LABELFONT") || form.LABELFONT == "" ) dchart.setLABELFONT(javacast("null",""));
		else dchart.setLABELFONT(trim(form.LABELFONT));

		if(Not IsDefined("form.PADDING") || form.PADDING == "" ) dchart.setPADDING(javacast("null",""));
		else dchart.setPADDING(trim(form.PADDING));

		if(Not IsDefined("form.LEGENDPOSITION") || form.LEGENDPOSITION == "" ) dchart.setLEGENDPOSITION(javacast("null",""));
		else dchart.setLEGENDPOSITION(trim(form.LEGENDPOSITION));

		if(Not IsDefined("form.CHARTUPDATE") || form.CHARTUPDATE == "" ) dchart.setCHARTUPDATE(javacast("null",""));
		else dchart.setCHARTUPDATE(trim(form.CHARTUPDATE));

		if(Not IsDefined("form.VISIBLE") || form.VISIBLE == "" ) dchart.setVISIBLE(javacast("null",""));
		else dchart.setVISIBLE(trim(form.VISIBLE));

		if(Not IsDefined("form.X") || form.X == "" ) dchart.setX(javacast("null",""));
		else dchart.setX(trim(form.X));

		if(Not IsDefined("form.Y") || form.Y == "" ) dchart.setY(javacast("null",""));
		else dchart.setY(trim(form.Y));

		if(Not IsDefined("form.ALLOWFUNCTIONS") || form.ALLOWFUNCTIONS == "" ) dchart.setALLOWFUNCTIONS(javacast("null",""));
		else dchart.setALLOWFUNCTIONS(trim(form.ALLOWFUNCTIONS));

		if(Not IsDefined("form.DEFAULTSORTDIRECTION") || form.DEFAULTSORTDIRECTION == "" ) dchart.setDEFAULTSORTDIRECTION(javacast("null",""));
		else dchart.setDEFAULTSORTDIRECTION(trim(form.DEFAULTSORTDIRECTION));

		if(Not IsDefined("form.LEGENDITEMLISTENERS") || form.LEGENDITEMLISTENERS == "" ) dchart.setLEGENDITEMLISTENERS(javacast("null",""));
		else dchart.setLEGENDITEMLISTENERS(trim(form.LEGENDITEMLISTENERS));

		if(Not IsDefined("form.SORTROOT") || form.SORTROOT == "" ) dchart.setSORTROOT(javacast("null",""));
		else dchart.setSORTROOT(trim(form.SORTROOT));

		if(Not IsDefined("form.SORTERS") || form.SORTERS == "" ) dchart.setSORTERS(javacast("null",""));
		else dchart.setSORTERS(trim(form.SORTERS));

		if(Not IsDefined("form.MASK") || form.MASK == "" ) dchart.setMASK(javacast("null",""));
		else dchart.setMASK(trim(form.MASK));

		if(Not IsDefined("form.AXISADJUSTEND") || form.AXISADJUSTEND == "" ) dchart.setAXISADJUSTEND(javacast("null",""));
		else dchart.setAXISADJUSTEND(trim(form.AXISADJUSTEND));

		if(Not IsDefined("form.AXISDASHSIZE") || form.AXISDASHSIZE == "" ) dchart.setAXISDASHSIZE(javacast("null",""));
		else dchart.setAXISDASHSIZE(trim(form.AXISDASHSIZE));

		if(Not IsDefined("form.AXISFIELDS") || form.AXISFIELDS == "" ) dchart.setAXISFIELDS(javacast("null",""));
		else dchart.setAXISFIELDS(trim(form.AXISFIELDS));

		if(Not IsDefined("form.AXISGRID") || form.AXISGRID == "" ) dchart.setAXISGRID(javacast("null",""));
		else dchart.setAXISGRID(trim(form.AXISGRID));

		if(Not IsDefined("form.AXISHIDDEN") || form.AXISHIDDEN == "" ) dchart.setAXISHIDDEN(javacast("null",""));
		else dchart.setAXISHIDDEN(trim(form.AXISHIDDEN));

		if(Not IsDefined("form.AXISLABEL") || form.AXISLABEL == "" ) dchart.setAXISLABEL(javacast("null",""));
		else dchart.setAXISLABEL(trim(form.AXISLABEL));

		if(Not IsDefined("form.AXISLENGTH") || form.AXISLENGTH == "" ) dchart.setAXISLENGTH(javacast("null",""));
		else dchart.setAXISLENGTH(trim(form.AXISLENGTH));

		if(Not IsDefined("form.AXISMAJORTICKSTEPS") || form.AXISMAJORTICKSTEPS == "" ) dchart.setAXISMAJORTICKSTEPS(javacast("null",""));
		else dchart.setAXISMAJORTICKSTEPS(trim(form.AXISMAJORTICKSTEPS));

		if(Not IsDefined("form.AXISMINORTICKSTEPS") || form.AXISMINORTICKSTEPS == "" ) dchart.setAXISMINORTICKSTEPS(javacast("null",""));
		else dchart.setAXISMINORTICKSTEPS(trim(form.AXISMINORTICKSTEPS));

		if(Not IsDefined("form.AXISPOSITION") || form.AXISPOSITION == "" ) dchart.setAXISPOSITION(javacast("null",""));
		else dchart.setAXISPOSITION(trim(form.AXISPOSITION));

		if(Not IsDefined("form.AXISTITLE") || form.AXISTITLE == "" ) dchart.setAXISTITLE(javacast("null",""));
		else dchart.setAXISTITLE(trim(form.AXISTITLE));

		if(Not IsDefined("form.AXISWIDTH") || form.AXISWIDTH == "" ) dchart.setAXISWIDTH(javacast("null",""));
		else dchart.setAXISWIDTH(trim(form.AXISWIDTH));

		if(Not IsDefined("form.AXISCALCULATECATEGORYCOUNT") || form.AXISCALCULATECATEGORYCOUNT == "" ) dchart.setAXISCALCULATECATEGORYCOUNT(javacast("null",""));
		else dchart.setAXISCALCULATECATEGORYCOUNT(trim(form.AXISCALCULATECATEGORYCOUNT));

		if(Not IsDefined("form.AXISCATEGORYNAMES") || form.AXISCATEGORYNAMES == "" ) dchart.setAXISCATEGORYNAMES(javacast("null",""));
		else dchart.setAXISCATEGORYNAMES(trim(form.AXISCATEGORYNAMES));

		if(Not IsDefined("form.AXISMARGIN") || form.AXISMARGIN == "" ) dchart.setAXISMARGIN(javacast("null",""));
		else dchart.setAXISMARGIN(trim(form.AXISMARGIN));

		if(Not IsDefined("form.AXISADJUSTMAXIMUMBYMAJORUNIT") || form.AXISADJUSTMAXIMUMBYMAJORUNIT == "" ) dchart.setAXISADJUSTMAXIMUMBYMAJORUNIT(javacast("null",""));
		else dchart.setAXISADJUSTMAXIMUMBYMAJORUNIT(trim(form.AXISADJUSTMAXIMUMBYMAJORUNIT));

		if(Not IsDefined("form.AXISADJUSTMINIMUMBYMAJORUNIT") || form.AXISADJUSTMINIMUMBYMAJORUNIT == "" ) dchart.setAXISADJUSTMINIMUMBYMAJORUNIT(javacast("null",""));
		else dchart.setAXISADJUSTMINIMUMBYMAJORUNIT(trim(form.AXISADJUSTMINIMUMBYMAJORUNIT));

		if(Not IsDefined("form.AXISCONSTRAIN") || form.AXISCONSTRAIN == "" ) dchart.setAXISCONSTRAIN(javacast("null",""));
		else dchart.setAXISCONSTRAIN(trim(form.AXISCONSTRAIN));

		if(Not IsDefined("form.AXISDECIMALS") || form.AXISDECIMALS == "" ) dchart.setAXISDECIMALS(javacast("null",""));
		else dchart.setAXISDECIMALS(trim(form.AXISDECIMALS));

		if(Not IsDefined("form.AXISMAXIMUM") || form.AXISMAXIMUM == "" ) dchart.setAXISMAXIMUM(javacast("null",""));
		else dchart.setAXISMAXIMUM(trim(form.AXISMAXIMUM));

		if(Not IsDefined("form.AXISMINIMUM") || form.AXISMINIMUM == "" ) dchart.setAXISMINIMUM(javacast("null",""));
		else dchart.setAXISMINIMUM(trim(form.AXISMINIMUM));

		if(Not IsDefined("form.AXISDATEFORMAT") || form.AXISDATEFORMAT == "" ) dchart.setAXISDATEFORMAT(javacast("null",""));
		else dchart.setAXISDATEFORMAT(trim(form.AXISDATEFORMAT));

		if(Not IsDefined("form.AXISFROMDATE") || form.AXISFROMDATE == "" ) dchart.setAXISFROMDATE(javacast("null",""));
		else dchart.setAXISFROMDATE(trim(form.AXISFROMDATE));

		if(Not IsDefined("form.AXISSTEP") || form.AXISSTEP == "" ) dchart.setAXISSTEP(javacast("null",""));
		else dchart.setAXISSTEP(trim(form.AXISSTEP));

		if(Not IsDefined("form.AXISTODATE") || form.AXISTODATE == "" ) dchart.setAXISTODATE(javacast("null",""));
		else dchart.setAXISTODATE(trim(form.AXISTODATE));

		if(Not IsDefined("form.AXISEXTRA") || form.AXISEXTRA == "" ) dchart.setAXISEXTRA(javacast("null",""));
		else dchart.setAXISEXTRA(trim(form.AXISEXTRA));

		if(Not IsDefined("form.SERIESAXIS") || form.SERIESAXIS == "" ) dchart.setSERIESAXIS(javacast("null",""));
		else dchart.setSERIESAXIS(trim(form.SERIESAXIS));

		if(Not IsDefined("form.SERIESHIGHLIGHT") || form.SERIESHIGHLIGHT == "" ) dchart.setSERIESHIGHLIGHT(javacast("null",""));
		else dchart.setSERIESHIGHLIGHT(trim(form.SERIESHIGHLIGHT));

		if(Not IsDefined("form.SERIESLABEL") || form.SERIESLABEL == "" ) dchart.setSERIESLABEL(javacast("null",""));
		else dchart.setSERIESLABEL(trim(form.SERIESLABEL));

		if(Not IsDefined("form.SERIESLISTENERS") || form.SERIESLISTENERS == "" ) dchart.setSERIESLISTENERS(javacast("null",""));
		else dchart.setSERIESLISTENERS(trim(form.SERIESLISTENERS));

		if(Not IsDefined("form.SERIESRENDERER") || form.SERIESRENDERER == "" ) dchart.setSERIESRENDERER(javacast("null",""));
		else dchart.setSERIESRENDERER(trim(form.SERIESRENDERER));

		if(Not IsDefined("form.SERIESSHADOWATTRIBUTES") || form.SERIESSHADOWATTRIBUTES == "" ) dchart.setSERIESSHADOWATTRIBUTES(javacast("null",""));
		else dchart.setSERIESSHADOWATTRIBUTES(trim(form.SERIESSHADOWATTRIBUTES));

		if(Not IsDefined("form.SERIESSHOWINLEGEND") || form.SERIESSHOWINLEGEND == "" ) dchart.setSERIESSHOWINLEGEND(javacast("null",""));
		else dchart.setSERIESSHOWINLEGEND(trim(form.SERIESSHOWINLEGEND));

		if(Not IsDefined("form.SERIESSTYLE") || form.SERIESSTYLE == "" ) dchart.setSERIESSTYLE(javacast("null",""));
		else dchart.setSERIESSTYLE(trim(form.SERIESSTYLE));

		if(Not IsDefined("form.SERIESTIPS") || form.SERIESTIPS == "" ) dchart.setSERIESTIPS(javacast("null",""));
		else dchart.setSERIESTIPS(trim(form.SERIESTIPS));

		if(Not IsDefined("form.SERIESTITLE") || form.SERIESTITLE == "" ) dchart.setSERIESTITLE(javacast("null",""));
		else dchart.setSERIESTITLE(trim(form.SERIESTITLE));

		if(Not IsDefined("form.SERIESTYPE") || form.SERIESTYPE == "" ) dchart.setSERIESTYPE(javacast("null",""));
		else dchart.setSERIESTYPE(trim(form.SERIESTYPE));

		if(Not IsDefined("form.SERIESXFIELD") || form.SERIESXFIELD == "" ) dchart.setSERIESXFIELD(javacast("null",""));
		else dchart.setSERIESXFIELD(trim(form.SERIESXFIELD));

		if(Not IsDefined("form.SERIESYFIELD") || form.SERIESYFIELD == "" ) dchart.setSERIESYFIELD(javacast("null",""));
		else dchart.setSERIESYFIELD(trim(form.SERIESYFIELD));

		if(Not IsDefined("form.SERIESCOLUMN") || form.SERIESCOLUMN == "" ) dchart.setSERIESCOLUMN(javacast("null",""));
		else dchart.setSERIESCOLUMN(trim(form.SERIESCOLUMN));

		if(Not IsDefined("form.SERIESGROUPGUTTER") || form.SERIESGROUPGUTTER == "" ) dchart.setSERIESGROUPGUTTER(javacast("null",""));
		else dchart.setSERIESGROUPGUTTER(trim(form.SERIESGROUPGUTTER));

		if(Not IsDefined("form.SERIESGUTTER") || form.SERIESGUTTER == "" ) dchart.setSERIESGUTTER(javacast("null",""));
		else dchart.setSERIESGUTTER(trim(form.SERIESGUTTER));

		if(Not IsDefined("form.SERIESSTACKED") || form.SERIESSTACKED == "" ) dchart.setSERIESSTACKED(javacast("null",""));
		else dchart.setSERIESSTACKED(trim(form.SERIESSTACKED));

		if(Not IsDefined("form.SERIESXPADDING") || form.SERIESXPADDING == "" ) dchart.setSERIESXPADDING(javacast("null",""));
		else dchart.setSERIESXPADDING(trim(form.SERIESXPADDING));

		if(Not IsDefined("form.SERIESYPADDING") || form.SERIESYPADDING == "" ) dchart.setSERIESYPADDING(javacast("null",""));
		else dchart.setSERIESYPADDING(trim(form.SERIESYPADDING));

		if(Not IsDefined("form.SERIESANGLEFIELD") || form.SERIESANGLEFIELD == "" ) dchart.setSERIESANGLEFIELD(javacast("null",""));
		else dchart.setSERIESANGLEFIELD(trim(form.SERIESANGLEFIELD));

		if(Not IsDefined("form.SERIESDONUT") || form.SERIESDONUT == "" ) dchart.setSERIESDONUT(javacast("null",""));
		else dchart.setSERIESDONUT(trim(form.SERIESDONUT));

		if(Not IsDefined("form.SERIESHIGHLIGHTDURATION") || form.SERIESHIGHLIGHTDURATION == "" ) dchart.setSERIESHIGHLIGHTDURATION(javacast("null",""));
		else dchart.setSERIESHIGHLIGHTDURATION(trim(form.SERIESHIGHLIGHTDURATION));

		if(Not IsDefined("form.SERIESNEEDLE") || form.SERIESNEEDLE == "" ) dchart.setSERIESNEEDLE(javacast("null",""));
		else dchart.setSERIESNEEDLE(trim(form.SERIESNEEDLE));

		if(Not IsDefined("form.SERIESFILL") || form.SERIESFILL == "" ) dchart.setSERIESFILL(javacast("null",""));
		else dchart.setSERIESFILL(trim(form.SERIESFILL));

		if(Not IsDefined("form.SERIESMARKERCONFIG") || form.SERIESMARKERCONFIG == "" ) dchart.setSERIESMARKERCONFIG(javacast("null",""));
		else dchart.setSERIESMARKERCONFIG(trim(form.SERIESMARKERCONFIG));

		if(Not IsDefined("form.SERIESSELECTIONTOLERANCE") || form.SERIESSELECTIONTOLERANCE == "" ) dchart.setSERIESSELECTIONTOLERANCE(javacast("null",""));
		else dchart.setSERIESSELECTIONTOLERANCE(trim(form.SERIESSELECTIONTOLERANCE));

		if(Not IsDefined("form.SERIESSHOWMARKERS") || form.SERIESSHOWMARKERS == "" ) dchart.setSERIESSHOWMARKERS(javacast("null",""));
		else dchart.setSERIESSHOWMARKERS(trim(form.SERIESSHOWMARKERS));

		if(Not IsDefined("form.SERIESSMOOTH") || form.SERIESSMOOTH == "" ) dchart.setSERIESSMOOTH(javacast("null",""));
		else dchart.setSERIESSMOOTH(trim(form.SERIESSMOOTH));

		if(Not IsDefined("form.SERIESCOLORSET") || form.SERIESCOLORSET == "" ) dchart.setSERIESCOLORSET(javacast("null",""));
		else dchart.setSERIESCOLORSET(trim(form.SERIESCOLORSET));

		if(Not IsDefined("form.SERIESFIELD") || form.SERIESFIELD == "" ) dchart.setSERIESFIELD(javacast("null",""));
		else dchart.setSERIESFIELD(trim(form.SERIESFIELD));

		if(Not IsDefined("form.SERIESLENGTHFIELD") || form.SERIESLENGTHFIELD == "" ) dchart.setSERIESLENGTHFIELD(javacast("null",""));
		else dchart.setSERIESLENGTHFIELD(trim(form.SERIESLENGTHFIELD));

		if(Not IsDefined("form.SERIESEXTRA") || form.SERIESEXTRA == "" ) dchart.setSERIESEXTRA(javacast("null",""));
		else dchart.setSERIESEXTRA(trim(form.SERIESEXTRA));

		if(Not IsDefined("form.CHARTEXTRA") || form.CHARTEXTRA == "" ) dchart.setCHARTEXTRA(javacast("null",""));
		else dchart.setCHARTEXTRA(trim(form.CHARTEXTRA));

		EntitySave(dchart);
		ormflush();

		dfeature = EntityLoad("EGRGQRYFEATURE",{EQRYCODE="#trim(form.EQRYCODE)#"}, true);
		if(IsDefined("dfeature")) {
			//update
		} else {
			//insert
			dfeature = EntityNew("EGRGQRYFEATURE");
		}

		if(Not IsDefined("form.EQRYCODE") || form.EQRYCODE == "" ) dfeature.setEQRYCODE(javacast("null",""));
		else dfeature.setEQRYCODE(trim(form.EQRYCODE));

		if(Not IsDefined("form.GROUPINGLISTENERS") || form.GROUPINGLISTENERS == "" ) dfeature.setGROUPINGLISTENERS(javacast("null",""));
		else dfeature.setGROUPINGLISTENERS(trim(form.GROUPINGLISTENERS));

		if(Not IsDefined("form.REMOTEROOT") || form.REMOTEROOT == "" ) dfeature.setREMOTEROOT(javacast("null",""));
		else dfeature.setREMOTEROOT(trim(form.REMOTEROOT));

		if(Not IsDefined("form.SHOWSUMMARYROW") || form.SHOWSUMMARYROW == "" ) dfeature.setSHOWSUMMARYROW(javacast("null",""));
		else dfeature.setSHOWSUMMARYROW(trim(form.SHOWSUMMARYROW));

		if(Not IsDefined("form.FCOLLAPSIBLE") || form.FCOLLAPSIBLE == "" ) dfeature.setFCOLLAPSIBLE(javacast("null",""));
		else dfeature.setFCOLLAPSIBLE(trim(form.FCOLLAPSIBLE));

		if(Not IsDefined("form.DEPTHTOINDENT") || form.DEPTHTOINDENT == "" ) dfeature.setDEPTHTOINDENT(javacast("null",""));
		else dfeature.setDEPTHTOINDENT(trim(form.DEPTHTOINDENT));

		if(Not IsDefined("form.ENABLEGROUPINGMENU") || form.ENABLEGROUPINGMENU == "" ) dfeature.setENABLEGROUPINGMENU(javacast("null",""));
		else dfeature.setENABLEGROUPINGMENU(trim(form.ENABLEGROUPINGMENU));

		if(Not IsDefined("form.ENABLENOGROUPS") || form.ENABLENOGROUPS == "" ) dfeature.setENABLENOGROUPS(javacast("null",""));
		else dfeature.setENABLENOGROUPS(trim(form.ENABLENOGROUPS));

		if(Not IsDefined("form.GROUPBYTEXT") || form.GROUPBYTEXT == "" ) dfeature.setGROUPBYTEXT(javacast("null",""));
		else dfeature.setGROUPBYTEXT(trim(form.GROUPBYTEXT));

		if(Not IsDefined("form.GROUPHEADERTPL") || form.GROUPHEADERTPL == "" ) dfeature.setGROUPHEADERTPL(javacast("null",""));
		else dfeature.setGROUPHEADERTPL(trim(form.GROUPHEADERTPL));

		if(Not IsDefined("form.HIDEGROUPEDHEADER") || form.HIDEGROUPEDHEADER == "" ) dfeature.setHIDEGROUPEDHEADER(javacast("null",""));
		else dfeature.setHIDEGROUPEDHEADER(trim(form.HIDEGROUPEDHEADER));

		if(Not IsDefined("form.SHOWGROUPSTEXT") || form.SHOWGROUPSTEXT == "" ) dfeature.setSHOWGROUPSTEXT(javacast("null",""));
		else dfeature.setSHOWGROUPSTEXT(trim(form.SHOWGROUPSTEXT));

		if(Not IsDefined("form.STARTCOLLAPSED") || form.STARTCOLLAPSED == "" ) dfeature.setSTARTCOLLAPSED(javacast("null",""));
		else dfeature.setSTARTCOLLAPSED(trim(form.STARTCOLLAPSED));

		if(Not IsDefined("form.FEATUREEXTRA") || form.FEATUREEXTRA == "" ) dfeature.setFEATUREEXTRA(javacast("null",""));
		else dfeature.setFEATUREEXTRA(trim(form.FEATUREEXTRA));

		EntitySave(dfeature);
		ormflush();

		dplugin = EntityLoad("EGRGQRYPLUGIN",{EQRYCODE="#trim(form.EQRYCODE)#"}, true);
		if(IsDefined("dplugin")) {
			//update
		} else {
			//insert
			dplugin = EntityNew("EGRGQRYPLUGIN");
		}

		if(Not IsDefined("form.EQRYCODE") || form.EQRYCODE == "" ) dplugin.setEQRYCODE(javacast("null",""));
		else dplugin.setEQRYCODE(trim(form.EQRYCODE));

		if(Not IsDefined("form.BLEADINGBUFFERZONE") || form.BLEADINGBUFFERZONE == "" ) dplugin.setBLEADINGBUFFERZONE(javacast("null",""));
		else dplugin.setBLEADINGBUFFERZONE(trim(form.BLEADINGBUFFERZONE));

		if(Not IsDefined("form.BNUMFROMEDGE") || form.BNUMFROMEDGE == "" ) dplugin.setBNUMFROMEDGE(javacast("null",""));
		else dplugin.setBNUMFROMEDGE(trim(form.BNUMFROMEDGE));

		if(Not IsDefined("form.BPLUGINID") || form.BPLUGINID == "" ) dplugin.setBPLUGINID(javacast("null",""));
		else dplugin.setBPLUGINID(trim(form.BPLUGINID));

		if(Not IsDefined("form.BSCROLLTOLOADBUFFER") || form.BSCROLLTOLOADBUFFER == "" ) dplugin.setBSCROLLTOLOADBUFFER(javacast("null",""));
		else dplugin.setBSCROLLTOLOADBUFFER(trim(form.BSCROLLTOLOADBUFFER));

		if(Not IsDefined("form.BSYNCHRONOUSRENDER") || form.BSYNCHRONOUSRENDER == "" ) dplugin.setBSYNCHRONOUSRENDER(javacast("null",""));
		else dplugin.setBSYNCHRONOUSRENDER(trim(form.BSYNCHRONOUSRENDER));

		if(Not IsDefined("form.BTRAILINGBUFFERZONE") || form.BTRAILINGBUFFERZONE == "" ) dplugin.setBTRAILINGBUFFERZONE(javacast("null",""));
		else dplugin.setBTRAILINGBUFFERZONE(trim(form.BTRAILINGBUFFERZONE));

		if(Not IsDefined("form.BVARIABLEROWHEIGHT") || form.BVARIABLEROWHEIGHT == "" ) dplugin.setBVARIABLEROWHEIGHT(javacast("null",""));
		else dplugin.setBVARIABLEROWHEIGHT(trim(form.BVARIABLEROWHEIGHT));

		if(Not IsDefined("form.CELLEDITINGCLICKSTOEDIT") || form.CELLEDITINGCLICKSTOEDIT == "" ) dplugin.setCELLEDITINGCLICKSTOEDIT(javacast("null",""));
		else dplugin.setCELLEDITINGCLICKSTOEDIT(trim(form.CELLEDITINGCLICKSTOEDIT));

		if(Not IsDefined("form.CELLEDITINGLISTENER") || form.CELLEDITINGLISTENER == "" ) dplugin.setCELLEDITINGLISTENER(javacast("null",""));
		else dplugin.setCELLEDITINGLISTENER(trim(form.CELLEDITINGLISTENER));

		if(Not IsDefined("form.TRIGGEREVENT") || form.TRIGGEREVENT == "" ) dplugin.setTRIGGEREVENT(javacast("null",""));
		else dplugin.setTRIGGEREVENT(trim(form.TRIGGEREVENT));

		if(Not IsDefined("form.DDCONTAINERSCROLL") || form.DDCONTAINERSCROLL == "" ) dplugin.setDDCONTAINERSCROLL(javacast("null",""));
		else dplugin.setDDCONTAINERSCROLL(trim(form.DDCONTAINERSCROLL));

		if(Not IsDefined("form.DDGROUP") || form.DDGROUP == "" ) dplugin.setDDGROUP(javacast("null",""));
		else dplugin.setDDGROUP(trim(form.DDGROUP));

		if(Not IsDefined("form.DDDRAGGROUP") || form.DDDRAGGROUP == "" ) dplugin.setDDDRAGGROUP(javacast("null",""));
		else dplugin.setDDDRAGGROUP(trim(form.DDDRAGGROUP));

		if(Not IsDefined("form.DDDRAGTEXT") || form.DDDRAGTEXT == "" ) dplugin.setDDDRAGTEXT(javacast("null",""));
		else dplugin.setDDDRAGTEXT(trim(form.DDDRAGTEXT));

		if(Not IsDefined("form.DDDROPGROUP") || form.DDDROPGROUP == "" ) dplugin.setDDDROPGROUP(javacast("null",""));
		else dplugin.setDDDROPGROUP(trim(form.DDDROPGROUP));

		if(Not IsDefined("form.DDENABLEDRAG") || form.DDENABLEDRAG == "" ) dplugin.setDDENABLEDRAG(javacast("null",""));
		else dplugin.setDDENABLEDRAG(trim(form.DDENABLEDRAG));

		if(Not IsDefined("form.DDENABLEDROP") || form.DDENABLEDROP == "" ) dplugin.setDDENABLEDROP(javacast("null",""));
		else dplugin.setDDENABLEDROP(trim(form.DDENABLEDROP));

		if(Not IsDefined("form.HEADERRESIZER") || form.HEADERRESIZER == "" ) dplugin.setHEADERRESIZER(javacast("null",""));
		else dplugin.setHEADERRESIZER(trim(form.HEADERRESIZER));

		if(Not IsDefined("form.ROWAUTOCANCEL") || form.ROWAUTOCANCEL == "" ) dplugin.setROWAUTOCANCEL(javacast("null",""));
		else dplugin.setROWAUTOCANCEL(trim(form.ROWAUTOCANCEL));

		if(Not IsDefined("form.ROWCLICKSTOEDIT") || form.ROWCLICKSTOEDIT == "" ) dplugin.setROWCLICKSTOEDIT(javacast("null",""));
		else dplugin.setROWCLICKSTOEDIT(trim(form.ROWCLICKSTOEDIT));

		if(Not IsDefined("form.ROWCLICKSTOMOVEEDITOR") || form.ROWCLICKSTOMOVEEDITOR == "" ) dplugin.setROWCLICKSTOMOVEEDITOR(javacast("null",""));
		else dplugin.setROWCLICKSTOMOVEEDITOR(trim(form.ROWCLICKSTOMOVEEDITOR));

		if(Not IsDefined("form.ROWERRORSUMMARY") || form.ROWERRORSUMMARY == "" ) dplugin.setROWERRORSUMMARY(javacast("null",""));
		else dplugin.setROWERRORSUMMARY(trim(form.ROWERRORSUMMARY));

		if(Not IsDefined("form.ROWLISTENERS") || form.ROWLISTENERS == "" ) dplugin.setROWLISTENERS(javacast("null",""));
		else dplugin.setROWLISTENERS(trim(form.ROWLISTENERS));

		if(Not IsDefined("form.ROWTRIGGEREVENT") || form.ROWTRIGGEREVENT == "" ) dplugin.setROWTRIGGEREVENT(javacast("null",""));
		else dplugin.setROWTRIGGEREVENT(trim(form.ROWTRIGGEREVENT));

		if(Not IsDefined("form.ROWEXPANDONDBLCLICK") || form.ROWEXPANDONDBLCLICK == "" ) dplugin.setROWEXPANDONDBLCLICK(javacast("null",""));
		else dplugin.setROWEXPANDONDBLCLICK(trim(form.ROWEXPANDONDBLCLICK));

		if(Not IsDefined("form.ROWEXPANDONENTER") || form.ROWEXPANDONENTER == "" ) dplugin.setROWEXPANDONENTER(javacast("null",""));
		else dplugin.setROWEXPANDONENTER(trim(form.ROWEXPANDONENTER));

		if(Not IsDefined("form.ROWSELECTROWONEXPAND") || form.ROWSELECTROWONEXPAND == "" ) dplugin.setROWSELECTROWONEXPAND(javacast("null",""));
		else dplugin.setROWSELECTROWONEXPAND(trim(form.ROWSELECTROWONEXPAND));

		if(Not IsDefined("form.PLUGINEXTRA") || form.PLUGINEXTRA == "" ) dplugin.setPLUGINEXTRA(javacast("null",""));
		else dplugin.setPLUGINEXTRA(trim(form.PLUGINEXTRA));

		EntitySave(dplugin);
		ormflush();

		rootstruct = StructNew();
		rootstruct["success"] = "true";
		return rootstruct;
	</cfscript>
</cffunction>

<cffunction name="Load" ExtDirect="true" returntype="struct">
	<cfargument name="querycode" type="string">
	<cfscript>
	rootstruct = StructNew();
	tmpresult = StructNew();
    tmpresult["EQRYCODE"] = querycode;
	dsource = EntityLoad("EGRGQRYGRID",{EQRYCODE="#querycode#"}, false);
	if(IsDefined("dsource")) {
		for(i=1; i<=ArrayLen(dsource); i++) {
			tmpresult["OUTPUTTYPE"] = dsource[i].getOUTPUTTYPE();
			tmpresult["ACTIVEITEM"] = dsource[i].getACTIVEITEM();
			tmpresult["ALLOWDESELECT"] = dsource[i].getALLOWDESELECT();
			tmpresult["ANCHORSIZE"] = dsource[i].getANCHORSIZE();
			tmpresult["ANIMCOLLAPSE"] = dsource[i].getANIMCOLLAPSE();
			tmpresult["AUTODESTROY"] = dsource[i].getAUTODESTROY();
			tmpresult["AUTORENDER"] = dsource[i].getAUTORENDER();
			tmpresult["AUTOSCROLL"] = dsource[i].getAUTOSCROLL();
			tmpresult["AUTOSHOW"] = dsource[i].getAUTOSHOW();
			tmpresult["BASECLS"] = dsource[i].getBASECLS();
			tmpresult["BBAR"] = dsource[i].getBBAR();
			tmpresult["GVIEWBLOCKREFRESH"] = dsource[i].getGVIEWBLOCKREFRESH();
			tmpresult["BODYBORDER"] = dsource[i].getBODYBORDER();
			tmpresult["BODYCLS"] = dsource[i].getBODYCLS();
			tmpresult["BODYPADDING"] = dsource[i].getBODYPADDING();
			tmpresult["BODYSTYLE"] = dsource[i].getBODYSTYLE();
			tmpresult["BORDER"] = dsource[i].getBORDER();
			tmpresult["BUBBLEEVENTS"] = dsource[i].getBUBBLEEVENTS();
			tmpresult["BUTTONALIGN"] = dsource[i].getBUTTONALIGN();
			tmpresult["BUTTONS"] = dsource[i].getBUTTONS();
			tmpresult["CHILDELS"] = dsource[i].getCHILDELS();
			tmpresult["CLS"] = dsource[i].getCLS();
			tmpresult["CLOSABLE"] = dsource[i].getCLOSABLE();
			tmpresult["CLOSEACTION"] = dsource[i].getCLOSEACTION();
			tmpresult["COLLAPSEDIRECTION"] = dsource[i].getCOLLAPSEDIRECTION();
			tmpresult["COLLAPSEDFIRST"] = dsource[i].getCOLLAPSEDFIRST();
			tmpresult["COLLAPSEMODE"] = dsource[i].getCOLLAPSEMODE();
			tmpresult["COLLAPSED"] = dsource[i].getCOLLAPSED();
			tmpresult["COLLAPSEDCLS"] = dsource[i].getCOLLAPSEDCLS();
			tmpresult["COLLAPSIBLE"] = dsource[i].getCOLLAPSIBLE();
			tmpresult["COLUMNLINES"] = dsource[i].getCOLUMNLINES();
			tmpresult["COLUMNWIDTH"] = dsource[i].getCOLUMNWIDTH();
			tmpresult["COMPONENTCLS"] = dsource[i].getCOMPONENTCLS();
			tmpresult["COMPONENTLAYOUT"] = dsource[i].getCOMPONENTLAYOUT();
			tmpresult["QRYCONSTRAIN"] = dsource[i].getQRYCONSTRAIN();
			tmpresult["CONSTRAINHEADER"] = dsource[i].getCONSTRAINHEADER();
			tmpresult["QRYCONSTRAINTO"] = dsource[i].getQRYCONSTRAINTO();
			tmpresult["CONSTRAINTINSETS"] = dsource[i].getCONSTRAINTINSETS();
			tmpresult["CONTENTEL"] = dsource[i].getCONTENTEL();
			tmpresult["QRYDATA"] = dsource[i].getQRYDATA();
			tmpresult["DEFAULTALIGN"] = dsource[i].getDEFAULTALIGN();
			tmpresult["DEFAULTDOCKWEIGHTS"] = dsource[i].getDEFAULTDOCKWEIGHTS();
			tmpresult["DEFAULTTYPE"] = dsource[i].getDEFAULTTYPE();
			tmpresult["DEFAULTS"] = dsource[i].getDEFAULTS();
			tmpresult["GVIEWDEFEREMPTYTEXT"] = dsource[i].getGVIEWDEFEREMPTYTEXT();
			tmpresult["GVIEWDEFERINITIALREFRESH"] = dsource[i].getGVIEWDEFERINITIALREFRESH();
			tmpresult["DEFERROWRENDER"] = dsource[i].getDEFERROWRENDER();
			tmpresult["DETACHONREMOVE"] = dsource[i].getDETACHONREMOVE();
			tmpresult["DISABLED"] = dsource[i].getDISABLED();
			tmpresult["DISABLESELECTION"] = dsource[i].getDISABLESELECTION();
			tmpresult["DISABLEDCLS"] = dsource[i].getDISABLEDCLS();
			tmpresult["DOCKEDITEMS"] = dsource[i].getDOCKEDITEMS();
			tmpresult["DRAGGABLE"] = dsource[i].getDRAGGABLE();
			tmpresult["EMPTYTEXT"] = dsource[i].getEMPTYTEXT();
			tmpresult["GVIEWENABLETEXTSELECTION"] = dsource[i].getGVIEWENABLETEXTSELECTION();
			tmpresult["ENABLECOLUMNHIDE"] = dsource[i].getENABLECOLUMNHIDE();
			tmpresult["ENABLECOLUMNMOVE"] = dsource[i].getENABLECOLUMNMOVE();
			tmpresult["ENABLECOLUMNRESIZE"] = dsource[i].getENABLECOLUMNRESIZE();
			tmpresult["ENABLELOCKING"] = dsource[i].getENABLELOCKING();
			tmpresult["FBAR"] = dsource[i].getFBAR();
			tmpresult["FEATURES"] = dsource[i].getFEATURES();
			tmpresult["GVIEWFIRSTCLS"] = dsource[i].getGVIEWFIRSTCLS();
			tmpresult["FIXED"] = dsource[i].getFIXED();
			tmpresult["FLOATABLE"] = dsource[i].getFLOATABLE();
			tmpresult["FLOATING"] = dsource[i].getFLOATING();
			tmpresult["FOCUSONTOFRONT"] = dsource[i].getFOCUSONTOFRONT();
			tmpresult["FORCEFIT"] = dsource[i].getFORCEFIT();
			tmpresult["FORMBIND"] = dsource[i].getFORMBIND();
			tmpresult["FRAME"] = dsource[i].getFRAME();
			tmpresult["FRAMEHEADER"] = dsource[i].getFRAMEHEADER();
			tmpresult["GLYPH"] = dsource[i].getGLYPH();
			tmpresult["HEADER"] = dsource[i].getHEADER();
			tmpresult["HEADEROVERCLS"] = dsource[i].getHEADEROVERCLS();
			tmpresult["HEADERPOSITION"] = dsource[i].getHEADERPOSITION();
			tmpresult["HEIGHT"] = dsource[i].getHEIGHT();
			tmpresult["HIDDEN"] = dsource[i].getHIDDEN();
			tmpresult["HIDECOLLAPSETOOL"] = dsource[i].getHIDECOLLAPSETOOL();
			tmpresult["HIDEHEADER"] = dsource[i].getHIDEHEADER();
			tmpresult["HIDEMODE"] = dsource[i].getHIDEMODE();
			tmpresult["HTML"] = dsource[i].getHTML();
			tmpresult["ICON"] = dsource[i].getICON();
			tmpresult["ICONCLS"] = dsource[i].getICONCLS();
			tmpresult["QRYID"] = dsource[i].getQRYID();
			tmpresult["ITEMID"] = dsource[i].getITEMID();
			tmpresult["GVIEWITEMCLS"] = dsource[i].getGVIEWITEMCLS();
			tmpresult["GVIEWITEMTPL"] = dsource[i].getGVIEWITEMTPL();
			tmpresult["ITEMS"] = dsource[i].getITEMS();
			tmpresult["GVIEWLASTCLS"] = dsource[i].getGVIEWLASTCLS();
			tmpresult["LAYOUT"] = dsource[i].getLAYOUT();
			tmpresult["LBAR"] = dsource[i].getLBAR();
			tmpresult["LISTENERS"] = dsource[i].getLISTENERS();
			tmpresult["GVIEWLOADMASK"] = dsource[i].getGVIEWLOADMASK();
			tmpresult["LOADER"] = dsource[i].getLOADER();
			tmpresult["GVIEWLOADINGCLS"] = dsource[i].getGVIEWLOADINGCLS();
			tmpresult["GVIEWLOADINGHEIGHT"] = dsource[i].getGVIEWLOADINGHEIGHT();
			tmpresult["GVIEWLOADINGTEXT"] = dsource[i].getGVIEWLOADINGTEXT();
			tmpresult["LOCKEDGRIDCONFIG"] = dsource[i].getLOCKEDGRIDCONFIG();
			tmpresult["LOCKEDVIEWCONFIG"] = dsource[i].getLOCKEDVIEWCONFIG();
			tmpresult["MANAGEHEIGHT"] = dsource[i].getMANAGEHEIGHT();
			tmpresult["MARGIN"] = dsource[i].getMARGIN();
			tmpresult["GVIEWMARKDIRTY"] = dsource[i].getGVIEWMARKDIRTY();
			tmpresult["MAXHEIGHT"] = dsource[i].getMAXHEIGHT();
			tmpresult["MAXWIDTH"] = dsource[i].getMAXWIDTH();
			tmpresult["MINBUTTONWIDTH"] = dsource[i].getMINBUTTONWIDTH();
			tmpresult["MINHEIGHT"] = dsource[i].getMINHEIGHT();
			tmpresult["MINWIDTH"] = dsource[i].getMINWIDTH();
			tmpresult["GVIEWMOUSEOVEROUTBUFFER"] = dsource[i].getGVIEWMOUSEOVEROUTBUFFER();
			tmpresult["NORMALGRIDCONFIG"] = dsource[i].getNORMALGRIDCONFIG();
			tmpresult["NORMALVIEWCONFIG"] = dsource[i].getNORMALVIEWCONFIG();
			tmpresult["OVERCLS"] = dsource[i].getOVERCLS();
			tmpresult["OVERFLOWX"] = dsource[i].getOVERFLOWX();
			tmpresult["OVERFLOWY"] = dsource[i].getOVERFLOWY();
			tmpresult["GVIEWOVERITEMCLS"] = dsource[i].getGVIEWOVERITEMCLS();
			tmpresult["OVERLAPHEADER"] = dsource[i].getOVERLAPHEADER();
			tmpresult["PADDING"] = dsource[i].getPADDING();
			tmpresult["PLACEHOLDER"] = dsource[i].getPLACEHOLDER();
			tmpresult["PLACEHOLDERCOLLAPSEHIDEMODE"] = dsource[i].getPLACEHOLDERCOLLAPSEHIDEMODE();
			tmpresult["PLUGINS"] = dsource[i].getPLUGINS();
			tmpresult["GVIEWPRESERVESCROLLONREFRESH"] = dsource[i].getGVIEWPRESERVESCROLLONREFRESH();
			tmpresult["RBAR"] = dsource[i].getRBAR();
			tmpresult["REGION"] = dsource[i].getREGION();
			tmpresult["RENDERDATA"] = dsource[i].getRENDERDATA();
			tmpresult["RENDERSELECTORS"] = dsource[i].getRENDERSELECTORS();
			tmpresult["RENDERTO"] = dsource[i].getRENDERTO();
			tmpresult["RESIZABLE"] = dsource[i].getRESIZABLE();
			tmpresult["RESIZEHANDLES"] = dsource[i].getRESIZEHANDLES();
			tmpresult["ROWLINES"] = dsource[i].getROWLINES();
			tmpresult["RTL"] = dsource[i].getRTL();
			tmpresult["SAVEDELAY"] = dsource[i].getSAVEDELAY();
			tmpresult["GVIEWSELECTEDITEMCLS"] = dsource[i].getGVIEWSELECTEDITEMCLS();
			tmpresult["SCROLL"] = dsource[i].getSCROLL();
			tmpresult["SCROLLDELTA"] = dsource[i].getSCROLLDELTA();
			tmpresult["SEALEDCOLUMNS"] = dsource[i].getSEALEDCOLUMNS();
			tmpresult["SELMODEL"] = dsource[i].getSELMODEL();
			tmpresult["SELTYPE"] = dsource[i].getSELTYPE();
			tmpresult["SHADOW"] = dsource[i].getSHADOW();
			tmpresult["SHADOWOFFSET"] = dsource[i].getSHADOWOFFSET();
			tmpresult["SHRINKWRAP"] = dsource[i].getSHRINKWRAP();
			tmpresult["SHRINKWRAPDOCK"] = dsource[i].getSHRINKWRAPDOCK();
			tmpresult["SIMPLEDRAG"] = dsource[i].getSIMPLEDRAG();
			tmpresult["SORTABLECOLUMNS"] = dsource[i].getSORTABLECOLUMNS();
			tmpresult["STATEEVENTS"] = dsource[i].getSTATEEVENTS();
			tmpresult["STATEID"] = dsource[i].getSTATEID();
			tmpresult["STATEFUL"] = dsource[i].getSTATEFUL();
			tmpresult["GVIEWSTRIPEROWS"] = dsource[i].getGVIEWSTRIPEROWS();
			tmpresult["STYLE"] = dsource[i].getSTYLE();
			tmpresult["SUBGRIDXTYPE"] = dsource[i].getSUBGRIDXTYPE();
			tmpresult["SUSPENDLAYOUT"] = dsource[i].getSUSPENDLAYOUT();
			tmpresult["SYNCROWHEIGHT"] = dsource[i].getSYNCROWHEIGHT();
			tmpresult["TBAR"] = dsource[i].getTBAR();
			tmpresult["QRYTITLE"] = dsource[i].getQRYTITLE();
			tmpresult["TITLEALIGN"] = dsource[i].getTITLEALIGN();
			tmpresult["TITLECOLLAPSE"] = dsource[i].getTITLECOLLAPSE();
			tmpresult["TOFRONTONSHOW"] = dsource[i].getTOFRONTONSHOW();
			tmpresult["TOOLS"] = dsource[i].getTOOLS();
			tmpresult["TPL"] = dsource[i].getTPL();
			tmpresult["TPLWRITEMODE"] = dsource[i].getTPLWRITEMODE();
			tmpresult["GVIEWTRACKOVER"] = dsource[i].getGVIEWTRACKOVER();
			tmpresult["QRYUI"] = dsource[i].getQRYUI();
			tmpresult["VERTICALSCROLLER"] = dsource[i].getVERTICALSCROLLER();
			tmpresult["QRYVIEW"] = dsource[i].getQRYVIEW();
			tmpresult["VIEWCONFIG"] = dsource[i].getVIEWCONFIG();
			tmpresult["WIDTH"] = dsource[i].getWIDTH();
			tmpresult["XTYPE"] = dsource[i].getXTYPE();
			tmpresult["GRIDEXTRA"] = dsource[i].getGRIDEXTRA();
			tmpresult["STORESORTERS"] = dsource[i].getSTORESORTERS();
			tmpresult["STOREFILTERS"] = dsource[i].getSTOREFILTERS();
			tmpresult["STOREPAGESIZE"] = dsource[i].getSTOREPAGESIZE();
			tmpresult["STORETIMEOUT"] = dsource[i].getSTORETIMEOUT();
			tmpresult["STOREEXTRA"] = dsource[i].getSTOREEXTRA();
			tmpresult["STOREPROXYEXTRA"] = dsource[i].getSTOREPROXYEXTRA();
			tmpresult["SHAREABLE"] = dsource[i].getSHAREABLE();
			tmpresult["PRINTABLE"] = dsource[i].getPRINTABLE();
			tmpresult["EXPORTABLE"] = dsource[i].getEXPORTABLE();
			tmpresult["APPENDABLEROW"] = dsource[i].getAPPENDABLEROW();
			tmpresult["REMOVABLEROW"] = dsource[i].getREMOVABLEROW();
			tmpresult["EMAILABLE"] = dsource[i].getEMAILABLE();
		}
	}

	dchart = EntityLoad("EGRGQRYCHART",{EQRYCODE="#querycode#"}, false);
	if(IsDefined("dchart")) {
		for(i=1; i<=ArrayLen(dchart); i++) {
			tmpresult["CHARTLABEL"] = dchart[i].getCHARTLABEL();
			tmpresult["BOXFILL"] = dchart[i].getBOXFILL();
			tmpresult["BOXSTROKE"] = dchart[i].getBOXSTROKE();
			tmpresult["BOXSTROKEWIDTH"] = dchart[i].getBOXSTROKEWIDTH();
			tmpresult["BOXZINDEX"] = dchart[i].getBOXZINDEX();
			tmpresult["ITEMSPACING"] = dchart[i].getITEMSPACING();
			tmpresult["LABELCOLOR"] = dchart[i].getLABELCOLOR();
			tmpresult["LABELFONT"] = dchart[i].getLABELFONT();
			tmpresult["PADDING"] = dchart[i].getPADDING();
			tmpresult["LEGENDPOSITION"] = dchart[i].getLEGENDPOSITION();
			tmpresult["CHARTUPDATE"] = dchart[i].getCHARTUPDATE();
			tmpresult["VISIBLE"] = dchart[i].getVISIBLE();
			tmpresult["X"] = dchart[i].getX();
			tmpresult["Y"] = dchart[i].getY();
			tmpresult["ALLOWFUNCTIONS"] = dchart[i].getALLOWFUNCTIONS();
			tmpresult["DEFAULTSORTDIRECTION"] = dchart[i].getDEFAULTSORTDIRECTION();
			tmpresult["LEGENDITEMLISTENERS"] = dchart[i].getLEGENDITEMLISTENERS();
			tmpresult["SORTROOT"] = dchart[i].getSORTROOT();
			tmpresult["SORTERS"] = dchart[i].getSORTERS();
			tmpresult["MASK"] = dchart[i].getMASK();
			tmpresult["AXISADJUSTEND"] = dchart[i].getAXISADJUSTEND();
			tmpresult["AXISDASHSIZE"] = dchart[i].getAXISDASHSIZE();
			tmpresult["AXISFIELDS"] = dchart[i].getAXISFIELDS();
			tmpresult["AXISGRID"] = dchart[i].getAXISGRID();
			tmpresult["AXISHIDDEN"] = dchart[i].getAXISHIDDEN();
			tmpresult["AXISLABEL"] = dchart[i].getAXISLABEL();
			tmpresult["AXISLENGTH"] = dchart[i].getAXISLENGTH();
			tmpresult["AXISMAJORTICKSTEPS"] = dchart[i].getAXISMAJORTICKSTEPS();
			tmpresult["AXISMINORTICKSTEPS"] = dchart[i].getAXISMINORTICKSTEPS();
			tmpresult["AXISPOSITION"] = dchart[i].getAXISPOSITION();
			tmpresult["AXISTITLE"] = dchart[i].getAXISTITLE();
			tmpresult["AXISWIDTH"] = dchart[i].getAXISWIDTH();
			tmpresult["AXISCALCULATECATEGORYCOUNT"] = dchart[i].getAXISCALCULATECATEGORYCOUNT();
			tmpresult["AXISCATEGORYNAMES"] = dchart[i].getAXISCATEGORYNAMES();
			tmpresult["AXISMARGIN"] = dchart[i].getAXISMARGIN();
			tmpresult["AXISADJUSTMAXIMUMBYMAJORUNIT"] = dchart[i].getAXISADJUSTMAXIMUMBYMAJORUNIT();
			tmpresult["AXISADJUSTMINIMUMBYMAJORUNIT"] = dchart[i].getAXISADJUSTMINIMUMBYMAJORUNIT();
			tmpresult["AXISCONSTRAIN"] = dchart[i].getAXISCONSTRAIN();
			tmpresult["AXISDECIMALS"] = dchart[i].getAXISDECIMALS();
			tmpresult["AXISMAXIMUM"] = dchart[i].getAXISMAXIMUM();
			tmpresult["AXISMINIMUM"] = dchart[i].getAXISMINIMUM();
			tmpresult["AXISDATEFORMAT"] = dchart[i].getAXISDATEFORMAT();
			tmpresult["AXISFROMDATE"] = dchart[i].getAXISFROMDATE();
			tmpresult["AXISSTEP"] = dchart[i].getAXISSTEP();
			tmpresult["AXISTODATE"] = dchart[i].getAXISTODATE();
			tmpresult["AXISEXTRA"] = dchart[i].getAXISEXTRA();
			tmpresult["SERIESAXIS"] = dchart[i].getSERIESAXIS();
			tmpresult["SERIESHIGHLIGHT"] = dchart[i].getSERIESHIGHLIGHT();
			tmpresult["SERIESLABEL"] = dchart[i].getSERIESLABEL();
			tmpresult["SERIESLISTENERS"] = dchart[i].getSERIESLISTENERS();
			tmpresult["SERIESRENDERER"] = dchart[i].getSERIESRENDERER();
			tmpresult["SERIESSHADOWATTRIBUTES"] = dchart[i].getSERIESSHADOWATTRIBUTES();
			tmpresult["SERIESSHOWINLEGEND"] = dchart[i].getSERIESSHOWINLEGEND();
			tmpresult["SERIESSTYLE"] = dchart[i].getSERIESSTYLE();
			tmpresult["SERIESTIPS"] = dchart[i].getSERIESTIPS();
			tmpresult["SERIESTITLE"] = dchart[i].getSERIESTITLE();
			tmpresult["SERIESTYPE"] = dchart[i].getSERIESTYPE();
			tmpresult["SERIESXFIELD"] = dchart[i].getSERIESXFIELD();
			tmpresult["SERIESYFIELD"] = dchart[i].getSERIESYFIELD();
			tmpresult["SERIESCOLUMN"] = dchart[i].getSERIESCOLUMN();
			tmpresult["SERIESGROUPGUTTER"] = dchart[i].getSERIESGROUPGUTTER();
			tmpresult["SERIESGUTTER"] = dchart[i].getSERIESGUTTER();
			tmpresult["SERIESSTACKED"] = dchart[i].getSERIESSTACKED();
			tmpresult["SERIESXPADDING"] = dchart[i].getSERIESXPADDING();
			tmpresult["SERIESYPADDING"] = dchart[i].getSERIESYPADDING();
			tmpresult["SERIESANGLEFIELD"] = dchart[i].getSERIESANGLEFIELD();
			tmpresult["SERIESDONUT"] = dchart[i].getSERIESDONUT();
			tmpresult["SERIESHIGHLIGHTDURATION"] = dchart[i].getSERIESHIGHLIGHTDURATION();
			tmpresult["SERIESNEEDLE"] = dchart[i].getSERIESNEEDLE();
			tmpresult["SERIESFILL"] = dchart[i].getSERIESFILL();
			tmpresult["SERIESMARKERCONFIG"] = dchart[i].getSERIESMARKERCONFIG();
			tmpresult["SERIESSELECTIONTOLERANCE"] = dchart[i].getSERIESSELECTIONTOLERANCE();
			tmpresult["SERIESSHOWMARKERS"] = dchart[i].getSERIESSHOWMARKERS();
			tmpresult["SERIESSMOOTH"] = dchart[i].getSERIESSMOOTH();
			tmpresult["SERIESCOLORSET"] = dchart[i].getSERIESCOLORSET();
			tmpresult["SERIESFIELD"] = dchart[i].getSERIESFIELD();
			tmpresult["SERIESLENGTHFIELD"] = dchart[i].getSERIESLENGTHFIELD();
			tmpresult["SERIESEXTRA"] = dchart[i].getSERIESEXTRA();
			tmpresult["CHARTEXTRA"] = dchart[i].getCHARTEXTRA();
		}
	}

	dfeature = EntityLoad("EGRGQRYFEATURE",{EQRYCODE="#querycode#"}, false);
	if(IsDefined("dfeature")) {
		for(i=1; i<=ArrayLen(dfeature); i++) {
			tmpresult["GROUPINGLISTENERS"] = dfeature[i].getGROUPINGLISTENERS();
			tmpresult["REMOTEROOT"] = dfeature[i].getREMOTEROOT();
			tmpresult["SHOWSUMMARYROW"] = dfeature[i].getSHOWSUMMARYROW();
			tmpresult["FCOLLAPSIBLE"] = dfeature[i].getFCOLLAPSIBLE();
			tmpresult["DEPTHTOINDENT"] = dfeature[i].getDEPTHTOINDENT();
			tmpresult["ENABLEGROUPINGMENU"] = dfeature[i].getENABLEGROUPINGMENU();
			tmpresult["ENABLENOGROUPS"] = dfeature[i].getENABLENOGROUPS();
			tmpresult["GROUPBYTEXT"] = dfeature[i].getGROUPBYTEXT();
			tmpresult["GROUPHEADERTPL"] = dfeature[i].getGROUPHEADERTPL();
			tmpresult["HIDEGROUPEDHEADER"] = dfeature[i].getHIDEGROUPEDHEADER();
			tmpresult["SHOWGROUPSTEXT"] = dfeature[i].getSHOWGROUPSTEXT();
			tmpresult["STARTCOLLAPSED"] = dfeature[i].getSTARTCOLLAPSED();
			tmpresult["FEATUREEXTRA"] = dfeature[i].getFEATUREEXTRA();
		}
	}

	dplugin = EntityLoad("EGRGQRYPLUGIN",{EQRYCODE="#querycode#"}, false);
	if(IsDefined("dplugin")) {
		for(i=1; i<=ArrayLen(dplugin); i++) {
			tmpresult["BLEADINGBUFFERZONE"] = dplugin[i].getBLEADINGBUFFERZONE();
			tmpresult["BNUMFROMEDGE"] = dplugin[i].getBNUMFROMEDGE();
			tmpresult["BPLUGINID"] = dplugin[i].getBPLUGINID();
			tmpresult["BSCROLLTOLOADBUFFER"] = dplugin[i].getBSCROLLTOLOADBUFFER();
			tmpresult["BSYNCHRONOUSRENDER"] = dplugin[i].getBSYNCHRONOUSRENDER();
			tmpresult["BTRAILINGBUFFERZONE"] = dplugin[i].getBTRAILINGBUFFERZONE();
			tmpresult["BVARIABLEROWHEIGHT"] = dplugin[i].getBVARIABLEROWHEIGHT();
			tmpresult["CELLEDITINGCLICKSTOEDIT"] = dplugin[i].getCELLEDITINGCLICKSTOEDIT();
			tmpresult["CELLEDITINGLISTENER"] = dplugin[i].getCELLEDITINGLISTENER();
			tmpresult["TRIGGEREVENT"] = dplugin[i].getTRIGGEREVENT();
			tmpresult["DDCONTAINERSCROLL"] = dplugin[i].getDDCONTAINERSCROLL();
			tmpresult["DDGROUP"] = dplugin[i].getDDGROUP();
			tmpresult["DDDRAGGROUP"] = dplugin[i].getDDDRAGGROUP();
			tmpresult["DDDRAGTEXT"] = dplugin[i].getDDDRAGTEXT();
			tmpresult["DDDROPGROUP"] = dplugin[i].getDDDROPGROUP();
			tmpresult["DDENABLEDRAG"] = dplugin[i].getDDENABLEDRAG();
			tmpresult["DDENABLEDROP"] = dplugin[i].getDDENABLEDROP();
			tmpresult["HEADERRESIZER"] = dplugin[i].getHEADERRESIZER();
			tmpresult["ROWAUTOCANCEL"] = dplugin[i].getROWAUTOCANCEL();
			tmpresult["ROWCLICKSTOEDIT"] = dplugin[i].getROWCLICKSTOEDIT();
			tmpresult["ROWCLICKSTOMOVEEDITOR"] = dplugin[i].getROWCLICKSTOMOVEEDITOR();
			tmpresult["ROWERRORSUMMARY"] = dplugin[i].getROWERRORSUMMARY();
			tmpresult["ROWLISTENERS"] = dplugin[i].getROWLISTENERS();
			tmpresult["ROWTRIGGEREVENT"] = dplugin[i].getROWTRIGGEREVENT();
			tmpresult["ROWEXPANDONDBLCLICK"] = dplugin[i].getROWEXPANDONDBLCLICK();
			tmpresult["ROWEXPANDONENTER"] = dplugin[i].getROWEXPANDONENTER();
			tmpresult["ROWSELECTROWONEXPAND"] = dplugin[i].getROWSELECTROWONEXPAND();
			tmpresult["PLUGINEXTRA"] = dplugin[i].getPLUGINEXTRA();
		}
	}

	rootstuct["success"] = "true";
	rootstuct["data"] = tmpresult;
	return rootstuct;
	</cfscript>
</cffunction>


<cffunction name="SubmitColumnDetail" ExtDirect="true" ExtFormHandler="true">
<cfscript>
		dcolumn = EntityLoad("EGRGQRYCOLUMN",{EVIEWFIELDCODE="#trim(form.EVIEWFIELDCODE)#"}, true);
		if(IsDefined("dcolumn")) {
			//update
			dfield = EntityLoad("EGRGEVIEWFIELDS",{EVIEWFIELDCODE="#trim(form.EVIEWFIELDCODE)#"}, true);
		} else {
			//insert
			dfield = EntityNew("EGRGEVIEWFIELDS");
			dcolumn = EntityNew("EGRGQRYCOLUMN");
		}

		if(Not IsDefined("form.EVIEWFIELDCODE") || form.EVIEWFIELDCODE == "" ) dcolumn.setEVIEWFIELDCODE(javacast("null",""));
		else dcolumn.setEVIEWFIELDCODE(trim(form.EVIEWFIELDCODE));

		if(Not IsDefined("form.OUTPUTTYPE") || form.OUTPUTTYPE == "" ) dcolumn.setOUTPUTTYPE(javacast("null",""));
		else dcolumn.setOUTPUTTYPE(trim(form.OUTPUTTYPE));

		if(Not IsDefined("form.COLUMNACTIVEITEM") || form.COLUMNACTIVEITEM == "" ) dcolumn.setCOLUMNACTIVEITEM(javacast("null",""));
		else dcolumn.setCOLUMNACTIVEITEM(trim(form.COLUMNACTIVEITEM));

		if(Not IsDefined("form.COLUMNALIGN") || form.COLUMNALIGN == "" ) dcolumn.setCOLUMNALIGN(javacast("null",""));
		else dcolumn.setCOLUMNALIGN(trim(form.COLUMNALIGN));

		if(Not IsDefined("form.CACTIONALTTEXT") || form.CACTIONALTTEXT == "" ) dcolumn.setCACTIONALTTEXT(javacast("null",""));
		else dcolumn.setCACTIONALTTEXT(trim(form.CACTIONALTTEXT));

		if(Not IsDefined("form.COLUMNANCHORSIZE") || form.COLUMNANCHORSIZE == "" ) dcolumn.setCOLUMNANCHORSIZE(javacast("null",""));
		else dcolumn.setCOLUMNANCHORSIZE(trim(form.COLUMNANCHORSIZE));

		if(Not IsDefined("form.COLUMNAUTODESTROY") || form.COLUMNAUTODESTROY == "" ) dcolumn.setCOLUMNAUTODESTROY(javacast("null",""));
		else dcolumn.setCOLUMNAUTODESTROY(trim(form.COLUMNAUTODESTROY));

		if(Not IsDefined("form.COLUMNAUTORENDER") || form.COLUMNAUTORENDER == "" ) dcolumn.setCOLUMNAUTORENDER(javacast("null",""));
		else dcolumn.setCOLUMNAUTORENDER(trim(form.COLUMNAUTORENDER));

		if(Not IsDefined("form.COLUMNAUTOSCROLL") || form.COLUMNAUTOSCROLL == "" ) dcolumn.setCOLUMNAUTOSCROLL(javacast("null",""));
		else dcolumn.setCOLUMNAUTOSCROLL(trim(form.COLUMNAUTOSCROLL));

		if(Not IsDefined("form.COLUMNAUTOSHOW") || form.COLUMNAUTOSHOW == "" ) dcolumn.setCOLUMNAUTOSHOW(javacast("null",""));
		else dcolumn.setCOLUMNAUTOSHOW(trim(form.COLUMNAUTOSHOW));

		if(Not IsDefined("form.COLUMNBASECLS") || form.COLUMNBASECLS == "" ) dcolumn.setCOLUMNBASECLS(javacast("null",""));
		else dcolumn.setCOLUMNBASECLS(trim(form.COLUMNBASECLS));

		if(Not IsDefined("form.COLUMNBORDER") || form.COLUMNBORDER == "" ) dcolumn.setCOLUMNBORDER(javacast("null",""));
		else dcolumn.setCOLUMNBORDER(trim(form.COLUMNBORDER));

		if(Not IsDefined("form.COLUMNBUBBLEEVENTS") || form.COLUMNBUBBLEEVENTS == "" ) dcolumn.setCOLUMNBUBBLEEVENTS(javacast("null",""));
		else dcolumn.setCOLUMNBUBBLEEVENTS(trim(form.COLUMNBUBBLEEVENTS));

		if(Not IsDefined("form.COLUMNCHILDELS") || form.COLUMNCHILDELS == "" ) dcolumn.setCOLUMNCHILDELS(javacast("null",""));
		else dcolumn.setCOLUMNCHILDELS(trim(form.COLUMNCHILDELS));

		if(Not IsDefined("form.COLUMNCLS") || form.COLUMNCLS == "" ) dcolumn.setCOLUMNCLS(javacast("null",""));
		else dcolumn.setCOLUMNCLS(trim(form.COLUMNCLS));

		if(Not IsDefined("form.COLUMNWIDTH") || form.COLUMNWIDTH == "" ) dcolumn.setCOLUMNWIDTH(javacast("null",""));
		else dcolumn.setCOLUMNWIDTH(trim(form.COLUMNWIDTH));

		if(Not IsDefined("form.COLUMNCOLUMNS") || form.COLUMNCOLUMNS == "" ) dcolumn.setCOLUMNCOLUMNS(javacast("null",""));
		else dcolumn.setCOLUMNCOLUMNS(trim(form.COLUMNCOLUMNS));

		if(Not IsDefined("form.COLUMNCOMPONENTCLS") || form.COLUMNCOMPONENTCLS == "" ) dcolumn.setCOLUMNCOMPONENTCLS(javacast("null",""));
		else dcolumn.setCOLUMNCOMPONENTCLS(trim(form.COLUMNCOMPONENTCLS));

		if(Not IsDefined("form.COLUMNCONSTRAIN") || form.COLUMNCONSTRAIN == "" ) dcolumn.setCOLUMNCONSTRAIN(javacast("null",""));
		else dcolumn.setCOLUMNCONSTRAIN(trim(form.COLUMNCONSTRAIN));

		if(Not IsDefined("form.COLUMNCONSTRAINTO") || form.COLUMNCONSTRAINTO == "" ) dcolumn.setCOLUMNCONSTRAINTO(javacast("null",""));
		else dcolumn.setCOLUMNCONSTRAINTO(trim(form.COLUMNCONSTRAINTO));

		if(Not IsDefined("form.COLUMNCONSTRAINTINSETS") || form.COLUMNCONSTRAINTINSETS == "" ) dcolumn.setCOLUMNCONSTRAINTINSETS(javacast("null",""));
		else dcolumn.setCOLUMNCONSTRAINTINSETS(trim(form.COLUMNCONSTRAINTINSETS));

		if(Not IsDefined("form.COLUMNCONTENTEL") || form.COLUMNCONTENTEL == "" ) dcolumn.setCOLUMNCONTENTEL(javacast("null",""));
		else dcolumn.setCOLUMNCONTENTEL(trim(form.COLUMNCONTENTEL));

		if(Not IsDefined("form.COLUMNDATA") || form.COLUMNDATA == "" ) dcolumn.setCOLUMNDATA(javacast("null",""));
		else dcolumn.setCOLUMNDATA(trim(form.COLUMNDATA));

		if(Not IsDefined("form.COLUMNDATAINDEX") || form.COLUMNDATAINDEX == "" ) dcolumn.setCOLUMNDATAINDEX(javacast("null",""));
		else dcolumn.setCOLUMNDATAINDEX(trim(form.COLUMNDATAINDEX));

		if(Not IsDefined("form.COLUMNDEFAULTALIGN") || form.COLUMNDEFAULTALIGN == "" ) dcolumn.setCOLUMNDEFAULTALIGN(javacast("null",""));
		else dcolumn.setCOLUMNDEFAULTALIGN(trim(form.COLUMNDEFAULTALIGN));

		if(Not IsDefined("form.COLUMNDEFAULTTYPE") || form.COLUMNDEFAULTTYPE == "" ) dcolumn.setCOLUMNDEFAULTTYPE(javacast("null",""));
		else dcolumn.setCOLUMNDEFAULTTYPE(trim(form.COLUMNDEFAULTTYPE));

		if(Not IsDefined("form.COLUMNDEFAULTWIDTH") || form.COLUMNDEFAULTWIDTH == "" ) dcolumn.setCOLUMNDEFAULTWIDTH(javacast("null",""));
		else dcolumn.setCOLUMNDEFAULTWIDTH(trim(form.COLUMNDEFAULTWIDTH));

		if(Not IsDefined("form.COLUMNDEFAULTS") || form.COLUMNDEFAULTS == "" ) dcolumn.setCOLUMNDEFAULTS(javacast("null",""));
		else dcolumn.setCOLUMNDEFAULTS(trim(form.COLUMNDEFAULTS));

		if(Not IsDefined("form.COLUMNDETACHONREMOVE") || form.COLUMNDETACHONREMOVE == "" ) dcolumn.setCOLUMNDETACHONREMOVE(javacast("null",""));
		else dcolumn.setCOLUMNDETACHONREMOVE(trim(form.COLUMNDETACHONREMOVE));

		if(Not IsDefined("form.COLUMNDISABLED") || form.COLUMNDISABLED == "" ) dcolumn.setCOLUMNDISABLED(javacast("null",""));
		else dcolumn.setCOLUMNDISABLED(trim(form.COLUMNDISABLED));

		if(Not IsDefined("form.COLUMNDISABLEDCLS") || form.COLUMNDISABLEDCLS == "" ) dcolumn.setCOLUMNDISABLEDCLS(javacast("null",""));
		else dcolumn.setCOLUMNDISABLEDCLS(trim(form.COLUMNDISABLEDCLS));

		if(Not IsDefined("form.COLUMNDRAGGABLE") || form.COLUMNDRAGGABLE == "" ) dcolumn.setCOLUMNDRAGGABLE(javacast("null",""));
		else dcolumn.setCOLUMNDRAGGABLE(trim(form.COLUMNDRAGGABLE));

		if(Not IsDefined("form.COLUMNEDITRENDERER") || form.COLUMNEDITRENDERER == "" ) dcolumn.setCOLUMNEDITRENDERER(javacast("null",""));
		else dcolumn.setCOLUMNEDITRENDERER(trim(form.COLUMNEDITRENDERER));

		if(Not IsDefined("form.COLUMNEDITOR") || form.COLUMNEDITOR == "" ) dcolumn.setCOLUMNEDITOR(javacast("null",""));
		else dcolumn.setCOLUMNEDITOR(trim(form.COLUMNEDITOR));

		if(Not IsDefined("form.COLUMNEMPTYCELLTEXT") || form.COLUMNEMPTYCELLTEXT == "" ) dcolumn.setCOLUMNEMPTYCELLTEXT(javacast("null",""));
		else dcolumn.setCOLUMNEMPTYCELLTEXT(trim(form.COLUMNEMPTYCELLTEXT));

		if(Not IsDefined("form.COLUMNENABLECOLUMNHIDE") || form.COLUMNENABLECOLUMNHIDE == "" ) dcolumn.setCOLUMNENABLECOLUMNHIDE(javacast("null",""));
		else dcolumn.setCOLUMNENABLECOLUMNHIDE(trim(form.COLUMNENABLECOLUMNHIDE));

		if(Not IsDefined("form.COLUMNFLOATING") || form.COLUMNFLOATING == "" ) dcolumn.setCOLUMNFLOATING(javacast("null",""));
		else dcolumn.setCOLUMNFLOATING(trim(form.COLUMNFLOATING));

		if(Not IsDefined("form.COLUMNFOCUSONTOFRONT") || form.COLUMNFOCUSONTOFRONT == "" ) dcolumn.setCOLUMNFOCUSONTOFRONT(javacast("null",""));
		else dcolumn.setCOLUMNFOCUSONTOFRONT(trim(form.COLUMNFOCUSONTOFRONT));

		if(Not IsDefined("form.COLUMNFORMBIND") || form.COLUMNFORMBIND == "" ) dcolumn.setCOLUMNFORMBIND(javacast("null",""));
		else dcolumn.setCOLUMNFORMBIND(trim(form.COLUMNFORMBIND));

		if(Not IsDefined("form.COLUMNFRAME") || form.COLUMNFRAME == "" ) dcolumn.setCOLUMNFRAME(javacast("null",""));
		else dcolumn.setCOLUMNFRAME(trim(form.COLUMNFRAME));

		if(Not IsDefined("form.COLUMNGROUPABLE") || form.COLUMNGROUPABLE == "" ) dcolumn.setCOLUMNGROUPABLE(javacast("null",""));
		else dcolumn.setCOLUMNGROUPABLE(trim(form.COLUMNGROUPABLE));

		if(Not IsDefined("form.COLUMNHANDLER") || form.COLUMNHANDLER == "" ) dcolumn.setCOLUMNHANDLER(javacast("null",""));
		else dcolumn.setCOLUMNHANDLER(trim(form.COLUMNHANDLER));

		if(Not IsDefined("form.COLUMNHEIGHT") || form.COLUMNHEIGHT == "" ) dcolumn.setCOLUMNHEIGHT(javacast("null",""));
		else dcolumn.setCOLUMNHEIGHT(trim(form.COLUMNHEIGHT));

		if(Not IsDefined("form.COLUMNHIDDEN") || form.COLUMNHIDDEN == "" ) dcolumn.setCOLUMNHIDDEN(javacast("null",""));
		else dcolumn.setCOLUMNHIDDEN(trim(form.COLUMNHIDDEN));

		if(Not IsDefined("form.COLUMNHIDEMODE") || form.COLUMNHIDEMODE == "" ) dcolumn.setCOLUMNHIDEMODE(javacast("null",""));
		else dcolumn.setCOLUMNHIDEMODE(trim(form.COLUMNHIDEMODE));

		if(Not IsDefined("form.COLUMNHIDEABLE") || form.COLUMNHIDEABLE == "" ) dcolumn.setCOLUMNHIDEABLE(javacast("null",""));
		else dcolumn.setCOLUMNHIDEABLE(trim(form.COLUMNHIDEABLE));

		if(Not IsDefined("form.COLUMNHTML") || form.COLUMNHTML == "" ) dcolumn.setCOLUMNHTML(javacast("null",""));
		else dcolumn.setCOLUMNHTML(trim(form.COLUMNHTML));

		if(Not IsDefined("form.COLUMNICON") || form.COLUMNICON == "" ) dcolumn.setCOLUMNICON(javacast("null",""));
		else dcolumn.setCOLUMNICON(trim(form.COLUMNICON));

		if(Not IsDefined("form.COLUMNICONCLS") || form.COLUMNICONCLS == "" ) dcolumn.setCOLUMNICONCLS(javacast("null",""));
		else dcolumn.setCOLUMNICONCLS(trim(form.COLUMNICONCLS));

		if(Not IsDefined("form.COLUMNID") || form.COLUMNID == "" ) dcolumn.setCOLUMNID(javacast("null",""));
		else dcolumn.setCOLUMNID(trim(form.COLUMNID));

		if(Not IsDefined("form.COLUMNITEMID") || form.COLUMNITEMID == "" ) dcolumn.setCOLUMNITEMID(javacast("null",""));
		else dcolumn.setCOLUMNITEMID(trim(form.COLUMNITEMID));

		if(Not IsDefined("form.COLUMNITEMS") || form.COLUMNITEMS == "" ) dcolumn.setCOLUMNITEMS(javacast("null",""));
		else dcolumn.setCOLUMNITEMS(trim(form.COLUMNITEMS));

		if(Not IsDefined("form.COLUMNLAYOUT") || form.COLUMNLAYOUT == "" ) dcolumn.setCOLUMNLAYOUT(javacast("null",""));
		else dcolumn.setCOLUMNLAYOUT(trim(form.COLUMNLAYOUT));

		if(Not IsDefined("form.COLUMNLISTENERS") || form.COLUMNLISTENERS == "" ) dcolumn.setCOLUMNLISTENERS(javacast("null",""));
		else dcolumn.setCOLUMNLISTENERS(trim(form.COLUMNLISTENERS));

		if(Not IsDefined("form.COLUMNLOADER") || form.COLUMNLOADER == "" ) dcolumn.setCOLUMNLOADER(javacast("null",""));
		else dcolumn.setCOLUMNLOADER(trim(form.COLUMNLOADER));

		if(Not IsDefined("form.COLUMNLOCKABLE") || form.COLUMNLOCKABLE == "" ) dcolumn.setCOLUMNLOCKABLE(javacast("null",""));
		else dcolumn.setCOLUMNLOCKABLE(trim(form.COLUMNLOCKABLE));

		if(Not IsDefined("form.COLUMNLOCKED") || form.COLUMNLOCKED == "" ) dcolumn.setCOLUMNLOCKED(javacast("null",""));
		else dcolumn.setCOLUMNLOCKED(trim(form.COLUMNLOCKED));

		if(Not IsDefined("form.COLUMNMARGIN") || form.COLUMNMARGIN == "" ) dcolumn.setCOLUMNMARGIN(javacast("null",""));
		else dcolumn.setCOLUMNMARGIN(trim(form.COLUMNMARGIN));

		if(Not IsDefined("form.COLUMNMAXHEIGHT") || form.COLUMNMAXHEIGHT == "" ) dcolumn.setCOLUMNMAXHEIGHT(javacast("null",""));
		else dcolumn.setCOLUMNMAXHEIGHT(trim(form.COLUMNMAXHEIGHT));

		if(Not IsDefined("form.COLUMNMAXWIDTH") || form.COLUMNMAXWIDTH == "" ) dcolumn.setCOLUMNMAXWIDTH(javacast("null",""));
		else dcolumn.setCOLUMNMAXWIDTH(trim(form.COLUMNMAXWIDTH));

		if(Not IsDefined("form.COLUMNMENUTEXT") || form.COLUMNMENUTEXT == "" ) dcolumn.setCOLUMNMENUTEXT(javacast("null",""));
		else dcolumn.setCOLUMNMENUTEXT(trim(form.COLUMNMENUTEXT));

		if(Not IsDefined("form.CACTIONMENUDISABLED") || form.CACTIONMENUDISABLED == "" ) dcolumn.setCACTIONMENUDISABLED(javacast("null",""));
		else dcolumn.setCACTIONMENUDISABLED(trim(form.CACTIONMENUDISABLED));

		if(Not IsDefined("form.COLUMNMINHEIGHT") || form.COLUMNMINHEIGHT == "" ) dcolumn.setCOLUMNMINHEIGHT(javacast("null",""));
		else dcolumn.setCOLUMNMINHEIGHT(trim(form.COLUMNMINHEIGHT));

		if(Not IsDefined("form.COLUMNMINWIDTH") || form.COLUMNMINWIDTH == "" ) dcolumn.setCOLUMNMINWIDTH(javacast("null",""));
		else dcolumn.setCOLUMNMINWIDTH(trim(form.COLUMNMINWIDTH));

		if(Not IsDefined("form.COLUMNOVERCLS") || form.COLUMNOVERCLS == "" ) dcolumn.setCOLUMNOVERCLS(javacast("null",""));
		else dcolumn.setCOLUMNOVERCLS(trim(form.COLUMNOVERCLS));

		if(Not IsDefined("form.COLUMNOVERFLOWX") || form.COLUMNOVERFLOWX == "" ) dcolumn.setCOLUMNOVERFLOWX(javacast("null",""));
		else dcolumn.setCOLUMNOVERFLOWX(trim(form.COLUMNOVERFLOWX));

		if(Not IsDefined("form.COLUMNOVERFLOWY") || form.COLUMNOVERFLOWY == "" ) dcolumn.setCOLUMNOVERFLOWY(javacast("null",""));
		else dcolumn.setCOLUMNOVERFLOWY(trim(form.COLUMNOVERFLOWY));

		if(Not IsDefined("form.COLUMNPADDING") || form.COLUMNPADDING == "" ) dcolumn.setCOLUMNPADDING(javacast("null",""));
		else dcolumn.setCOLUMNPADDING(trim(form.COLUMNPADDING));

		if(Not IsDefined("form.COLUMNPLUGINS") || form.COLUMNPLUGINS == "" ) dcolumn.setCOLUMNPLUGINS(javacast("null",""));
		else dcolumn.setCOLUMNPLUGINS(trim(form.COLUMNPLUGINS));

		if(Not IsDefined("form.COLUMNREGION") || form.COLUMNREGION == "" ) dcolumn.setCOLUMNREGION(javacast("null",""));
		else dcolumn.setCOLUMNREGION(trim(form.COLUMNREGION));

		if(Not IsDefined("form.COLUMNRENDERDATA") || form.COLUMNRENDERDATA == "" ) dcolumn.setCOLUMNRENDERDATA(javacast("null",""));
		else dcolumn.setCOLUMNRENDERDATA(trim(form.COLUMNRENDERDATA));

		if(Not IsDefined("form.COLUMNRENDERSELECTORS") || form.COLUMNRENDERSELECTORS == "" ) dcolumn.setCOLUMNRENDERSELECTORS(javacast("null",""));
		else dcolumn.setCOLUMNRENDERSELECTORS(trim(form.COLUMNRENDERSELECTORS));

		if(Not IsDefined("form.COLUMNRENDERTO") || form.COLUMNRENDERTO == "" ) dcolumn.setCOLUMNRENDERTO(javacast("null",""));
		else dcolumn.setCOLUMNRENDERTO(trim(form.COLUMNRENDERTO));

		if(Not IsDefined("form.COLUMNRENDERER") || form.COLUMNRENDERER == "" ) dcolumn.setCOLUMNRENDERER(javacast("null",""));
		else dcolumn.setCOLUMNRENDERER(trim(form.COLUMNRENDERER));

		if(Not IsDefined("form.COLUMNRESIZABLE") || form.COLUMNRESIZABLE == "" ) dcolumn.setCOLUMNRESIZABLE(javacast("null",""));
		else dcolumn.setCOLUMNRESIZABLE(trim(form.COLUMNRESIZABLE));

		if(Not IsDefined("form.COLUMNRESIZEHANDLES") || form.COLUMNRESIZEHANDLES == "" ) dcolumn.setCOLUMNRESIZEHANDLES(javacast("null",""));
		else dcolumn.setCOLUMNRESIZEHANDLES(trim(form.COLUMNRESIZEHANDLES));

		if(Not IsDefined("form.COLUMNRTL") || form.COLUMNRTL == "" ) dcolumn.setCOLUMNRTL(javacast("null",""));
		else dcolumn.setCOLUMNRTL(trim(form.COLUMNRTL));

		if(Not IsDefined("form.COLUMNSAVEDELAY") || form.COLUMNSAVEDELAY == "" ) dcolumn.setCOLUMNSAVEDELAY(javacast("null",""));
		else dcolumn.setCOLUMNSAVEDELAY(trim(form.COLUMNSAVEDELAY));

		if(Not IsDefined("form.CACTIONSCOPE") || form.CACTIONSCOPE == "" ) dcolumn.setCACTIONSCOPE(javacast("null",""));
		else dcolumn.setCACTIONSCOPE(trim(form.CACTIONSCOPE));

		if(Not IsDefined("form.COLUMNSEALED") || form.COLUMNSEALED == "" ) dcolumn.setCOLUMNSEALED(javacast("null",""));
		else dcolumn.setCOLUMNSEALED(trim(form.COLUMNSEALED));

		if(Not IsDefined("form.COLUMNSHADOW") || form.COLUMNSHADOW == "" ) dcolumn.setCOLUMNSHADOW(javacast("null",""));
		else dcolumn.setCOLUMNSHADOW(trim(form.COLUMNSHADOW));

		if(Not IsDefined("form.COLUMNSHADOWOFFSET") || form.COLUMNSHADOWOFFSET == "" ) dcolumn.setCOLUMNSHADOWOFFSET(javacast("null",""));
		else dcolumn.setCOLUMNSHADOWOFFSET(trim(form.COLUMNSHADOWOFFSET));

		if(Not IsDefined("form.COLUMNSHRINKWRAP") || form.COLUMNSHRINKWRAP == "" ) dcolumn.setCOLUMNSHRINKWRAP(javacast("null",""));
		else dcolumn.setCOLUMNSHRINKWRAP(trim(form.COLUMNSHRINKWRAP));

		if(Not IsDefined("form.COLUMNSORTABLE") || form.COLUMNSORTABLE == "" ) dcolumn.setCOLUMNSORTABLE(javacast("null",""));
		else dcolumn.setCOLUMNSORTABLE(trim(form.COLUMNSORTABLE));

		if(Not IsDefined("form.COLUMNSTATEEVENTS") || form.COLUMNSTATEEVENTS == "" ) dcolumn.setCOLUMNSTATEEVENTS(javacast("null",""));
		else dcolumn.setCOLUMNSTATEEVENTS(trim(form.COLUMNSTATEEVENTS));

		if(Not IsDefined("form.COLUMNSTATEID") || form.COLUMNSTATEID == "" ) dcolumn.setCOLUMNSTATEID(javacast("null",""));
		else dcolumn.setCOLUMNSTATEID(trim(form.COLUMNSTATEID));

		if(Not IsDefined("form.COLUMNSTATEFUL") || form.COLUMNSTATEFUL == "" ) dcolumn.setCOLUMNSTATEFUL(javacast("null",""));
		else dcolumn.setCOLUMNSTATEFUL(trim(form.COLUMNSTATEFUL));

		if(Not IsDefined("form.CACTIONSTOPSELECTION") || form.CACTIONSTOPSELECTION == "" ) dcolumn.setCACTIONSTOPSELECTION(javacast("null",""));
		else dcolumn.setCACTIONSTOPSELECTION(trim(form.CACTIONSTOPSELECTION));

		if(Not IsDefined("form.COLUMNSTYLE") || form.COLUMNSTYLE == "" ) dcolumn.setCOLUMNSTYLE(javacast("null",""));
		else dcolumn.setCOLUMNSTYLE(trim(form.COLUMNSTYLE));

		if(Not IsDefined("form.COLUMNSUSPENDLAYOUT") || form.COLUMNSUSPENDLAYOUT == "" ) dcolumn.setCOLUMNSUSPENDLAYOUT(javacast("null",""));
		else dcolumn.setCOLUMNSUSPENDLAYOUT(trim(form.COLUMNSUSPENDLAYOUT));

		if(Not IsDefined("form.COLUMNTDCLS") || form.COLUMNTDCLS == "" ) dcolumn.setCOLUMNTDCLS(javacast("null",""));
		else dcolumn.setCOLUMNTDCLS(trim(form.COLUMNTDCLS));

		if(Not IsDefined("form.COLUMNTEXT") || form.COLUMNTEXT == "" ) dcolumn.setCOLUMNTEXT(javacast("null",""));
		else dcolumn.setCOLUMNTEXT(trim(form.COLUMNTEXT));

		if(Not IsDefined("form.COLUMNTOFRONTONSHOW") || form.COLUMNTOFRONTONSHOW == "" ) dcolumn.setCOLUMNTOFRONTONSHOW(javacast("null",""));
		else dcolumn.setCOLUMNTOFRONTONSHOW(trim(form.COLUMNTOFRONTONSHOW));

		if(Not IsDefined("form.COLUMNTOOLTIP") || form.COLUMNTOOLTIP == "" ) dcolumn.setCOLUMNTOOLTIP(javacast("null",""));
		else dcolumn.setCOLUMNTOOLTIP(trim(form.COLUMNTOOLTIP));

		if(Not IsDefined("form.COLUMNTOOLTIPTYPE") || form.COLUMNTOOLTIPTYPE == "" ) dcolumn.setCOLUMNTOOLTIPTYPE(javacast("null",""));
		else dcolumn.setCOLUMNTOOLTIPTYPE(trim(form.COLUMNTOOLTIPTYPE));

		if(Not IsDefined("form.COLUMNTPL") || form.COLUMNTPL == "" ) dcolumn.setCOLUMNTPL(javacast("null",""));
		else dcolumn.setCOLUMNTPL(trim(form.COLUMNTPL));

		if(Not IsDefined("form.COLUMNTPLWRITEMODE") || form.COLUMNTPLWRITEMODE == "" ) dcolumn.setCOLUMNTPLWRITEMODE(javacast("null",""));
		else dcolumn.setCOLUMNTPLWRITEMODE(trim(form.COLUMNTPLWRITEMODE));

		if(Not IsDefined("form.COLUMNUI") || form.COLUMNUI == "" ) dcolumn.setCOLUMNUI(javacast("null",""));
		else dcolumn.setCOLUMNUI(trim(form.COLUMNUI));

		if(Not IsDefined("form.CBOOLEANUNDEFINEDTEXT") || form.CBOOLEANUNDEFINEDTEXT == "" ) dcolumn.setCBOOLEANUNDEFINEDTEXT(javacast("null",""));
		else dcolumn.setCBOOLEANUNDEFINEDTEXT(trim(form.CBOOLEANUNDEFINEDTEXT));

		if(Not IsDefined("form.COLUMNWEIGHT") || form.COLUMNWEIGHT == "" ) dcolumn.setCOLUMNWEIGHT(javacast("null",""));
		else dcolumn.setCOLUMNWEIGHT(trim(form.COLUMNWEIGHT));

		if(Not IsDefined("form.COLUMNXTYPE") || form.COLUMNXTYPE == "" ) dcolumn.setCOLUMNXTYPE(javacast("null",""));
		else dcolumn.setCOLUMNXTYPE(trim(form.COLUMNXTYPE));

		if(Not IsDefined("form.COLUMNEXTRA") || form.COLUMNEXTRA == "" ) dcolumn.setCOLUMNEXTRA(javacast("null",""));
		else dcolumn.setCOLUMNEXTRA(trim(form.COLUMNEXTRA));


		dcolumn.setEGRGEVIEWFIELDS(dfield);
		EntitySave(dcolumn);
		ormflush();

		rootstruct = StructNew();
		rootstruct["success"] = "true";
		return rootstruct;
	</cfscript>
</cffunction>

<cffunction name="LoadColumnDetail" ExtDirect="true" returntype="struct">
	<cfargument name="fieldcode" type="string">
	<cfscript>
	rootstruct = StructNew();
	tmpresult = StructNew();
    tmpresult["EVIEWFIELDCODE"] = fieldcode;
	dcolumn = EntityLoad("EGRGQRYCOLUMN",{EVIEWFIELDCODE="#fieldcode#"}, false);
	if(IsDefined("dcolumn")) {
		for(i=1; i<=ArrayLen(dcolumn); i++) {
			tmpresult["OUTPUTTYPE"] = dcolumn[i].getOUTPUTTYPE();
			tmpresult["COLUMNACTIVEITEM"] = dcolumn[i].getCOLUMNACTIVEITEM();
			tmpresult["COLUMNALIGN"] = dcolumn[i].getCOLUMNALIGN();
			tmpresult["CACTIONALTTEXT"] = dcolumn[i].getCACTIONALTTEXT();
			tmpresult["COLUMNANCHORSIZE"] = dcolumn[i].getCOLUMNANCHORSIZE();
			tmpresult["COLUMNAUTODESTROY"] = dcolumn[i].getCOLUMNAUTODESTROY();
			tmpresult["COLUMNAUTORENDER"] = dcolumn[i].getCOLUMNAUTORENDER();
			tmpresult["COLUMNAUTOSCROLL"] = dcolumn[i].getCOLUMNAUTOSCROLL();
			tmpresult["COLUMNAUTOSHOW"] = dcolumn[i].getCOLUMNAUTOSHOW();
			tmpresult["COLUMNBASECLS"] = dcolumn[i].getCOLUMNBASECLS();
			tmpresult["COLUMNBORDER"] = dcolumn[i].getCOLUMNBORDER();
			tmpresult["COLUMNBUBBLEEVENTS"] = dcolumn[i].getCOLUMNBUBBLEEVENTS();
			tmpresult["COLUMNCHILDELS"] = dcolumn[i].getCOLUMNCHILDELS();
			tmpresult["COLUMNCLS"] = dcolumn[i].getCOLUMNCLS();
			tmpresult["COLUMNWIDTH"] = dcolumn[i].getCOLUMNWIDTH();
			tmpresult["COLUMNCOLUMNS"] = dcolumn[i].getCOLUMNCOLUMNS();
			tmpresult["COLUMNCOMPONENTCLS"] = dcolumn[i].getCOLUMNCOMPONENTCLS();
			tmpresult["COLUMNCONSTRAIN"] = dcolumn[i].getCOLUMNCONSTRAIN();
			tmpresult["COLUMNCONSTRAINTO"] = dcolumn[i].getCOLUMNCONSTRAINTO();
			tmpresult["COLUMNCONSTRAINTINSETS"] = dcolumn[i].getCOLUMNCONSTRAINTINSETS();
			tmpresult["COLUMNCONTENTEL"] = dcolumn[i].getCOLUMNCONTENTEL();
			tmpresult["COLUMNDATA"] = dcolumn[i].getCOLUMNDATA();
			tmpresult["COLUMNDATAINDEX"] = dcolumn[i].getCOLUMNDATAINDEX();
			tmpresult["COLUMNDEFAULTALIGN"] = dcolumn[i].getCOLUMNDEFAULTALIGN();
			tmpresult["COLUMNDEFAULTTYPE"] = dcolumn[i].getCOLUMNDEFAULTTYPE();
			tmpresult["COLUMNDEFAULTWIDTH"] = dcolumn[i].getCOLUMNDEFAULTWIDTH();
			tmpresult["COLUMNDEFAULTS"] = dcolumn[i].getCOLUMNDEFAULTS();
			tmpresult["COLUMNDETACHONREMOVE"] = dcolumn[i].getCOLUMNDETACHONREMOVE();
			tmpresult["COLUMNDISABLED"] = dcolumn[i].getCOLUMNDISABLED();
			tmpresult["COLUMNDISABLEDCLS"] = dcolumn[i].getCOLUMNDISABLEDCLS();
			tmpresult["COLUMNDRAGGABLE"] = dcolumn[i].getCOLUMNDRAGGABLE();
			tmpresult["COLUMNEDITRENDERER"] = dcolumn[i].getCOLUMNEDITRENDERER();
			tmpresult["COLUMNEDITOR"] = dcolumn[i].getCOLUMNEDITOR();
			tmpresult["COLUMNEMPTYCELLTEXT"] = dcolumn[i].getCOLUMNEMPTYCELLTEXT();
			tmpresult["COLUMNENABLECOLUMNHIDE"] = dcolumn[i].getCOLUMNENABLECOLUMNHIDE();
			tmpresult["COLUMNFLOATING"] = dcolumn[i].getCOLUMNFLOATING();
			tmpresult["COLUMNFOCUSONTOFRONT"] = dcolumn[i].getCOLUMNFOCUSONTOFRONT();
			tmpresult["COLUMNFORMBIND"] = dcolumn[i].getCOLUMNFORMBIND();
			tmpresult["COLUMNFRAME"] = dcolumn[i].getCOLUMNFRAME();
			tmpresult["COLUMNGROUPABLE"] = dcolumn[i].getCOLUMNGROUPABLE();
			tmpresult["COLUMNHANDLER"] = dcolumn[i].getCOLUMNHANDLER();
			tmpresult["COLUMNHEIGHT"] = dcolumn[i].getCOLUMNHEIGHT();
			tmpresult["COLUMNHIDDEN"] = dcolumn[i].getCOLUMNHIDDEN();
			tmpresult["COLUMNHIDEMODE"] = dcolumn[i].getCOLUMNHIDEMODE();
			tmpresult["COLUMNHIDEABLE"] = dcolumn[i].getCOLUMNHIDEABLE();
			tmpresult["COLUMNHTML"] = dcolumn[i].getCOLUMNHTML();
			tmpresult["COLUMNICON"] = dcolumn[i].getCOLUMNICON();
			tmpresult["COLUMNICONCLS"] = dcolumn[i].getCOLUMNICONCLS();
			tmpresult["COLUMNID"] = dcolumn[i].getCOLUMNID();
			tmpresult["COLUMNITEMID"] = dcolumn[i].getCOLUMNITEMID();
			tmpresult["COLUMNITEMS"] = dcolumn[i].getCOLUMNITEMS();
			tmpresult["COLUMNLAYOUT"] = dcolumn[i].getCOLUMNLAYOUT();
			tmpresult["COLUMNLISTENERS"] = dcolumn[i].getCOLUMNLISTENERS();
			tmpresult["COLUMNLOADER"] = dcolumn[i].getCOLUMNLOADER();
			tmpresult["COLUMNLOCKABLE"] = dcolumn[i].getCOLUMNLOCKABLE();
			tmpresult["COLUMNLOCKED"] = dcolumn[i].getCOLUMNLOCKED();
			tmpresult["COLUMNMARGIN"] = dcolumn[i].getCOLUMNMARGIN();
			tmpresult["COLUMNMAXHEIGHT"] = dcolumn[i].getCOLUMNMAXHEIGHT();
			tmpresult["COLUMNMAXWIDTH"] = dcolumn[i].getCOLUMNMAXWIDTH();
			tmpresult["COLUMNMENUTEXT"] = dcolumn[i].getCOLUMNMENUTEXT();
			tmpresult["CACTIONMENUDISABLED"] = dcolumn[i].getCACTIONMENUDISABLED();
			tmpresult["COLUMNMINHEIGHT"] = dcolumn[i].getCOLUMNMINHEIGHT();
			tmpresult["COLUMNMINWIDTH"] = dcolumn[i].getCOLUMNMINWIDTH();
			tmpresult["COLUMNOVERCLS"] = dcolumn[i].getCOLUMNOVERCLS();
			tmpresult["COLUMNOVERFLOWX"] = dcolumn[i].getCOLUMNOVERFLOWX();
			tmpresult["COLUMNOVERFLOWY"] = dcolumn[i].getCOLUMNOVERFLOWY();
			tmpresult["COLUMNPADDING"] = dcolumn[i].getCOLUMNPADDING();
			tmpresult["COLUMNPLUGINS"] = dcolumn[i].getCOLUMNPLUGINS();
			tmpresult["COLUMNREGION"] = dcolumn[i].getCOLUMNREGION();
			tmpresult["COLUMNRENDERDATA"] = dcolumn[i].getCOLUMNRENDERDATA();
			tmpresult["COLUMNRENDERSELECTORS"] = dcolumn[i].getCOLUMNRENDERSELECTORS();
			tmpresult["COLUMNRENDERTO"] = dcolumn[i].getCOLUMNRENDERTO();
			tmpresult["COLUMNRENDERER"] = dcolumn[i].getCOLUMNRENDERER();
			tmpresult["COLUMNRESIZABLE"] = dcolumn[i].getCOLUMNRESIZABLE();
			tmpresult["COLUMNRESIZEHANDLES"] = dcolumn[i].getCOLUMNRESIZEHANDLES();
			tmpresult["COLUMNRTL"] = dcolumn[i].getCOLUMNRTL();
			tmpresult["COLUMNSAVEDELAY"] = dcolumn[i].getCOLUMNSAVEDELAY();
			tmpresult["CACTIONSCOPE"] = dcolumn[i].getCACTIONSCOPE();
			tmpresult["COLUMNSEALED"] = dcolumn[i].getCOLUMNSEALED();
			tmpresult["COLUMNSHADOW"] = dcolumn[i].getCOLUMNSHADOW();
			tmpresult["COLUMNSHADOWOFFSET"] = dcolumn[i].getCOLUMNSHADOWOFFSET();
			tmpresult["COLUMNSHRINKWRAP"] = dcolumn[i].getCOLUMNSHRINKWRAP();
			tmpresult["COLUMNSORTABLE"] = dcolumn[i].getCOLUMNSORTABLE();
			tmpresult["COLUMNSTATEEVENTS"] = dcolumn[i].getCOLUMNSTATEEVENTS();
			tmpresult["COLUMNSTATEID"] = dcolumn[i].getCOLUMNSTATEID();
			tmpresult["COLUMNSTATEFUL"] = dcolumn[i].getCOLUMNSTATEFUL();
			tmpresult["CACTIONSTOPSELECTION"] = dcolumn[i].getCACTIONSTOPSELECTION();
			tmpresult["COLUMNSTYLE"] = dcolumn[i].getCOLUMNSTYLE();
			tmpresult["COLUMNSUSPENDLAYOUT"] = dcolumn[i].getCOLUMNSUSPENDLAYOUT();
			tmpresult["COLUMNTDCLS"] = dcolumn[i].getCOLUMNTDCLS();
			tmpresult["COLUMNTEXT"] = dcolumn[i].getCOLUMNTEXT();
			tmpresult["COLUMNTOFRONTONSHOW"] = dcolumn[i].getCOLUMNTOFRONTONSHOW();
			tmpresult["COLUMNTOOLTIP"] = dcolumn[i].getCOLUMNTOOLTIP();
			tmpresult["COLUMNTOOLTIPTYPE"] = dcolumn[i].getCOLUMNTOOLTIPTYPE();
			tmpresult["COLUMNTPL"] = dcolumn[i].getCOLUMNTPL();
			tmpresult["COLUMNTPLWRITEMODE"] = dcolumn[i].getCOLUMNTPLWRITEMODE();
			tmpresult["COLUMNUI"] = dcolumn[i].getCOLUMNUI();
			tmpresult["CBOOLEANUNDEFINEDTEXT"] = dcolumn[i].getCBOOLEANUNDEFINEDTEXT();
			tmpresult["COLUMNWEIGHT"] = dcolumn[i].getCOLUMNWEIGHT();
			tmpresult["COLUMNXTYPE"] = dcolumn[i].getCOLUMNXTYPE();
			tmpresult["COLUMNEXTRA"] = dcolumn[i].getCOLUMNEXTRA();
		}
	}

	rootstuct["success"] = "true";
	rootstuct["data"] = tmpresult;
	return rootstuct;
	</cfscript>
</cffunction>
</cfcomponent>