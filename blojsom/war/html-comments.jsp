<%@ page import="org.ignition.blojsom.blog.Blog,
                 org.ignition.blojsom.util.BlojsomConstants,
                 org.ignition.blojsom.blog.BlogEntry,
                 org.ignition.blojsom.blog.BlogCategory,
                 org.ignition.blojsom.blog.BlogComment,
                 java.util.ArrayList"
		 session="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<%
            Blog blogInformation = (Blog) request.getAttribute(BlojsomConstants.BLOJSOM_BLOG);
            BlogEntry[] entryArray = (BlogEntry[]) request.getAttribute(BlojsomConstants.BLOJSOM_ENTRIES);
            BlogCategory[] blogCategories = (BlogCategory[]) request.getAttribute(BlojsomConstants.BLOJSOM_CATEGORIES);
            String blogSiteURL = (String) request.getAttribute(BlojsomConstants.BLOJSOM_SITE_URL);
            BlogCategory requestedCategory = (BlogCategory) request.getAttribute(BlojsomConstants.BLOJSOM_REQUESTED_CATEGORY);
            boolean blogCommentsEnabled = ((Boolean) request.getAttribute(BlojsomConstants.BLOJSOM_COMMENTS_ENABLED)).booleanValue();


            StringBuffer catStringBuf = new StringBuffer(20);
            String blogName = null;
            for (int j = 0; j < blogCategories.length; j++) {
                BlogCategory blogCategory = blogCategories[j];
                blogName = blogCategory.getName();
                if ((blogName == null) || (blogName.length() < 1)) {
                    blogName = blogCategory.getCategory();
                }
                catStringBuf.append("[<i><a href=").append(blogCategory.getCategoryURL());
                catStringBuf.append(">").append(blogName).append("</a></i>]");
            }
            String catString = catStringBuf.toString();
%>

    <head>
	<title><%= blogInformation.getBlogName() %></title>
	<link rel="stylesheet" href="<%= blogSiteURL %>/blojsom.css" />
    <link rel="SHORTCUT ICON" href="<%= blogSiteURL %>/favicon.ico" />
    <link rel="alternate" type="application/rss+xml" title="RSS" href="<%= blogInformation.getBlogURL() %>?flavor=rss" />
    </head>

    <body>
	<h1><a href="<%= blogInformation.getBlogURL() %>">
		<%= blogInformation.getBlogName() %>
	</a></h1>

	<big><i><%= blogInformation.getBlogDescription() %></i></big>

	<p><b>Available Categories: </b><%= catString %></p>
<%
            if (entryArray != null) {
                for (int i = 0; i < entryArray.length; i++) {
                BlogEntry blogEntry = entryArray[i];
%>
		<div class="entrystyle">
		<p class="weblogtitle"><%= blogEntry.getTitle() %>
		    <span class="smalltext">
			[<a href="<%= blogEntry.getLink() %>">Permalink</a>]
		    </span>
		</p>
		<p class="weblogdateline"><%= blogEntry.getDate() %></p>
		<p><%= blogEntry.getDescription() %></p>
		</div>
        <p class="weblogtitle">Comments on this entry</p>
        <div class="entrystyle">
        <%
            ArrayList blogComments = blogEntry.getComments();
            if (blogComments != null) {
            for (int j = 0; j < blogComments.size(); j++) {
                BlogComment blogComment = (BlogComment) blogComments.get(j);
        %>
        <div class="commentstyle">
            Comment by: <a href="mailto:<%= blogComment.getAuthorEmail() %>"><%= blogComment.getAuthor() %></a> -
                <a href="<%= blogComment.getAuthorURL() %>"><%= blogComment.getAuthorURL() %></a>
            <div class="weblogdateline">Left on: <%= blogComment.getCommentDate() %></div><br/>
            <%= blogComment.getComment() %><br />
        </div>

        <%
                    }
            }
        %>
        </div>

        <% if (blogCommentsEnabled) { %>
        <hr />
    <table>
        <form name="commentform" method="post" action=".">
            <input type="hidden" name="comment" value="y"/>
            <input type="hidden" name="page" value="comments"/>
            <input type="hidden" name="category" value="<%= requestedCategory.getCategory() %>"/><br />
            <input type="hidden" name="permalink" value="<%= blogEntry.getPermalink() %>"/> <br />
            <tr>
                <td>Author:</td><td><input type="text" name="author" value=""/></td>
            </tr>
            <tr>
                <td>E-mail:</td><td><input type="text" name="authorEmail" value=""/></td>
            </tr>
            <tr>
                <td>URL: </td><td><input type="text" name="authorURL" value=""/></td>
            </tr>
            <tr>
                <td>Comment:</td><td><textarea name="commentText" value="" rows="5" columns="120"></textarea></td>
            </tr>
            <p />
            <tr>
                <td colspan="2"><input type="submit" name="submit" value="Submit Comment"/>
                <input type="reset" name="reset" value="Reset"/>
                </td>
            </tr>
        </form>
    </table>
        <% } %>
<%
                }
            }
%>

<p />

<%
            if ((entryArray != null) && (entryArray.length > 0)) {
%>
	<p><b>Available Categories: </b><%= catString %></p>
<%
            }
%>

    <p />
    <a href="http://blojsom.sf.net"><img src="<%= blogSiteURL %>/powered-by-blojsom.gif" border="0" alt="Powered By blojsom"/></a>&nbsp;&nbsp;
    <a href="<%= requestedCategory.getCategoryURL() %>?flavor=rss"><img src="<%= blogSiteURL %>/xml.gif" border="0" alt="RSS Feed"/></a>&nbsp;
    <a href="<%= requestedCategory.getCategoryURL() %>?flavor=rss2"><img src="<%= blogSiteURL %>/rss.gif" border="0" alt="RSS2 Feed"/></a>&nbsp;
    <a href="<%= requestedCategory.getCategoryURL() %>?flavor=rdf"><img src="<%= blogSiteURL %>/rdf.gif" border="0" alt="RDF Feed"/></a>

    </body>
</html>
