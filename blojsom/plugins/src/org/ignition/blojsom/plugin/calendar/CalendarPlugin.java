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
 * @version $Id: CalendarPlugin.java,v 1.6 2003-03-26 15:46:13 intabulas Exp $
 */
public class CalendarPlugin implements BlojsomPlugin {

    private Log _logger = LogFactory.getLog(CalendarPlugin.class);

    /**
     * Initialize this plugin. This method only called when the plugin is instantiated.
     *
     * @param servletConfig Servlet config object for the plugin to retrieve any initialization parameters
     * @param blogProperties Read-only properties for the Blog
     * @throws BlojsomPluginException If there is an error initializing the plugin
     */
    public void init(ServletConfig servletConfig, HashMap blogProperties) throws BlojsomPluginException {
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

        // Default to the Current Month and Year
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(new Date());
        int currentmonth = calendar.get(Calendar.MONTH);
        int currentyear = calendar.get(Calendar.YEAR);

        // If a  Month is seen on the URL, either by design or calnav params, use it!
        String navmonth = httpServletRequest.getParameter(BlojsomConstants.MONTH_PARAM);
        if (navmonth != null) {
            currentmonth = new Integer(navmonth).intValue();
            calendar = new GregorianCalendar(currentyear, currentmonth, 1);
        }

        // If a Year is seen on the URL, either by design or calnav params, use it!
        String navyear = httpServletRequest.getParameter(BlojsomConstants.YEAR_PARAM);
        if (navyear != null) {
            currentyear = new Integer(navyear).intValue();
            calendar = new GregorianCalendar(currentyear, currentmonth, 1);
        }

        // Create the Calendar Caption (ie: March 2003) and shove it in the context
        String caption = BlojsomUtils.getFormattedDate(calendar.getTime(), BlojsomConstants.BLOJSOM_CALENDAR_FORMAT);
        context.put(BlojsomConstants.BLOJSOM_CALENDAR_CAPTION, caption);

        // Roll the calendar back 1 month (we do not care about the year for this) and grab the short month caption
        calendar.roll(Calendar.MONTH, -1);
        String prevmonth = BlojsomUtils.getFormattedDate(calendar.getTime(), BlojsomConstants.BLOJSOM_CALENDAR_SHORTFORMAT);
        context.put(BlojsomConstants.BLOJSOM_CALENDAR_PREVIOUS, prevmonth);

        // Roll the calendar forward 2 months (to skip current) and grab the short month caption
        calendar.roll(Calendar.MONTH, 2);
        String nextmonth = BlojsomUtils.getFormattedDate(calendar.getTime(), BlojsomConstants.BLOJSOM_CALENDAR_SHORTFORMAT);
        context.put(BlojsomConstants.BLOJSOM_CALENDAR_NEXT, nextmonth);


        Boolean[] dates = new Boolean[calendar.getMaximum(Calendar.DAY_OF_MONTH)];
        Arrays.fill(dates, Boolean.FALSE);

        if (entries != null && entries.length > 0) {
            for (int x = 0; x < entries.length; x++) {
                BlogEntry entry = entries[x];
                calendar.setTime(entry.getDate());
                int entrymonth = calendar.get(Calendar.MONTH);
                int entryear = calendar.get(Calendar.YEAR);

                // If the Entry is is the same month and the same year, then flag that date as having a Entry
                if ((entrymonth == currentmonth) && (entryear == currentyear)) {
                    dates[calendar.get(Calendar.DAY_OF_MONTH)] = Boolean.TRUE;
                }

                // The MB Filter ;) Break on dates EARLIER than current month/year.. to avoid running though 947
                // entries.
                if ((entrymonth < currentmonth) && (entryear <= currentyear)) {
                    break;
                }
            }
        }

        context.put(BlojsomConstants.BLOJSOM_CALENDAR, dates);
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
