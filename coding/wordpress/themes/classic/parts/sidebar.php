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