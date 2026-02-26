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
