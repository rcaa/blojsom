/**
 * Copyright (c) 2003, David A. Czarnecki
 * All rights reserved.
 *
 * Portions Copyright (c) 2003 by Mark Lussier
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * Redistributions of source code must retain the above copyright notice,
 *      this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice,
 *      this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 * Neither the name of the "David A. Czarnecki" and "blojsom" nor the names of
 * its contributors may be used to endorse or promote products derived from
 * this software without specific prior written permission.
 * Products derived from this software may not be called "blojsom",
 * nor may "blojsom" appear in their name, without prior written permission of
 * David A. Czarnecki.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
 * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
 * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
 * EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED
 * AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
package org.blojsom.filter;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.util.zip.GZIPOutputStream;

/**
 *  Filter that compresses output with gzip
 *  (assuming that browser supports gzip).
 *  <P />
 *  Taken from More Servlets and JavaServer Pages
 *  from Prentice Hall and Sun Microsystems Press,
 *  http://www.moreservlets.com/.
 *  &copy; 2002 Marty Hall; may be freely used or adapted.
 */
public class CompressionFilter implements Filter {

    private Log _logger = LogFactory.getLog(CompressionFilter.class);
    private FilterConfig config;

    /**
     *  If browser does not support gzip, invoke resource
     *  normally. If browser <I>does</I> support gzip,
     *  set the Content-Encoding response header and
     *  invoke resource with a wrapped response that
     *  collects all the output. Extract the output
     *  and write it into a gzipped byte array. Finally,
     *  write that array to the client's output stream.
     */
    public void doFilter(ServletRequest request,
                         ServletResponse response,
                         FilterChain chain)
            throws ServletException, IOException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        if (!isGzipSupported(req)) {
            // Invoke resource normally.
            chain.doFilter(req, res);
        } else {
            // Tell browser we are sending it gzipped data.
            res.setHeader("Content-Encoding", "gzip");
      
            // Invoke resource, accumulating output in the wrapper.
            CharArrayWrapper responseWrapper = new CharArrayWrapper(res);
            chain.doFilter(req, responseWrapper);
      
            // Get character array representing output.
            char[] responseChars = responseWrapper.toCharArray();

            // Make a writer that compresses data and puts
            // it into a byte array.
            ByteArrayOutputStream byteStream = new ByteArrayOutputStream();
            GZIPOutputStream zipOut = new GZIPOutputStream(byteStream);
            OutputStreamWriter tempOut = new OutputStreamWriter(zipOut);
      
            // Compress original output and put it into byte array.
            tempOut.write(responseChars);
      
            // Gzip streams must be explicitly closed.
            tempOut.close();

            // Update the Content-Length header.
            res.setContentLength(byteStream.size());

            // Send compressed result to client.
            OutputStream realOut = res.getOutputStream();
            byteStream.writeTo(realOut);
            realOut.flush();
        }
    }

    /**
     * Store the FilterConfig object in case subclasses
     *  want it.
     */
    public void init(FilterConfig config) throws ServletException {
        this.config = config;
        _logger.debug("Initialized compression filter");
    }

    /**
     * Return the <code>FilterConfig</code> object
     *
     * @return <code>FilterConfig</code> object
     */
    protected FilterConfig getFilterConfig() {
        return (config);
    }

    /**
     * Called when this filter is taken out of service
     */
    public void destroy() {
    }

    /**
     * Check to see whether or not GZIP compression is supported
     *
     * @param req Servlet request
     * @return <code>true</code> if the client supports GZIP compression, <code>false</code> otherwise
     */
    private boolean isGzipSupported(HttpServletRequest req) {
        String browserEncodings = req.getHeader("Accept-Encoding");
        return ((browserEncodings != null) && (browserEncodings.indexOf("gzip") != -1));
    }
}
