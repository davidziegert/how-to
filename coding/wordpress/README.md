# WORDPRESS

## Themes

### Classic Theme

#### Folder Structure

```
[WORDPRESS/WP-CONTENT/THEMES/THEMENAME]
├── assets
│   ├── css
│   ├── images
│   └── js
├── parts
│   ├── footer.php			// Footer Template-Part
│   ├── header.php			// Header Template-Part
│   ├── main.php			// Content Template-Part
│   ├── nav.php				// Navigation Template-Part
│   └── sidebar.php			// Sidebar Template-Part
├── 404.php					// 404 Page-Template
├── archive.php				// Archive Page-Template
├── author.php				// Author Page-Template
├── category.php			// Category Page-Template
├── comments.php		    // Comments Template-Part
├── front-page.php			// Static Front-Page-Template
├── functions.php			// WordPress-Functions
├── home.php				// Blog Home Page-Template
├── index.php				// Global Page-Template
├── page.php				// Site Page-Template
├── screenshot.png			// Default-Screenshot
├── search.php				// Search-Result Page-Template
├── searchform.php		    // Search-Form Template-Part
├── single.php				// Blog-Entry Page-Template
└── style.css				// Default-Stylesheet and Theme Information
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

##### TAG - html

```php
/* HTML lang global attribute */
<?php language_attributes(); ?>
```

##### TAG - head

```php
/* HEAD meta charset attribute */
<?php bloginfo('charset'); ?>

/* HEAD title tag */
<?php bloginfo('name'); ?>

/* HEAD meta author attribute */
<?php bloginfo('insert_author'); ?>

/* HEAD meta description attribute */
<?php bloginfo('insert_meta_description'); ?>

/* HEAD meta og:title" attribute */
<?php bloginfo('the_title'); ?>

/* HEAD meta og:description attribute */
<?php bloginfo('insert_meta_description'); ?>

/* HEAD meta og:image attribute */
<?php bloginfo('name'); ?>

/* HEAD meta og:url attribute */
<?php echo the_permalink(); ?>

/* link to theme folder directory */
<?php echo get_bloginfo('template_directory'); ?>

/* Wordpress specific elements */
<?php wp_head(); ?>
```

##### TAG - ?

```php
<?php
    /* Checks which Page is routed */
    switch (true) {
        case is_404():
        break;

        case is_search():
        break;

        case is_front_page():
        break;

        case is_home():
        break;

        case is_single():
        break;

        case is_page():
        break;

        case is_category():
        break;

        case is_author():
        break;

        case is_archive():
        break;

        default:
        break;
    }
?>
```

##### TAG - body (end)

```php
/* WordPress-Specific-Elements */
<?php wp_footer(); ?>
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

##### archive.php

```php
/* Link to Home-Page */
<?php echo home_url(); ?>
```

##### archive.php

```php
/* Archive Title */
<?php the_archive_title(); ?>

/* Archive Query */
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
    if (have_posts()) : while (have_posts()) : the_post();
        if (has_post_thumbnail()) {echo get_the_post_thumbnail(null, 'thumbnail');}
        the_title();
        the_excerpt();
        echo esc_url(get_permalink());
        echo esc_html(get_permalink());
    endwhile;
    endif;

    /* Pagination for Posts */
    if (function_exists('insert_blog_pagination')) {
        insert_blog_pagination('', 4);
    }

    wp_reset_postdata();
?>
```

##### author.php

```php
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

    echo $author_image;
    echo $author_username;
    echo $author_firstname;
    echo $author_lastname;
    echo $author_nickname;
    echo $author_displayname;
    echo esc_url($author_email);
    echo esc_html($author_email);
    echo esc_url($author_url);
    echo esc_html($author_url);
    echo $author_bio;
?>
```

##### category.php

