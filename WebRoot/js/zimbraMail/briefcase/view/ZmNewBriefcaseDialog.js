/*
 * ***** BEGIN LICENSE BLOCK *****
 * Zimbra Collaboration Suite Web Client
 * Copyright (C) 2007, 2009 Zimbra, Inc.
 * 
 * The contents of this file are subject to the Zimbra Public License
 * Version 1.2 ("License"); you may not use this file except in
 * compliance with the License.  You may obtain a copy of the License at
 * http://www.zimbra.com/license.
 * 
 * Software distributed under the License is distributed on an "AS IS"
 * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied.
 * ***** END LICENSE BLOCK *****
 */

ZmNewBriefcaseDialog = function(parent, className) {
	var title = ZmMsg.createNewBriefcaseItem;
	var type = ZmOrganizer.BRIEFCASE;
	ZmNewOrganizerDialog.call(this, parent, className, title, type);
}

ZmNewBriefcaseDialog.prototype = new ZmNewOrganizerDialog;
ZmNewBriefcaseDialog.prototype.constructor = ZmNewBriefcaseDialog;

ZmNewBriefcaseDialog.prototype.toString = 
function() {
	return "ZmNewBriefcaseDialog";
}

// Protected methods

// NOTE: don't show remote checkbox
ZmNewBriefcaseDialog.prototype._createRemoteContentHtml =
function(html, idx) {
	return idx;
};
