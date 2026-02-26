# WORDPRESS

## Themes

### Classic Theme

#### Folder Structure

```
[WORDPRESS/WP-CONTENT/THEMES/THEMENAME]
├── assets
│   ├── css                 // Theme stylesheets
│   ├── images              // Theme images (logo, thumbnails, etc.)
│   └── js                  // JavaScript files
├── parts                   // Reusable template parts (optional custom structure)
│   ├── footer.php			// Footer template part
│   ├── header.php			// Header template part
│   ├── nav.php				// Navigation template part
│   └── sidebar.php			// Sidebar template part
├── 404.php					// 404 error template
├── archive.php				// Archive template (date, category, tag, etc.)
├── author.php				// Author archive template
├── category.php			// Category archive template
├── comments.php		    // Comments template (loaded via comments_template())
├── front-page.php			// Static front page template
├── functions.php			// Theme setup and custom functions
├── home.php				// Blog posts index template
├── index.php				// Fallback template (required)
├── page.php				// Static page template
├── screenshot.png			// Theme preview image (shown in admin)
├── search.php				// Search results template
├── searchform.php		    // Custom search form template
├── single.php				// Single post template
└── style.css				// Theme stylesheet + theme metadata (required)
```

#### Snippets

##### style.css

```css
/*
    Theme Name: [THEME-NAME]
    Theme URI: [THEME-URL]

    Author: The name of the individual or organization who developed the theme.
    Author URI: The URL of the author.

    Description: A short description of the theme.
    Version: The version, written in X.X or X.X.X format.
    Requires at least: The oldest main WordPress version supported, written in X.X format. 

    Tested up to: The last main WordPress version the theme has been tested up to, i.e. 6.4. Write only the number.
    Requires PHP: The oldest PHP version supported, in X.X format, only the number.

    License: The license of the theme.
    License URI: The URL of the theme license.
    
    Text Domain: The string used for textdomain for translation. The theme slug.
    Tags: one-column, custom-colors, custom-menu, custom-logo, editor-style, featured-images, block-patterns, rtl-language-support, sticky-post, threaded-comments, translation-ready, wide-blocks, block-styles, accessibility-ready, blog, portfolio, news
*/
```

##### functions.php

```php
<?php

/* *********** */
/* Theme Setup */
/* *********** */

if (!function_exists('my_theme_setup')) {
    function my_theme_setup()
    {
        // Translation support
        load_theme_textdomain('myfirsttheme', get_template_directory() . '/languages');

        // RSS feed links
        add_theme_support('automatic-feed-links');

        // Title tag
        add_theme_support('title-tag');

        // Featured images
        add_theme_support('post-thumbnails');

        // Supported post formats
        add_theme_support('post-formats', array('aside', 'gallery', 'quote', 'image', 'video'));

        // Register menus
        register_nav_menus(array(
            'my-main-menu' => __('Main Menu', 'myfirsttheme'),
            'my-lang-menu' => __('Language Menu', 'myfirsttheme'),
        ));
    }
}
add_action('after_setup_theme', 'my_theme_setup');

/* ******************** */
/* Breadcrumbs Function */
/* ******************** */

function insert_breadcrumbs()
{
    echo '<div class="breadcrumbs-tag">';
    echo '<a href="' . esc_url(home_url('/')) . '" rel="nofollow">' . esc_html__('Home', 'myfirsttheme') . '</a>';

    if (is_category() || is_single()) {
        echo ' &raquo; ';
        the_category(' &bull; ');

        if (is_single()) {
            echo ' &raquo; ';
            echo esc_html(get_the_title());
        }
    } elseif (is_page()) {
        echo ' &raquo; ';
        echo esc_html(get_the_title());
    } elseif (is_search()) {
        echo ' &raquo; ';
        printf(
            esc_html__('Search Results for: "%s"', 'myfirsttheme'),
            esc_html(get_search_query())
        );
    }

    echo '</div>';
}

/* **************** */
/* Random Page Link */
/* **************** */

function insert_random_link()
{
    $pages = get_pages();
    if ($pages) {
        $page = $pages[array_rand($pages)];
        echo '<li><a href="' . esc_url(get_permalink($page->ID)) . '">' . esc_html__('Random Page', 'myfirsttheme') . '</a></li>';
    }
}

/* ************************ */
/* Meta Description for SEO */
/* ************************ */

function insert_meta_description()
{
    $excerpt = get_the_excerpt();
    if (!$excerpt) {
        $excerpt = wp_trim_words(get_the_content(), 20);
    }
    echo esc_attr(strip_tags($excerpt));
}

/* ******************* */
/* Display Post Author */
/* ******************* */

function insert_author()
{
    if (have_posts()) {
        the_post();
        echo esc_html(get_the_author());
        rewind_posts(); // restore loop
    }
}

/* *************** */
/* Blog Pagination */
/* *************** */

function insert_blog_pagination($pages = '', $range = 2)
{
    global $paged, $wp_query;

    if (empty($paged)) $paged = 1;
    if ($pages == '') $pages = $wp_query->max_num_pages ?: 1;

    if ($pages > 1) {
        echo '<div class="post-pagination-tag">';
        echo '<span class="post-pagination">&#187;';

        $showitems = ($range * 2) + 1;

        for ($i = 1; $i <= $pages; $i++) {
            if (!($i >= $paged + $range + 1 || $i <= $paged - $range - 1) || $pages <= $showitems) {
                if ($i == $paged) {
                    echo '<span>' . esc_html($i) . '</span>';
                } else {
                    echo '<a href="' . esc_url(get_pagenum_link($i)) . '">' . esc_html($i) . '</a>';
                }
            }
        }

        echo '&#171;</span>';
        echo '<em>' . sprintf(esc_html__('Page %d of %d', 'myfirsttheme'), $paged, $pages) . '</em>';
        echo '</div>';
    }
}

/* ************** */
/* Excerpt Length */
/* ************** */

function my_excerpt_length($length)
{
    return 15;
}
add_filter('excerpt_length', 'my_excerpt_length', 999);

/* **************************** */
/* Block WP-JSON Users Endpoint */
/* **************************** */

add_filter('rest_endpoints', function ($endpoints) {
    unset($endpoints['/wp/v2/users'], $endpoints['/wp/v2/users/(?P<id>[\d]+)']);
    return $endpoints;
});
```

##### header.php

```php
<header>
    <div class="row">
        <div class="column">
            <div class="box-logo">
                <img class="header-logo" src="<?php echo get_bloginfo('template_directory'); ?>/assets/images/logo.svg" alt="image loading" loading="lazy" />
            </div>
            <div class="box-title">
                <span class="header-title"><?php bloginfo('name'); ?></span>
                <span class="header-subtitle"><?php bloginfo('description'); ?></span>
            </div>
        </div>
    </div>
</header>
```

##### nav.php

```php
<nav id="nav">
    <div class="row">
        <div class="column">
            <?php wp_nav_menu(array('theme_location' => 'my-main-menu', 'container_class' => 'main-menu')); ?>
        </div>
    </div>
</nav>
```

##### sidebar.php

