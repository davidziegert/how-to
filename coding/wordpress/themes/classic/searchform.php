<!-- Search-Form-Template -->
<form class="search-menu" method="get" action="<?php echo esc_url(home_url('/')); ?>" role="search">
    <input type="search" id="search-field" name="s" value="<?php echo esc_attr(get_search_query()); ?>" placeholder="<?php esc_attr_e('...', 'textdomain'); ?>" required />
    <button type="submit" aria-label="<?php esc_attr_e('Submit search', 'textdomain'); ?>">Search</button>
</form>