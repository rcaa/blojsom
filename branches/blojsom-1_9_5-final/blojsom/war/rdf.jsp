<?xml version="1.0"?>
<%@ page import="org.ignition.blojsom.blog.Blog,
                 org.ignition.blojsom.util.BlojsomConstants,
                 org.ignition.blojsom.blog.BlogEntry"
                 session="false"%>
<%
    Blog blogInformation = (Blog) request.getAttribute(BlojsomConstants.BLOJSOM_BLOG);
    BlogEntry[] blogEntries = (BlogEntry[]) request.getAttribute(BlojsomConstants.BLOJSOM_ENTRIES);
    String blogDate = (String) request.getAttribute(BlojsomConstants.BLOJSOM_DATE_ISO8601);
%>

<!-- RDF generated by blojsom v1.9.2 -->
<rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
         xmlns:dc="http://purl.org/dc/elements/1.1/"
         xmlns="http://purl.org/rss/1.0/">

	<channel rdf:about="<%= blogInformation.getBlogURL() %>">
        <title><%= blogInformation.getBlogName() %></title>
        <link><%= blogInformation.getBlogURL() %></link>
        <description><%= blogInformation.getBlogDescription() %></description>
		<dc:publisher><%= blogInformation.getBlogOwner() %></dc:publisher>
		<dc:creator><%= blogInformation.getBlogOwnerEmail() %></dc:creator>
		<dc:date><%= blogDate %></dc:date>
        <dc:language><%= blogInformation.getBlogLanguage() %></dc:language>
	</channel>

    <%
        if (blogEntries != null) {
            for (int i = 0; i < blogEntries.length; i++) {
                BlogEntry blogEntry = blogEntries[i];
    %>
    	<item rdf:about="<%= blogEntry.getEscapedLink() %>">>
    		<title><%= blogEntry.getEscapedTitle() %></title>
    		<link><%= blogEntry.getEscapedLink() %></link>
    		<description><%= blogEntry.getEscapedDescription() %></description>
            <dc:date>><%= blogEntry.getISO8601Date()%></dc:date>
			<wfw:comment xmlns:wfw="http://wellformedweb.org/CommentAPI/">
                 <%= blogInformation.getBlogBaseURL()%>/commentapi/<%= blogEntry.getId()%>
            </wfw:comment>
    	</item>
    <%
            }
        }
    %>
</rdf:RDF>
