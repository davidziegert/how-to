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