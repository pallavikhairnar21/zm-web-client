<%@ tag body-content="empty" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="app" uri="com.zimbra.htmlclient" %>
<%@ taglib prefix="zm" uri="com.zimbra.zm" %>

<app:handleError>
<c:set var="ids" value="${fn:join(paramValues.id, ',')}"/>
<c:choose>
    <c:when test="${!empty param.actionCompose}">
        <jsp:forward page="/h/compose"/>
    </c:when>
    <c:when test="${!empty param.actionMarkTagRead}">
        <c:set var="tagName" value="${zm:getTagName(pageContext, param.contextTagId)}"/>
        <zm:markTagRead id="${param.contextTagId}"/>
        <app:status>
            <fmt:message key="actionTagMarkRead">
                <fmt:param value="${tagName}"/>
            </fmt:message>
        </app:status>
    </c:when>
    <c:when test="${!empty param.actionMarkFolderRead}">
        <c:set var="folderName" value="${zm:getFolderName(pageContext, param.contextFolderId)}"/>
        <zm:markFolderRead id="${param.contextFolderId}"/>
        <app:status>
            <fmt:message key="actionFolderMarkRead">
                <fmt:param value="${folderName}"/>
            </fmt:message>
        </app:status>
    </c:when>
        <c:when test="${!empty param.actionMarkConvRead}">
        <zm:markConversationRead read="true" var="result" id="${param.contextConvId}"/>
        <app:status>
            <fmt:message key="actionConvMarkedRead">
                <fmt:param value="${result.idCount}"/>
            </fmt:message>
        </app:status>
    </c:when>
    <c:when test="${!empty param.actionEmpty}">
        <zm:emptyFolder id="${param.contextFolderId}"/>
        <app:status>
            <fmt:message key="folderEmptied">
                <fmt:param value="${zm:getFolderName(pageContext, param.contextFolderId)}"/>
            </fmt:message>
        </app:status>
    </c:when>
    <c:when test="${!empty param.actionLoadFeed}">
        <zm:syncFolder id="${param.contextFolderId}"/>
        <app:status>
            <fmt:message key="feedLoaded">
                <fmt:param value="${zm:getFolderName(pageContext, param.contextFolderId)}"/>
            </fmt:message>
        </app:status>
    </c:when>
    <c:when test="${empty ids}">
        <app:status style="Warning"><fmt:message key="actionNoMessageSelected"/></app:status>
    </c:when>
    <c:otherwise>
        <c:choose>
            <c:when test="${!empty param.actionSpam}">
                <zm:markMessageSpam  var="result" id="${ids}" spam="true"/>
                <app:status>
                    <fmt:message key="actionMessageMarkedSpam">
                        <fmt:param value="${result.idCount}"/>
                    </fmt:message>
                </app:status>
            </c:when>
            <c:when test="${!empty param.actionDelete}">
                <zm:getMailbox var="mailbox"/>
                <zm:moveMessage  var="result" id="${ids}" folderid="${mailbox.trash.id}"/>
                <app:status>
                    <fmt:message key="actionMessageMovedTrash">
                        <fmt:param value="${result.idCount}"/>
                    </fmt:message>
                </app:status>
            </c:when>
            <c:when test="${!empty param.actionHardDelete}">
                <zm:getMailbox var="mailbox"/>
                <zm:deleteMessage  var="result" id="${ids}"/>
                <app:status>
                    <fmt:message key="actionMessageHardDeleted">
                        <fmt:param value="${result.idCount}"/>
                    </fmt:message>
                </app:status>
            </c:when>
            <c:when test="${param.actionOp eq 'unread' or param.actionOp eq 'read'}">
                <zm:markMessageRead var="result" id="${ids}" read="${param.actionOp eq 'read'}"/>
                <app:status>
                    <fmt:message key="${param.actionOp eq 'read' ? 'actionMessageMarkedRead' : 'actionMessageMarkedUnread'}">
                        <fmt:param value="${result.idCount}"/>
                    </fmt:message>
                </app:status>
            </c:when>
            <c:when test="${param.actionOp eq 'flag' or param.actionOp eq 'unflag'}">
                <zm:flagMessage var="result" id="${ids}" flag="${param.actionOp eq 'flag'}"/>
                <app:status>
                    <fmt:message key="${param.actionOp eq 'flag' ? 'actionMessageFlag' : 'actionMessageUnflag'}">
                        <fmt:param value="${result.idCount}"/>
                    </fmt:message>
                </app:status>
            </c:when>
            <c:when test="${fn:startsWith(param.actionOp, 't:') or fn:startsWith(param.actionOp, 'u:')}">
                <c:set var="tag" value="${fn:startsWith(param.actionOp, 't')}"/>
                <c:set var="tagid" value="${fn:substring(param.actionOp, 2, -1)}"/>
                <zm:tagMessage tagid="${tagid}"var="result" id="${ids}" tag="${tag}"/>
                <app:status>
                    <fmt:message key="${tag ? 'actionMessageTag' : 'actionMessageUntag'}">
                        <fmt:param value="${result.idCount}"/>
                        <fmt:param value="${zm:getTagName(pageContext, tagid)}"/>
                    </fmt:message>
                </app:status>
            </c:when>
            <c:when test="${fn:startsWith(param.folderId, 'm:')}">
                <c:set var="folderid" value="${fn:substring(param.folderId, 2, -1)}"/>
                <zm:getMailbox var="mailbox"/>
                <zm:moveMessage folderid="${folderid}"var="result" id="${ids}"/>
                <app:status>
                    <fmt:message key="actionMessageMoved">
                        <fmt:param value="${result.idCount}"/>
                        <fmt:param value="${zm:getFolderName(pageContext, folderid)}"/>
                    </fmt:message>
                </app:status>
            </c:when>
            <c:when test="${!empty param.actionMove}">
                <app:status style="Warning"><fmt:message key="actionNoFolderSelected"/></app:status>
            </c:when>
            <c:otherwise>
                <app:status style="Warning"><fmt:message key="actionNoActionSelected"/></app:status>
            </c:otherwise>
        </c:choose>
    </c:otherwise>
</c:choose>
</app:handleError>