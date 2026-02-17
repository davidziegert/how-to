<!doctype html>
<html <?php language_attributes(); ?>>

<head>
    <meta charset="<?php bloginfo('charset'); ?>">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="robots" content="noindex, nofollow" />
    <meta name="mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-capable" content="yes" />

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

    <!-- Site Meta Tags -->
    <meta name="author" content="<?php insert_author(); ?>" />
    <meta name="description" content="<?php insert_meta_description(); ?>" />
    <meta name="keywords" content="" />

    <!-- Open Graph Meta Tags -->
    <meta property="og:title" content="<?php the_title(); ?>" />
    <meta property="og:description" content="<?php insert_meta_description(); ?>" />
    <meta property="og:image" content="<?php echo get_bloginfo('template_directory'); ?>/assets/images/opengraph.jpg" />
    <meta property="og:site_name" content="<?php bloginfo('name'); ?>" />
    <meta property="og:url" content="<?php echo the_permalink(); ?>" />

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