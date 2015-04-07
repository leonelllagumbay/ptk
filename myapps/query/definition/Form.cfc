
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
		if(IsDefined("form.EQRYCODE")) {
		    dsource.setEQRYCODE(trim(form.EQRYCODE));
		}
		if(IsDefined("form.OUTPUTTYPE")) {
		    dsource.setOUTPUTTYPE(trim(form.OUTPUTTYPE));
		}
		if(IsDefined("form.ACTIVEITEM")) {
		    dsource.setACTIVEITEM(trim(form.ACTIVEITEM));
		}
		if(IsDefined("form.ALLOWDESELECT")) {
		    dsource.setALLOWDESELECT(trim(form.ALLOWDESELECT));
		}
		if(IsDefined("form.ANCHORSIZE")) {
		    dsource.setANCHORSIZE(trim(form.ANCHORSIZE));
		}
		if(IsDefined("form.ANIMCOLLAPSE")) {
		    dsource.setANIMCOLLAPSE(trim(form.ANIMCOLLAPSE));
		}
		if(IsDefined("form.AUTODESTROY")) {
		    dsource.setAUTODESTROY(trim(form.AUTODESTROY));
		}
		if(IsDefined("form.AUTORENDER")) {
		    dsource.setAUTORENDER(trim(form.AUTORENDER));
		}
		if(IsDefined("form.AUTOSCROLL")) {
		    dsource.setAUTOSCROLL(trim(form.AUTOSCROLL));
		}
		if(IsDefined("form.AUTOSHOW")) {
		    dsource.setAUTOSHOW(trim(form.AUTOSHOW));
		}
		if(IsDefined("form.BASECLS")) {
		    dsource.setBASECLS(trim(form.BASECLS));
		}
		if(IsDefined("form.BBAR")) {
		    dsource.setBBAR(trim(form.BBAR));
		}
		if(IsDefined("form.GVIEWBLOCKREFRESH")) {
		    dsource.setGVIEWBLOCKREFRESH(trim(form.GVIEWBLOCKREFRESH));
		}
		if(IsDefined("form.BODYBORDER")) {
		    dsource.setBODYBORDER(trim(form.BODYBORDER));
		}
		if(IsDefined("form.BODYCLS")) {
		    dsource.setBODYCLS(trim(form.BODYCLS));
		}
		if(IsDefined("form.BODYPADDING")) {
		    dsource.setBODYPADDING(trim(form.BODYPADDING));
		}
		if(IsDefined("form.BODYSTYLE")) {
		    dsource.setBODYSTYLE(trim(form.BODYSTYLE));
		}
		if(IsDefined("form.BORDER")) {
		    dsource.setBORDER(trim(form.BORDER));
		}
		if(IsDefined("form.BUBBLEEVENTS")) {
		    dsource.setBUBBLEEVENTS(trim(form.BUBBLEEVENTS));
		}
		if(IsDefined("form.BUTTONALIGN")) {
		    dsource.setBUTTONALIGN(trim(form.BUTTONALIGN));
		}
		if(IsDefined("form.BUTTONS")) {
		    dsource.setBUTTONS(trim(form.BUTTONS));
		}
		if(IsDefined("form.CHILDELS")) {
		    dsource.setCHILDELS(trim(form.CHILDELS));
		}
		if(IsDefined("form.CLS")) {
		    dsource.setCLS(trim(form.CLS));
		}
		if(IsDefined("form.CLOSABLE")) {
		    dsource.setCLOSABLE(trim(form.CLOSABLE));
		}
		if(IsDefined("form.CLOSEACTION")) {
		    dsource.setCLOSEACTION(trim(form.CLOSEACTION));
		}
		if(IsDefined("form.COLLAPSEDIRECTION")) {
		    dsource.setCOLLAPSEDIRECTION(trim(form.COLLAPSEDIRECTION));
		}
		if(IsDefined("form.COLLAPSEDFIRST")) {
		    dsource.setCOLLAPSEDFIRST(trim(form.COLLAPSEDFIRST));
		}
		if(IsDefined("form.COLLAPSEMODE")) {
		    dsource.setCOLLAPSEMODE(trim(form.COLLAPSEMODE));
		}
		if(IsDefined("form.COLLAPSED")) {
		    dsource.setCOLLAPSED(trim(form.COLLAPSED));
		}
		if(IsDefined("form.COLLAPSEDCLS")) {
		    dsource.setCOLLAPSEDCLS(trim(form.COLLAPSEDCLS));
		}
		if(IsDefined("form.COLLAPSIBLE")) {
		    dsource.setCOLLAPSIBLE(trim(form.COLLAPSIBLE));
		}
		if(IsDefined("form.COLUMNLINES")) {
		    dsource.setCOLUMNLINES(trim(form.COLUMNLINES));
		}
		if(IsDefined("form.COLUMNWIDTH")) {
		    dsource.setCOLUMNWIDTH(trim(form.COLUMNWIDTH));
		}
		if(IsDefined("form.COMPONENTCLS")) {
		    dsource.setCOMPONENTCLS(trim(form.COMPONENTCLS));
		}
		if(IsDefined("form.COMPONENTLAYOUT")) {
		    dsource.setCOMPONENTLAYOUT(trim(form.COMPONENTLAYOUT));
		}
		if(IsDefined("form.QRYCONSTRAIN")) {
		    dsource.setQRYCONSTRAIN(trim(form.QRYCONSTRAIN));
		}
		if(IsDefined("form.CONSTRAINHEADER")) {
		    dsource.setCONSTRAINHEADER(trim(form.CONSTRAINHEADER));
		}
		if(IsDefined("form.QRYCONSTRAINTO")) {
		    dsource.setQRYCONSTRAINTO(trim(form.QRYCONSTRAINTO));
		}
		if(IsDefined("form.CONSTRAINTINSETS")) {
		    dsource.setCONSTRAINTINSETS(trim(form.CONSTRAINTINSETS));
		}
		if(IsDefined("form.CONTENTEL")) {
		    dsource.setCONTENTEL(trim(form.CONTENTEL));
		}
		if(IsDefined("form.QRYDATA")) {
		    dsource.setQRYDATA(trim(form.QRYDATA));
		}
		if(IsDefined("form.DEFAULTALIGN")) {
		    dsource.setDEFAULTALIGN(trim(form.DEFAULTALIGN));
		}
		if(IsDefined("form.DEFAULTDOCKWEIGHTS")) {
		    dsource.setDEFAULTDOCKWEIGHTS(trim(form.DEFAULTDOCKWEIGHTS));
		}
		if(IsDefined("form.DEFAULTTYPE")) {
		    dsource.setDEFAULTTYPE(trim(form.DEFAULTTYPE));
		}
		if(IsDefined("form.DEFAULTS")) {
		    dsource.setDEFAULTS(trim(form.DEFAULTS));
		}
		if(IsDefined("form.GVIEWDEFEREMPTYTEXT")) {
		    dsource.setGVIEWDEFEREMPTYTEXT(trim(form.GVIEWDEFEREMPTYTEXT));
		}
		if(IsDefined("form.GVIEWDEFERINITIALREFRESH")) {
		    dsource.setGVIEWDEFERINITIALREFRESH(trim(form.GVIEWDEFERINITIALREFRESH));
		}
		if(IsDefined("form.DEFERROWRENDER")) {
		    dsource.setDEFERROWRENDER(trim(form.DEFERROWRENDER));
		}
		if(IsDefined("form.DETACHONREMOVE")) {
		    dsource.setDETACHONREMOVE(trim(form.DETACHONREMOVE));
		}
		if(IsDefined("form.DISABLED")) {
		    dsource.setDISABLED(trim(form.DISABLED));
		}
		if(IsDefined("form.DISABLESELECTION")) {
		    dsource.setDISABLESELECTION(trim(form.DISABLESELECTION));
		}
		if(IsDefined("form.DISABLEDCLS")) {
		    dsource.setDISABLEDCLS(trim(form.DISABLEDCLS));
		}
		if(IsDefined("form.DOCKEDITEMS")) {
		    dsource.setDOCKEDITEMS(trim(form.DOCKEDITEMS));
		}
		if(IsDefined("form.DRAGGABLE")) {
		    dsource.setDRAGGABLE(trim(form.DRAGGABLE));
		}
		if(IsDefined("form.EMPTYTEXT")) {
		    dsource.setEMPTYTEXT(trim(form.EMPTYTEXT));
		}
		if(IsDefined("form.GVIEWENABLETEXTSELECTION")) {
		    dsource.setGVIEWENABLETEXTSELECTION(trim(form.GVIEWENABLETEXTSELECTION));
		}
		if(IsDefined("form.ENABLECOLUMNHIDE")) {
		    dsource.setENABLECOLUMNHIDE(trim(form.ENABLECOLUMNHIDE));
		}
		if(IsDefined("form.ENABLECOLUMNMOVE")) {
		    dsource.setENABLECOLUMNMOVE(trim(form.ENABLECOLUMNMOVE));
		}
		if(IsDefined("form.ENABLECOLUMNRESIZE")) {
		    dsource.setENABLECOLUMNRESIZE(trim(form.ENABLECOLUMNRESIZE));
		}
		if(IsDefined("form.ENABLELOCKING")) {
		    dsource.setENABLELOCKING(trim(form.ENABLELOCKING));
		}
		if(IsDefined("form.FBAR")) {
		    dsource.setFBAR(trim(form.FBAR));
		}
		if(IsDefined("form.FEATURES")) {
		    dsource.setFEATURES(trim(form.FEATURES));
		}
		if(IsDefined("form.GVIEWFIRSTCLS")) {
		    dsource.setGVIEWFIRSTCLS(trim(form.GVIEWFIRSTCLS));
		}
		if(IsDefined("form.FIXED")) {
		    dsource.setFIXED(trim(form.FIXED));
		}
		if(IsDefined("form.FLOATABLE")) {
		    dsource.setFLOATABLE(trim(form.FLOATABLE));
		}
		if(IsDefined("form.FLOATING")) {
		    dsource.setFLOATING(trim(form.FLOATING));
		}
		if(IsDefined("form.FOCUSONTOFRONT")) {
		    dsource.setFOCUSONTOFRONT(trim(form.FOCUSONTOFRONT));
		}
		if(IsDefined("form.FORCEFIT")) {
		    dsource.setFORCEFIT(trim(form.FORCEFIT));
		}
		if(IsDefined("form.FORMBIND")) {
		    dsource.setFORMBIND(trim(form.FORMBIND));
		}
		if(IsDefined("form.FRAME")) {
		    dsource.setFRAME(trim(form.FRAME));
		}
		if(IsDefined("form.FRAMEHEADER")) {
		    dsource.setFRAMEHEADER(trim(form.FRAMEHEADER));
		}
		if(IsDefined("form.GLYPH")) {
		    dsource.setGLYPH(trim(form.GLYPH));
		}
		if(IsDefined("form.HEADER")) {
		    dsource.setHEADER(trim(form.HEADER));
		}
		if(IsDefined("form.HEADEROVERCLS")) {
		    dsource.setHEADEROVERCLS(trim(form.HEADEROVERCLS));
		}
		if(IsDefined("form.HEADERPOSITION")) {
		    dsource.setHEADERPOSITION(trim(form.HEADERPOSITION));
		}
		if(IsDefined("form.HEIGHT")) {
			if(trim(form.HEIGHT) neq "") dsource.setHEIGHT(trim(form.HEIGHT));
		}
		if(IsDefined("form.HIDDEN")) {
		    dsource.setHIDDEN(trim(form.HIDDEN));
		}
		if(IsDefined("form.HIDECOLLAPSETOOL")) {
		    dsource.setHIDECOLLAPSETOOL(trim(form.HIDECOLLAPSETOOL));
		}
		if(IsDefined("form.HIDEHEADER")) {
		    dsource.setHIDEHEADER(trim(form.HIDEHEADER));
		}
		if(IsDefined("form.HIDEMODE")) {
		    dsource.setHIDEMODE(trim(form.HIDEMODE));
		}
		if(IsDefined("form.HTML")) {
		    dsource.setHTML(trim(form.HTML));
		}
		if(IsDefined("form.ICON")) {
		    dsource.setICON(trim(form.ICON));
		}
		if(IsDefined("form.ICONCLS")) {
		    dsource.setICONCLS(trim(form.ICONCLS));
		}
		if(IsDefined("form.QRYID")) {
		    dsource.setQRYID(trim(form.QRYID));
		}
		if(IsDefined("form.ITEMID")) {
		    dsource.setITEMID(trim(form.ITEMID));
		}
		if(IsDefined("form.GVIEWITEMCLS")) {
		    dsource.setGVIEWITEMCLS(trim(form.GVIEWITEMCLS));
		}
		if(IsDefined("form.GVIEWITEMTPL")) {
		    dsource.setGVIEWITEMTPL(trim(form.GVIEWITEMTPL));
		}
		if(IsDefined("form.ITEMS")) {
		    dsource.setITEMS(trim(form.ITEMS));
		}
		if(IsDefined("form.GVIEWLASTCLS")) {
		    dsource.setGVIEWLASTCLS(trim(form.GVIEWLASTCLS));
		}
		if(IsDefined("form.LAYOUT")) {
		    dsource.setLAYOUT(trim(form.LAYOUT));
		}
		if(IsDefined("form.LBAR")) {
		    dsource.setLBAR(trim(form.LBAR));
		}
		if(IsDefined("form.LISTENERS")) {
		    dsource.setLISTENERS(trim(form.LISTENERS));
		}
		if(IsDefined("form.GVIEWLOADMASK")) {
		    dsource.setGVIEWLOADMASK(trim(form.GVIEWLOADMASK));
		}
		if(IsDefined("form.LOADER")) {
		    dsource.setLOADER(trim(form.LOADER));
		}
		if(IsDefined("form.GVIEWLOADINGCLS")) {
		    dsource.setGVIEWLOADINGCLS(trim(form.GVIEWLOADINGCLS));
		}
		if(IsDefined("form.GVIEWLOADINGHEIGHT")) {
		    if(trim(form.GVIEWLOADINGHEIGHT) neq "") dsource.setGVIEWLOADINGHEIGHT(trim(form.GVIEWLOADINGHEIGHT));
		}
		if(IsDefined("form.GVIEWLOADINGTEXT")) {
		    dsource.setGVIEWLOADINGTEXT(trim(form.GVIEWLOADINGTEXT));
		}
		if(IsDefined("form.LOCKEDGRIDCONFIG")) {
		    dsource.setLOCKEDGRIDCONFIG(trim(form.LOCKEDGRIDCONFIG));
		}
		if(IsDefined("form.LOCKEDVIEWCONFIG")) {
		    dsource.setLOCKEDVIEWCONFIG(trim(form.LOCKEDVIEWCONFIG));
		}
		if(IsDefined("form.MANAGEHEIGHT")) {
		    dsource.setMANAGEHEIGHT(trim(form.MANAGEHEIGHT));
		}
		if(IsDefined("form.MARGIN")) {
		    dsource.setMARGIN(trim(form.MARGIN));
		}
		if(IsDefined("form.GVIEWMARKDIRTY")) {
		    dsource.setGVIEWMARKDIRTY(trim(form.GVIEWMARKDIRTY));
		}
		if(IsDefined("form.MAXHEIGHT")) {
		    if(trim(form.MAXHEIGHT) neq "") dsource.setMAXHEIGHT(trim(form.MAXHEIGHT));
		}
		if(IsDefined("form.MAXWIDTH")) {
		    if(trim(form.MAXWIDTH) neq "") dsource.setMAXWIDTH(trim(form.MAXWIDTH));
		}
		if(IsDefined("form.MINBUTTONWIDTH")) {
		    if(trim(form.MINBUTTONWIDTH) neq "") dsource.setMINBUTTONWIDTH(trim(form.MINBUTTONWIDTH));
		}
		if(IsDefined("form.MINHEIGHT")) {
		    if(trim(form.MINHEIGHT) neq "") dsource.setMINHEIGHT(trim(form.MINHEIGHT));
		}
		if(IsDefined("form.MINWIDTH")) {
		    if(trim(form.MINWIDTH) neq "") dsource.setMINWIDTH(trim(form.MINWIDTH));
		}
		if(IsDefined("form.GVIEWMOUSEOVEROUTBUFFER")) {
		    if(trim(form.GVIEWMOUSEOVEROUTBUFFER) neq "") dsource.setGVIEWMOUSEOVEROUTBUFFER(trim(form.GVIEWMOUSEOVEROUTBUFFER));
		}
		if(IsDefined("form.NORMALGRIDCONFIG")) {
		    dsource.setNORMALGRIDCONFIG(trim(form.NORMALGRIDCONFIG));
		}
		if(IsDefined("form.NORMALVIEWCONFIG")) {
		    dsource.setNORMALVIEWCONFIG(trim(form.NORMALVIEWCONFIG));
		}
		if(IsDefined("form.OVERCLS")) {
		    dsource.setOVERCLS(trim(form.OVERCLS));
		}
		if(IsDefined("form.OVERFLOWX")) {
		    dsource.setOVERFLOWX(trim(form.OVERFLOWX));
		}
		if(IsDefined("form.OVERFLOWY")) {
		    dsource.setOVERFLOWY(trim(form.OVERFLOWY));
		}
		if(IsDefined("form.GVIEWOVERITEMCLS")) {
		    dsource.setGVIEWOVERITEMCLS(trim(form.GVIEWOVERITEMCLS));
		}
		if(IsDefined("form.OVERLAPHEADER")) {
		    dsource.setOVERLAPHEADER(trim(form.OVERLAPHEADER));
		}
		if(IsDefined("form.PADDING")) {
		    dsource.setPADDING(trim(form.PADDING));
		}
		if(IsDefined("form.PLACEHOLDER")) {
		    dsource.setPLACEHOLDER(trim(form.PLACEHOLDER));
		}
		if(IsDefined("form.PLACEHOLDERCOLLAPSEHIDEMODE")) {
		    if(trim(form.PLACEHOLDERCOLLAPSEHIDEMODE) neq "") dsource.setPLACEHOLDERCOLLAPSEHIDEMODE(trim(form.PLACEHOLDERCOLLAPSEHIDEMODE));
		}
		if(IsDefined("form.PLUGINS")) {
		    dsource.setPLUGINS(trim(form.PLUGINS));
		}
		if(IsDefined("form.GVIEWPRESERVESCROLLONREFRESH")) {
		    dsource.setGVIEWPRESERVESCROLLONREFRESH(trim(form.GVIEWPRESERVESCROLLONREFRESH));
		}
		if(IsDefined("form.RBAR")) {
		    dsource.setRBAR(trim(form.RBAR));
		}
		if(IsDefined("form.REGION")) {
		    dsource.setREGION(trim(form.REGION));
		}
		if(IsDefined("form.RENDERDATA")) {
		    dsource.setRENDERDATA(trim(form.RENDERDATA));
		}
		if(IsDefined("form.RENDERSELECTORS")) {
		    dsource.setRENDERSELECTORS(trim(form.RENDERSELECTORS));
		}
		if(IsDefined("form.RENDERTO")) {
		    dsource.setRENDERTO(trim(form.RENDERTO));
		}
		if(IsDefined("form.RESIZABLE")) {
		    dsource.setRESIZABLE(trim(form.RESIZABLE));
		}
		if(IsDefined("form.RESIZEHANDLES")) {
		    dsource.setRESIZEHANDLES(trim(form.RESIZEHANDLES));
		}
		if(IsDefined("form.ROWLINES")) {
		    dsource.setROWLINES(trim(form.ROWLINES));
		}
		if(IsDefined("form.RTL")) {
		    dsource.setRTL(trim(form.RTL));
		}
		if(IsDefined("form.SAVEDELAY")) {
		    if(trim(form.SAVEDELAY) neq "") dsource.setSAVEDELAY(trim(form.SAVEDELAY));
		}
		if(IsDefined("form.GVIEWSELECTEDITEMCLS")) {
		    dsource.setGVIEWSELECTEDITEMCLS(trim(form.GVIEWSELECTEDITEMCLS));
		}
		if(IsDefined("form.SCROLL")) {
		    dsource.setSCROLL(trim(form.SCROLL));
		}
		if(IsDefined("form.SCROLLDELTA")) {
		    if(trim(form.SCROLLDELTA) neq "") dsource.setSCROLLDELTA(trim(form.SCROLLDELTA));
		}
		if(IsDefined("form.SEALEDCOLUMNS")) {
		    dsource.setSEALEDCOLUMNS(trim(form.SEALEDCOLUMNS));
		}
		if(IsDefined("form.SELMODEL")) {
		    dsource.setSELMODEL(trim(form.SELMODEL));
		}
		if(IsDefined("form.SELTYPE")) {
		    dsource.setSELTYPE(trim(form.SELTYPE));
		}
		if(IsDefined("form.SHADOW")) {
		    dsource.setSHADOW(trim(form.SHADOW));
		}
		if(IsDefined("form.SHADOWOFFSET")) {
		    if(trim(form.SHADOWOFFSET) neq "") dsource.setSHADOWOFFSET(trim(form.SHADOWOFFSET));
		}
		if(IsDefined("form.SHRINKWRAP")) {
		    dsource.setSHRINKWRAP(trim(form.SHRINKWRAP));
		}
		if(IsDefined("form.SHRINKWRAPDOCK")) {
		    dsource.setSHRINKWRAPDOCK(trim(form.SHRINKWRAPDOCK));
		}
		if(IsDefined("form.SIMPLEDRAG")) {
		    dsource.setSIMPLEDRAG(trim(form.SIMPLEDRAG));
		}
		if(IsDefined("form.SORTABLECOLUMNS")) {
		    dsource.setSORTABLECOLUMNS(trim(form.SORTABLECOLUMNS));
		}
		if(IsDefined("form.STATEEVENTS")) {
		    dsource.setSTATEEVENTS(trim(form.STATEEVENTS));
		}
		if(IsDefined("form.STATEID")) {
		    dsource.setSTATEID(trim(form.STATEID));
		}
		if(IsDefined("form.STATEFUL")) {
		    dsource.setSTATEFUL(trim(form.STATEFUL));
		}
		if(IsDefined("form.GVIEWSTRIPEROWS")) {
		    dsource.setGVIEWSTRIPEROWS(trim(form.GVIEWSTRIPEROWS));
		}
		if(IsDefined("form.STYLE")) {
		    dsource.setSTYLE(trim(form.STYLE));
		}
		if(IsDefined("form.SUBGRIDXTYPE")) {
		    dsource.setSUBGRIDXTYPE(trim(form.SUBGRIDXTYPE));
		}
		if(IsDefined("form.SUSPENDLAYOUT")) {
		    dsource.setSUSPENDLAYOUT(trim(form.SUSPENDLAYOUT));
		}
		if(IsDefined("form.SYNCROWHEIGHT")) {
		    dsource.setSYNCROWHEIGHT(trim(form.SYNCROWHEIGHT));
		}
		if(IsDefined("form.TBAR")) {
		    dsource.setTBAR(trim(form.TBAR));
		}
		if(IsDefined("form.QRYTITLE")) {
		    dsource.setQRYTITLE(trim(form.QRYTITLE));
		}
		if(IsDefined("form.TITLEALIGN")) {
		    dsource.setTITLEALIGN(trim(form.TITLEALIGN));
		}
		if(IsDefined("form.TITLECOLLAPSE")) {
		    dsource.setTITLECOLLAPSE(trim(form.TITLECOLLAPSE));
		}
		if(IsDefined("form.TOFRONTONSHOW")) {
		    dsource.setTOFRONTONSHOW(trim(form.TOFRONTONSHOW));
		}
		if(IsDefined("form.TOOLS")) {
		    dsource.setTOOLS(trim(form.TOOLS));
		}
		if(IsDefined("form.TPL")) {
		    dsource.setTPL(trim(form.TPL));
		}
		if(IsDefined("form.TPLWRITEMODE")) {
		    dsource.setTPLWRITEMODE(trim(form.TPLWRITEMODE));
		}
		if(IsDefined("form.GVIEWTRACKOVER")) {
		    dsource.setGVIEWTRACKOVER(trim(form.GVIEWTRACKOVER));
		}
		if(IsDefined("form.QRYUI")) {
		    dsource.setQRYUI(trim(form.QRYUI));
		}
		if(IsDefined("form.VERTICALSCROLLER")) {
		    dsource.setVERTICALSCROLLER(trim(form.VERTICALSCROLLER));
		}
		if(IsDefined("form.QRYVIEW")) {
		    dsource.setQRYVIEW(trim(form.QRYVIEW));
		}
		if(IsDefined("form.VIEWCONFIG")) {
		    dsource.setVIEWCONFIG(trim(form.VIEWCONFIG));
		}
		if(IsDefined("form.WIDTH")) {
		    if(trim(form.WIDTH) neq "") dsource.setWIDTH(trim(form.WIDTH));
		}
		if(IsDefined("form.XTYPE")) {
		    dsource.setXTYPE(trim(form.XTYPE));
		}
		if(IsDefined("form.GRIDEXTRA")) {
		    dsource.setGRIDEXTRA(trim(form.GRIDEXTRA));
		}
		if(IsDefined("form.STORESORTERS")) {
		    dsource.setSTORESORTERS(trim(form.STORESORTERS));
		}
		if(IsDefined("form.STOREFILTERS")) {
		    dsource.setSTOREFILTERS(trim(form.STOREFILTERS));
		}
		if(IsDefined("form.STOREPAGESIZE")) {
		    if(trim(form.STOREPAGESIZE) neq "") dsource.setSTOREPAGESIZE(trim(form.STOREPAGESIZE));
		}
		if(IsDefined("form.STORETIMEOUT")) {
		    if(trim(form.STORETIMEOUT) neq "") dsource.setSTORETIMEOUT(trim(form.STORETIMEOUT));
		}
		if(IsDefined("form.STOREEXTRA")) {
		    dsource.setSTOREEXTRA(trim(form.STOREEXTRA));
		}
		if(IsDefined("form.STOREPROXYEXTRA")) {
		    dsource.setSTOREPROXYEXTRA(trim(form.STOREPROXYEXTRA));
		}
		if(IsDefined("form.SHAREABLE")) {
		    dsource.setSHAREABLE(trim(form.SHAREABLE));
		}
		if(IsDefined("form.PRINTABLE")) {
		    dsource.setPRINTABLE(trim(form.PRINTABLE));
		}
		if(IsDefined("form.EXPORTABLE")) {
		    dsource.setEXPORTABLE(trim(form.EXPORTABLE));
		}
		if(IsDefined("form.APPENDABLEROW")) {
		    dsource.setAPPENDABLEROW(trim(form.APPENDABLEROW));
		}
		if(IsDefined("form.REMOVABLEROW")) {
		    dsource.setREMOVABLEROW(trim(form.REMOVABLEROW));
		}
		if(IsDefined("form.EMAILABLE")) {
		    dsource.setEMAILABLE(trim(form.EMAILABLE));
		}
		EntitySave(dsource);
		ormflush();

		dchart = EntityLoad("EGRGQRYCHART",{EQRYCODE="#trim(form.EQRYCODE)#"}, true);
		if(IsDefined("dchart")) {
			//update
		} else {
			//insert
			dchart = EntityNew("EGRGQRYCHART");
		}
		if(IsDefined("form.EQRYCODE")) {
		    dchart.setEQRYCODE(trim(form.EQRYCODE));
		}
		if(IsDefined("form.CHARTLABEL")) {
		    dchart.setCHARTLABEL(trim(form.CHARTLABEL));
		}
		if(IsDefined("form.BOXFILL")) {
		    dchart.setBOXFILL(trim(form.BOXFILL));
		}
		if(IsDefined("form.BOXSTROKE")) {
		    dchart.setBOXSTROKE(trim(form.BOXSTROKE));
		}
		if(IsDefined("form.BOXSTROKEWIDTH")) {
		    dchart.setBOXSTROKEWIDTH(trim(form.BOXSTROKEWIDTH));
		}
		if(IsDefined("form.BOXZINDEX")) {
		    if(trim(form.BOXZINDEX) neq "") dchart.setBOXZINDEX(trim(form.BOXZINDEX));
		}
		if(IsDefined("form.ITEMSPACING")) {
		    if(trim(form.ITEMSPACING) neq "") dchart.setITEMSPACING(trim(form.ITEMSPACING));
		}
		if(IsDefined("form.LABELCOLOR")) {
		    dchart.setLABELCOLOR(trim(form.LABELCOLOR));
		}
		if(IsDefined("form.LABELFONT")) {
		    dchart.setLABELFONT(trim(form.LABELFONT));
		}
		if(IsDefined("form.PADDING")) {
		    if(trim(form.PADDING) neq "") dchart.setPADDING(trim(form.PADDING));
		}
		if(IsDefined("form.LEGENDPOSITION")) {
		    dchart.setLEGENDPOSITION(trim(form.LEGENDPOSITION));
		}
		if(IsDefined("form.CHARTUPDATE")) {
		    dchart.setCHARTUPDATE(trim(form.CHARTUPDATE));
		}
		if(IsDefined("form.VISIBLE")) {
		    dchart.setVISIBLE(trim(form.VISIBLE));
		}
		if(IsDefined("form.X")) {
		    if(trim(form.X) neq "") dchart.setX(trim(form.X));
		}
		if(IsDefined("form.Y")) {
		    if(trim(form.Y) neq "") dchart.setY(trim(form.Y));
		}
		if(IsDefined("form.ALLOWFUNCTIONS")) {
		    dchart.setALLOWFUNCTIONS(trim(form.ALLOWFUNCTIONS));
		}
		if(IsDefined("form.DEFAULTSORTDIRECTION")) {
		    dchart.setDEFAULTSORTDIRECTION(trim(form.DEFAULTSORTDIRECTION));
		}
		if(IsDefined("form.LEGENDITEMLISTENERS")) {
		    dchart.setLEGENDITEMLISTENERS(trim(form.LEGENDITEMLISTENERS));
		}
		if(IsDefined("form.SORTROOT")) {
		    dchart.setSORTROOT(trim(form.SORTROOT));
		}
		if(IsDefined("form.SORTERS")) {
		    dchart.setSORTERS(trim(form.SORTERS));
		}
		if(IsDefined("form.MASK")) {
		    dchart.setMASK(trim(form.MASK));
		}
		if(IsDefined("form.AXISADJUSTEND")) {
		    dchart.setAXISADJUSTEND(trim(form.AXISADJUSTEND));
		}
		if(IsDefined("form.AXISDASHSIZE")) {
		    if(trim(form.AXISDASHSIZE) neq "") dchart.setAXISDASHSIZE(trim(form.AXISDASHSIZE));
		}
		if(IsDefined("form.AXISFIELDS")) {
		    dchart.setAXISFIELDS(trim(form.AXISFIELDS));
		}
		if(IsDefined("form.AXISGRID")) {
		    dchart.setAXISGRID(trim(form.AXISGRID));
		}
		if(IsDefined("form.AXISHIDDEN")) {
		    dchart.setAXISHIDDEN(trim(form.AXISHIDDEN));
		}
		if(IsDefined("form.AXISLABEL")) {
		    dchart.setAXISLABEL(trim(form.AXISLABEL));
		}
		if(IsDefined("form.AXISLENGTH")) {
		    if(trim(form.AXISLENGTH) neq "") dchart.setAXISLENGTH(trim(form.AXISLENGTH));
		}
		if(IsDefined("form.AXISMAJORTICKSTEPS")) {
		    if(trim(form.AXISMAJORTICKSTEPS) neq "") dchart.setAXISMAJORTICKSTEPS(trim(form.AXISMAJORTICKSTEPS));
		}
		if(IsDefined("form.AXISMINORTICKSTEPS")) {
		    if(trim(form.AXISMINORTICKSTEPS) neq "") dchart.setAXISMINORTICKSTEPS(trim(form.AXISMINORTICKSTEPS));
		}
		if(IsDefined("form.AXISPOSITION")) {
		    dchart.setAXISPOSITION(trim(form.AXISPOSITION));
		}
		if(IsDefined("form.AXISTITLE")) {
		    dchart.setAXISTITLE(trim(form.AXISTITLE));
		}
		if(IsDefined("form.AXISWIDTH")) {
		   if(trim(form.AXISWIDTH) neq "") dchart.setAXISWIDTH(trim(form.AXISWIDTH));
		}
		if(IsDefined("form.AXISCALCULATECATEGORYCOUNT")) {
		    dchart.setAXISCALCULATECATEGORYCOUNT(trim(form.AXISCALCULATECATEGORYCOUNT));
		}
		if(IsDefined("form.AXISCATEGORYNAMES")) {
		    dchart.setAXISCATEGORYNAMES(trim(form.AXISCATEGORYNAMES));
		}
		if(IsDefined("form.AXISMARGIN")) {
		    if(trim(form.AXISMARGIN) neq "") dchart.setAXISMARGIN(trim(form.AXISMARGIN));
		}
		if(IsDefined("form.AXISADJUSTMAXIMUMBYMAJORUNIT")) {
		    dchart.setAXISADJUSTMAXIMUMBYMAJORUNIT(trim(form.AXISADJUSTMAXIMUMBYMAJORUNIT));
		}
		if(IsDefined("form.AXISADJUSTMINIMUMBYMAJORUNIT")) {
		    dchart.setAXISADJUSTMINIMUMBYMAJORUNIT(trim(form.AXISADJUSTMINIMUMBYMAJORUNIT));
		}
		if(IsDefined("form.AXISCONSTRAIN")) {
		    dchart.setAXISCONSTRAIN(trim(form.AXISCONSTRAIN));
		}
		if(IsDefined("form.AXISDECIMALS")) {
		    if(trim(form.AXISDECIMALS) neq "") dchart.setAXISDECIMALS(trim(form.AXISDECIMALS));
		}
		if(IsDefined("form.AXISMAXIMUM")) {
		    if(trim(form.AXISMAXIMUM) neq "") dchart.setAXISMAXIMUM(trim(form.AXISMAXIMUM));
		}
		if(IsDefined("form.AXISMINIMUM")) {
		    if(trim(form.AXISMINIMUM) neq "") dchart.setAXISMINIMUM(trim(form.AXISMINIMUM));
		}
		if(IsDefined("form.AXISDATEFORMAT")) {
		    dchart.setAXISDATEFORMAT(trim(form.AXISDATEFORMAT));
		}
		if(IsDefined("form.AXISFROMDATE")) {
		    dchart.setAXISFROMDATE(trim(form.AXISFROMDATE));
		}
		if(IsDefined("form.AXISSTEP")) {
		    dchart.setAXISSTEP(trim(form.AXISSTEP));
		}
		if(IsDefined("form.AXISTODATE")) {
		    dchart.setAXISTODATE(trim(form.AXISTODATE));
		}
		if(IsDefined("form.AXISEXTRA")) {
		    dchart.setAXISEXTRA(trim(form.AXISEXTRA));
		}
		if(IsDefined("form.SERIESAXIS")) {
		    dchart.setSERIESAXIS(trim(form.SERIESAXIS));
		}
		if(IsDefined("form.SERIESHIGHLIGHT")) {
		    dchart.setSERIESHIGHLIGHT(trim(form.SERIESHIGHLIGHT));
		}
		if(IsDefined("form.SERIESLABEL")) {
		    dchart.setSERIESLABEL(trim(form.SERIESLABEL));
		}
		if(IsDefined("form.SERIESLISTENERS")) {
		    dchart.setSERIESLISTENERS(trim(form.SERIESLISTENERS));
		}
		if(IsDefined("form.SERIESRENDERER")) {
		    dchart.setSERIESRENDERER(trim(form.SERIESRENDERER));
		}
		if(IsDefined("form.SERIESSHADOWATTRIBUTES")) {
		    dchart.setSERIESSHADOWATTRIBUTES(trim(form.SERIESSHADOWATTRIBUTES));
		}
		if(IsDefined("form.SERIESSHOWINLEGEND")) {
		    dchart.setSERIESSHOWINLEGEND(trim(form.SERIESSHOWINLEGEND));
		}
		if(IsDefined("form.SERIESSTYLE")) {
		    dchart.setSERIESSTYLE(trim(form.SERIESSTYLE));
		}
		if(IsDefined("form.SERIESTIPS")) {
		    dchart.setSERIESTIPS(trim(form.SERIESTIPS));
		}
		if(IsDefined("form.SERIESTITLE")) {
		    dchart.setSERIESTITLE(trim(form.SERIESTITLE));
		}
		if(IsDefined("form.SERIESTYPE")) {
		    dchart.setSERIESTYPE(trim(form.SERIESTYPE));
		}
		if(IsDefined("form.SERIESXFIELD")) {
		    dchart.setSERIESXFIELD(trim(form.SERIESXFIELD));
		}
		if(IsDefined("form.SERIESYFIELD")) {
		    dchart.setSERIESYFIELD(trim(form.SERIESYFIELD));
		}
		if(IsDefined("form.SERIESCOLUMN")) {
		    dchart.setSERIESCOLUMN(trim(form.SERIESCOLUMN));
		}
		if(IsDefined("form.SERIESGROUPGUTTER")) {
		    if(trim(form.SERIESGROUPGUTTER) neq "") dchart.setSERIESGROUPGUTTER(trim(form.SERIESGROUPGUTTER));
		}
		if(IsDefined("form.SERIESGUTTER")) {
		    if(trim(form.SERIESGUTTER) neq "") dchart.setSERIESGUTTER(trim(form.SERIESGUTTER));
		}
		if(IsDefined("form.SERIESSTACKED")) {
		    dchart.setSERIESSTACKED(trim(form.SERIESSTACKED));
		}
		if(IsDefined("form.SERIESXPADDING")) {
		    dchart.setSERIESXPADDING(trim(form.SERIESXPADDING));
		}
		if(IsDefined("form.SERIESYPADDING")) {
		    dchart.setSERIESYPADDING(trim(form.SERIESYPADDING));
		}
		if(IsDefined("form.SERIESANGLEFIELD")) {
		    dchart.setSERIESANGLEFIELD(trim(form.SERIESANGLEFIELD));
		}
		if(IsDefined("form.SERIESDONUT")) {
		    dchart.setSERIESDONUT(trim(form.SERIESDONUT));
		}
		if(IsDefined("form.SERIESHIGHLIGHTDURATION")) {
		    if(trim(form.SERIESHIGHLIGHTDURATION) neq "") dchart.setSERIESHIGHLIGHTDURATION(trim(form.SERIESHIGHLIGHTDURATION));
		}
		if(IsDefined("form.SERIESNEEDLE")) {
		    dchart.setSERIESNEEDLE(trim(form.SERIESNEEDLE));
		}
		if(IsDefined("form.SERIESFILL")) {
		    dchart.setSERIESFILL(trim(form.SERIESFILL));
		}
		if(IsDefined("form.SERIESMARKERCONFIG")) {
		    dchart.setSERIESMARKERCONFIG(trim(form.SERIESMARKERCONFIG));
		}
		if(IsDefined("form.SERIESSELECTIONTOLERANCE")) {
		    if(trim(form.SERIESSELECTIONTOLERANCE) neq "") dchart.setSERIESSELECTIONTOLERANCE(trim(form.SERIESSELECTIONTOLERANCE));
		}
		if(IsDefined("form.SERIESSHOWMARKERS")) {
		    dchart.setSERIESSHOWMARKERS(trim(form.SERIESSHOWMARKERS));
		}
		if(IsDefined("form.SERIESSMOOTH")) {
		    dchart.setSERIESSMOOTH(trim(form.SERIESSMOOTH));
		}
		if(IsDefined("form.SERIESCOLORSET")) {
		    dchart.setSERIESCOLORSET(trim(form.SERIESCOLORSET));
		}
		if(IsDefined("form.SERIESFIELD")) {
		    dchart.setSERIESFIELD(trim(form.SERIESFIELD));
		}
		if(IsDefined("form.SERIESLENGTHFIELD")) {
		    dchart.setSERIESLENGTHFIELD(trim(form.SERIESLENGTHFIELD));
		}
		if(IsDefined("form.SERIESEXTRA")) {
		    dchart.setSERIESEXTRA(trim(form.SERIESEXTRA));
		}
		if(IsDefined("form.CHARTEXTRA")) {
		    dchart.setCHARTEXTRA(trim(form.CHARTEXTRA));
		}
		EntitySave(dchart);
		ormflush();

		dfeature = EntityLoad("EGRGQRYFEATURE",{EQRYCODE="#trim(form.EQRYCODE)#"}, true);
		if(IsDefined("dfeature")) {
			//update
		} else {
			//insert
			dfeature = EntityNew("EGRGQRYFEATURE");
		}
		if(IsDefined("form.EQRYCODE")) {
		    dfeature.setEQRYCODE(trim(form.EQRYCODE));
		}
		if(IsDefined("form.GROUPINGLISTENERS")) {
		    dfeature.setGROUPINGLISTENERS(trim(form.GROUPINGLISTENERS));
		}
		if(IsDefined("form.REMOTEROOT")) {
		    dfeature.setREMOTEROOT(trim(form.REMOTEROOT));
		}
		if(IsDefined("form.SHOWSUMMARYROW")) {
		    dfeature.setSHOWSUMMARYROW(trim(form.SHOWSUMMARYROW));
		}
		if(IsDefined("form.FCOLLAPSIBLE")) {
		    dfeature.setFCOLLAPSIBLE(trim(form.FCOLLAPSIBLE));
		}
		if(IsDefined("form.DEPTHTOINDENT")) {
		    if(trim(form.DEPTHTOINDENT) neq "") dfeature.setDEPTHTOINDENT(trim(form.DEPTHTOINDENT));
		}
		if(IsDefined("form.ENABLEGROUPINGMENU")) {
		    dfeature.setENABLEGROUPINGMENU(trim(form.ENABLEGROUPINGMENU));
		}
		if(IsDefined("form.ENABLENOGROUPS")) {
		    dfeature.setENABLENOGROUPS(trim(form.ENABLENOGROUPS));
		}
		if(IsDefined("form.GROUPBYTEXT")) {
		    dfeature.setGROUPBYTEXT(trim(form.GROUPBYTEXT));
		}
		if(IsDefined("form.GROUPHEADERTPL")) {
		    dfeature.setGROUPHEADERTPL(trim(form.GROUPHEADERTPL));
		}
		if(IsDefined("form.HIDEGROUPEDHEADER")) {
		    dfeature.setHIDEGROUPEDHEADER(trim(form.HIDEGROUPEDHEADER));
		}
		if(IsDefined("form.SHOWGROUPSTEXT")) {
		    dfeature.setSHOWGROUPSTEXT(trim(form.SHOWGROUPSTEXT));
		}
		if(IsDefined("form.STARTCOLLAPSED")) {
		    dfeature.setSTARTCOLLAPSED(trim(form.STARTCOLLAPSED));
		}
		if(IsDefined("form.FEATUREEXTRA")) {
		    dfeature.setFEATUREEXTRA(trim(form.FEATUREEXTRA));
		}
		EntitySave(dfeature);
		ormflush();

		dplugin = EntityLoad("EGRGQRYPLUGIN",{EQRYCODE="#trim(form.EQRYCODE)#"}, true);
		if(IsDefined("dplugin")) {
			//update
		} else {
			//insert
			dplugin = EntityNew("EGRGQRYPLUGIN");
		}
		if(IsDefined("form.EQRYCODE")) {
		    dplugin.setEQRYCODE(trim(form.EQRYCODE));
		}
		if(IsDefined("form.BLEADINGBUFFERZONE")) {
		    if(trim(form.BLEADINGBUFFERZONE) neq "") dplugin.setBLEADINGBUFFERZONE(trim(form.BLEADINGBUFFERZONE));
		}
		if(IsDefined("form.BNUMFROMEDGE")) {
		    if(trim(form.BNUMFROMEDGE) neq "") dplugin.setBNUMFROMEDGE(trim(form.BNUMFROMEDGE));
		}
		if(IsDefined("form.BPLUGINID")) {
		    dplugin.setBPLUGINID(trim(form.BPLUGINID));
		}
		if(IsDefined("form.BSCROLLTOLOADBUFFER")) {
		    if(trim(form.BSCROLLTOLOADBUFFER) neq "") dplugin.setBSCROLLTOLOADBUFFER(trim(form.BSCROLLTOLOADBUFFER));
		}
		if(IsDefined("form.BSYNCHRONOUSRENDER")) {
		    dplugin.setBSYNCHRONOUSRENDER(trim(form.BSYNCHRONOUSRENDER));
		}
		if(IsDefined("form.BTRAILINGBUFFERZONE")) {
		    if(trim(form.BTRAILINGBUFFERZONE) neq "") dplugin.setBTRAILINGBUFFERZONE(trim(form.BTRAILINGBUFFERZONE));
		}
		if(IsDefined("form.BVARIABLEROWHEIGHT")) {
		    dplugin.setBVARIABLEROWHEIGHT(trim(form.BVARIABLEROWHEIGHT));
		}
		if(IsDefined("form.CELLEDITINGCLICKSTOEDIT")) {
		    if(trim(form.CELLEDITINGCLICKSTOEDIT) neq "") dplugin.setCELLEDITINGCLICKSTOEDIT(trim(form.CELLEDITINGCLICKSTOEDIT));
		}
		if(IsDefined("form.CELLEDITINGLISTENER")) {
		    dplugin.setCELLEDITINGLISTENER(trim(form.CELLEDITINGLISTENER));
		}
		if(IsDefined("form.TRIGGEREVENT")) {
		    dplugin.setTRIGGEREVENT(trim(form.TRIGGEREVENT));
		}
		if(IsDefined("form.DDCONTAINERSCROLL")) {
		    dplugin.setDDCONTAINERSCROLL(trim(form.DDCONTAINERSCROLL));
		}
		if(IsDefined("form.DDGROUP")) {
		    dplugin.setDDGROUP(trim(form.DDGROUP));
		}
		if(IsDefined("form.DDDRAGGROUP")) {
		    dplugin.setDDDRAGGROUP(trim(form.DDDRAGGROUP));
		}
		if(IsDefined("form.DDDRAGTEXT")) {
		    dplugin.setDDDRAGTEXT(trim(form.DDDRAGTEXT));
		}
		if(IsDefined("form.DDDROPGROUP")) {
		    dplugin.setDDDROPGROUP(trim(form.DDDROPGROUP));
		}
		if(IsDefined("form.DDENABLEDRAG")) {
		    dplugin.setDDENABLEDRAG(trim(form.DDENABLEDRAG));
		}
		if(IsDefined("form.DDENABLEDROP")) {
		    dplugin.setDDENABLEDROP(trim(form.DDENABLEDROP));
		}
		if(IsDefined("form.HEADERRESIZER")) {
		    dplugin.setHEADERRESIZER(trim(form.HEADERRESIZER));
		}
		if(IsDefined("form.ROWAUTOCANCEL")) {
		    dplugin.setROWAUTOCANCEL(trim(form.ROWAUTOCANCEL));
		}
		if(IsDefined("form.ROWCLICKSTOEDIT")) {
		    if(trim(form.ROWCLICKSTOEDIT) neq "") dplugin.setROWCLICKSTOEDIT(trim(form.ROWCLICKSTOEDIT));
		}
		if(IsDefined("form.ROWCLICKSTOMOVEEDITOR")) {
		    if(trim(form.ROWCLICKSTOMOVEEDITOR) neq "") dplugin.setROWCLICKSTOMOVEEDITOR(trim(form.ROWCLICKSTOMOVEEDITOR));
		}
		if(IsDefined("form.ROWERRORSUMMARY")) {
		    dplugin.setROWERRORSUMMARY(trim(form.ROWERRORSUMMARY));
		}
		if(IsDefined("form.ROWLISTENERS")) {
		    dplugin.setROWLISTENERS(trim(form.ROWLISTENERS));
		}
		if(IsDefined("form.ROWTRIGGEREVENT")) {
		    dplugin.setROWTRIGGEREVENT(trim(form.ROWTRIGGEREVENT));
		}
		if(IsDefined("form.ROWEXPANDONDBLCLICK")) {
		    dplugin.setROWEXPANDONDBLCLICK(trim(form.ROWEXPANDONDBLCLICK));
		}
		if(IsDefined("form.ROWEXPANDONENTER")) {
		    dplugin.setROWEXPANDONENTER(trim(form.ROWEXPANDONENTER));
		}
		if(IsDefined("form.ROWSELECTROWONEXPAND")) {
		    dplugin.setROWSELECTROWONEXPAND(trim(form.ROWSELECTROWONEXPAND));
		}
		if(IsDefined("form.PLUGINEXTRA")) {
		    dplugin.setPLUGINEXTRA(trim(form.PLUGINEXTRA));
		}
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
		if(IsDefined("form.EVIEWFIELDCODE")) {
		    dcolumn.setEVIEWFIELDCODE(trim(form.EVIEWFIELDCODE));
		}
		if(IsDefined("form.COLUMNACTIVEITEM")) {
		    dcolumn.setCOLUMNACTIVEITEM(trim(form.COLUMNACTIVEITEM));
		}
		if(IsDefined("form.OUTPUTTYPE")) {
		    dcolumn.setOUTPUTTYPE(trim(form.OUTPUTTYPE));
		}


		if(IsDefined("form.COLUMNALIGN")) {
		    dcolumn.setCOLUMNALIGN(trim(form.COLUMNALIGN));
		}
		if(IsDefined("form.CACTIONALTTEXT")) {
		    dcolumn.setCACTIONALTTEXT(trim(form.CACTIONALTTEXT));
		}
		if(IsDefined("form.COLUMNANCHORSIZE")) {
		    dcolumn.setCOLUMNANCHORSIZE(trim(form.COLUMNANCHORSIZE));
		}
		if(IsDefined("form.COLUMNAUTODESTROY")) {
		    dcolumn.setCOLUMNAUTODESTROY(trim(form.COLUMNAUTODESTROY));
		}
		if(IsDefined("form.COLUMNAUTORENDER")) {
		    dcolumn.setCOLUMNAUTORENDER(trim(form.COLUMNAUTORENDER));
		}
		if(IsDefined("form.COLUMNAUTOSCROLL")) {
		    dcolumn.setCOLUMNAUTOSCROLL(trim(form.COLUMNAUTOSCROLL));
		}
		if(IsDefined("form.COLUMNAUTOSHOW")) {
		    dcolumn.setCOLUMNAUTOSHOW(trim(form.COLUMNAUTOSHOW));
		}
		if(IsDefined("form.COLUMNBASECLS")) {
		    dcolumn.setCOLUMNBASECLS(trim(form.COLUMNBASECLS));
		}
		if(IsDefined("form.COLUMNBORDER")) {
		    dcolumn.setCOLUMNBORDER(trim(form.COLUMNBORDER));
		}
		if(IsDefined("form.COLUMNBUBBLEEVENTS")) {
		    dcolumn.setCOLUMNBUBBLEEVENTS(trim(form.COLUMNBUBBLEEVENTS));
		}
		if(IsDefined("form.COLUMNCHILDELS")) {
		    dcolumn.setCOLUMNCHILDELS(trim(form.COLUMNCHILDELS));
		}
		if(IsDefined("form.COLUMNCLS")) {
		    dcolumn.setCOLUMNCLS(trim(form.COLUMNCLS));
		}
		if(IsDefined("form.COLUMNWIDTH")) {
		    dcolumn.setCOLUMNWIDTH(trim(form.COLUMNWIDTH));
		}
		if(IsDefined("form.COLUMNCOLUMNS")) {
		    dcolumn.setCOLUMNCOLUMNS(trim(form.COLUMNCOLUMNS));
		}
		if(IsDefined("form.COLUMNCOMPONENTCLS")) {
		    dcolumn.setCOLUMNCOMPONENTCLS(trim(form.COLUMNCOMPONENTCLS));
		}
		if(IsDefined("form.COLUMNCONSTRAIN")) {
		    dcolumn.setCOLUMNCONSTRAIN(trim(form.COLUMNCONSTRAIN));
		}
		if(IsDefined("form.COLUMNCONSTRAINTO")) {
		    dcolumn.setCOLUMNCONSTRAINTO(trim(form.COLUMNCONSTRAINTO));
		}
		if(IsDefined("form.COLUMNCONSTRAINTINSETS")) {
		    dcolumn.setCOLUMNCONSTRAINTINSETS(trim(form.COLUMNCONSTRAINTINSETS));
		}
		if(IsDefined("form.COLUMNCONTENTEL")) {
		    dcolumn.setCOLUMNCONTENTEL(trim(form.COLUMNCONTENTEL));
		}
		if(IsDefined("form.COLUMNDATA")) {
		    dcolumn.setCOLUMNDATA(trim(form.COLUMNDATA));
		}
		if(IsDefined("form.COLUMNDATAINDEX")) {
		    dcolumn.setCOLUMNDATAINDEX(trim(form.COLUMNDATAINDEX));
		}
		if(IsDefined("form.COLUMNDEFAULTALIGN")) {
		    dcolumn.setCOLUMNDEFAULTALIGN(trim(form.COLUMNDEFAULTALIGN));
		}
		if(IsDefined("form.COLUMNDEFAULTTYPE")) {
		    dcolumn.setCOLUMNDEFAULTTYPE(trim(form.COLUMNDEFAULTTYPE));
		}
		if(IsDefined("form.COLUMNDEFAULTWIDTH")) {
		    if(trim(form.COLUMNDEFAULTWIDTH) neq "") dcolumn.setCOLUMNDEFAULTWIDTH(trim(form.COLUMNDEFAULTWIDTH));
		}
		if(IsDefined("form.COLUMNDEFAULTS")) {
		    dcolumn.setCOLUMNDEFAULTS(trim(form.COLUMNDEFAULTS));
		}
		if(IsDefined("form.COLUMNDETACHONREMOVE")) {
		    dcolumn.setCOLUMNDETACHONREMOVE(trim(form.COLUMNDETACHONREMOVE));
		}
		if(IsDefined("form.COLUMNDISABLED")) {
		    dcolumn.setCOLUMNDISABLED(trim(form.COLUMNDISABLED));
		}
		if(IsDefined("form.COLUMNDISABLEDCLS")) {
		    dcolumn.setCOLUMNDISABLEDCLS(trim(form.COLUMNDISABLEDCLS));
		}
		if(IsDefined("form.COLUMNDRAGGABLE")) {
		    dcolumn.setCOLUMNDRAGGABLE(trim(form.COLUMNDRAGGABLE));
		}
		if(IsDefined("form.COLUMNEDITRENDERER")) {
		    dcolumn.setCOLUMNEDITRENDERER(trim(form.COLUMNEDITRENDERER));
		}
		if(IsDefined("form.COLUMNEDITOR")) {
		    dcolumn.setCOLUMNEDITOR(trim(form.COLUMNEDITOR));
		}
		if(IsDefined("form.COLUMNEMPTYCELLTEXT")) {
		    dcolumn.setCOLUMNEMPTYCELLTEXT(trim(form.COLUMNEMPTYCELLTEXT));
		}
		if(IsDefined("form.COLUMNENABLECOLUMNHIDE")) {
		    dcolumn.setCOLUMNENABLECOLUMNHIDE(trim(form.COLUMNENABLECOLUMNHIDE));
		}
		if(IsDefined("form.COLUMNFLOATING")) {
		    dcolumn.setCOLUMNFLOATING(trim(form.COLUMNFLOATING));
		}
		if(IsDefined("form.COLUMNFOCUSONTOFRONT")) {
		    dcolumn.setCOLUMNFOCUSONTOFRONT(trim(form.COLUMNFOCUSONTOFRONT));
		}
		if(IsDefined("form.COLUMNFORMBIND")) {
		    dcolumn.setCOLUMNFORMBIND(trim(form.COLUMNFORMBIND));
		}
		if(IsDefined("form.COLUMNFRAME")) {
		    dcolumn.setCOLUMNFRAME(trim(form.COLUMNFRAME));
		}
		if(IsDefined("form.COLUMNGROUPABLE")) {
		    dcolumn.setCOLUMNGROUPABLE(trim(form.COLUMNGROUPABLE));
		}
		if(IsDefined("form.COLUMNHANDLER")) {
		    dcolumn.setCOLUMNHANDLER(trim(form.COLUMNHANDLER));
		}
		if(IsDefined("form.COLUMNHEIGHT")) {
		    if(trim(form.COLUMNHEIGHT) neq "") dcolumn.setCOLUMNHEIGHT(trim(form.COLUMNHEIGHT));
		}
		if(IsDefined("form.COLUMNHIDDEN")) {
		    dcolumn.setCOLUMNHIDDEN(trim(form.COLUMNHIDDEN));
		}
		if(IsDefined("form.COLUMNHIDEMODE")) {
		    dcolumn.setCOLUMNHIDEMODE(trim(form.COLUMNHIDEMODE));
		}
		if(IsDefined("form.COLUMNHIDEABLE")) {
		    dcolumn.setCOLUMNHIDEABLE(trim(form.COLUMNHIDEABLE));
		}
		if(IsDefined("form.COLUMNHTML")) {
		    dcolumn.setCOLUMNHTML(trim(form.COLUMNHTML));
		}
		if(IsDefined("form.COLUMNICON")) {
		    dcolumn.setCOLUMNICON(trim(form.COLUMNICON));
		}
		if(IsDefined("form.COLUMNICONCLS")) {
		    dcolumn.setCOLUMNICONCLS(trim(form.COLUMNICONCLS));
		}
		if(IsDefined("form.COLUMNID")) {
		    dcolumn.setCOLUMNID(trim(form.COLUMNID));
		}
		if(IsDefined("form.COLUMNITEMID")) {
		    dcolumn.setCOLUMNITEMID(trim(form.COLUMNITEMID));
		}
		if(IsDefined("form.COLUMNITEMS")) {
		    dcolumn.setCOLUMNITEMS(trim(form.COLUMNITEMS));
		}
		if(IsDefined("form.COLUMNLAYOUT")) {
		    dcolumn.setCOLUMNLAYOUT(trim(form.COLUMNLAYOUT));
		}
		if(IsDefined("form.COLUMNLISTENERS")) {
		    dcolumn.setCOLUMNLISTENERS(trim(form.COLUMNLISTENERS));
		}
		if(IsDefined("form.COLUMNLOADER")) {
		    dcolumn.setCOLUMNLOADER(trim(form.COLUMNLOADER));
		}
		if(IsDefined("form.COLUMNLOCKABLE")) {
		    dcolumn.setCOLUMNLOCKABLE(trim(form.COLUMNLOCKABLE));
		}
		if(IsDefined("form.COLUMNLOCKED")) {
		    dcolumn.setCOLUMNLOCKED(trim(form.COLUMNLOCKED));
		}
		if(IsDefined("form.COLUMNMARGIN")) {
		    dcolumn.setCOLUMNMARGIN(trim(form.COLUMNMARGIN));
		}
		if(IsDefined("form.COLUMNMAXHEIGHT")) {
		    if(trim(form.COLUMNMAXHEIGHT) neq "") dcolumn.setCOLUMNMAXHEIGHT(trim(form.COLUMNMAXHEIGHT));
		}
		if(IsDefined("form.COLUMNMAXWIDTH")) {
		    if(trim(form.COLUMNMAXWIDTH) neq "") dcolumn.setCOLUMNMAXWIDTH(trim(form.COLUMNMAXWIDTH));
		}
		if(IsDefined("form.COLUMNMENUTEXT")) {
		    dcolumn.setCOLUMNMENUTEXT(trim(form.COLUMNMENUTEXT));
		}
		if(IsDefined("form.CACTIONMENUDISABLED")) {
		    dcolumn.setCACTIONMENUDISABLED(trim(form.CACTIONMENUDISABLED));
		}
		if(IsDefined("form.COLUMNMINHEIGHT")) {
		    if(trim(form.COLUMNMINHEIGHT) neq "") dcolumn.setCOLUMNMINHEIGHT(trim(form.COLUMNMINHEIGHT));
		}
		if(IsDefined("form.COLUMNMINWIDTH")) {
		    if(trim(form.COLUMNMINWIDTH) neq "") dcolumn.setCOLUMNMINWIDTH(trim(form.COLUMNMINWIDTH));
		}
		if(IsDefined("form.COLUMNOVERCLS")) {
		    dcolumn.setCOLUMNOVERCLS(trim(form.COLUMNOVERCLS));
		}
		if(IsDefined("form.COLUMNOVERFLOWX")) {
		    dcolumn.setCOLUMNOVERFLOWX(trim(form.COLUMNOVERFLOWX));
		}
		if(IsDefined("form.COLUMNOVERFLOWY")) {
		    dcolumn.setCOLUMNOVERFLOWY(trim(form.COLUMNOVERFLOWY));
		}
		if(IsDefined("form.COLUMNPADDING")) {
		    dcolumn.setCOLUMNPADDING(trim(form.COLUMNPADDING));
		}
		if(IsDefined("form.COLUMNPLUGINS")) {
		    dcolumn.setCOLUMNPLUGINS(trim(form.COLUMNPLUGINS));
		}
		if(IsDefined("form.COLUMNREGION")) {
		    dcolumn.setCOLUMNREGION(trim(form.COLUMNREGION));
		}
		if(IsDefined("form.COLUMNRENDERDATA")) {
		    dcolumn.setCOLUMNRENDERDATA(trim(form.COLUMNRENDERDATA));
		}
		if(IsDefined("form.COLUMNRENDERSELECTORS")) {
		    dcolumn.setCOLUMNRENDERSELECTORS(trim(form.COLUMNRENDERSELECTORS));
		}
		if(IsDefined("form.COLUMNRENDERTO")) {
		    dcolumn.setCOLUMNRENDERTO(trim(form.COLUMNRENDERTO));
		}
		if(IsDefined("form.COLUMNRENDERER")) {
		    dcolumn.setCOLUMNRENDERER(trim(form.COLUMNRENDERER));
		}
		if(IsDefined("form.COLUMNRESIZABLE")) {
		    dcolumn.setCOLUMNRESIZABLE(trim(form.COLUMNRESIZABLE));
		}
		if(IsDefined("form.COLUMNRESIZEHANDLES")) {
		    dcolumn.setCOLUMNRESIZEHANDLES(trim(form.COLUMNRESIZEHANDLES));
		}
		if(IsDefined("form.COLUMNRTL")) {
		    dcolumn.setCOLUMNRTL(trim(form.COLUMNRTL));
		}
		if(IsDefined("form.COLUMNSAVEDELAY")) {
		    if(trim(form.COLUMNSAVEDELAY) neq "") dcolumn.setCOLUMNSAVEDELAY(trim(form.COLUMNSAVEDELAY));
		}
		if(IsDefined("form.CACTIONSCOPE")) {
		    dcolumn.setCACTIONSCOPE(trim(form.CACTIONSCOPE));
		}
		if(IsDefined("form.COLUMNSEALED")) {
		    dcolumn.setCOLUMNSEALED(trim(form.COLUMNSEALED));
		}
		if(IsDefined("form.COLUMNSHADOW")) {
		    dcolumn.setCOLUMNSHADOW(trim(form.COLUMNSHADOW));
		}
		if(IsDefined("form.COLUMNSHADOWOFFSET")) {
		    if(trim(form.COLUMNSHADOWOFFSET) neq "") dcolumn.setCOLUMNSHADOWOFFSET(trim(form.COLUMNSHADOWOFFSET));
		}
		if(IsDefined("form.COLUMNSHRINKWRAP")) {
		    dcolumn.setCOLUMNSHRINKWRAP(trim(form.COLUMNSHRINKWRAP));
		}
		if(IsDefined("form.COLUMNSORTABLE")) {
		    dcolumn.setCOLUMNSORTABLE(trim(form.COLUMNSORTABLE));
		}
		if(IsDefined("form.COLUMNSTATEEVENTS")) {
		    dcolumn.setCOLUMNSTATEEVENTS(trim(form.COLUMNSTATEEVENTS));
		}
		if(IsDefined("form.COLUMNSTATEID")) {
		    dcolumn.setCOLUMNSTATEID(trim(form.COLUMNSTATEID));
		}
		if(IsDefined("form.COLUMNSTATEFUL")) {
		    dcolumn.setCOLUMNSTATEFUL(trim(form.COLUMNSTATEFUL));
		}
		if(IsDefined("form.CACTIONSTOPSELECTION")) {
		    dcolumn.setCACTIONSTOPSELECTION(trim(form.CACTIONSTOPSELECTION));
		}
		if(IsDefined("form.COLUMNSTYLE")) {
		    dcolumn.setCOLUMNSTYLE(trim(form.COLUMNSTYLE));
		}
		if(IsDefined("form.COLUMNSUSPENDLAYOUT")) {
		    dcolumn.setCOLUMNSUSPENDLAYOUT(trim(form.COLUMNSUSPENDLAYOUT));
		}
		if(IsDefined("form.COLUMNTDCLS")) {
		    dcolumn.setCOLUMNTDCLS(trim(form.COLUMNTDCLS));
		}
		if(IsDefined("form.COLUMNTEXT")) {
		    dcolumn.setCOLUMNTEXT(trim(form.COLUMNTEXT));
		}
		if(IsDefined("form.COLUMNTOFRONTONSHOW")) {
		    dcolumn.setCOLUMNTOFRONTONSHOW(trim(form.COLUMNTOFRONTONSHOW));
		}
		if(IsDefined("form.COLUMNTOOLTIP")) {
		    dcolumn.setCOLUMNTOOLTIP(trim(form.COLUMNTOOLTIP));
		}
		if(IsDefined("form.COLUMNTOOLTIPTYPE")) {
		    dcolumn.setCOLUMNTOOLTIPTYPE(trim(form.COLUMNTOOLTIPTYPE));
		}
		if(IsDefined("form.COLUMNTPL")) {
		    dcolumn.setCOLUMNTPL(trim(form.COLUMNTPL));
		}
		if(IsDefined("form.COLUMNTPLWRITEMODE")) {
		    dcolumn.setCOLUMNTPLWRITEMODE(trim(form.COLUMNTPLWRITEMODE));
		}
		if(IsDefined("form.COLUMNUI")) {
		    dcolumn.setCOLUMNUI(trim(form.COLUMNUI));
		}
		if(IsDefined("form.CBOOLEANUNDEFINEDTEXT")) {
		    dcolumn.setCBOOLEANUNDEFINEDTEXT(trim(form.CBOOLEANUNDEFINEDTEXT));
		}
		if(IsDefined("form.COLUMNWEIGHT")) {
		    if(trim(form.COLUMNWEIGHT) neq "") dcolumn.setCOLUMNWEIGHT(trim(form.COLUMNWEIGHT));
		}
		if(IsDefined("form.COLUMNXTYPE")) {
		    dcolumn.setCOLUMNXTYPE(trim(form.COLUMNXTYPE));
		}
		if(IsDefined("form.COLUMNEXTRA")) {
		    dcolumn.setCOLUMNEXTRA(trim(form.COLUMNEXTRA));
		}
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