```php
<aside>
    <div class="row">
        <div class="column">
            <div class="box-language">
                <!-- Menu-Languages -->
                <?php wp_nav_menu(array('theme_location' => 'my-lang-menu', 'container_class' => 'lang-menu')); ?>
            </div>
        </div>
        <div class="column">
            <div class="box-search">
                <!-- Searchform -->
                <?php get_search_form(); ?>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="column">
            <div class="box-breadcrumbs">
                <!-- Breadcrumb-Navigation -->
                <?php insert_breadcrumbs(); ?>
            </div>
        </div>
        <div class="column">
                <!-- Empty -->
        </div>
    </div>
</aside>
```

##### footer.php

```php
<footer>
    <div class="row">
        <div class="column">
            <div class="box-theme">
                <span class="footer-theme">Theme: wordpress - classic v.3</span>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="column">
            <h6>Categories:</h6>
            <div class="box-categories">
                <ul>
                    <!-- List Categories -->
                    <?php wp_list_categories('orderby=name&order=ASC&title_li='); ?>
                </ul>
            </div>
        </div>
        <div class="column">
            <h6>Archive:</h6>
            <div class="box-archives">
                <ul>
                    <!-- Archive -->
                    <?php wp_get_archives('type=yearly'); ?>
                </ul>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="column">
            <h6>Sites:</h6>
            <div class="box-sites">
                <ul>
                    <!-- List Sites -->
                    <?php wp_list_pages('title_li=' . __('')); ?>
                </ul>
            </div>
        </div>
        <div class="column">
            <h6>Links:</h6>
            <div class="box-links">
                <ul>
                    <!-- Link to Random Page -->
                    <?php insert_random_link(); ?>
                </ul>
            </div>
        </div>
    </div>
</footer>
```

##### 404.php

```php
<!doctype html>
<html <?php language_attributes(); ?>>

<head>
    <!-- Site Meta Tags -->
    <meta charset="<?php bloginfo('charset'); ?>">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="robots" content="noindex, nofollow" />
    <meta name="mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="author" content="<?php insert_author(); ?>" />
    <meta name="description" content="<?php insert_meta_description(); ?>" />
    <meta name="keywords" content="" />

    <!-- Open Graph Meta Tags -->
    <meta property="og:title" content="<?php the_title(); ?>" />
    <meta property="og:description" content="<?php insert_meta_description(); ?>" />
    <meta property="og:image" content="<?php echo get_bloginfo('template_directory'); ?>/assets/images/opengraph.jpg" />
    <meta property="og:site_name" content="<?php bloginfo('name'); ?>" />
    <meta property="og:url" content="<?php echo the_permalink(); ?>" />

    <!-- Title Tag -->
    <title>
        <?php
        /* Checks which Page is routed */
        switch (true) {
            case is_404():
                echo "404 - ";
                bloginfo('name');
                break;

            case is_search():
                echo "Search - ";
                bloginfo('name');
                break;

            case is_front_page():
                the_title();
                echo " - ";
                bloginfo('name');
                break;

            case is_home():
                echo "Latest Posts - ";
                bloginfo('name');
                break;

            case is_single():
                the_title();
                echo " - ";
                bloginfo('name');
                break;

            case is_page():
                the_title();
                echo " - ";
                bloginfo('name');
                break;

            case is_category():
                echo "Category - ";
                bloginfo('name');
                break;

            case is_author():
                echo "Author - ";
                bloginfo('name');
                break;

            case is_archive():
                echo "Archive - ";
                bloginfo('name');
                break;

            default:
                the_title();
                echo " - ";
                bloginfo('name');
                break;
        }
        ?>
    </title>

    <!-- FavIcons -->
    <link rel="shortcut icon" type="image/x-icon" href="<?php echo get_bloginfo('template_directory'); ?>/assets/images/favicon.svg" />
    <link rel="apple-touch-icon" href="<?php echo get_bloginfo('template_directory'); ?>/assets/images/favicon.svg" />

    <!-- Styles -->
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/print.css" media="print" />
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/reset.css" media="screen" />
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/skeleton.css" media="screen" />
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/style.css" media="screen" />
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/theme.css" media="screen" />

    <!-- Wordpress specific elements -->
    <?php wp_head(); ?>
</head>

<body>
    <div class="wrapper">
        <!-- Header -->
        <?php include_once "parts/header.php"; ?>

        <!-- Nav -->
        <?php include_once "parts/nav.php"; ?>

        <!-- Main -->
        <main>
            <div class="row">
                <div class="column">
                    <h1>404 - Error</h1>
                    <p>Sorry, but we can't find the page you are looking for.</p>
                    <a href="<?php echo home_url(); ?>" rel="nofollow">Go Back</a>
                </div>
            </div>
        </main>

        <!-- Aside -->
        <?php include_once "parts/sidebar.php"; ?>

        <!-- Footer -->
        <?php include_once "parts/footer.php"; ?>
    </div>

    <!-- WordPress-Specific-Elements -->
    <?php wp_footer(); ?>
</body>

</html>
```

##### archive.php

```php
<!doctype html>
<html <?php language_attributes(); ?>>

<head>
    <!-- Site Meta Tags -->
    <meta charset="<?php bloginfo('charset'); ?>">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="robots" content="noindex, nofollow" />
    <meta name="mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="author" content="<?php insert_author(); ?>" />
    <meta name="description" content="<?php insert_meta_description(); ?>" />
    <meta name="keywords" content="" />

    <!-- Open Graph Meta Tags -->
    <meta property="og:title" content="<?php the_title(); ?>" />
    <meta property="og:description" content="<?php insert_meta_description(); ?>" />
    <meta property="og:image" content="<?php echo get_bloginfo('template_directory'); ?>/assets/images/opengraph.jpg" />
    <meta property="og:site_name" content="<?php bloginfo('name'); ?>" />
    <meta property="og:url" content="<?php echo the_permalink(); ?>" />

    <!-- Title Tag -->
    <title>
        <?php
        /* Checks which Page is routed */
        switch (true) {
            case is_404():
                echo "404 - ";
                bloginfo('name');
                break;

            case is_search():
                echo "Search - ";
                bloginfo('name');
                break;

            case is_front_page():
                the_title();
                echo " - ";
                bloginfo('name');
                break;

            case is_home():
                echo "Latest Posts - ";
                bloginfo('name');
                break;

            case is_single():
                the_title();
                echo " - ";
                bloginfo('name');
                break;

            case is_page():
                the_title();
                echo " - ";
                bloginfo('name');
                break;

            case is_category():
                echo "Category - ";
                bloginfo('name');
                break;

            case is_author():
                echo "Author - ";
                bloginfo('name');
                break;

            case is_archive():
                echo "Archive - ";
                bloginfo('name');
                break;

            default:
                the_title();
                echo " - ";
                bloginfo('name');
                break;
        }
        ?>
    </title>

    <!-- FavIcons -->
    <link rel="shortcut icon" type="image/x-icon" href="<?php echo get_bloginfo('template_directory'); ?>/assets/images/favicon.svg" />
    <link rel="apple-touch-icon" href="<?php echo get_bloginfo('template_directory'); ?>/assets/images/favicon.svg" />

    <!-- Styles -->
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/print.css" media="print" />
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/reset.css" media="screen" />
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/skeleton.css" media="screen" />
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/style.css" media="screen" />
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/theme.css" media="screen" />

    <!-- Wordpress specific elements -->
    <?php wp_head(); ?>
</head>

<body>
    <div class="wrapper">
        <!-- Header -->
        <?php include_once "parts/header.php"; ?>

        <!-- Nav -->
        <?php include_once "parts/nav.php"; ?>

        <!-- Main -->
        <main>
            <div class="row">
                <div class="column">

                    <!-- Archive Title -->
                    <h1><?php the_archive_title(); ?></h1>

                    <!-- Archive Query -->
                    <?php
                    if (get_query_var('paged')) {
                        $paged = get_query_var('paged');
                    } elseif (get_query_var('page')) {
                        $paged = get_query_var('page');
                    } else {
                        $paged = 1;
                    }

                    /* Yearly/Monthly Date-Slug */
                    global $wp;
                    $my_slug = add_query_arg(array(), $wp->request);
                    $my_array = explode('/', $my_slug);
                    $my_year = $my_array[0];
                    $my_month = $my_array[1];

                    /* Show defined public Posts */
                    query_posts(array(
                        'post_type' => 'post',
                        'paged' => $paged,
                        'posts_per_page' => 4,
                        'post_status' => 'publish',
                        'year' => $my_year,
                        'monthnum' => $my_month,
                    ));

                    /* Loop through every Post */
                    if (have_posts()) :

                        echo '<div class="box-posts">';

                        while (have_posts()) : the_post();

                            echo '<div class="box-post-item">';

                            echo '<div class="item-left">';
                            if (has_post_thumbnail()) {
                                echo get_the_post_thumbnail(null, 'thumbnail');
                            }
                            echo '</div>';

                            echo '<div class="item-right">';
                            echo '<h2>';
                            the_title();
                            echo '</h2>';

                            the_excerpt();

                            echo '<a href="';
                            echo esc_url(get_permalink());
                            echo '">';
                            echo esc_html(get_permalink());
                            echo '</a>';
                            echo '</div>';

                            echo '</div>';

                        endwhile;

                        echo '</div>';
                    endif;

                    /* Pagination for Posts */
                    if (function_exists('insert_blog_pagination')) {
                        insert_blog_pagination('', 4);
                    }

                    wp_reset_postdata();
                    ?>

                </div>
            </div>
        </main>

        <!-- Aside -->
        <?php include_once "parts/sidebar.php"; ?>

        <!-- Footer -->
        <?php include_once "parts/footer.php"; ?>
    </div>

    <!-- WordPress-Specific-Elements -->
    <?php wp_footer(); ?>
</body>

</html>
```

