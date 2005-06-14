/**
 * Copyright (c) 2003-2005, David A. Czarnecki
 * All rights reserved.
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
package org.blojsom.plugin.admin;

import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.blojsom.blog.BlogEntry;
import org.blojsom.blog.BlogUser;
import org.blojsom.blog.BlojsomConfiguration;
import org.blojsom.event.BlojsomEvent;
import org.blojsom.event.BlojsomListener;
import org.blojsom.plugin.BlojsomPlugin;
import org.blojsom.plugin.BlojsomPluginException;
import org.blojsom.plugin.admin.event.ProcessRequestEvent;
import org.blojsom.util.BlojsomUtils;

import javax.servlet.ServletConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

/**
 *
 */
public class ThemeUploadPlugin implements BlojsomPlugin, BlojsomListener {

    private static final String THEME_UPLOAD_TEMPLATE = "org/blojsom/plugin/admin/templates/admin-theme-upload.vm";
    private Log _logger = LogFactory.getLog(ThemeUploadPlugin.class);

    private String _resourcesDirectory;
    private String _templatesDirectory;
    private String _installationDirectory;
    private String _baseConfigurationDirectory;
    private String _themesDirectory = "/themes";

    /**
     *
     */
    public ThemeUploadPlugin() {
    }

    /**
     * Initialize this plugin. This method only called when the plugin is instantiated.
     *
     * @param servletConfig        Servlet config object for the plugin to retrieve any initialization parameters
     * @param blojsomConfiguration {@link org.blojsom.blog.BlojsomConfiguration} information
     * @throws org.blojsom.plugin.BlojsomPluginException
     *          If there is an error initializing the plugin
     */
    public void init(ServletConfig servletConfig, BlojsomConfiguration blojsomConfiguration) throws BlojsomPluginException {
        _resourcesDirectory = BlojsomUtils.removeInitialSlash(blojsomConfiguration.getResourceDirectory());
        _templatesDirectory = BlojsomUtils.removeInitialSlash(blojsomConfiguration.getTemplatesDirectory());

        _installationDirectory = blojsomConfiguration.getInstallationDirectory();
        _baseConfigurationDirectory = blojsomConfiguration.getBaseConfigurationDirectory();

        blojsomConfiguration.getEventBroadcaster().addListener(this);
    }

    /**
     * Process the blog entries
     *
     * @param httpServletRequest  Request
     * @param httpServletResponse Response
     * @param user                {@link org.blojsom.blog.BlogUser} instance
     * @param context             Context
     * @param entries             Blog entries retrieved for the particular request
     * @return Modified set of blog entries
     * @throws org.blojsom.plugin.BlojsomPluginException
     *          If there is an error processing the blog entries
     */
    public BlogEntry[] process(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, BlogUser user, Map context, BlogEntry[] entries) throws BlojsomPluginException {
        return entries;
    }

    /**
     * Perform any cleanup for the plugin. Called after {@link #process}.
     *
     * @throws org.blojsom.plugin.BlojsomPluginException
     *          If there is an error performing cleanup for this plugin
     */
    public void cleanup() throws BlojsomPluginException {

    }

    /**
     * Called when BlojsomServlet is taken out of service
     *
     * @throws org.blojsom.plugin.BlojsomPluginException
     *          If there is an error in finalizing this plugin
     */
    public void destroy() throws BlojsomPluginException {

    }

    /**
     * Handle an event broadcast from another component
     *
     * @param event {@link org.blojsom.event.BlojsomEvent} to be handled
     */
    public void handleEvent(BlojsomEvent event) {

    }

    /**
     * Process an event from another component
     *
     * @param event {@link org.blojsom.event.BlojsomEvent} to be handled
     * @since blojsom 2.24
     */
    public void processEvent(BlojsomEvent event) {
        if (event instanceof ProcessRequestEvent) {
            ProcessRequestEvent requestEvent = (ProcessRequestEvent) event;

            Map templateAdditions = (Map) requestEvent.getContext().get("BLOJSOM_TEMPLATE_ADDITIONS");
            if (templateAdditions == null) {
                templateAdditions = new TreeMap();
            }

            templateAdditions.put(getClass().getName(), "#parse('" + THEME_UPLOAD_TEMPLATE + "')");
            requestEvent.getContext().put("BLOJSOM_TEMPLATE_ADDITIONS", templateAdditions);


            // Create a new disk file upload and set its parameters
            DiskFileUpload diskFileUpload = new DiskFileUpload();
            diskFileUpload.setRepositoryPath("/tmp");
            diskFileUpload.setSizeThreshold(300000);
            diskFileUpload.setSizeMax(2000000);

            try {
                List items = diskFileUpload.parseRequest(requestEvent.getHttpServletRequest());
                Iterator itemsIterator = items.iterator();
                while (itemsIterator.hasNext()) {
                    FileItem item = (FileItem) itemsIterator.next();

                    // Check for the file upload form item
                    if (!item.isFormField()) {
                        String itemNameWithoutPath = BlojsomUtils.getFilenameFromPath(item.getName());

                        if (itemNameWithoutPath.endsWith(".zip")) {
                            _logger.debug("Found file item: " + itemNameWithoutPath + " of type: " + item.getContentType());

                            try {
                                ZipInputStream zipInputStream = new ZipInputStream(item.getInputStream());
                                ZipEntry zipEntry;
                                String themeName = BlojsomUtils.getFilename(item.getName());

                                while ((zipEntry = zipInputStream.getNextEntry()) != null) {
                                    if (zipEntry.isDirectory()) {
                                        continue;
                                    } else {
                                        String zipItemName = zipEntry.getName();
                                        if (zipItemName.startsWith(_resourcesDirectory)) {
                                            _logger.debug(createThemeOutputFilename(themeName, zipItemName, true, requestEvent.getBlogUser().getId()));
                                        } else if (zipItemName.startsWith(_templatesDirectory)) {
                                            _logger.debug(createThemeOutputFilename(themeName, zipItemName, false, requestEvent.getBlogUser().getId()));
                                        } else {
                                            _logger.debug("Ignoring non-resources or templates file: " + zipEntry.getName());
                                        }
                                    }
                                }
                            } catch (IOException e) {
                                _logger.error(e);
                            }
                        } else {
                            _logger.debug("Theme .ZIP file not a recognized with a .zip extension");
                        }
                    }
                }
            } catch (FileUploadException e) {
                _logger.error(e);
            }


        }
    }

    /**
     *
     * @param theme
     * @param file
     * @param resource
     * @param blogID
     * @return
     */
    protected String createThemeOutputFilename(String theme, String file, boolean resource, String blogID) {
        String outputFilename;

        outputFilename = _installationDirectory;
        if (resource) {
            outputFilename += _resourcesDirectory + "/" + blogID + "/" + file;
        } else {
            outputFilename += _baseConfigurationDirectory + "/" + _themesDirectory + "/" + theme + "/" + file;
        }

        return outputFilename;
    }
}