# How To - Wordpress - Theme [^1] [^2]

## Folder Structure Example

```
- THEME_NAME
    - header.php			// Header-Template
    - nav.php				// Navigation-Template
    - main.php				// Content-Template
    - sidebar.php			// Sidebar-Template
    - footer.php			// Footer-Template
    - front-page.php			// Home-Page
    - index.php				// Standard-Page
    - 404.php				// 404-Page
    - search.php			// Search-Result-Page
    - searchform.php			// Search-Form-Template
    - page.php				// Page-Template
    - single.php			// Blog-Entry-Template
    - comments.php			// Comments-Template
    - functions.php			// WordPress-Functions
    - style.css				// Default-Stylesheet
    - screenshot.png			// Default-Screenshot
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
<!-- Website-Language -->
<?php language_attributes(); ?>

<!-- Website-Charset -->
<?php bloginfo('charset'); ?>

<!-- Path to Template-Folder -->
<?php echo get_bloginfo( 'template_directory' );?>

<!-- WordPress-Specific-Elements -->
<?php wp_head(); ?>
<?php wp_footer(); ?>
```

### header

```
<!-- Website-Name -->
<?php bloginfo('name'); ?>

<!-- Website-Description -->
<?php bloginfo('description'); ?>
```

### nav

```
<!-- Breadcrumb-Navigation -->
<?php get_breadcrumb(); ?>

<!-- Custom-Navigation () from functions.php (WITH container_id OR container_class) -->
<?php wp_nav_menu(array('theme_location' => 'REGISTER-NAME', 'container_id' => 'ID-NAME')); ?>
```

### sidebar

```
<!-- Includes searchform.php -->
<?php get_search_form(); ?>
```

### footer

```
<!-- List of all Post-Categories -->
<?php wp_list_categories('orderby=name&order=ASC&title_li='); ?>

<!-- List the monthly Archive -->
<?php wp_get_archives('type=monthly'); ?>

 <!-- List all Pages -->
 <?php wp_list_pages('title_li=' . __('')); ?>
```

### search

```
<?php if (have_posts()) : ?>
	<!-- Print Search-Term -->
    <?php echo $s ?>
	<!-- Loop prints all Sites and Post including the Search-Term -->
    <?php $i=1; while (have_posts()) : the_post(); ?>
		<!-- Title of Site or Post -->
        <?php the_title(); ?>
		<!-- Trimmed (20) Content of Site or Post and Link -->
        <?php echo wp_trim_words(get_the_content(), 20); ?> <a href="<?php the_permalink(); ?>">MORE</a>
    <?php $i++; endwhile; ?>
<?php else : ?>
	<!-- If no match found -->
    <?php echo "SORYY" ?>
<?php endif; ?>
```

### searchform

```
<!-- Search-Form-Template -->
<form class="search-menu" method="get" action="<?php echo esc_url( home_url( '/' ) ); ?>">
	<input type="text" placeholder="PLACEHOLDER" name="s" value="<?php echo get_search_query(); ?>">
	<button type="submit">SEARCH</button>
</form>
```

### page

```
 <!-- If Content exists then post -->
<?php if (have_posts()) : while (have_posts()) : the_post(); ?>   
	<!-- Page-Title -->
	<?php the_title(); ?>
	<!-- Page-Content -->
	<?php the_content(); ?>
	<!-- Page-Last-Update -->
	<?php the_modified_date() ?>
<?php endwhile; endif; ?>
```

### single

```
<!-- Show 20 Post per Page -->
<?php $the_query = new WP_Query( 'posts_per_page=20' ); ?>   

<!-- Loop through every Post -->
<?php while ($the_query -> have_posts()) : $the_query -> the_post(); ?>
	<!-- Post-Title -->
	<?php the_title(); ?>
	<!-- Post-Thumbnail -->
	<?php echo get_the_post_thumbnail(get_the_ID(), 'thumbnail'); ?>
	<!-- Post-Content (10 words with link) -->
	<?php echo wp_trim_words(get_the_content(), 10); ?> <a href="<?php the_permalink(); ?>">MORE</a>
	<!-- Post-Date -->
	<?php the_date('d.m.Y'); ?>
	<!-- Post-Category -->
	<?php the_category(', '); ?>
<?php endwhile; wp_reset_postdata(); ?>

<!-- Includes comments.php -->
<?php comments_template(); ?>                                                                                       
```

### comments

```
<!-- Comment-Form-Template -->
<form action="<?php echo get_option('siteurl'); ?>/wp-comments-post.php" method="post">
	<label for="author">AUTHOR</label>
	<!-- Comment-Author-Name -->
	<input type="text" name="author" id="author" value="<?php echo $comment_author; ?>" size="20" tabindex="1">
	<label for="email">EMAIL</label>
	<!-- Comment-Author-EMail (not public) -->
	<input type="text" name="email" id="email" value="<?php echo $comment_author_email; ?>" size="20" tabindex="2">
	<label for="url">URL</label>
	<!-- Comment-Author-URL (not public) -->
	<input type="text" name="url" id="url" value="<?php echo $comment_author_url; ?>" size="20" tabindex="3">
	<label for="comment">COMMENT</label>
	<!-- Comment-Text -->
	<textarea name="comment" id="comment" rows="10" tabindex="4"></textarea>
	<input name="submit" type="submit" id="submit" value="SUBMIT" tabindex="5">
	<input type="hidden" name="comment_post_ID" value="<?php echo $id; ?>">
	<?php do_action('comment_form', $post->ID); ?>
</form>

<!-- Loop prints all Comments to this Post-ID -->
<?php foreach ($comments as $comment) : ?>
	<!-- Comment-Template -->
	<div class="COMMENT" id="comment-<?php comment_ID() ?>">
		<!-- Comment-Author-Name -->
		<?php comment_author_link() ?>
		<!-- Comment-Date -->
		<?php comment_date('j. F Y') ?>
		<!-- Comment-Time -->
		<?php comment_time('H:i') ?>
		<!-- Comment-Text -->
		<?php comment_text() ?>
		<!-- If no Comment found -->
		<?php if ($comment->comment_approved == '0') : ?>
			<?php echo "NO COMMENT" ?>
		<?php endif; ?>
    </div>
<?php endforeach; ?>
```

### functions

```
<!-- Link to Random Page -->
<?php get_randomsite(); ?>	
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

	/* *********** */
	/* Random Site */
	/* *********** */

	function get_randomsite() 
	{
		$count_pages = wp_count_posts('page');
		$total_pages = $count_pages->publish;
		$random_page = rand(1, $total_pages);
		$random_link = "?p=".$random_page;
		echo "<a href=". $random_link .">Enter</a>";
	}

?>
```

## WordPress - Themes

- ### [Blog Example](/files/wordpress_blog.zip)
- ### [Blog & Sites Example](/files/wordpress_complex.zip)

[^1]: https://wphierarchy.com/
[^2]: https://www.rarst.net/wordpress/front-page-logic/
