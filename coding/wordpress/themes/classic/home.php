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