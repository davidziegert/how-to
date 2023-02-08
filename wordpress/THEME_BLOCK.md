# How To - Wordpress - Block/FSE Theme [^1] [^2] [^3] [^4]

## Folder Structure Example

```
- THEME_NAME

    - functions.php         // WordPress-Functions
    - screenshot.png            // Default-Screenshot
    - style.css         // Default-Stylesheet and Theme Information
	- theme.json            // Default-JSON with Stylesheets

	- assets
        - img
            - favicon.ico
            - logo.png
        - fonts
            - font.woff2
    - parts
        - header.html           // Header Template-Part
        - nav.html          // Navigation Template-Part
        - main.html         // Content Template-Part
        - sidebar.html          // Sidebar Template-Part
        - footer.html           // Footer Template-Part
        - searchform.html           // Search-Form Template-Part
        - comments.html         // Comments Template-Part
    - templates
        - index.html            // Blog Page-Template
        - 404.html          // 404 Page-Template
        - front-page.html           // Home Page-Template
        - page.html         // Site Page-Template
        - single.html           // Blog-Entry Page-Template
        - search.html           // Search-Result Page-Template
        - privacy-policy.html           // Disclaimer and Privacy Policy Page-Template
        - archive.html          // Archive Page-Template
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

## WordPress - Shortcodes in Template-Parts

### header

```
<!-- wp:site-logo /-->

<!-- wp:site-title /-->

<!-- wp:site-tagline /-->
```

### nav

```
<!-- wp:navigation -->
<!-- wp:page-list /-->
<!-- /wp:navigation -->
```

### searchform

```
<!-- wp:search {"label":"Search","buttonText":"Search ..."} /-->
```

### main

```
<!-- wp:post-title /-->

<!-- wp:post-content /-->
```

### sidebar

```
    <!-- wp:post-title /-->
    <!-- wp:post-excerpt /-->
    <!-- wp:read-more /-->
```

### footer

```

```

### comments

```

```

## WordPress - Using Template-Parts in Templates

### front-page

```

```

### page

```
<!-- wp:template-part {"slug":"header","theme":"mytheme"} /-->

<!-- wp:template-part {"slug":"nav","theme":"mytheme"} /-->

<!-- wp:template-part {"slug":"searchform","theme":"mytheme"} /-->

<!-- wp:template-part {"slug":"main","theme":"mytheme"} /-->

<!-- wp:template-part {"slug":"sidebar","theme":"mytheme"} /-->

<!-- wp:template-part {"slug":"footer","theme":"mytheme"} /-->

<!-- wp:template-part {"slug":"comments","theme":"mytheme"} /-->
```

### index

```

```

### single

```
<!-- wp:post-featured-image /-->
<!-- wp:post-title /-->
<!-- wp:post-content /-->
<!-- wp:post-author /-->
<!-- wp:post-terms {"term":"category"} /-->
<!-- wp:post-date /-->                                                                                     
```

### search

```
<!-- wp:query-title {"type":"search"} /-->
```

### archive

```

```

### 404

```

```

## WordPress - Themes

- ### [Block-FSE Example](/files/wordpress_block-fse.zip)

---

[^1]: https://developer.wordpress.org/block-editor/how-to-guides/themes/block-theme-overview/
[^2]: https://fullsiteediting.com/courses/full-site-editing-for-theme-developers/
[^3]: https://github.com/WordPress/theme-experiments
[^4]: https://github.com/carolinan/fullsiteediting