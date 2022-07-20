# How To - Wordpress - Skeleton [^1] [^2]

## Folder Structure Example

```
- THEME_NAME
    - header.php                                                                                                    // Header-Template
    - nav.php                                                                                                       // Navigation-Template
    - main.php                                                                                                      // Content-Template
    - sidebar.php                                                                                                   // Sidebar-Template
    - footer.php                                                                                                    // Footer-Template
    - front-page.php                                                                                                // Home-Page
    - index.php                                                                                                     // Standard-Page
    - 404.php                                                                                                       // 404-Page
    - search.php                                                                                                    // Search-Result-Page
    - searchform.php                                                                                                // Search-Form-Template
    - page.php                                                                                                      // Page-Template
    - single.php                                                                                                    // Blog-Entry-Template
    - comments.php                                                                                                  // Comments-Template
    - functions.php                                                                                                 // WordPress-Functions
    - style.css                                                                                                     // Default-Stylesheet
    - screenshot.png                                                                                                // Default-Screenshot
    - css
        - custom.css
    - js
        - custom.js
    - img
        - favicon.ico
        - logo.png
```

![Screenshot-17](/files/wordpress_structure.jpg)

## WordPress - Functions

### html - head

```
<?php language_attributes(); ?>                                                                                     <!-- Website-Language -->
<?php bloginfo('charset'); ?>                                                                                       <!-- Website-Charset -->
<?php echo get_bloginfo( 'template_directory' );?>                                                                  <!-- Path to Template-Folder --> 
<?php wp_head(); ?>                                                                                                 <!-- WordPress-Specific-Elements -->
<?php wp_footer(); ?>                                                                                               <!-- WordPress-Specific-Elements -->
```

### header

```
<?php bloginfo('name'); ?>                                                                                          <!-- Website-Name -->
<?php bloginfo('description'); ?>                                                                                   <!-- Website-Description -->
```

### nav

```
<?php get_breadcrumb(); ?>                                                                                          <!-- Breadcrumb-Navigation -->
<?php wp_nav_menu(array('theme_location' => 'REGISTER-NAME', 'container_id' => 'ID-NAME')); ?>                      <!-- Custom-Navigation () from functions.php (WITH container_id OR container_class) -->
```

### sidebar

```
<?php get_search_form(); ?>                                                                                         <!-- Includes searchform.php -->
```

### footer

```
<?php wp_list_categories('orderby=name&order=ASC&title_li='); ?>                                                    <!-- List of all Post-Categories -->
<?php wp_get_archives('type=monthly'); ?>                                                                           <!-- List the monthly Archive -->
<?php wp_list_pages('title_li=' . __('')); ?>                                                                       <!-- List all Pages -->
```

### search

```
<?php if (have_posts()) : ?>
    <?php echo $s ?>                                                                                                <!-- Print Search-Term -->  
    <?php $i=1; while (have_posts()) : the_post(); ?>                                                               <!-- Loop prints all Sites and Post including the Search-Term -->
        <?php the_title(); ?>                                                                                       <!-- Title of Site or Post -->
        <?php echo wp_trim_words(get_the_content(), 20); ?> <a href="<?php the_permalink(); ?>">MORE</a>            <!-- Trimmed (20) Content of Site or Post and Link -->
    <?php $i++; endwhile; ?>
<?php else : ?>
    <?php echo "SORYY" ?>                                                                                           <!-- If no match found -->
<?php endif; ?>
```

### searchform

```
<form class="search-menu" method="get" action="<?php echo esc_url( home_url( '/' ) ); ?>">                          <!-- Search-Form-Template -->
	<input type="text" placeholder="PLACEHOLDER" name="s" value="<?php echo get_search_query(); ?>">
	<button type="submit">SEARCH</button>
</form>
```

### page

```
<?php if (have_posts()) : while (have_posts()) : the_post(); ?>                                                     <!-- If Content exists then post -->
    <?php the_title(); ?>                                                                                           <!-- Page-Title -->
    <?php the_content(); ?>                                                                                         <!-- Page-Content -->
    <?php the_modified_date() ?>
<?php endwhile; endif; ?>
```

### single

```
<?php $the_query = new WP_Query( 'posts_per_page=20' ); ?>                                                          <!-- Show 20 Post per Page -->
<?php while ($the_query -> have_posts()) : $the_query -> the_post(); ?>                                             <!-- Loop through every Post -->
    <?php the_title(); ?>                                                                                           <!-- Post-Title -->
    <?php echo get_the_post_thumbnail(get_the_ID(), 'thumbnail'); ?>                                                <!-- Post-Thumbnail -->
    <?php echo wp_trim_words(get_the_content(), 10); ?> <a href="<?php the_permalink(); ?>">MORE</a>                <!-- Post-Content (10 words with link) -->
    <?php the_date('d.m.Y'); ?>                                                                                     <!-- Post-Date -->
    <?php the_category(', '); ?>                                                                                    <!-- Post-Category -->
<?php endwhile; wp_reset_postdata(); ?>
<?php comments_template(); ?>                                                                                       <!-- Includes comments.php -->
```