##### author.php

```php
<!doctype html>
<html <?php language_attributes(); ?>>

<head>
    <!-- Site Meta Tags -->
    <meta charset="<?php bloginfo('charset'); ?>">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="robots" content="noindex, nofollow" />
    <meta name="mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="author" content="<?php insert_author(); ?>" />
    <meta name="description" content="<?php insert_meta_description(); ?>" />
    <meta name="keywords" content="" />

    <!-- Open Graph Meta Tags -->
    <meta property="og:title" content="<?php the_title(); ?>" />
    <meta property="og:description" content="<?php insert_meta_description(); ?>" />
    <meta property="og:image" content="<?php echo get_bloginfo('template_directory'); ?>/assets/images/opengraph.jpg" />
    <meta property="og:site_name" content="<?php bloginfo('name'); ?>" />
    <meta property="og:url" content="<?php echo the_permalink(); ?>" />

    <!-- Title Tag -->
    <title>
        <?php
        /* Checks which Page is routed */
        switch (true) {
            case is_404():
                echo "404 - ";
                bloginfo('name');
                break;

            case is_search():
                echo "Search - ";
                bloginfo('name');
                break;

            case is_front_page():
                the_title();
                echo " - ";
                bloginfo('name');
                break;

            case is_home():
                echo "Latest Posts - ";
                bloginfo('name');
                break;

            case is_single():
                the_title();
                echo " - ";
                bloginfo('name');
                break;

            case is_page():
                the_title();
                echo " - ";
                bloginfo('name');
                break;

            case is_category():
                echo "Category - ";
                bloginfo('name');
                break;

            case is_author():
                echo "Author - ";
                bloginfo('name');
                break;

            case is_archive():
                echo "Archive - ";
                bloginfo('name');
                break;

            default:
                the_title();
                echo " - ";
                bloginfo('name');
                break;
        }
        ?>
    </title>

    <!-- FavIcons -->
    <link rel="shortcut icon" type="image/x-icon" href="<?php echo get_bloginfo('template_directory'); ?>/assets/images/favicon.svg" />
    <link rel="apple-touch-icon" href="<?php echo get_bloginfo('template_directory'); ?>/assets/images/favicon.svg" />

    <!-- Styles -->
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/print.css" media="print" />
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/reset.css" media="screen" />
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/skeleton.css" media="screen" />
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/style.css" media="screen" />
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/theme.css" media="screen" />

    <!-- Wordpress specific elements -->
    <?php wp_head(); ?>
</head>

<body>
    <div class="wrapper">
        <!-- Header -->
        <?php include_once "parts/header.php"; ?>

        <!-- Nav -->
        <?php include_once "parts/nav.php"; ?>

        <!-- Main -->
        <main>
            <div class="row">
                <div class="column">

                    <h1>Author</h1>

                    <?php
                    /* Author Data */
                    $author_image = get_avatar(get_the_author_meta('ID'));
                    $author_username = get_the_author_meta('user_nicename');
                    $author_firstname = get_the_author_meta('first_name');
                    $author_lastname = get_the_author_meta('last_name');
                    $author_nickname = get_the_author_meta('nickname');
                    $author_displayname = get_the_author_meta('display_name');
                    $author_email = get_the_author_meta('user_email');
                    $author_url = get_the_author_meta('user_url');
                    $author_bio = get_the_author_meta('description');

                    echo '<div class="author-card">';
                    echo '<div class="author-card-left">';
                    echo $author_image;
                    echo '</div>';
                    echo '<div class="author-card-right">';
                    echo '<span>';
                    echo $author_nickname;
                    echo '</span>';

                    echo '<span>';
                    echo '<a href="';
                    echo esc_url($author_email);
                    echo '">';
                    echo esc_html($author_email);
                    echo '</a>';
                    echo '</span>';

                    echo '<span>';
                    echo '<a href="';
                    echo esc_url($author_url);
                    echo '">';
                    echo esc_html($author_url);
                    echo '</a>';
                    echo '</span>';

                    echo '<span>';
                    echo $author_bio;
                    echo '</span>';
                    echo '</div>';
                    echo '</div>';

                    ?>
                </div>
            </div>
        </main>

        <!-- Aside -->
        <?php include_once "parts/sidebar.php"; ?>

        <!-- Footer -->
        <?php include_once "parts/footer.php"; ?>
    </div>

    <!-- WordPress-Specific-Elements -->
    <?php wp_footer(); ?>
</body>

</html>
```

##### category.php

