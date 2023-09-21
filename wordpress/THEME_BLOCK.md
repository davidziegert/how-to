# How To - Wordpress - Block/FSE Theme [^1] [^2] [^3] [^4]

## Folder Structure Example

```
theme
├── assets
│   ├── fonts
│   │   └── font.woff2
│   └── img
│       ├── favicon.ico
│       └── logo.png
├── parts
│   ├── header.html             // Header Template-Part                    
│   ├── nav.html                // Navigation Template-Part
│   ├── main.html               // Content Template-Part
│   ├── sidebar.html            // Sidebar Template-Part
│   ├── footer.html             // Footer Template-Part
│   ├── searchform.html         // Search-Form Template-Part
|   └── comments.html           // Comments Template-Part
├── templates
│   ├── front-page.html         // Home Page-Template
│   ├── 404.html                // 404 Page-Template
│   ├── page.html               // Site Page-Template
│   ├── search.html             // Search-Result Page-Template
│   ├── privacy-policy.html     // Disclaimer and Privacy Policy Page-Template
│   ├── index.html              // Blog Page-Template
│   ├── single.html             // Blog-Entry Page-Template
│   └── archive.html            // Blog-Archive Page-Template  
├── functions.php               // WordPress-Functions
├── screenshot.png              // Default-Screenshot
├── style.css                   // Default-Stylesheet and Theme Information
└── theme.json                  // Default-JSON with Stylesheets
```

## WordPress - Functions

### functions.php

```
<?php

    if ( ! function_exists( 'mytheme_styles' ) ) :
        function mytheme_styles() 
        {
            // Register theme stylesheet.
            $theme_version = wp_get_theme()->get( 'Version' );
            $version_string = is_string( $theme_version ) ? $theme_version : false;
            wp_register_style('mytheme-style', get_template_directory_uri() . '/style.css', array(), $version_string);  
                
            // Enqueue theme stylesheet.
            wp_enqueue_style( 'mytheme-style' );
        }

        add_action( 'wp_enqueue_scripts', 'mytheme_styles' );
    endif;

    if ( ! function_exists( 'mytheme_support' ) ) :
        function mytheme_support()  
        {
            // Adding support for core block visual styles.
            add_theme_support( 'wp-block-styles' );

            // Enqueue editor styles.
            add_editor_style( 'style.css' );
        }

        add_action( 'after_setup_theme', 'mytheme_support' );
    endif;
```

## WordPress - Parts Shortcodes

### header.html

```
<!-- wp:site-logo /-->
<!-- wp:site-title /-->
<!-- wp:site-tagline /-->
```

### nav.html

```
<!-- wp:navigation -->
	<!-- wp:page-list /-->
<!-- /wp:navigation -->
```

### main.html

```
<!-- wp:post-title /-->
<!-- wp:post-content /-->
```

### sidebar.html

```
<!-- wp:query {"queryId":0,"query":{"perPage":3,"pages":0,"offset":0,"postType":"post","order":"desc","orderBy":"date","author":"","search":"","exclude":[],"sticky":"","inherit":false,"parents":[]}} -->
	<!-- wp:post-template -->
		<!-- wp:post-featured-image {"isLink":true} /-->
		<!-- wp:post-title {"isLink":true} /-->
		<!-- wp:post-excerpt {"moreText":"read more","excerptLength":40} /-->
		<!-- wp:post-author {"showAvatar":false,"showBio":false} /-->
		<!-- wp:post-date /-->
		<!-- wp:post-terms {"term":"category"} /-->
	<!-- /wp:post-template -->
<!-- /wp:query -->
```

### footer.html

```

```

### searchform.html

```
<!-- wp:search {"label":"Search","showLabel":false,"buttonText":"Search","buttonUseIcon":true} /-->
```

### comments.html

```
<!-- wp:comments -->
	<!-- wp:comments-title /-->
	<!-- wp:comment-template -->
		<!-- wp:comment-author-name /-->
		<!-- wp:group -->
			<!-- wp:comment-date  /-->
			<!-- wp:comment-edit-link /-->
		<!-- /wp:group -->
		<!-- wp:comment-content /-->
		<!-- wp:comment-reply-link /-->
	<!-- /wp:comment-template -->
	<!-- wp:comments-pagination -->
		<!-- wp:comments-pagination-previous /-->
		<!-- wp:comments-pagination-numbers /-->
		<!-- wp:comments-pagination-next /-->
	<!-- /wp:comments-pagination -->
	<!-- wp:post-comments-form /-->
<!-- /wp:comments -->
```

## WordPress - Templates Shortcodes

### front-page.html

```
<!-- wp:template-part {"slug":"header"} /-->
<!-- wp:template-part {"slug":"nav"} /-->
<!-- wp:template-part {"slug":"searchform"} /-->
<!-- wp:template-part {"slug":"main"} /-->
<!-- wp:template-part {"slug":"sidebar"} /-->
<!-- wp:template-part {"slug":"footer"} /-->
```

### 404.html

```

```

### page.html

