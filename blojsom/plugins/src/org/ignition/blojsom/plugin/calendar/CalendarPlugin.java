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
package org.ignition.blojsom.plugin.calendar;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.ignition.blojsom.blog.BlogEntry;
import org.ignition.blojsom.plugin.BlojsomPlugin;
import org.ignition.blojsom.plugin.BlojsomPluginException;
import org.ignition.blojsom.util.BlojsomConstants;
import org.ignition.blojsom.util.BlojsomUtils;

import javax.servlet.ServletConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;


/**
 * CalendarPlugin
 *
 * @author Mark Lussier
 * @version $Id: CalendarPlugin.java,v 1.10 2003-03-27 05:47:16 intabulas Exp $
 */
public class CalendarPlugin implements BlojsomPlugin {

    private Log _logger = LogFactory.getLog(CalendarPlugin.class);

    /**
     * Locale to use for the Calendar.
     */
    private Locale _locale = Locale.getDefault();

    /**
     * Blog Prefix URL used for Calender Hyperlinks
     */
    private String _blogUrlPrefix;

    /**
     * Initialize this plugin. This method only called when the plugin is instantiated.
     *
     * @param servletConfig Servlet config object for the plugin to retrieve any initialization parameters
     * @param blogProperties Read-only properties for the Blog
     * @throws BlojsomPluginException If there is an error initializing the plugin
     */
    public void init(ServletConfig servletConfig, HashMap blogProperties) throws BlojsomPluginException {
        // If blog-language is set in blojsom.properties, use it instead
        String locale = (String)blogProperties.get(BlojsomConstants.BLOG_LANGUAGE_DEFAULT);

        // If no locale is configured, use the system default
        if ( locale != null ) {
             _locale = new Locale(locale);
        }

        _blogUrlPrefix = (String) blogProperties.get(BlojsomConstants.BLOG_URL_IP);
    }

    /**
     * Process the blog entries
     *
     * @param httpServletRequest Request
     * @param httpServletResponse Response
     * @param context Context
     * @param entries Blog entries retrieved for the particular request
     * @return Modified set of blog entries
     * @throws BlojsomPluginException If there is an error processing the blog entries
     */
    public BlogEntry[] process(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse,
                               Map context, BlogEntry[] entries) throws BlojsomPluginException {

        // Was a category part of the URL? If so we want to create href's based on the category
        String category = httpServletRequest.getParameter(BlojsomConstants.CATEGORY_PARAM);
        if ( category == null ) {
            category = "";
        }

        // Default to the Current Month and Year
        Calendar calendar = new GregorianCalendar(_locale);
        calendar.setTime(new Date());
        int currentmonth = calendar.get(Calendar.MONTH);
        int currentyear = calendar.get(Calendar.YEAR);

        // If a  Month is seen on the URL, either by design or calnav params, use it!
        String navmonth = httpServletRequest.getParameter(BlojsomConstants.MONTH_PARAM);
        if (navmonth != null) {
            currentmonth = new Integer(navmonth).intValue() - 1; // Damm Sun!
            calendar.set(Calendar.MONTH, currentmonth );
        }

        // If a Year is seen on the URL, either by design or calnav params, use it!
        String navyear = httpServletRequest.getParameter(BlojsomConstants.YEAR_PARAM);
        if (navyear != null) {
            currentyear = new Integer(navyear).intValue();
            calendar.set(Calendar.YEAR, currentyear);
        }

        String _calurl =_blogUrlPrefix + BlojsomUtils.removeInitialSlash(category);
        BlogCalendar _blogCalendar = new BlogCalendar(calendar, _calurl, _locale);

        Calendar entrycalendar = new GregorianCalendar(_locale);
        if (entries != null && entries.length > 0) {
            for (int x = 0; x < entries.length; x++) {
                BlogEntry entry = entries[x];
                entrycalendar.setTime(entry.getDate());
                int entrymonth = entrycalendar.get(Calendar.MONTH);
                int entryear = entrycalendar.get(Calendar.YEAR);

                // If the Entry is is the same month and the same year, then flag that date as having a Entry
                if ((entrymonth == currentmonth) && (entryear == currentyear)) {
                    _blogCalendar.setEntryForDOM(entrycalendar.get(Calendar.DAY_OF_MONTH));
                }

                // The MB Filter ;) Break on dates EARLIER than current month/year.. to avoid running though 947
                // entries.
                if ((entrymonth < currentmonth) && (entryear <= currentyear)) {
                    break;
                }
            }
        }

        _blogCalendar.buildCalendar();
        context.put(BlojsomConstants.BLOJSOM_CALENDAR, _blogCalendar);
        return entries;
    }

    /**
     * Perform any cleanup for the plugin. Called after {@link #process}.
     *
     * @throws BlojsomPluginException If there is an error performing cleanup for this plugin
     */
    public void cleanup() throws BlojsomPluginException {
    }

    /**
     * Called when BlojsomServlet is taken out of service
     *
     * @throws BlojsomPluginException If there is an error in finalizing this plugin
     */
    public void destroy() throws BlojsomPluginException {
    }
}