```php
<!doctype html>
<html <?php language_attributes(); ?>>

<head>
    <!-- Site Meta Tags -->
    <meta charset="<?php bloginfo('charset'); ?>">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="robots" content="noindex, nofollow" />
    <meta name="mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="author" content="<?php insert_author(); ?>" />
    <meta name="description" content="<?php insert_meta_description(); ?>" />
    <meta name="keywords" content="" />

    <!-- Open Graph Meta Tags -->
    <meta property="og:title" content="<?php the_title(); ?>" />
    <meta property="og:description" content="<?php insert_meta_description(); ?>" />
    <meta property="og:image" content="<?php echo get_bloginfo('template_directory'); ?>/assets/images/opengraph.jpg" />
    <meta property="og:site_name" content="<?php bloginfo('name'); ?>" />
    <meta property="og:url" content="<?php echo the_permalink(); ?>" />

    <!-- Title Tag -->
    <title>
        <?php
        /* Checks which Page is routed */
        switch (true) {
            case is_404():
                echo "404 - ";
                bloginfo('name');
                break;

            case is_search():
                echo "Search - ";
                bloginfo('name');
                break;

            case is_front_page():
                the_title();
                echo " - ";
                bloginfo('name');
                break;

            case is_home():
                echo "Latest Posts - ";
                bloginfo('name');
                break;

            case is_single():
                the_title();
                echo " - ";
                bloginfo('name');
                break;

            case is_page():
                the_title();
                echo " - ";
                bloginfo('name');
                break;

            case is_category():
                echo "Category - ";
                bloginfo('name');
                break;

            case is_author():
                echo "Author - ";
                bloginfo('name');
                break;

            case is_archive():
                echo "Archive - ";
                bloginfo('name');
                break;

            default:
                the_title();
                echo " - ";
                bloginfo('name');
                break;
        }
        ?>
    </title>

    <!-- FavIcons -->
    <link rel="shortcut icon" type="image/x-icon" href="<?php echo get_bloginfo('template_directory'); ?>/assets/images/favicon.svg" />
    <link rel="apple-touch-icon" href="<?php echo get_bloginfo('template_directory'); ?>/assets/images/favicon.svg" />

    <!-- Styles -->
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/print.css" media="print" />
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/reset.css" media="screen" />
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/skeleton.css" media="screen" />
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/style.css" media="screen" />
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/theme.css" media="screen" />

    <!-- Wordpress specific elements -->
    <?php wp_head(); ?>
</head>

<body>
    <div class="wrapper">
        <!-- Header -->
        <?php include_once "parts/header.php"; ?>

        <!-- Nav -->
        <?php include_once "parts/nav.php"; ?>

        <!-- Main -->
        <main>
            <div class="row">
                <div class="column">

                    <!-- Category Title -->
                    <h1><?php the_archive_title(); ?></h1>

                    <!-- Category Query -->
                    <?php
                    if (get_query_var('paged')) {
                        $paged = get_query_var('paged');
                    } elseif (get_query_var('page')) {
                        $paged = get_query_var('page');
                    } else {
                        $paged = 1;
                    }

                    /* Category-Slug */
                    $my_category_array = get_the_category();
                    $my_category_list = join(', ', wp_list_pluck($my_category_array, 'slug'));
                    $my_category = wp_kses_post($my_category_list);

                    /* Show defined public Posts */
                    query_posts(array(
                        'post_type' => 'post',
                        'paged' => $paged,
                        'posts_per_page' => 4,
                        'post_status' => 'publish',
                        'category_name' => $my_category,
                    ));

                    /* Loop through every Post */
                    if (have_posts()) :

                        echo '<div class="box-posts">';

                        while (have_posts()) : the_post();

                            echo '<div class="box-post-item">';

                            echo '<div class="item-left">';
                            if (has_post_thumbnail()) {
                                echo get_the_post_thumbnail(null, 'thumbnail');
                            }
                            echo '</div>';

                            echo '<div class="item-right">';
                            echo '<h2>';
                            the_title();
                            echo '</h2>';

                            the_excerpt();

                            echo '<a href="';
                            echo esc_url(get_permalink());
                            echo '">';
                            echo esc_html(get_permalink());
                            echo '</a>';
                            echo '</div>';

                            echo '</div>';

                        endwhile;

                        echo '</div>';
                    endif;

                    /* Pagination for Posts */
                    if (function_exists('insert_blog_pagination')) {
                        insert_blog_pagination('', 4);
                    }

                    wp_reset_postdata();
                    ?>

                </div>
            </div>
        </main>

        <!-- Aside -->
        <?php include_once "parts/sidebar.php"; ?>

        <!-- Footer -->
        <?php include_once "parts/footer.php"; ?>
    </div>

    <!-- WordPress-Specific-Elements -->
    <?php wp_footer(); ?>
</body>

</html>
```

##### comments.php

```php
<?php
/* Block comments.php from direct calling */
if (!defined('ABSPATH')) {
    exit;
}

/* Loop all Comments to this Post-ID */
$comments = get_comments(array(
    'status'  => 'approve',
    'post_id' => get_the_ID(),
));

/* Prints all Comments */
if ($comments):
    foreach ($comments as $comment):

        echo '<code>';
        echo '<ul>';
        echo '<li>';
        echo comment_ID();
        echo '</li>';
        echo '<li>';
        echo esc_html(get_comment_date('j. F Y', $comment));
        echo '</li>';
        echo '<li>';
        echo esc_html(get_comment_time('H:i', false, $comment));
        echo '</li>';
        echo '<li>';
        echo '<a href="';
        echo esc_url(get_comment_author_url($comment));
        echo '">';
        echo esc_html(get_comment_author($comment));
        echo '</a>';
        echo '</li>';
        echo '<li>';
        echo wp_kses_post(get_comment_text($comment));
        echo '</li>';
        echo '</ul>';
        echo '</code>';

    endforeach;
endif;
?>

<hr>

<?php if (comments_open()) : ?>
    <!-- Comment-Form-Template -->
    <form class="comment-form" action="<?php echo esc_url(site_url('/wp-comments-post.php')); ?>" method="post">
        <fieldset>
            <!-- Comment-Author-Name -->
            <label for="author">Author</label>
            <input type="text" name="author" id="author" size="20" tabindex="1" required />
            <!-- Comment-Author-EMail -->
            <label for="email">E-Mail</label>
            <input type="email" name="email" id="email" size="20" tabindex="2" required />
            <!-- Comment-Author-URL -->
            <label for="url">URL</label>
            <input type="url" name="url" id="url" size="20" tabindex="3" />
            <!-- Comment-Text -->
            <label for="comment">Comment</label>
            <textarea name="comment" id="comment" rows="10" tabindex="4" required></textarea>
            <?php comment_id_fields(); ?> <?php do_action('comment_form', get_the_ID()); ?>
            <input name="submit" type="submit" id="submit" value="Post" tabindex="5" />
        </fieldset>
    </form>
<?php endif; ?>
```

##### front-page.php