```
<!-- wp:template-part {"slug":"header"} /-->
<!-- wp:template-part {"slug":"nav"} /-->
<!-- wp:template-part {"slug":"searchform"} /-->
<!-- wp:template-part {"slug":"main"} /-->
<!-- wp:template-part {"slug":"sidebar"} /-->
<!-- wp:template-part {"slug":"footer"} /-->
```

### search.html

```
<!-- wp:query-title {"type":"search"} /-->
<!-- wp:query {"queryId":2,"query":{"perPage":5,"pages":0,"offset":0,"postType":"page","order":"desc","orderBy":"date","author":"","search":"","exclude":[],"sticky":"","inherit":false}} -->
	<!-- wp:post-template -->
		<!-- wp:post-title {"isLink":true} /-->
		<!-- wp:post-excerpt {"moreText":"read more","excerptLength":50} /-->
	<!-- /wp:post-template -->
	<!-- wp:query-pagination -->
		<!-- wp:query-pagination-previous /-->
		<!-- wp:query-pagination-numbers /-->
		<!-- wp:query-pagination-next /-->
	<!-- /wp:query-pagination -->
	<!-- wp:query-no-results -->
		<!-- wp:paragraph -->
		<p>Unfortunately, there is no match for your search terms. Please try again with other keywords.</p>
		<!-- /wp:paragraph -->
	<!-- /wp:query-no-results -->
<!-- /wp:query -->
```

### privacy-policy.html

```

```

### index.html

```
<!-- wp:query-title {"type":"search"} /-->
<!-- wp:query {"queryId":3,"query":{"perPage":10,"pages":0,"offset":0,"postType":"post","order":"desc","orderBy":"date","author":"","search":"","exclude":[],"sticky":"","inherit":false}} -->
	<!-- wp:post-template -->
		<!-- wp:post-featured-image {"isLink":true} /-->
		<!-- wp:post-title {"isLink":true} /-->
		<!-- wp:post-excerpt {"moreText":"read more","excerptLength":25} /-->
		<!-- wp:post-author {"showAvatar":false,"showBio":false} /-->
		<!-- wp:post-date /-->
		<!-- wp:post-terms {"term":"category"} /-->
	<!-- /wp:post-template -->
<!-- /wp:query -->
```

### single.html

```
<!-- wp:post-featured-image {"isLink":false} /-->
<!-- wp:post-title {"isLink":false} /-->
<!-- wp:post-content /-->
<!-- wp:post-author {"showAvatar":false,"showBio":false} /-->
<!-- wp:post-date /-->
<!-- wp:post-terms {"term":"category"} /-->
```

### archive.html

```
<!-- wp:query-title {"type":"search"} /-->
<!-- wp:query {"queryId":3,"query":{"perPage":1,"pages":0,"offset":0,"postType":"post","order":"desc","orderBy":"date","author":"","search":"","exclude":[],"sticky":"","inherit":false}} -->
	<!-- wp:post-template -->
		<!-- wp:post-title {"isLink":true} /-->
		<!-- wp:post-excerpt {"moreText":"read more","excerptLength":25} /-->
		<!-- wp:post-date /-->
	<!-- /wp:post-template -->
	<!-- wp:query-pagination -->
		<!-- wp:query-pagination-previous /-->
		<!-- wp:query-pagination-numbers /-->
		<!-- wp:query-pagination-next /-->
	<!-- /wp:query-pagination -->
<!-- /wp:query -->
```

## WordPress - Functions

### theme.json

