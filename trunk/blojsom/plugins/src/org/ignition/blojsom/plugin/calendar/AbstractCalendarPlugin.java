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

import javax.servlet.ServletConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

/**
 * AbstractCalendarPlugin is a base plugin that is used by the various calendar plugins to filter content
 * @author Mark Lussier
 * @version $Id: AbstractCalendarPlugin.java,v 1.2 2003-03-31 04:37:14 intabulas Exp $
 */
public class AbstractCalendarPlugin implements BlojsomPlugin {

    private Log _logger = LogFactory.getLog(AbstractCalendarPlugin.class);

    /**
     * Key under which the blog calendar will be placed
     * (example: on the request for the JSPDispatcher)
     */
    public static final String BLOJSOM_CALENDAR = "BLOJSOM_CALENDAR";

    /**
     * Key under which the blog calendar vtl helper will be placed
     * (example: on the request for the JSPDispatcher)
     */
    public static final String BLOJSOM_CALENDAR_VTLHELPER = "BLOJSOM_CALENDAR_VTLHELPER";

    /**
     * Format String for Calendar Month
     * (Example: March 2003)
     */
    public static final String BLOJSOM_CALENDAR_FORMAT = "MMMMM yyyy";

    /**
     * Short Format String for Previous/Next Calendar Month(s)
     * (Example: Mar)
     */
    public static final String BLOJSOM_CALENDAR_SHORTFORMAT = "MMM";

    /**
     * Locale to use for the Calendar.
     */
    protected Locale _locale = Locale.getDefault();

    /**
     * Blog Prefix URL used for Calender Hyperlinks
     */
    protected String _blogUrlPrefix;

    protected int _currentMonth;
    protected int _currentDay;
    protected int _currentYear;
    protected Calendar _calendar;
    protected String _requestedDateKey;


    /**
     * Initialize this plugin. This method only called when the plugin is instantiated.
     *
     * @param servletConfig Servlet config object for the plugin to retrieve any initialization parameters
     * @param blogProperties Read-only properties for the Blog
     * @throws org.ignition.blojsom.plugin.BlojsomPluginException If there is an error initializing the plugin
     */
    public void init(ServletConfig servletConfig, HashMap blogProperties) throws BlojsomPluginException {
        // If blog-language is set in blojsom.properties, use it instead
        String locale = (String) blogProperties.get(BlojsomConstants.BLOG_LANGUAGE_DEFAULT);

        // If no locale is configured, use the system default
        if (locale != null) {
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

        // Default to the Current Month and Year
        _calendar = new GregorianCalendar(_locale);
        _calendar.setTime(new Date());
        _currentMonth = _calendar.get(Calendar.MONTH);
        _currentYear = _calendar.get(Calendar.YEAR);
        _currentDay = _calendar.get(Calendar.DAY_OF_MONTH);

        // Determine a calendar-based request
        String year = null;
        String month = null;
        String day = null;


        year = httpServletRequest.getParameter(BlojsomConstants.YEAR_PARAM);
        if (year != null) {

            // Must be a 4 digit year
            if (year.length() != 4) {
                year = null;
            } else {
                try {
                    _currentYear = Integer.parseInt(year);
                    _calendar.set(Calendar.YEAR, _currentYear);
                } catch (NumberFormatException e) {
                    year = "";
                    _logger.error("Invalid Year Param submitted and ignored: " + year);
                }

                month = httpServletRequest.getParameter(BlojsomConstants.MONTH_PARAM);
                if (month == null) {
                    month = "";
                } else if (month.length() < 2) {
                    month = "0" + month;
                }
                if (!month.equals("")) {
                    try {
                        _currentMonth = Integer.parseInt(month) - 1; // Damm Sun!
                        _calendar.set(Calendar.MONTH, _currentMonth);
                    } catch (NumberFormatException e) {
                        month = "";
                        _logger.error("Invalid Month Param submitted and ignored: " + month);
                    }
                }
                day = httpServletRequest.getParameter(BlojsomConstants.DAY_PARAM);
                if (day == null) {
                    day = "";
                } else if (day.length() < 2) {
                    day = "0" + day;
                }

                if (!day.equals("")) {
                    try {
                        _currentDay = Integer.parseInt(day);
                        _calendar.set(Calendar.DAY_OF_MONTH, _currentDay);
                    } catch (NumberFormatException e) {
                        _logger.error("Invalid Day Param submitted and ignored: " + day);
                    }
                }


            }
            _requestedDateKey = year + month + day;
            _logger.info("Setting Filter Key = " + _requestedDateKey);

        } else {
            _requestedDateKey = null;
        }

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