```php
<!doctype html>
<html <?php language_attributes(); ?>>

<head>
    <!-- Site Meta Tags -->
    <meta charset="<?php bloginfo('charset'); ?>">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="robots" content="noindex, nofollow" />
    <meta name="mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="author" content="<?php insert_author(); ?>" />
    <meta name="description" content="<?php insert_meta_description(); ?>" />
    <meta name="keywords" content="" />

    <!-- Open Graph Meta Tags -->
    <meta property="og:title" content="<?php the_title(); ?>" />
    <meta property="og:description" content="<?php insert_meta_description(); ?>" />
    <meta property="og:image" content="<?php echo get_bloginfo('template_directory'); ?>/assets/images/opengraph.jpg" />
    <meta property="og:site_name" content="<?php bloginfo('name'); ?>" />
    <meta property="og:url" content="<?php echo the_permalink(); ?>" />

    <!-- Title Tag -->
    <title>
        <?php
        /* Checks which Page is routed */
        switch (true) {
            case is_404():
                echo "404 - ";
                bloginfo('name');
                break;

            case is_search():
                echo "Search - ";
                bloginfo('name');
                break;

            case is_front_page():
                the_title();
                echo " - ";
                bloginfo('name');
                break;

            case is_home():
                echo "Latest Posts - ";
                bloginfo('name');
                break;

            case is_single():
                the_title();
                echo " - ";
                bloginfo('name');
                break;

            case is_page():
                the_title();
                echo " - ";
                bloginfo('name');
                break;

            case is_category():
                echo "Category - ";
                bloginfo('name');
                break;

            case is_author():
                echo "Author - ";
                bloginfo('name');
                break;

            case is_archive():
                echo "Archive - ";
                bloginfo('name');
                break;

            default:
                the_title();
                echo " - ";
                bloginfo('name');
                break;
        }
        ?>
    </title>

    <!-- FavIcons -->
    <link rel="shortcut icon" type="image/x-icon" href="<?php echo get_bloginfo('template_directory'); ?>/assets/images/favicon.svg" />
    <link rel="apple-touch-icon" href="<?php echo get_bloginfo('template_directory'); ?>/assets/images/favicon.svg" />

    <!-- Styles -->
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/print.css" media="print" />
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/reset.css" media="screen" />
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/skeleton.css" media="screen" />
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/style.css" media="screen" />
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/theme.css" media="screen" />

    <!-- Wordpress specific elements -->
    <?php wp_head(); ?>
</head>

<body>
    <div class="wrapper">
        <!-- Header -->
        <?php include_once "parts/header.php"; ?>

        <!-- Nav -->
        <?php include_once "parts/nav.php"; ?>

        <!-- Main -->
        <main>
            <div class="row hero">
                <div class="column">
                    <div class="box-hero">
                        <span class="hero-title">Hero</span>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="column">
                    <?php if (have_posts()) : while (have_posts()) : the_post(); ?>
                    <h1><?php the_title(); ?></h1>
                    <?php the_content(); ?>
                    <?php endwhile; endif; ?>
                </div>
            </div>
        </main>

        <!-- Aside -->
        <?php include_once "parts/sidebar.php"; ?>

        <!-- Footer -->
        <?php include_once "parts/footer.php"; ?>
    </div>

    <!-- WordPress-Specific-Elements -->
    <?php wp_footer(); ?>
</body>

</html>
```

##### home.php

```php
<!doctype html>
<html <?php language_attributes(); ?>>

<head>
    <!-- Site Meta Tags -->
    <meta charset="<?php bloginfo('charset'); ?>">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="robots" content="noindex, nofollow" />
    <meta name="mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="author" content="<?php insert_author(); ?>" />
    <meta name="description" content="<?php insert_meta_description(); ?>" />
    <meta name="keywords" content="" />

    <!-- Open Graph Meta Tags -->
    <meta property="og:title" content="<?php the_title(); ?>" />
    <meta property="og:description" content="<?php insert_meta_description(); ?>" />
    <meta property="og:image" content="<?php echo get_bloginfo('template_directory'); ?>/assets/images/opengraph.jpg" />
    <meta property="og:site_name" content="<?php bloginfo('name'); ?>" />
    <meta property="og:url" content="<?php echo the_permalink(); ?>" />

    <!-- Title Tag -->
    <title>
        <?php
        /* Checks which Page is routed */
        switch (true) {
            case is_404():
                echo "404 - ";
                bloginfo('name');
                break;

            case is_search():
                echo "Search - ";
                bloginfo('name');
                break;

            case is_front_page():
                the_title();
                echo " - ";
                bloginfo('name');
                break;

            case is_home():
                echo "Latest Posts - ";
                bloginfo('name');
                break;

            case is_single():
                the_title();
                echo " - ";
                bloginfo('name');
                break;

            case is_page():
                the_title();
                echo " - ";
                bloginfo('name');
                break;

            case is_category():
                echo "Category - ";
                bloginfo('name');
                break;

            case is_author():
                echo "Author - ";
                bloginfo('name');
                break;

            case is_archive():
                echo "Archive - ";
                bloginfo('name');
                break;

            default:
                the_title();
                echo " - ";
                bloginfo('name');
                break;
        }
        ?>
    </title>

    <!-- FavIcons -->
    <link rel="shortcut icon" type="image/x-icon" href="<?php echo get_bloginfo('template_directory'); ?>/assets/images/favicon.svg" />
    <link rel="apple-touch-icon" href="<?php echo get_bloginfo('template_directory'); ?>/assets/images/favicon.svg" />

    <!-- Styles -->
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/print.css" media="print" />
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/reset.css" media="screen" />
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/skeleton.css" media="screen" />
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/style.css" media="screen" />
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/theme.css" media="screen" />

    <!-- Wordpress specific elements -->
    <?php wp_head(); ?>
</head>

<body>
    <div class="wrapper">
        <!-- Header -->
        <?php include_once "parts/header.php"; ?>

        <!-- Nav -->
        <?php include_once "parts/nav.php"; ?>

        <!-- Main -->
        <main>
            <div class="row">
                <div class="column">

                    <h1>Latest Posts</h1>

                    <?php
                    if (get_query_var('paged')) {
                        $paged = get_query_var('paged');
                    } elseif (get_query_var('page')) {
                        $paged = get_query_var('page');
                    } else {
                        $paged = 1;
                    }

                    /* Show defined public Posts */
                    query_posts(array(
                        'post_type' => 'post',
                        'paged' => $paged,
                        'posts_per_page' => 3,
                        'post_status' => 'publish',
                    ));

                    /* Loop through every Post */
                    if (have_posts()) :

                        echo '<div class="box-blog">';

                        while (have_posts()) : the_post();

                            echo '<div class="blog-post-item">';
                            echo '<div class="post-image">';
                            if (has_post_thumbnail()) {
                                echo get_the_post_thumbnail(null, 'thumbnail');
                            }
                            echo '</div>';

                            echo '<div class="post-content">';
                            echo '<span class="post-title">';
                            the_title();
                            echo '</span>';

                            echo '<span class="post-date">';
                            echo get_the_modified_date();
                            echo '</span>';

                            echo '<div class="post-excerpt">';
                            the_excerpt();
                            echo '</div>';

                            echo '<a class="post-url" href="';
                            echo esc_url(get_permalink());
                            echo '">read more</a>';
                            echo '</div>';
                            echo '</div>';

                        endwhile;

                        echo '</div>';
                    endif;

                    /* Pagination for Posts */
                    if (function_exists('insert_blog_pagination')) {
                        insert_blog_pagination('', 3);
                    }

                    wp_reset_postdata();
                    ?>

                </div>
            </div>
        </main>

        <!-- Aside -->
        <?php include_once "parts/sidebar.php"; ?>

        <!-- Footer -->
        <?php include_once "parts/footer.php"; ?>
    </div>

    <!-- WordPress-Specific-Elements -->
    <?php wp_footer(); ?>
</body>

</html>
```

##### index.php | page.php