```php
/* Category Title */
<?php the_archive_title(); ?>

/* Category Query */
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
    if (have_posts()) : while (have_posts()) : the_post();
        if (has_post_thumbnail()) {echo get_the_post_thumbnail(null, 'thumbnail');}
        the_title();
        the_excerpt();
        echo esc_url(get_permalink());
        echo esc_html(get_permalink());
    endwhile;
    endif;

    /* Pagination for Posts */
    if (function_exists('insert_blog_pagination')) {
        insert_blog_pagination('', 4);
    }

    wp_reset_postdata();
?>
```

##### front-page.php | index.php | page.php

```php
<?php
    if (have_posts()) : while (have_posts()) : the_post();
        the_title();
        the_content();
    endwhile;
    endif;
?>
```

##### home.php

```php
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
        'posts_per_page' => 4,
        'post_status' => 'publish',
    ));

    /* Loop through every Post */
    if (have_posts()) : while (have_posts()) : the_post();
        if (has_post_thumbnail()) {echo get_the_post_thumbnail(null, 'thumbnail');}
        the_title();
        the_excerpt();
        echo esc_url(get_permalink());
        echo esc_html(get_permalink());
    endwhile;
    endif;

    /* Pagination for Posts */
    if (function_exists('insert_blog_pagination')) {
        insert_blog_pagination('', 4);
    }

    wp_reset_postdata();
?>
```

##### single.php

```php
<?php
    /* Show this Post */
    if (have_posts()) : while (have_posts()) : the_post();
        the_title();
        the_content();
        echo esc_html(get_the_modified_date());
        echo esc_url(get_author_posts_url(get_the_author_meta('ID')));
        the_author();
        the_category(', ');
    endwhile;
    endif;

    /* Load comments.php */
    comments_template();
?>
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
            echo comment_ID();
            echo esc_html(get_comment_date('j. F Y', $comment));
            echo esc_html(get_comment_time('H:i', false, $comment));
            echo esc_url(get_comment_author_url($comment));
            echo esc_html(get_comment_author($comment));
            echo wp_kses_post(get_comment_text($comment));
        endforeach;
    endif;
?>
```

```html
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

##### searchform.php

```html
<!-- Search-Form-Template -->
<form class="search-menu" method="get" action="<?php echo esc_url(home_url('/')); ?>" role="search">
  <input type="search" id="search-field" name="s" value="<?php echo esc_attr(get_search_query()); ?>" placeholder="<?php esc_attr_e('...', 'textdomain'); ?>" required />
  <button type="submit" aria-label="<?php esc_attr_e('Submit search', 'textdomain'); ?>">Search</button>
</form>
```

##### search.php

```php
<?php
    if (have_posts()) :
    /* Print Search-Query */
    printf(esc_html__('Search Results for: %s', 'textdomain'), '<span>' . esc_html(get_search_query()) . '</span>');
    $i = 1;
    /* Print Search-Results */
    while (have_posts()) : the_post();
    echo the_ID();
    the_title();
    echo esc_html(wp_trim_words(wp_strip_all_tags(get_the_content()),20));
    echo esc_url(get_permalink());
    echo esc_html(get_permalink());
    $i++;
    endwhile;
    /* No Search-Results */
    else :
    esc_html_e('No results found.', 'textdomain');
    endif;
?>
```

##### sidebar.php

```php
    <?php
    /* List Categories */
    wp_list_categories(array(
        'orderby'  => 'name',
        'order'    => 'ASC',
        'title_li' => '',
    ));
    ?>

<?php
    /* Archive */
    wp_get_archives(array(
        'type' => 'yearly',
    ));
?>


<?php
    /* List Pages */
    wp_list_pages(array(
        'title_li' => '',
    ));
?>

<?php
    /* (CUSTOM FUNCTION) Link to a random Page */
    insert_random_link();
?>
```

##### nav.php

```php
<?php
    /* Load Menu */
    wp_nav_menu(array(
        'theme_location' => 'my-main-menu',
        'container'      => false,
        'menu_class'     => 'main-menu',
        'fallback_cb'    => false,
    ));
?>
```
