<aside>
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
</aside>