```php
<!doctype html>
<html <?php language_attributes(); ?>>

<head>
    <!-- Site Meta Tags -->
    <meta charset="<?php bloginfo('charset'); ?>">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="robots" content="noindex, nofollow" />
    <meta name="mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="author" content="<?php insert_author(); ?>" />
    <meta name="description" content="<?php insert_meta_description(); ?>" />
    <meta name="keywords" content="" />

    <!-- Open Graph Meta Tags -->
    <meta property="og:title" content="<?php the_title(); ?>" />
    <meta property="og:description" content="<?php insert_meta_description(); ?>" />
    <meta property="og:image" content="<?php echo get_bloginfo('template_directory'); ?>/assets/images/opengraph.jpg" />
    <meta property="og:site_name" content="<?php bloginfo('name'); ?>" />
    <meta property="og:url" content="<?php echo the_permalink(); ?>" />

    <!-- Title Tag -->
    <title>
        <?php
        /* Checks which Page is routed */
        switch (true) {
            case is_404():
                echo "404 - ";
                bloginfo('name');
                break;

            case is_search():
                echo "Search - ";
                bloginfo('name');
                break;

            case is_front_page():
                the_title();
                echo " - ";
                bloginfo('name');
                break;

            case is_home():
                echo "Latest Posts - ";
                bloginfo('name');
                break;

            case is_single():
                the_title();
                echo " - ";
                bloginfo('name');
                break;

            case is_page():
                the_title();
                echo " - ";
                bloginfo('name');
                break;

            case is_category():
                echo "Category - ";
                bloginfo('name');
                break;

            case is_author():
                echo "Author - ";
                bloginfo('name');
                break;

            case is_archive():
                echo "Archive - ";
                bloginfo('name');
                break;

            default:
                the_title();
                echo " - ";
                bloginfo('name');
                break;
        }
        ?>
    </title>

    <!-- FavIcons -->
    <link rel="shortcut icon" type="image/x-icon" href="<?php echo get_bloginfo('template_directory'); ?>/assets/images/favicon.svg" />
    <link rel="apple-touch-icon" href="<?php echo get_bloginfo('template_directory'); ?>/assets/images/favicon.svg" />

    <!-- Styles -->
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/print.css" media="print" />
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/reset.css" media="screen" />
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/skeleton.css" media="screen" />
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/style.css" media="screen" />
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/theme.css" media="screen" />

    <!-- Wordpress specific elements -->
    <?php wp_head(); ?>
</head>

<body>
    <div class="wrapper">
        <!-- Header -->
        <?php include_once "parts/header.php"; ?>

        <!-- Nav -->
        <?php include_once "parts/nav.php"; ?>

        <!-- Main -->
        <main>
            <div class="row">
                <div class="column">
                    <?php if (have_posts()) : while (have_posts()) : the_post(); ?>
                    <h1><?php the_title(); ?></h1>
                    <?php the_content(); ?>
                    <?php endwhile; endif; ?>
                </div>
            </div>
        </main>

        <!-- Aside -->
        <?php include_once "parts/sidebar.php"; ?>

        <!-- Footer -->
        <?php include_once "parts/footer.php"; ?>
    </div>

    <!-- WordPress-Specific-Elements -->
    <?php wp_footer(); ?>
</body>

</html>
```

##### search.php

```php
<!doctype html>
<html <?php language_attributes(); ?>>

<head>
    <!-- Site Meta Tags -->
    <meta charset="<?php bloginfo('charset'); ?>">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="robots" content="noindex, nofollow" />
    <meta name="mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="author" content="<?php insert_author(); ?>" />
    <meta name="description" content="<?php insert_meta_description(); ?>" />
    <meta name="keywords" content="" />

    <!-- Open Graph Meta Tags -->
    <meta property="og:title" content="<?php the_title(); ?>" />
    <meta property="og:description" content="<?php insert_meta_description(); ?>" />
    <meta property="og:image" content="<?php echo get_bloginfo('template_directory'); ?>/assets/images/opengraph.jpg" />
    <meta property="og:site_name" content="<?php bloginfo('name'); ?>" />
    <meta property="og:url" content="<?php echo the_permalink(); ?>" />

    <!-- Title Tag -->
    <title>
        <?php
        /* Checks which Page is routed */
        switch (true) {
            case is_404():
                echo "404 - ";
                bloginfo('name');
                break;

            case is_search():
                echo "Search - ";
                bloginfo('name');
                break;

            case is_front_page():
                the_title();
                echo " - ";
                bloginfo('name');
                break;

            case is_home():
                echo "Latest Posts - ";
                bloginfo('name');
                break;

            case is_single():
                the_title();
                echo " - ";
                bloginfo('name');
                break;

            case is_page():
                the_title();
                echo " - ";
                bloginfo('name');
                break;

            case is_category():
                echo "Category - ";
                bloginfo('name');
                break;

            case is_author():
                echo "Author - ";
                bloginfo('name');
                break;

            case is_archive():
                echo "Archive - ";
                bloginfo('name');
                break;

            default:
                the_title();
                echo " - ";
                bloginfo('name');
                break;
        }
        ?>
    </title>

    <!-- FavIcons -->
    <link rel="shortcut icon" type="image/x-icon" href="<?php echo get_bloginfo('template_directory'); ?>/assets/images/favicon.svg" />
    <link rel="apple-touch-icon" href="<?php echo get_bloginfo('template_directory'); ?>/assets/images/favicon.svg" />

    <!-- Styles -->
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/print.css" media="print" />
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/reset.css" media="screen" />
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/skeleton.css" media="screen" />
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/style.css" media="screen" />
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/theme.css" media="screen" />

    <!-- Wordpress specific elements -->
    <?php wp_head(); ?>
</head>

<body>
    <div class="wrapper">
        <!-- Header -->
        <?php include_once "parts/header.php"; ?>

        <!-- Nav -->
        <?php include_once "parts/nav.php"; ?>

        <!-- Main -->
        <main>
            <div class="row">
                <div class="column">

                    <?php
                    if (have_posts()) :
                        /* Print Search-Query */
                        echo '<h1>';
                        printf(esc_html__('Search Results for: %s', 'textdomain'), '<span>' . esc_html(get_search_query()) . '</span>');
                        echo '</h1>';
                        $i = 1;

                        /* Print Search-Results */
                        while (have_posts()) : the_post();

                            echo '<details>';
                            echo '<summary>';
                            echo the_ID();
                            echo ' - ';
                            the_title();
                            echo '</summary>';
                            echo '<p>';
                            echo esc_html(wp_trim_words(wp_strip_all_tags(get_the_content()), 20));
                            echo '</p>';
                            echo '<p><a href="';
                            echo esc_url(get_permalink());
                            echo '">';
                            echo esc_html(get_permalink());
                            echo '</a></p>';
                            echo '</details';

                            $i++;
                        endwhile;

                    /* No Search-Results */
                    else :
                        esc_html_e('No results found.', 'textdomain');
                    endif;
                    ?>

                </div>
            </div>
        </main>

        <!-- Aside -->
        <?php include_once "parts/sidebar.php"; ?>

        <!-- Footer -->
        <?php include_once "parts/footer.php"; ?>
    </div>

    <!-- WordPress-Specific-Elements -->
    <?php wp_footer(); ?>
</body>

</html>
```

##### searchform.php