```
{
	"$schema": "https://schemas.wp.org/trunk/theme.json",

	"settings": {
		"appearanceTools": true,
		"layout": {
			"contentSize": "",
			"wideSize": ""
		},
		"color": {
			"defaultPalette": false,
			"palette": [
				{
					"color": "#000000",
					"name": "Primary",
					"slug": "primary"
				},
				{
					"color": "#FFFFFF",
					"name": "Secondary",
					"slug": "secondary"
				},
				{
					"color": "#444444",
					"name": "Tertiary",
					"slug": "tertiary"
				}
			]
		},
        "typography": {
            "fluid": true,
            "fontSizes": [
                {
                    "size": "0.67rem",
                    "name": "Extra small",
                    "slug": "extra-small"
                },
                {
                    "size": "0.83rem",
                    "name": "Small",
                    "slug": "small"
                },
                {
                    "size": "1.0rem",
                    "name": "Medium",
                    "slug": "medium"
                },
                {
                    "size": "1.17rem",
                    "name": "Large",
                    "slug": "large"
                },
                {
                    "size": "1.5rem",
                    "name": "Extra large",
                    "slug": "x-large"
                },
                {
                    "size": "2rem",
                    "name": "Extra-Extra large",
                    "slug": "xx-large"
                }
            ],
            "fontFamilies": [
                {
                    "fontFamily": "-apple-system,BlinkMacSystemFont,\"Segoe UI\",Roboto,Oxygen-Sans,Ubuntu,Cantarell,\"Helvetica Neue\",sans-serif",
                    "slug": "system-fonts",
                    "name": "System Fonts"
                }
            ]
        },		
		"spacing": {
			"blockGap": null,
			"padding": false,
			"margin": false,
			"units": [
				"px",
				"em",
				"rem",
				"vh",
				"vw",
				"%"
			]
		},
		"useRootPaddingAwareAlignments": true
	},
	"styles": {
        "color": {
            "background": "var(--wp--preset--color--primary)",
            "text": "var(--wp--preset--color--secondary)"
        },
        "border": {
            "color": "none",
            "radius": "0",
            "style": "none",
            "width": "0"
        },
        "spacing": {
            "blockGap": "1rem",
            "margin": {
                "top": "1rem",
                "right": "1rem",
                "bottom": "1rem",
                "left": "1rem"
            },
            "padding": {
                "top": "1rem",
                "right": "1rem",
                "bottom": "1rem",
                "left": "1rem"
            }
        },
        "typography": {
            "fontFamily": "var(--wp--preset--font-family--system-fonts)",
            "fontSize": "var(--wp--preset--font-size--medium)",
            "fontStyle": "",
            "fontWeight": "",
            "letterSpacing": "",
            "lineHeight": "1.5",
            "textDecoration": "",
            "textTransform": ""
        },
        "blocks": {
            "core/archives": {},
            "core/audio": {},
            "core/avatar": {},
            "core/block": {},
            "core/button": {},
            "core/buttons": {},
            "core/calendar": {},
            "core/categories": {},
            "core/code": {},
            "core/column": {},
            "core/columns": {},
            "core/comment-author-name": {},
            "core/comment-content": {},
            "core/comment-date": {},
            "core/comment-edit-link": {},
            "core/comment-reply-link": {},
            "core/comments": {},
            "core/comments-pagination": {},
            "core/comments-pagination-next": {},
            "core/comments-pagination-numbers": {},
            "core/comments-pagination-previous": {},
            "core/comments-title": {},
            "core/comment-template": {},
            "core/cover": {},
            "core/details": {},
            "core/embed": {},
            "core/file": {},
            "core/footnotes": {},
            "core/freeform": {},
            "core/gallery": {},
            "core/group": {},
            "core/heading": {},
            "core/home-link": {},
            "core/html": {},
            "core/image": {},
            "core/latest-comments": {},
            "core/latest-posts": {},
            "core/legacy-widget": {},
            "core/list": {},
            "core/list-item": {},
            "core/loginout": {},
            "core/media-text": {},
            "core/missing": {},
            "core/more": {},
            "core/navigation": {},
            "core/navigation-link": {},
            "core/navigation-submenu": {},
            "core/nextpage": {},
            "core/page-list": {},
            "core/page-list-item": {},
            "core/paragraph": {},
            "core/pattern": {},
            "core/post-author": {},
            "core/post-author-biography": {},
            "core/post-author-name": {},
            "core/post-comments": {},
            "core/post-comments-form": {},
            "core/post-content": {},
            "core/post-date": {},
            "core/post-excerpt": {},
            "core/post-featured-image": {},
            "core/post-navigation-link": {},
            "core/post-template": {},
            "core/post-terms": {},
            "core/post-title": {},
            "core/preformatted": {},
            "core/pullquote": {},
            "core/query": {},
            "core/query-no-results": {},
            "core/query-pagination": {},
            "core/query-pagination-next": {},
            "core/query-pagination-numbers": {},
            "core/query-pagination-previous": {},
            "core/query-title": {},
            "core/quote": {},
            "core/read-more": {},
            "core/rss": {},
            "core/search": {},
            "core/separator": {},
            "core/shortcode": {},
            "core/site-logo": {},
            "core/site-tagline": {},
            "core/site-title": {},
            "core/social-link": {},
            "core/social-links": {},
            "core/spacer": {},
            "core/table": {},
            "core/tag-cloud": {},
            "core/template-part": {},
            "core/term-description": {},
            "core/text-columns": {},
            "core/verse": {},
            "core/video": {},
            "core/widget-group": {}
        },
        "elements": {
            "button": {},
            "caption": {},
            "cite": {},
            "h1": {},
            "h2": {},
            "h3": {},
            "h4": {},
            "h5": {},
            "h6": {},
            "heading": {},
            "link": {
                "color": {
                    "text": "var(--wp--preset--color--primary)"
                }
            }
        }
    },
	"templateParts": [
		{
			"area": "header",
			"name": "header",
			"title": "Header-Part"
		},
		{
			"area": "nav",
			"name": "nav",
			"title": "Navigation-Part"
		},
		{
			"area": "main",
			"name": "main",
			"title": "Main-Part"
		},
		{
			"area": "sidebar",
			"name": "sidebar",
			"title": "Aside-Part"
		},
		{
			"area": "footer",
			"name": "footer",
			"title": "Footer-Part"
		},
		{
			"area": "searchform",
			"name": "searchform",
			"title": "Search-Form-Part"
		},
		{
			"area": "comments",
			"name": "comments",
			"title": "Comments-Part"
		}
	],

	"version": 2
}
```

## WordPress - Themes

- ### [Blog Example](/files/wp_block_test.zip)