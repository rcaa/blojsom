if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[category_blog_blogidfk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [dbo].[Category] DROP CONSTRAINT category_blog_blogidfk

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[comment_blog_blogidfk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [dbo].[Comment] DROP CONSTRAINT comment_blog_blogidfk

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[user_blog_blogidfk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [dbo].[DBUser] DROP CONSTRAINT user_blog_blogidfk

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[entry_blog_blogidfk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [dbo].[Entry] DROP CONSTRAINT entry_blog_blogidfk

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[pingback_blog_blogidfk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [dbo].[Pingback] DROP CONSTRAINT pingback_blog_blogidfk

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[plugin_blog_blogidfk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [dbo].[Plugin] DROP CONSTRAINT plugin_blog_blogidfk

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[properties_blog_blogidfk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [dbo].[Properties] DROP CONSTRAINT properties_blog_blogidfk

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[template_blog_blogidfk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [dbo].[Template] DROP CONSTRAINT template_blog_blogidfk

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[trackback_blog_blogidfk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [dbo].[Trackback] DROP CONSTRAINT trackback_blog_blogidfk

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[categorymetadata_category_categoryidfk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [dbo].[CategoryMetadata] DROP CONSTRAINT categorymetadata_category_categoryidfk

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[entry_category_categoryidfk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [dbo].[Entry] DROP CONSTRAINT entry_category_categoryidfk

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[commentmetadata_comment_commentidfk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [dbo].[CommentMetadata] DROP CONSTRAINT commentmetadata_comment_commentidfk

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[usermetadata_user_useridfk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [dbo].[DBUserMetadata] DROP CONSTRAINT usermetadata_user_useridfk

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[entrymetadata_entry_entryidfk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [dbo].[EntryMetadata] DROP CONSTRAINT entrymetadata_entry_entryidfk

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[pingbackmetadata_pingback_pingbackidfk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [dbo].[PingbackMetadata] DROP CONSTRAINT pingbackmetadata_pingback_pingbackidfk

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[trackbackmetadata_trackback_trackbackidfk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [dbo].[TrackbackMetadata] DROP CONSTRAINT trackbackmetadata_trackback_trackbackidfk

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Blog]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [dbo].[Blog]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Category]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [dbo].[Category]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CategoryMetadata]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [dbo].[CategoryMetadata]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Comment]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [dbo].[Comment]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CommentMetadata]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [dbo].[CommentMetadata]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DBUser]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [dbo].[DBUser]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DBUserMetadata]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [dbo].[DBUserMetadata]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Entry]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [dbo].[Entry]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[EntryMetadata]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [dbo].[EntryMetadata]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Pingback]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [dbo].[Pingback]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[PingbackMetadata]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [dbo].[PingbackMetadata]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Plugin]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [dbo].[Plugin]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Properties]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [dbo].[Properties]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Template]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [dbo].[Template]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Trackback]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [dbo].[Trackback]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TrackbackMetadata]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [dbo].[TrackbackMetadata]

GO



CREATE TABLE [dbo].[Blog] (

	[id] [int] IDENTITY (1, 1) NOT NULL ,

	[blog_id] [nvarchar] (50)  NOT NULL 

) ON [PRIMARY]

GO



SET IDENTITY_INSERT Blog ON

GO

INSERT INTO Blog ([id], [blog_id]) VALUES (1, 'default');

SET IDENTITY_INSERT Blog OFF

GO



CREATE TABLE [dbo].[Category] (

	[category_id] [int] IDENTITY (1, 1) NOT NULL ,

	[blog_id] [int] NOT NULL ,

	[parent_category_id] [int] NULL ,

	[name] [nvarchar] (255)  NOT NULL ,

	[description] [nvarchar] (3700)  NULL 

) ON [PRIMARY]

GO



SET IDENTITY_INSERT Category ON

GO

INSERT INTO Category ([category_id], [blog_id], [parent_category_id], [name], [description]) VALUES (1,1,NULL,'/uncategorized/','Uncategorized');

SET IDENTITY_INSERT Category OFF

GO



CREATE TABLE [dbo].[CategoryMetadata] (

	[category_metadata_id] [int] IDENTITY (1, 1) NOT NULL ,

	[category_id] [int] NOT NULL ,

	[metadata_key] [nvarchar] (255)  NOT NULL ,

	[metadata_value] [text]  NULL 

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



CREATE TABLE [dbo].[Comment] (

	[comment_id] [int] IDENTITY (1, 1) NOT NULL ,

	[entry_id] [int] NOT NULL ,

	[author] [nvarchar] (75)  NULL ,

	[author_url] [varchar] (255)  NULL ,

	[author_email] [varchar] (50)  NULL ,

	[comment] [ntext]  NULL ,

	[date] [datetime] NOT NULL ,

	[ip] [varchar] (100)  NULL ,

	[status] [nvarchar] (255)  NULL ,

	[comment_parent] [int] NULL ,

	[blog_id] [int] NOT NULL 

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



CREATE TABLE [dbo].[CommentMetadata] (

	[comment_metadata_id] [int] IDENTITY (1, 1) NOT NULL ,

	[comment_id] [int] NOT NULL ,

	[metadata_key] [nvarchar] (255)  NOT NULL ,

	[metadata_value] [ntext]  NULL 

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



CREATE TABLE [dbo].[DBUser] (

	[user_id] [int] IDENTITY (1, 1) NOT NULL ,

	[user_login] [nvarchar] (50)  NOT NULL ,

	[user_password] [nvarchar] (64)  NOT NULL ,

	[user_name] [nvarchar] (250)  NOT NULL ,

	[user_email] [varchar] (100)  NOT NULL ,

	[user_registered] [datetime] NOT NULL ,

	[user_status] [nvarchar] (64)  NOT NULL ,

	[blog_id] [int] NOT NULL 

) ON [PRIMARY]

GO



SET IDENTITY_INSERT DBUser ON

GO

INSERT INTO DBUser (user_id, user_login, user_password, user_name, user_email, user_registered, user_status, blog_id) VALUES (1,'default','default','Default User','default_owner@email.com',getdate(),'',1);

SET IDENTITY_INSERT DBUser OFF

GO



CREATE TABLE [dbo].[DBUserMetadata] (

	[user_metadata_id] [int] IDENTITY (1, 1) NOT NULL ,

	[user_id] [int] NOT NULL ,

	[metadata_key] [nvarchar] (255)  NOT NULL ,

	[metadata_value] [ntext]  NULL 

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



SET IDENTITY_INSERT DBUserMetadata ON

GO

INSERT INTO DBUserMetadata (user_metadata_id, user_id, metadata_key, metadata_value) VALUES (1,1,'all_permissions_permission','true');

SET IDENTITY_INSERT DBUserMetadata OFF

GO



CREATE TABLE [dbo].[Entry] (

	[entry_id] [int] IDENTITY (1, 1) NOT NULL ,

	[blog_id] [int] NOT NULL ,

	[title] [nvarchar] (255)  NULL ,

	[description] [ntext]  NULL ,

	[entry_date] [datetime] NOT NULL ,

	[blog_category_id] [int] NOT NULL ,

	[status] [nvarchar] (100)  NULL ,

	[author] [nvarchar] (75)  NULL ,

	[allow_comments] [int] NULL ,

	[allow_trackbacks] [int] NULL ,

	[allow_pingbacks] [int] NULL ,

	[post_slug] [nvarchar] (255)  NOT NULL ,

	[modified_date] [datetime] NOT NULL 

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



CREATE TABLE [dbo].[EntryMetadata] (

	[entry_metadata_id] [int] IDENTITY (1, 1) NOT NULL ,

	[entry_id] [int] NOT NULL ,

	[metadata_key] [nvarchar] (255)  NOT NULL ,

	[metadata_value] [ntext]  NULL 

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



CREATE TABLE [dbo].[Pingback] (

	[pingback_id] [int] IDENTITY (1, 1) NOT NULL ,

	[entry_id] [int] NOT NULL ,

	[title] [nvarchar] (255)  NULL ,

	[excerpt] [nvarchar] (500)  NULL ,

	[url] [varchar] (255)  NULL ,

	[blog_name] [nvarchar] (255)  NULL ,

	[trackback_date] [datetime] NOT NULL ,

	[blog_id] [int] NOT NULL ,

	[ip] [varchar] (100)  NULL ,

	[status] [nvarchar] (255)  NULL ,

	[source_uri] [nvarchar] (255)  NOT NULL ,

	[target_uri] [nvarchar] (255)  NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [dbo].[PingbackMetadata] (

	[pingback_metadata_id] [int] IDENTITY (1, 1) NOT NULL ,

	[pingback_id] [int] NOT NULL ,

	[metadata_key] [nvarchar] (255)  NOT NULL ,

	[metadata_value] [ntext]  NULL 

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



CREATE TABLE [dbo].[Plugin] (

	[plugin_id] [int] IDENTITY (1, 1) NOT NULL ,

	[blog_id] [int] NOT NULL ,

	[plugin_flavor] [nvarchar] (50)  NOT NULL ,

	[plugin_value] [nvarchar] (3950)  NULL 

) ON [PRIMARY]

GO



SET IDENTITY_INSERT Plugin ON

GO

INSERT INTO Plugin ([plugin_id], [blog_id], [plugin_flavor], [plugin_value]) VALUES (1,1,'html','meta, tag-cloud, date-format, referer-log, calendar-gui, calendar-filter, comment, trackback, simple-search, emoticons, macro-expansion, days-since-posted, word-count, simple-obfuscation, nofollow, rss-enclosure, technorati-tags');

INSERT INTO Plugin ([plugin_id], [blog_id], [plugin_flavor], [plugin_value]) VALUES (2,1,'default','conditional-get, meta, nofollow, rss-enclosure');

INSERT INTO Plugin ([plugin_id], [blog_id], [plugin_flavor], [plugin_value]) VALUES (3,1,'admin','admin');

SET IDENTITY_INSERT Plugin OFF

Go



CREATE TABLE [dbo].[Properties] (

	[property_id] [int] IDENTITY (1, 1) NOT NULL ,

	[blog_id] [int] NOT NULL ,

	[property_name] [nvarchar] (255)  NOT NULL ,

	[property_value] [nvarchar] (255)  NULL 

) ON [PRIMARY]

GO



SET IDENTITY_INSERT Properties ON

GO

INSERT INTO Properties ([property_id], [blog_id], [property_name], [property_value]) VALUES (1,1,'blog-url','/blojsom/blog/default');

INSERT INTO Properties ([property_id], [blog_id], [property_name], [property_value]) VALUES (2,1,'blog-admin-url','/blojsom/blog/default');

INSERT INTO Properties ([property_id], [blog_id], [property_name], [property_value]) VALUES (3,1,'blog-base-url','/blojsom');

INSERT INTO Properties ([property_id], [blog_id], [property_name], [property_value]) VALUES (4,1,'blog-base-admin-url','/blojsom');

INSERT INTO Properties ([property_id], [blog_id], [property_name], [property_value]) VALUES (5,1,'blog-language','en');

INSERT INTO Properties ([property_id], [blog_id], [property_name], [property_value]) VALUES (6,1,'blog-name','NAME YOUR BLOG');

INSERT INTO Properties ([property_id], [blog_id], [property_name], [property_value]) VALUES (7,1,'blog-description','DESCRIBE YOUR BLOG');

INSERT INTO Properties ([property_id], [blog_id], [property_name], [property_value]) VALUES (8,1,'blog-entries-display','15');

INSERT INTO Properties ([property_id], [blog_id], [property_name], [property_value]) VALUES (9,1,'blog-owner','Default Owner');

INSERT INTO Properties ([property_id], [blog_id], [property_name], [property_value]) VALUES (10,1,'blog-owner-email','default_owner@email.com');

INSERT INTO Properties ([property_id], [blog_id], [property_name], [property_value]) VALUES (11,1,'blog-comments-enabled','true');

INSERT INTO Properties ([property_id], [blog_id], [property_name], [property_value]) VALUES (12,1,'blog-trackbacks-enabled','true');

INSERT INTO Properties ([property_id], [blog_id], [property_name], [property_value]) VALUES (13,1,'blog-email-enabled','true');

INSERT INTO Properties ([property_id], [blog_id], [property_name], [property_value]) VALUES (14,1,'blog-default-flavor','html');

INSERT INTO Properties ([property_id], [blog_id], [property_name], [property_value]) VALUES (15,1,'plugin-comment-autoformat','true');

INSERT INTO Properties ([property_id], [blog_id], [property_name], [property_value]) VALUES (16,1,'linear-navigation-enabled','true');

INSERT INTO Properties ([property_id], [blog_id], [property_name], [property_value]) VALUES (17,1,'comment-moderation-enabled','true');

INSERT INTO Properties ([property_id], [blog_id], [property_name], [property_value]) VALUES (18,1,'trackback-moderation-enabled','true');

INSERT INTO Properties ([property_id], [blog_id], [property_name], [property_value]) VALUES (19,1,'blog-ping-urls','http://rpc.pingomatic.com');

INSERT INTO Properties ([property_id], [blog_id], [property_name], [property_value]) VALUES (20,1,'blojsom-extension-metaweblog-accepted-types','image/jpeg, image/gif, image/png, img');

INSERT INTO Properties ([property_id], [blog_id], [property_name], [property_value]) VALUES (21,1,'xmlrpc-enabled','true');

INSERT INTO Properties ([property_id], [blog_id], [property_name], [property_value]) VALUES (22,1,'blog-pingbacks-enabled','true');

SET IDENTITY_INSERT Properties OFF

GO



CREATE TABLE [dbo].[Template] (

	[template_id] [int] IDENTITY (1, 1) NOT NULL ,

	[blog_id] [int] NOT NULL ,

	[template_flavor] [nvarchar] (50)  NOT NULL ,

	[template_value] [nvarchar] (255)  NULL 

) ON [PRIMARY]

GO



SET IDENTITY_INSERT Template ON

GO

INSERT INTO Template ([template_id], [blog_id], [template_flavor], [template_value]) VALUES (1,1,'rss','rss.vm, text/xml;charset=UTF-8');

INSERT INTO Template ([template_id], [blog_id], [template_flavor], [template_value]) VALUES (2,1,'rsd','rsd.vm, application/rsd+xml;charset=UTF-8');

INSERT INTO Template ([template_id], [blog_id], [template_flavor], [template_value]) VALUES (3,1,'html','asual.vm, text/html;charset=UTF-8');

INSERT INTO Template ([template_id], [blog_id], [template_flavor], [template_value]) VALUES (4,1,'atom','atom.vm, application/atom+xml;charset=UTF-8');

INSERT INTO Template ([template_id], [blog_id], [template_flavor], [template_value]) VALUES (5,1,'rss2','rss2.vm, text/xml;charset=UTF-8');

INSERT INTO Template ([template_id], [blog_id], [template_flavor], [template_value]) VALUES (6,1,'rdf','rdf.vm, text/xml;charset=UTF-8');

INSERT INTO Template ([template_id], [blog_id], [template_flavor], [template_value]) VALUES (7,1,'admin','org/blojsom/plugin/admin/templates/admin.vm, text/html;charset=UTF-8');

SET IDENTITY_INSERT Template OFF

GO



CREATE TABLE [dbo].[Trackback] (

	[trackback_id] [int] IDENTITY (1, 1) NOT NULL ,

	[entry_id] [int] NOT NULL ,

	[title] [nvarchar] (255)  NULL ,

	[excerpt] [nvarchar] (500)  NULL ,

	[url] [varchar] (255)  NULL ,

	[blog_name] [nvarchar] (255)  NULL ,

	[trackback_date] [datetime] NOT NULL ,

	[blog_id] [int] NOT NULL ,

	[ip] [varchar] (100)  NULL ,

	[status] [nvarchar] (255)  NULL 

) ON [PRIMARY]

GO



CREATE TABLE [dbo].[TrackbackMetadata] (

	[trackback_metadata_id] [int] IDENTITY (1, 1) NOT NULL ,

	[trackback_id] [int] NOT NULL ,

	[metadata_key] [nvarchar] (255)  NOT NULL ,

	[metadata_value] [ntext]  NULL 

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



ALTER TABLE [dbo].[Blog] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [dbo].[Category] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[category_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [dbo].[CategoryMetadata] WITH NOCHECK ADD 

	CONSTRAINT [PK_CategoryMetadata] PRIMARY KEY  CLUSTERED 

	(

		[category_metadata_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [dbo].[Comment] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[comment_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [dbo].[CommentMetadata] WITH NOCHECK ADD 

	CONSTRAINT [PK_CommentMetadata] PRIMARY KEY  CLUSTERED 

	(

		[comment_metadata_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [dbo].[DBUser] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[user_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [dbo].[DBUserMetadata] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[user_metadata_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [dbo].[Entry] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[entry_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [dbo].[EntryMetadata] WITH NOCHECK ADD 

	CONSTRAINT [PK_EntryMetadata] PRIMARY KEY  CLUSTERED 

	(

		[entry_metadata_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [dbo].[Pingback] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[pingback_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [dbo].[PingbackMetadata] WITH NOCHECK ADD 

	CONSTRAINT [PK_PingbackMetadata] PRIMARY KEY  CLUSTERED 

	(

		[pingback_metadata_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [dbo].[Plugin] WITH NOCHECK ADD 

	CONSTRAINT [PK_Plugin] PRIMARY KEY  CLUSTERED 

	(

		[plugin_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [dbo].[Properties] WITH NOCHECK ADD 

	CONSTRAINT [PK_Properties] PRIMARY KEY  CLUSTERED 

	(

		[property_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [dbo].[Template] WITH NOCHECK ADD 

	CONSTRAINT [PK_Template] PRIMARY KEY  CLUSTERED 

	(

		[template_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [dbo].[Trackback] WITH NOCHECK ADD 

	 PRIMARY KEY  CLUSTERED 

	(

		[trackback_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [dbo].[TrackbackMetadata] WITH NOCHECK ADD 

	CONSTRAINT [PK_TrackbackMetadata] PRIMARY KEY  CLUSTERED 

	(

		[trackback_metadata_id]

	)  ON [PRIMARY] 

GO



ALTER TABLE [dbo].[Category] WITH NOCHECK ADD 

	CONSTRAINT [DF__Category__parent__5D95E53A] DEFAULT (null) FOR [parent_category_id]

GO



ALTER TABLE [dbo].[Comment] WITH NOCHECK ADD 

	CONSTRAINT [DF__Comment__ip__634EBE90] DEFAULT (null) FOR [ip],

	CONSTRAINT [DF__Comment__status__6442E2C9] DEFAULT (null) FOR [status],

	CONSTRAINT [DF__Comment__comment__65370702] DEFAULT (null) FOR [comment_parent]

GO



ALTER TABLE [dbo].[Entry] WITH NOCHECK ADD 

	CONSTRAINT [DF__Entry__allow_com__6AEFE058] DEFAULT ('1') FOR [allow_comments],

	CONSTRAINT [DF__Entry__allow_tra__6BE40491] DEFAULT ('1') FOR [allow_trackbacks],

	CONSTRAINT [DF__Entry__allow_pin__6CD828CA] DEFAULT ('1') FOR [allow_pingbacks]

GO



ALTER TABLE [dbo].[Pingback] WITH NOCHECK ADD 

	CONSTRAINT [DF__Pingback__ip__73852659] DEFAULT (null) FOR [ip],

	CONSTRAINT [DF__Pingback__status__74794A92] DEFAULT (null) FOR [status]

GO



ALTER TABLE [dbo].[Plugin] WITH NOCHECK ADD 

	CONSTRAINT [DF__Plugin__plugin_v__793DFFAF] DEFAULT (null) FOR [plugin_value]

GO



ALTER TABLE [dbo].[Template] WITH NOCHECK ADD 

	CONSTRAINT [DF__Template__templa__7E02B4CC] DEFAULT (null) FOR [template_value]

GO



ALTER TABLE [dbo].[Trackback] WITH NOCHECK ADD 

	CONSTRAINT [DF__Trackback__ip__01D345B0] DEFAULT (null) FOR [ip],

	CONSTRAINT [DF__Trackback__statu__02C769E9] DEFAULT (null) FOR [status]

GO



ALTER TABLE [dbo].[Category] ADD 

	CONSTRAINT [category_blog_blogidfk] FOREIGN KEY 

	(

		[blog_id]

	) REFERENCES [dbo].[Blog] (

		[id]

	) ON DELETE CASCADE 

GO



ALTER TABLE [dbo].[CategoryMetadata] ADD 

	CONSTRAINT [categorymetadata_category_categoryidfk] FOREIGN KEY 

	(

		[category_id]

	) REFERENCES [dbo].[Category] (

		[category_id]

	) ON DELETE CASCADE 

GO



ALTER TABLE [dbo].[Comment] ADD 

	CONSTRAINT [comment_blog_blogidfk] FOREIGN KEY 

	(

		[blog_id]

	) REFERENCES [dbo].[Blog] (

		[id]

	) ON DELETE CASCADE 

GO



ALTER TABLE [dbo].[CommentMetadata] ADD 

	CONSTRAINT [commentmetadata_comment_commentidfk] FOREIGN KEY 

	(

		[comment_id]

	) REFERENCES [dbo].[Comment] (

		[comment_id]

	) ON DELETE CASCADE 

GO



ALTER TABLE [dbo].[DBUser] ADD 

	CONSTRAINT [user_blog_blogidfk] FOREIGN KEY 

	(

		[blog_id]

	) REFERENCES [dbo].[Blog] (

		[id]

	) ON DELETE CASCADE 

GO



ALTER TABLE [dbo].[DBUserMetadata] ADD 

	CONSTRAINT [usermetadata_user_useridfk] FOREIGN KEY 

	(

		[user_id]

	) REFERENCES [dbo].[DBUser] (

		[user_id]

	) ON DELETE CASCADE 

GO



ALTER TABLE [dbo].[Entry] ADD 

	CONSTRAINT [entry_blog_blogidfk] FOREIGN KEY 

	(

		[blog_id]

	) REFERENCES [dbo].[Blog] (

		[id]

	) ON DELETE CASCADE ,

	CONSTRAINT [entry_category_categoryidfk] FOREIGN KEY 

	(

		[blog_category_id]

	) REFERENCES [dbo].[Category] (

		[category_id]

	)

GO



ALTER TABLE [dbo].[EntryMetadata] ADD 

	CONSTRAINT [entrymetadata_entry_entryidfk] FOREIGN KEY 

	(

		[entry_id]

	) REFERENCES [dbo].[Entry] (

		[entry_id]

	) ON DELETE CASCADE 

GO



ALTER TABLE [dbo].[Pingback] ADD 

	CONSTRAINT [pingback_blog_blogidfk] FOREIGN KEY 

	(

		[blog_id]

	) REFERENCES [dbo].[Blog] (

		[id]

	) ON DELETE CASCADE 

GO



ALTER TABLE [dbo].[PingbackMetadata] ADD 

	CONSTRAINT [pingbackmetadata_pingback_pingbackidfk] FOREIGN KEY 

	(

		[pingback_id]

	) REFERENCES [dbo].[Pingback] (

		[pingback_id]

	) ON DELETE CASCADE 

GO



ALTER TABLE [dbo].[Plugin] ADD 

	CONSTRAINT [plugin_blog_blogidfk] FOREIGN KEY 

	(

		[blog_id]

	) REFERENCES [dbo].[Blog] (

		[id]

	) ON DELETE CASCADE 

GO



ALTER TABLE [dbo].[Properties] ADD 

	CONSTRAINT [properties_blog_blogidfk] FOREIGN KEY 

	(

		[blog_id]

	) REFERENCES [dbo].[Blog] (

		[id]

	) ON DELETE CASCADE 

GO



ALTER TABLE [dbo].[Template] ADD 

	CONSTRAINT [template_blog_blogidfk] FOREIGN KEY 

	(

		[blog_id]

	) REFERENCES [dbo].[Blog] (

		[id]

	) ON DELETE CASCADE 

GO



ALTER TABLE [dbo].[Trackback] ADD 

	CONSTRAINT [trackback_blog_blogidfk] FOREIGN KEY 

	(

		[blog_id]

	) REFERENCES [dbo].[Blog] (

		[id]

	) ON DELETE CASCADE 

GO



ALTER TABLE [dbo].[TrackbackMetadata] ADD 

	CONSTRAINT [trackbackmetadata_trackback_trackbackidfk] FOREIGN KEY 

	(

		[trackback_id]

	) REFERENCES [dbo].[Trackback] (

		[trackback_id]

	) ON DELETE CASCADE 

GO