```php
<!-- Search-Form-Template -->
<form class="search-menu" method="get" action="<?php echo esc_url(home_url('/')); ?>" role="search">
    <input type="search" id="search-field" name="s" value="<?php echo esc_attr(get_search_query()); ?>" placeholder="<?php esc_attr_e('...', 'textdomain'); ?>" required />
    <button type="submit" aria-label="<?php esc_attr_e('Submit search', 'textdomain'); ?>">Search</button>
</form>
```

##### single.php

```php
<!doctype html>
<html <?php language_attributes(); ?>>

<head>
    <!-- Site Meta Tags -->
    <meta charset="<?php bloginfo('charset'); ?>">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="robots" content="noindex, nofollow" />
    <meta name="mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="author" content="<?php insert_author(); ?>" />
    <meta name="description" content="<?php insert_meta_description(); ?>" />
    <meta name="keywords" content="" />

    <!-- Open Graph Meta Tags -->
    <meta property="og:title" content="<?php the_title(); ?>" />
    <meta property="og:description" content="<?php insert_meta_description(); ?>" />
    <meta property="og:image" content="<?php echo get_bloginfo('template_directory'); ?>/assets/images/opengraph.jpg" />
    <meta property="og:site_name" content="<?php bloginfo('name'); ?>" />
    <meta property="og:url" content="<?php echo the_permalink(); ?>" />

    <!-- Title Tag -->
    <title>
        <?php
        /* Checks which Page is routed */
        switch (true) {
            case is_404():
                echo "404 - ";
                bloginfo('name');
                break;

            case is_search():
                echo "Search - ";
                bloginfo('name');
                break;

            case is_front_page():
                the_title();
                echo " - ";
                bloginfo('name');
                break;

            case is_home():
                echo "Latest Posts - ";
                bloginfo('name');
                break;

            case is_single():
                the_title();
                echo " - ";
                bloginfo('name');
                break;

            case is_page():
                the_title();
                echo " - ";
                bloginfo('name');
                break;

            case is_category():
                echo "Category - ";
                bloginfo('name');
                break;

            case is_author():
                echo "Author - ";
                bloginfo('name');
                break;

            case is_archive():
                echo "Archive - ";
                bloginfo('name');
                break;

            default:
                the_title();
                echo " - ";
                bloginfo('name');
                break;
        }
        ?>
    </title>

    <!-- FavIcons -->
    <link rel="shortcut icon" type="image/x-icon" href="<?php echo get_bloginfo('template_directory'); ?>/assets/images/favicon.svg" />
    <link rel="apple-touch-icon" href="<?php echo get_bloginfo('template_directory'); ?>/assets/images/favicon.svg" />

    <!-- Styles -->
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/print.css" media="print" />
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/reset.css" media="screen" />
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/skeleton.css" media="screen" />
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/style.css" media="screen" />
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/theme.css" media="screen" />

    <!-- Wordpress specific elements -->
    <?php wp_head(); ?>
</head>

<body>
    <div class="wrapper">
        <!-- Header -->
        <?php include_once "parts/header.php"; ?>

        <!-- Nav -->
        <?php include_once "parts/nav.php"; ?>

        <!-- Main -->
        <main>
            <div class="row">
                <div class="column">

                    <?php
                    /* Show this Post */
                    if (have_posts()) : while (have_posts()) : the_post();

                            echo '<h1>';
                            the_title();
                            echo '</h1>';

                            echo '<article class="blog-article">';
                            echo '<div class="blog-article-left">';
                            if (has_post_thumbnail()) {
                                echo get_the_post_thumbnail(null, 'thumbnail');
                            }
                            echo '</div>';
                            echo '<div class="blog-article-right">';
                            the_content();
                            echo '</div>';
                            echo '</article>';

                            echo '<code>';
                            echo '<ul>';
                            echo '<li>';
                            echo esc_html(get_the_modified_date());
                            echo '</li>';
                            echo '<li>';
                            echo '<a href="';
                            echo esc_url(get_author_posts_url(get_the_author_meta('ID')));
                            echo '">';
                            the_author();
                            echo '</a>';
                            echo '</li>';
                            echo '<li>';
                            the_category(', ');
                            echo '</li>';
                            echo '</ul>';
                            echo '</code>';

                        endwhile;
                    endif;

                    /* Load comments.php */
                    comments_template();
                    ?>

                </div>
            </div>
        </main>

        <!-- Aside -->
        <?php include_once "parts/sidebar.php"; ?>

        <!-- Footer -->
        <?php include_once "parts/footer.php"; ?>
    </div>

    <!-- WordPress-Specific-Elements -->
    <?php wp_footer(); ?>
</body>

</html>
```

##### archive.php

```php
<!doctype html>
<html <?php language_attributes(); ?>>

<head>
    <!-- Site Meta Tags -->
    <meta charset="<?php bloginfo('charset'); ?>">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="robots" content="noindex, nofollow" />
    <meta name="mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="author" content="<?php insert_author(); ?>" />
    <meta name="description" content="<?php insert_meta_description(); ?>" />
    <meta name="keywords" content="" />

    <!-- Open Graph Meta Tags -->
    <meta property="og:title" content="<?php the_title(); ?>" />
    <meta property="og:description" content="<?php insert_meta_description(); ?>" />
    <meta property="og:image" content="<?php echo get_bloginfo('template_directory'); ?>/assets/images/opengraph.jpg" />
    <meta property="og:site_name" content="<?php bloginfo('name'); ?>" />
    <meta property="og:url" content="<?php echo the_permalink(); ?>" />

    <!-- Title Tag -->
    <title>
        <?php
        /* Checks which Page is routed */
        switch (true) {
            case is_404():
                echo "404 - ";
                bloginfo('name');
                break;

            case is_search():
                echo "Search - ";
                bloginfo('name');
                break;

            case is_front_page():
                the_title();
                echo " - ";
                bloginfo('name');
                break;

            case is_home():
                echo "Latest Posts - ";
                bloginfo('name');
                break;

            case is_single():
                the_title();
                echo " - ";
                bloginfo('name');
                break;

            case is_page():
                the_title();
                echo " - ";
                bloginfo('name');
                break;

            case is_category():
                echo "Category - ";
                bloginfo('name');
                break;

            case is_author():
                echo "Author - ";
                bloginfo('name');
                break;

            case is_archive():
                echo "Archive - ";
                bloginfo('name');
                break;

            default:
                the_title();
                echo " - ";
                bloginfo('name');
                break;
        }
        ?>
    </title>

    <!-- FavIcons -->
    <link rel="shortcut icon" type="image/x-icon" href="<?php echo get_bloginfo('template_directory'); ?>/assets/images/favicon.svg" />
    <link rel="apple-touch-icon" href="<?php echo get_bloginfo('template_directory'); ?>/assets/images/favicon.svg" />

    <!-- Styles -->
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/print.css" media="print" />
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/reset.css" media="screen" />
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/skeleton.css" media="screen" />
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/style.css" media="screen" />
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/theme.css" media="screen" />

    <!-- Wordpress specific elements -->
    <?php wp_head(); ?>
</head>

<body>
    <div class="wrapper">
        <!-- Header -->
        <?php include_once "parts/header.php"; ?>

        <!-- Nav -->
        <?php include_once "parts/nav.php"; ?>

        <!-- Main -->
        <main>
            <div class="row">
                <div class="column">

                    <!-- Archive Title -->
                    <h1><?php the_archive_title(); ?></h1>

                    <!-- Archive Query -->
                    <?php
                    if (get_query_var('paged')) {
                        $paged = get_query_var('paged');
                    } elseif (get_query_var('page')) {
                        $paged = get_query_var('page');
                    } else {
                        $paged = 1;
                    }

                    /* Yearly/Monthly Date-Slug */
                    global $wp;
                    $my_slug = add_query_arg(array(), $wp->request);
                    $my_array = explode('/', $my_slug);
                    $my_year = $my_array[0];
                    $my_month = $my_array[1];

                    /* Show defined public Posts */
                    query_posts(array(
                        'post_type' => 'post',
                        'paged' => $paged,
                        'posts_per_page' => 3,
                        'post_status' => 'publish',
                        'year' => $my_year,
                        'monthnum' => $my_month,
                    ));

                    /* Loop through every Post */
                    if (have_posts()) :

                        echo '<div class="box-blog">';

                        while (have_posts()) : the_post();

                            echo '<div class="blog-post-item">';
                            echo '<div class="post-image">';
                            if (has_post_thumbnail()) {
                                echo get_the_post_thumbnail(null, 'thumbnail');
                            }
                            echo '</div>';

                            echo '<div class="post-content">';
                            echo '<span class="post-title">';
                            the_title();
                            echo '</span>';

                            echo '<span class="post-date">';
                            echo get_the_modified_date();
                            echo '</span>';

                            echo '<div class="post-excerpt">';
                            the_excerpt();
                            echo '</div>';

                            echo '<a class="post-url" href="';
                            echo esc_url(get_permalink());
                            echo '">read more</a>';
                            echo '</div>';
                            echo '</div>';

                        endwhile;

                        echo '</div>';
                    endif;

                    /* Pagination for Posts */
                    if (function_exists('insert_blog_pagination')) {
                        insert_blog_pagination('', 3);
                    }

                    wp_reset_postdata();
                    ?>

                </div>
            </div>
        </main>

        <!-- Aside -->
        <?php include_once "parts/sidebar.php"; ?>

        <!-- Footer -->
        <?php include_once "parts/footer.php"; ?>
    </div>

    <!-- WordPress-Specific-Elements -->
    <?php wp_footer(); ?>
</body>

</html>
```

