<header>
    <div class="row">
        <div class="column">
            <div class="box-logo">
                <img class="header-logo" src="<?php echo get_bloginfo('template_directory'); ?>/assets/images/favicon.svg" alt="image loading" loading="lazy" />
            </div>
            <div class="box-title">
                <span class="header-title"><?php bloginfo('name'); ?></span>
                <span class="header-subtitle"><?php bloginfo('description'); ?></span>
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
            <div class="box-search">
                <!-- Searchform -->
                <?php get_search_form(); ?>
            </div>
        </div>
    </div>
</header>