### comments

```
<form action="<?php echo get_option('siteurl'); ?>/wp-comments-post.php" method="post">                             <!-- Comment-Form-Template -->
	<label for="author">AUTHOR</label>                                                                          
	<input type="text" name="author" id="author" value="<?php echo $comment_author; ?>" size="20" tabindex="1">     <!-- Comment-Author-Name -->
	<label for="email">EMAIL</label>                                                                    
	<input type="text" name="email" id="email" value="<?php echo $comment_author_email; ?>" size="20" tabindex="2"> <!-- Comment-Author-EMail (not public) -->
	<label for="url">URL</label>                                                                        
	<input type="text" name="url" id="url" value="<?php echo $comment_author_url; ?>" size="20" tabindex="3">       <!-- Comment-Author-URL (not public) -->
	<label for="comment">COMMENT</label>                                                               
	<textarea name="comment" id="comment" rows="10" tabindex="4"></textarea>                                        <!-- Comment-Text -->
	<input name="submit" type="submit" id="submit" value="SUBMIT" tabindex="5">
	<input type="hidden" name="comment_post_ID" value="<?php echo $id; ?>">
	<?php do_action('comment_form', $post->ID); ?>
</form>

<?php foreach ($comments as $comment) : ?>                                                                          <!-- Loop prints all Comments to this Post-ID -->
    <div class="COMMENT" id="comment-<?php comment_ID() ?>">                                                        <!-- Comment-Template -->
        <?php comment_author_link() ?>                                                                              <!-- Comment-Author-Name -->
        <?php comment_date('j. F Y') ?>                                                                             <!-- Comment-Date -->
        <?php comment_time('H:i') ?>                                                                                <!-- Comment-Time -->
        <?php comment_text() ?>                                                                                     <!-- Comment-Text -->
        <?php if ($comment->comment_approved == '0') : ?>                                                           <!-- If no Comment found -->
            <?php echo "NO COMMENT" ?>
        <?php endif; ?>
    </div>
<?php endforeach; ?>
```

### functions

```
<?php 

	/* ********************* */
	/* Register Custom Theme */
	/* ********************* */

	if ( ! function_exists( 'myfirsttheme_setup' ) ) :

	function myfirsttheme_setup()
	{

		/* Make theme available for translation. Translations can be placed in the /languages/ directory. */
			 
		load_theme_textdomain( 'myfirsttheme', get_template_directory() . '/languages' );

		/* Add default posts and comments RSS feed links */
		 
		add_theme_support( 'automatic-feed-links' );

		/* Enable support for post thumbnails and featured images. */
		 
		add_theme_support( 'post-thumbnails' );

		/* Enable support for the following post formats: aside, gallery, quote, image, and video */
		
		add_theme_support( 'post-formats', array ( 'aside', 'gallery', 'quote', 'image', 'video' ) );
	}
	
	endif;

	
	add_action( 'after_setup_theme', 'myfirsttheme_setup' );

	/* ********************* */
	/* Register Custom Menus */
	/* ********************* */

	function wpb_main_menu()
	{
	  register_nav_menu('REGISTER-NAME',__( 'MENU-NAME' ));
	}
	
	add_action( 'init', 'wpb_main_menu' );	

	/* *********** */
	/* Breadcrumbs */
	/* *********** */

	function get_breadcrumb() 
	{
		echo '<a href="'.home_url().'" rel="nofollow">Home</a>';
						
		if (is_category() || is_single()) 
		{
			echo "&nbsp;&nbsp;&#187;&nbsp;&nbsp;";
			the_category(' &bull; ');
			
			if (is_single()) 
			{
				echo " &nbsp;&nbsp;&#187;&nbsp;&nbsp; ";
				the_title();
			}
		} 
		
		elseif (is_page()) 
		{
			echo "&nbsp;&nbsp;&#187;&nbsp;&nbsp;";
			echo the_title();
		} 
		
		elseif (is_search()) 
		{
			echo "&nbsp;&nbsp;&#187;&nbsp;&nbsp;Search Results for... ";
			echo '"<em>';
			echo the_search_query();
			echo '</em>"';
		}
	}

?>
```

## WordPress - Templates

- ### [Blog Example](/files/wordpress_blog.zip)
- ### [Blog & Sites Example](/files/wordpress_complex.zip)

[^1]: https://wphierarchy.com/
[^2]: https://www.rarst.net/wordpress/front-page-logic/