##### category.php

```php
<!doctype html>
<html <?php language_attributes(); ?>>

<head>
    <!-- Site Meta Tags -->
    <meta charset="<?php bloginfo('charset'); ?>">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="robots" content="noindex, nofollow" />
    <meta name="mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="author" content="<?php insert_author(); ?>" />
    <meta name="description" content="<?php insert_meta_description(); ?>" />
    <meta name="keywords" content="" />

    <!-- Open Graph Meta Tags -->
    <meta property="og:title" content="<?php the_title(); ?>" />
    <meta property="og:description" content="<?php insert_meta_description(); ?>" />
    <meta property="og:image" content="<?php echo get_bloginfo('template_directory'); ?>/assets/images/opengraph.jpg" />
    <meta property="og:site_name" content="<?php bloginfo('name'); ?>" />
    <meta property="og:url" content="<?php echo the_permalink(); ?>" />

    <!-- Title Tag -->
    <title>
        <?php
        /* Checks which Page is routed */
        switch (true) {
            case is_404():
                echo "404 - ";
                bloginfo('name');
                break;

            case is_search():
                echo "Search - ";
                bloginfo('name');
                break;

            case is_front_page():
                the_title();
                echo " - ";
                bloginfo('name');
                break;

            case is_home():
                echo "Latest Posts - ";
                bloginfo('name');
                break;

            case is_single():
                the_title();
                echo " - ";
                bloginfo('name');
                break;

            case is_page():
                the_title();
                echo " - ";
                bloginfo('name');
                break;

            case is_category():
                echo "Category - ";
                bloginfo('name');
                break;

            case is_author():
                echo "Author - ";
                bloginfo('name');
                break;

            case is_archive():
                echo "Archive - ";
                bloginfo('name');
                break;

            default:
                the_title();
                echo " - ";
                bloginfo('name');
                break;
        }
        ?>
    </title>

    <!-- FavIcons -->
    <link rel="shortcut icon" type="image/x-icon" href="<?php echo get_bloginfo('template_directory'); ?>/assets/images/favicon.svg" />
    <link rel="apple-touch-icon" href="<?php echo get_bloginfo('template_directory'); ?>/assets/images/favicon.svg" />

    <!-- Styles -->
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/print.css" media="print" />
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/reset.css" media="screen" />
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/skeleton.css" media="screen" />
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/style.css" media="screen" />
    <link rel="stylesheet" href="<?php echo get_bloginfo('template_directory'); ?>/assets/css/theme.css" media="screen" />

    <!-- Wordpress specific elements -->
    <?php wp_head(); ?>
</head>

<body>
    <div class="wrapper">
        <!-- Header -->
        <?php include_once "parts/header.php"; ?>

        <!-- Nav -->
        <?php include_once "parts/nav.php"; ?>

        <!-- Main -->
        <main>
            <div class="row">
                <div class="column">

                    <!-- Category Title -->
                    <h1><?php the_archive_title(); ?></h1>

                    <!-- Category Query -->
                    <?php
                    if (get_query_var('paged')) {
                        $paged = get_query_var('paged');
                    } elseif (get_query_var('page')) {
                        $paged = get_query_var('page');
                    } else {
                        $paged = 1;
                    }

                    /* Category-Slug */
                    $my_category_array = get_the_category();
                    $my_category_list = join(', ', wp_list_pluck($my_category_array, 'slug'));
                    $my_category = wp_kses_post($my_category_list);

                    /* Show defined public Posts */
                    query_posts(array(
                        'post_type' => 'post',
                        'paged' => $paged,
                        'posts_per_page' => 4,
                        'post_status' => 'publish',
                        'category_name' => $my_category,
                    ));

                    /* Loop through every Post */
                    if (have_posts()) :

                        echo '<div class="box-blog">';

                        while (have_posts()) : the_post();

                            echo '<div class="blog-post-item">';
                            echo '<div class="post-image">';
                            if (has_post_thumbnail()) {
                                echo get_the_post_thumbnail(null, 'thumbnail');
                            }
                            echo '</div>';

                            echo '<div class="post-content">';
                            echo '<span class="post-title">';
                            the_title();
                            echo '</span>';

                            echo '<span class="post-date">';
                            echo get_the_modified_date();
                            echo '</span>';

                            echo '<div class="post-excerpt">';
                            the_excerpt();
                            echo '</div>';

                            echo '<a class="post-url" href="';
                            echo esc_url(get_permalink());
                            echo '">read more</a>';
                            echo '</div>';
                            echo '</div>';

                        endwhile;

                        echo '</div>';
                    endif;

                    /* Pagination for Posts */
                    if (function_exists('insert_blog_pagination')) {
                        insert_blog_pagination('', 3);
                    }

                    wp_reset_postdata();
                    ?>

                </div>
            </div>
        </main>

        <!-- Aside -->
        <?php include_once "parts/sidebar.php"; ?>

        <!-- Footer -->
        <?php include_once "parts/footer.php"; ?>
    </div>

    <!-- WordPress-Specific-Elements -->
    <?php wp_footer(); ?>
</body>

</html>
```
