# WordPress

## Requirements

```bash
sudo apt install apache2
sudo systemctl enable apache2
sudo a2enmod rewrite
sudo systemctl status apache2
```

```bash
sudo apt install -y php php-{bcmath,common,mysql,xml,xmlrpc,curl,gd,imagick,cli,dev,imap,mbstring,opcache,soap,zip,intl}
sudo php -v
```

```bash
sudo apt install mariadb-server mariadb-client
sudo systemctl enable --now mariadb
sudo systemctl status mariadb
```

```bash
sudo mysql_secure_installation

Enter current password for root (enter for none): Press ENTER
Set root password? [Y/n]: Y
New password: Set-your-new-password
Re-enter new password: Set-your-new-password
Remove anonymous users? [Y/n] Y
Disallow root login remotely? [Y/n] Y
Remove test database and access to it? [Y/n] Y
Reload privilege tables now? [Y/n] Y
```

```bash
sudo mysql -u root -p

CREATE USER 'wp_user'@'localhost' IDENTIFIED BY 'your_password';
CREATE DATABASE wordpress;
GRANT ALL PRIVILEGES ON wordpress.* TO 'wp_user'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

## Installation & Configuration

```bash
sudo apt install wget unzip
```

```bash
sudo wget https://wordpress.org/latest.zip
sudo unzip latest.zip
sudo mv wordpress/ /var/www/html/
sudo rm latest.zip
sudo rm /var/www/html/index.html
```

```bash
sudo chown -R www-data:www-data /var/www/html/wordpress/
sudo find /var/www/html/wordpress/ -type d -exec chmod 750 {} \;
sudo find /var/www/html/wordpress/ -type f -exec chmod 640 {} \;
```

```bash
sudo nano /etc/apache2/sites-available/wordpress.conf
```

```
<VirtualHost *:80>
	ServerAdmin admin@example.com
	DocumentRoot /var/www/html/wordpress
	ServerName example.com
	ServerAlias www.example.com
	
	<Directory /var/www/html/wordpress/>
		Options FollowSymLinks
		AllowOverride All
		Require all granted
	</Directory>
	
	ErrorLog ${APACHE_LOG_DIR}/error.log
	CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```

```bash
sudo a2ensite wordpress.conf
sudo a2dissite 000-default.conf
sudo a2enmod rewrite
sudo systemctl restart apache2
```

```
http://your-server-ip-address
```

![Screenshot-1](./assets/wordpress_install_1.jpg)
![Screenshot-2](./assets/wordpress_install_2.jpg)
![Screenshot-3](./assets/wordpress_install_3.jpg)
![Screenshot-4](./assets/wordpress_install_4.jpg)
![Screenshot-5](./assets/wordpress_install_5.jpg)
![Screenshot-6](./assets/wordpress_install_6.jpg)
![Screenshot-7](./assets/wordpress_install_7.jpg)

## Security

### Folder Accesss

```bash
sudo chown -R www-data:www-data /var/www/html/wordpress/
sudo find /var/www/html/wordpress/ -type d -exec chmod 750 {} \;
sudo find /var/www/html/wordpress/ -type f -exec chmod 640 {} \;
```

### Limit PHP Functions

```bash
php -i | grep allow_url_include
allow_url_include => Off => Off
```

### Modify your PHP.ini

```bash
sudo cp /etc/php/8.1/apache2/php.ini /etc/php/8.1/apache2/php.ini.original
sudo nano /etc/php/8.1/apache2/php.ini
```

```
;;;;;;;;;;;
; EXAMPLE ;
;;;;;;;;;;;

[PHP]

;;;;;;;;;;;;;;;;;;;;
; Language Options ;
;;;;;;;;;;;;;;;;;;;;

engine = On
short_open_tag = Off
precision = 14
output_buffering = Off
zlib.output_compression = Off
implicit_flush = Off
serialize_precision = -1
disable_functions = allow_url_fopen,curl_exec,curl_multi_exec,exec,openlog,parse_ini_filew_source,passthru,phpinfo,popen,proc_open,shell_exec,show_source,syslog,system,highlight_file,fopen_with_path,dbmopen,dbase_open,putenv,chdir,filepro,filepro_rowcount,filepro_retrieve,posix_mkfifo
zend.enable_gc = On
zend.exception_ignore_args = On
zend.exception_string_param_max_len = 0
cgi.force_redirect= On

;;;;;;;;;;;;;;;;;
; Miscellaneous ;
;;;;;;;;;;;;;;;;;

expose_php = Off
allow_webdav_methods = Off

;;;;;;;;;;;;;;;;;;;
; Resource Limits ;
;;;;;;;;;;;;;;;;;;;

max_execution_time = 30
max_input_time = 60
memory_limit = 128M

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Error handling and logging ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

error_reporting = E_ALL
display_errors = Off
display_startup_errors = Off
log_errors = On
error_log = /var/log/apache2/php_scripts_error.log
ignore_repeated_errors = Off
ignore_repeated_source = Off
report_memleaks = On
track_errors = Off
html_errors = Off

;;;;;;;;;;;;;;;;;
; Data Handling ;
;;;;;;;;;;;;;;;;;

variables_order = "GPCS"
request_order = "GP"
register_argc_argv = Off
auto_globals_jit = On
post_max_size = 25M
auto_prepend_file =
auto_append_file =
default_mimetype = "text/html"
default_charset = "UTF-8"

;;;;;;;;;;;;;;;;;;;;;;;;;
; Paths and Directories ;
;;;;;;;;;;;;;;;;;;;;;;;;;

enable_dl = Off
file_uploads = On
upload_max_filesize = 25M
max_file_uploads = 5

;;;;;;;;;;;;;;;;;;
; Fopen wrappers ;
;;;;;;;;;;;;;;;;;;

allow_url_fopen = Off
allow_url_include = Off
default_socket_timeout = 60

;;;;;;;;;;;;;;;;;;;
; Module Settings ;
;;;;;;;;;;;;;;;;;;;

[CLI Server]
cli_server.color = On

[Date]
date.timezone = Europe/Berlin

[mail function]
SMTP = localhost
smtp_port = 25
mail.add_x_header = Off

[ODBC]
odbc.allow_persistent = On
odbc.check_persistent = On
odbc.max_persistent = -1
odbc.max_links = -1
odbc.defaultlrl = 4096
odbc.defaultbinmode = 1

[MySQLi]
mysqli.max_persistent = -1
mysqli.allow_persistent = On
mysqli.max_links = -1
mysqli.default_port = 3306
mysqli.reconnect = Off

[mysqlnd]
mysqlnd.collect_statistics = On
mysqlnd.collect_memory_statistics = Off

[PostgreSQL]
pgsql.allow_persistent = On
pgsql.auto_reset_persistent = Off
pgsql.max_persistent = -1
pgsql.max_links = -1
pgsql.ignore_notice = 0
pgsql.log_notice = 0

[bcmath]
bcmath.scale = 0

[Session]
session.save_handler = files
session.use_strict_mode = 1
session.use_cookies = 1
session.use_only_cookies = 1
session.name = NEW_SSID
session.auto_start = 0
session.cookie_lifetime = 0
session.cookie_secure = 1
session.cookie_httponly = 1
session.cookie_samesite = Strict
session.serialize_handler = php
session.gc_probability = 0
session.gc_divisor = 1000
session.gc_maxlifetime  = 600
session.cache_limiter = nocache
session.cache_expire = 30
session.use_trans_sid = 0
session.sid_length = 256
session.trans_sid_tags = "a=href,area=href,frame=src,form="
session.sid_bits_per_character = 6

[Assertion]
zend.assertions = -1

[Tidy]
tidy.clean_output = Off

[soap]
soap.wsdl_cache_enabled = 1
soap.wsdl_cache_dir = "/tmp"
soap.wsdl_cache_ttl = 86400
soap.wsdl_cache_limit = 5

[ldap]
ldap.max_links = -1
```

### Block  Userlist in WP’s REST API

```
A list all of all is available at users https://example.com/wp-json/wp/v2/users and one can also get information about a specific user at https://example.com/wp-json/wp/v2/users/1, where 1 is a user’s ID. To disable these two endpoints, add this code snippet to your theme’s functions.php file or in the wp-config.php file.
```

```php
// functions.php

add_filter('rest_endpoints', function( $endpoints ) {
    if ( isset( $endpoints['/wp/v2/users'] ) ) {
        unset( $endpoints['/wp/v2/users'] );
    }
    if ( isset( $endpoints['/wp/v2/users/(?P<id>[\d]+)'] ) ) {
        unset( $endpoints['/wp/v2/users/(?P<id>[\d]+)'] );
    }
    return $endpoints;
});
```

```php
// wp-config.php

remove_action('rest_api_init', 'create_initial_rest_routes', 99);
```

### Remove WP-Admin Login-Path

```
Are you looking for a simple, yet effective way to protect your admin page? If so, you can use the WPS Hide Login plugin to change the location of the login page.
The most popular method to break into a website is brute force (continually entering login information until it is right).
Redirect the the login page to another URL with the WPS Hide Login Plugin.
```

## Plugins

- [WPS Hide Login](https://de.wordpress.org/plugins/wps-hide-login/)
- [wp_head() cleaner](https://de.wordpress.org/plugins/wp-head-cleaner/)
- [WP Fastest Cache](https://de.wordpress.org/plugins/wp-fastest-cache/)
- [Very Simple Meta Description](https://wordpress.org/plugins/very-simple-meta-description/)
- [Real Media Library](https://de.wordpress.org/plugins/real-media-library-lite/)
- [Polylang](https://de.wordpress.org/plugins/polylang/)
- [Insert PHP Code Snippet](https://de.wordpress.org/plugins/insert-php-code-snippet/)
- [Nested Pages](https://de.wordpress.org/plugins/wp-nested-pages/)
- [Health Check & Troubleshooting](https://wordpress.org/plugins/health-check/)

## Backup

### Manually

#### Files

```bash
sudo systemctl enable cron
sudo crontab -e
```

```
# Every Monday on 02:00 AM
0 2 * * 1   tar -cvf backup_wordpress_$(date "+%d-%b-%y").tar /var/www/html/wordpress
```

#### Database

```bash
sudo systemctl enable cron
sudo crontab -e
```

```
# Every Monday on 02:00 AM
0 2 * * 1   mysqldump -u [USERNAME] -p [DATABASE] > backup_wordpress_$(date "+%d-%b-%y").sql
```

### via Plugin

- #### [UpdraftPlus](https://de.wordpress.org/plugins/updraftplus/)
- #### [BackWPup](https://de.wordpress.org/plugins/backwpup/)
- #### [VaultPress](https://de.wordpress.org/plugins/vaultpress/)

### Export Data (no Backup!)

![Screenshot-1](./assets/wordpress_export.jpg)

## Classic Theme [^1] [^2]

### Folder Structure Example

![Screenshot-17](./assets/wordpress_structure.jpg)

```
theme
├── css
│	└── custom.css
├── js
│	└── script.js
├── img
│	├── img/favicon.ico
│	└── img/logo.png
├── functions.php			// WordPress-Functions
├── screenshot.png			// Default-Screenshot
├── style.css				// Default-Stylesheet and Theme Information
├── header.php				// Header Template-Part                    
├── nav.php					// Navigation Template-Part
├── main.php				// Content Template-Part
├── sidebar.php				// Sidebar Template-Part
├── footer.php				// Footer Template-Part
├── searchform.php			// Search-Form Template-Part
├── comments.php			// Comments Template-Part
├── index.php				// Blog Page-Template
├── 404.php					// 404 Page-Template
├── front-page.php			// Home Page-Template
├── page.php				// Site Page-Template
├── single.php				// Blog-Entry Page-Template
└── search.php				// Search-Result Page-Template     
```

### Shortcodes

#### html - head

```php
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

#### header

```php
<!-- Website-Name -->
<?php bloginfo('name'); ?>

<!-- Website-Description -->
<?php bloginfo('description'); ?>
```

#### nav

```php
<!-- Breadcrumb-Navigation -->
<?php get_breadcrumb(); ?>

<!-- Custom-Navigation () from functions.php (WITH container_id OR container_class) -->
<?php wp_nav_menu(array('theme_location' => 'REGISTER-NAME', 'container_id' => 'ID-NAME')); ?>
```

#### sidebar

```php
<!-- Includes searchform.php -->
<?php get_search_form(); ?>
```

#### footer

```php
<!-- List of all Post-Categories -->
<?php wp_list_categories('orderby=name&order=ASC&title_li='); ?>

<!-- List the monthly Archive -->
<?php wp_get_archives('type=monthly'); ?>

 <!-- List all Pages -->
 <?php wp_list_pages('title_li=' . __('')); ?>
```

#### search

```php
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

#### searchform

```php
<!-- Search-Form-Template -->
<form class="search-menu" method="get" action="<?php echo esc_url( home_url( '/' ) ); ?>">
	<input type="text" placeholder="PLACEHOLDER" name="s" value="<?php echo get_search_query(); ?>">
	<button type="submit">SEARCH</button>
</form>
```

#### page

```php
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

#### single

```php
 <!-- If Content exists then post -->
<?php if (have_posts()) : while (have_posts()) : the_post(); ?>   
	<!-- Page-Title -->
	<?php the_title(); ?>
	<!-- Page-Content -->
	<?php the_content(); ?>
	<!-- Page-Last-Update -->
	<?php the_modified_date() ?>
<?php endwhile; endif; ?>

<!-- Includes comments.php -->
<?php comments_template(); ?>
```

#### index

```php
<!-- Show Latest 6 Post -->
<?php $args = array( 'post_type' => 'post', 'post_status' => 'publish', 'posts_per_page' => 6 ); ?>

<?php $the_query = new WP_Query( $args ); ?>

<!-- Loop through every Post -->
<?php if($the_query->have_posts()): ?>
	<?php while ($the_query->have_posts()) : $the_query->the_post(); ?>
		<!-- Post-Title -->
		<?php the_title(); ?>
		<!-- Post-Thumbnail -->
		<?php echo get_the_post_thumbnail(get_the_ID(), 'thumbnail'); ?>
		<!-- Post-Content (10 words with link) -->
		<?php echo wp_trim_words(get_the_content(), 10); ?>
		<a href="<?php the_permalink(); ?>">MORE</a>
		<!-- Post-Date -->
		<?php the_date('d.m.Y'); ?>
		<!-- Post-Category -->
		<?php the_category(', '); ?>
	<?php endwhile; ?>
<?php else: ?>
	<?php _e( 'There no posts to display.' ); ?>
<?php endif; wp_reset_postdata(); ?>
```

```php
<!-- Show All Post from Category -->
<?php $args = array( 'post_type' => 'post', 'post_status' => 'publish', 'category_name' => 'my_category', 'nopaging' => true ); ?>

<?php $the_query = new WP_Query( $args ); ?>

<!-- Loop through every Post -->
<?php if($the_query->have_posts()): ?>
	<?php while ($the_query->have_posts()) : $the_query->the_post(); ?>
		<!-- Post-Title -->
		<?php the_title(); ?>
		<!-- Post-Thumbnail -->
		<?php echo get_the_post_thumbnail(get_the_ID(), 'thumbnail'); ?>
		<!-- Post-Content (10 words with link) -->
		<?php echo wp_trim_words(get_the_content(), 10); ?>
		<a href="<?php the_permalink(); ?>">MORE</a>
		<!-- Post-Date -->
		<?php the_date('d.m.Y'); ?>
		<!-- Post-Category -->
		<?php the_category(', '); ?>
	<?php endwhile; ?>
<?php else: ?>
	<?php _e( 'There no posts to display.' ); ?>
<?php endif; wp_reset_postdata(); ?>
```

```php
<!-- NOT WORK ON index.php OR front-page.php -->
<!-- Show 4 Post per Page with Pagination -->
<?php $args = array( 'post_type' => 'post', 'posts_per_page' => 4, 'paged' => $paged ); ?>

<?php $the_query = new WP_Query( $args ); ?>

<!-- Loop through every Post -->
<?php if($the_query->have_posts()): ?>
	<?php while ($the_query->have_posts()) : $the_query->the_post(); ?>
		<!-- Post-Title -->
		<?php the_title(); ?>
		<!-- Post-Thumbnail -->
		<?php echo get_the_post_thumbnail(get_the_ID(), 'thumbnail'); ?>
		<!-- Post-Content (10 words with link) -->
		<?php echo wp_trim_words(get_the_content(), 10); ?>
		<a href="<?php the_permalink(); ?>">MORE</a>
		<!-- Post-Date -->
		<?php the_date('d.m.Y'); ?>
		<!-- Post-Category -->
		<?php the_category(', '); ?>
	<?php endwhile; ?>

	<!-- Add the pagination functions here. -->
	<?php posts_nav_link(); ?>

<?php else: ?>
	<?php _e( 'There no posts to display.' ); ?>
<?php endif; wp_reset_postdata(); ?>
```

#### comments

```php
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

#### random-page-link

```php
<!-- Link to Random Page -->
<?php get_randomsite(); ?>	
```

#### functions.php

```php
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

    /* ************* */
	/* WP-JSON-Users */
	/* ************* */

    add_filter('rest_endpoints', function( $endpoints ) {
        if ( isset( $endpoints['/wp/v2/users'] ) ) {
            unset( $endpoints['/wp/v2/users'] );
        }
        if ( isset( $endpoints['/wp/v2/users/(?P<id>[\d]+)'] ) ) {
            unset( $endpoints['/wp/v2/users/(?P<id>[\d]+)'] );
        }
        return $endpoints;
    });
```

## Block/FSE Theme

### Folder Structure Example

```
theme
├── assets
│   ├── fonts
│   │   └── font.woff2
│   └── img
│       ├── favicon.ico
│       └── logo.png
├── parts
│   ├── header.html             // Header Template-Part                    
│   ├── nav.html                // Navigation Template-Part
│   ├── main.html               // Content Template-Part
│   ├── sidebar.html            // Sidebar Template-Part
│   ├── footer.html             // Footer Template-Part
│   ├── searchform.html         // Search-Form Template-Part
|   └── comments.html           // Comments Template-Part
├── templates
│   ├── front-page.html         // Home Page-Template
│   ├── 404.html                // 404 Page-Template
│   ├── page.html               // Site Page-Template
│   ├── search.html             // Search-Result Page-Template
│   ├── privacy-policy.html     // Disclaimer and Privacy Policy Page-Template
│   ├── index.html              // Blog Page-Template
│   ├── single.html             // Blog-Entry Page-Template
│   └── archive.html            // Blog-Archive Page-Template  
├── functions.php               // WordPress-Functions
├── screenshot.png              // Default-Screenshot
├── style.css                   // Default-Stylesheet and Theme Information
└── theme.json                  // Default-JSON with Stylesheets
```

### functions.php

```php
<?php

    if ( ! function_exists( 'mytheme_styles' ) ) :
        function mytheme_styles() 
        {
            // Register theme stylesheet.
            $theme_version = wp_get_theme()->get( 'Version' );
            $version_string = is_string( $theme_version ) ? $theme_version : false;
            wp_register_style('mytheme-style', get_template_directory_uri() . '/style.css', array(), $version_string);  
                
            // Enqueue theme stylesheet.
            wp_enqueue_style( 'mytheme-style' );
        }

        add_action( 'wp_enqueue_scripts', 'mytheme_styles' );
    endif;

    if ( ! function_exists( 'mytheme_support' ) ) :
        function mytheme_support()  
        {
            // Adding support for core block visual styles.
            add_theme_support( 'wp-block-styles' );

            // Enqueue editor styles.
            add_editor_style( 'style.css' );
        }

        add_action( 'after_setup_theme', 'mytheme_support' );
    endif;
```

### header.html

```
<!-- wp:site-logo /-->
<!-- wp:site-title /-->
<!-- wp:site-tagline /-->
```

### nav.html

```
<!-- wp:navigation -->
	<!-- wp:page-list /-->
<!-- /wp:navigation -->
```

### main.html

```
<!-- wp:post-title /-->
<!-- wp:post-content /-->
```

### sidebar.html

```
<!-- wp:query {"queryId":0,"query":{"perPage":3,"pages":0,"offset":0,"postType":"post","order":"desc","orderBy":"date","author":"","search":"","exclude":[],"sticky":"","inherit":false,"parents":[]}} -->
	<!-- wp:post-template -->
		<!-- wp:post-featured-image {"isLink":true} /-->
		<!-- wp:post-title {"isLink":true} /-->
		<!-- wp:post-excerpt {"moreText":"read more","excerptLength":40} /-->
		<!-- wp:post-author {"showAvatar":false,"showBio":false} /-->
		<!-- wp:post-date /-->
		<!-- wp:post-terms {"term":"category"} /-->
	<!-- /wp:post-template -->
<!-- /wp:query -->
```

### footer.html

```

```

### searchform.html

```
<!-- wp:search {"label":"Search","showLabel":false,"buttonText":"Search","buttonUseIcon":true} /-->
```

### comments.html

```
<!-- wp:comments -->
	<!-- wp:comments-title /-->
	<!-- wp:comment-template -->
		<!-- wp:comment-author-name /-->
		<!-- wp:group -->
			<!-- wp:comment-date  /-->
			<!-- wp:comment-edit-link /-->
		<!-- /wp:group -->
		<!-- wp:comment-content /-->
		<!-- wp:comment-reply-link /-->
	<!-- /wp:comment-template -->
	<!-- wp:comments-pagination -->
		<!-- wp:comments-pagination-previous /-->
		<!-- wp:comments-pagination-numbers /-->
		<!-- wp:comments-pagination-next /-->
	<!-- /wp:comments-pagination -->
	<!-- wp:post-comments-form /-->
<!-- /wp:comments -->
```

### front-page.html

```
<!-- wp:template-part {"slug":"header"} /-->
<!-- wp:template-part {"slug":"nav"} /-->
<!-- wp:template-part {"slug":"searchform"} /-->
<!-- wp:template-part {"slug":"main"} /-->
<!-- wp:template-part {"slug":"sidebar"} /-->
<!-- wp:template-part {"slug":"footer"} /-->
```

### 404.html

```

```

### page.html

```
<!-- wp:template-part {"slug":"header"} /-->
<!-- wp:template-part {"slug":"nav"} /-->
<!-- wp:template-part {"slug":"searchform"} /-->
<!-- wp:template-part {"slug":"main"} /-->
<!-- wp:template-part {"slug":"sidebar"} /-->
<!-- wp:template-part {"slug":"footer"} /-->
```

### search.html

```
<!-- wp:query-title {"type":"search"} /-->
<!-- wp:query {"queryId":2,"query":{"perPage":5,"pages":0,"offset":0,"postType":"page","order":"desc","orderBy":"date","author":"","search":"","exclude":[],"sticky":"","inherit":false}} -->
	<!-- wp:post-template -->
		<!-- wp:post-title {"isLink":true} /-->
		<!-- wp:post-excerpt {"moreText":"read more","excerptLength":50} /-->
	<!-- /wp:post-template -->
	<!-- wp:query-pagination -->
		<!-- wp:query-pagination-previous /-->
		<!-- wp:query-pagination-numbers /-->
		<!-- wp:query-pagination-next /-->
	<!-- /wp:query-pagination -->
	<!-- wp:query-no-results -->
		<!-- wp:paragraph -->
		<p>Unfortunately, there is no match for your search terms. Please try again with other keywords.</p>
		<!-- /wp:paragraph -->
	<!-- /wp:query-no-results -->
<!-- /wp:query -->
```

### privacy-policy.html

```

```

### index.html

```
<!-- wp:query-title {"type":"search"} /-->
<!-- wp:query {"queryId":3,"query":{"perPage":10,"pages":0,"offset":0,"postType":"post","order":"desc","orderBy":"date","author":"","search":"","exclude":[],"sticky":"","inherit":false}} -->
	<!-- wp:post-template -->
		<!-- wp:post-featured-image {"isLink":true} /-->
		<!-- wp:post-title {"isLink":true} /-->
		<!-- wp:post-excerpt {"moreText":"read more","excerptLength":25} /-->
		<!-- wp:post-author {"showAvatar":false,"showBio":false} /-->
		<!-- wp:post-date /-->
		<!-- wp:post-terms {"term":"category"} /-->
	<!-- /wp:post-template -->
<!-- /wp:query -->
```

### single.html

```
<!-- wp:post-featured-image {"isLink":false} /-->
<!-- wp:post-title {"isLink":false} /-->
<!-- wp:post-content /-->
<!-- wp:post-author {"showAvatar":false,"showBio":false} /-->
<!-- wp:post-date /-->
<!-- wp:post-terms {"term":"category"} /-->
```

### archive.html

```
<!-- wp:query-title {"type":"search"} /-->
<!-- wp:query {"queryId":3,"query":{"perPage":1,"pages":0,"offset":0,"postType":"post","order":"desc","orderBy":"date","author":"","search":"","exclude":[],"sticky":"","inherit":false}} -->
	<!-- wp:post-template -->
		<!-- wp:post-title {"isLink":true} /-->
		<!-- wp:post-excerpt {"moreText":"read more","excerptLength":25} /-->
		<!-- wp:post-date /-->
	<!-- /wp:post-template -->
	<!-- wp:query-pagination -->
		<!-- wp:query-pagination-previous /-->
		<!-- wp:query-pagination-numbers /-->
		<!-- wp:query-pagination-next /-->
	<!-- /wp:query-pagination -->
<!-- /wp:query -->
```

### theme.json

```json
{
	"$schema": "https://schemas.wp.org/trunk/theme.json",

	"settings": {
		"appearanceTools": true,
		"layout": {
			"contentSize": "",
			"wideSize": ""
		},
		"color": {
			"defaultPalette": false,
			"palette": [
				{
					"color": "#000000",
					"name": "Primary",
					"slug": "primary"
				},
				{
					"color": "#FFFFFF",
					"name": "Secondary",
					"slug": "secondary"
				},
				{
					"color": "#444444",
					"name": "Tertiary",
					"slug": "tertiary"
				}
			]
		},
        "typography": {
            "fluid": true,
            "fontSizes": [
                {
                    "size": "0.67rem",
                    "name": "Extra small",
                    "slug": "extra-small"
                },
                {
                    "size": "0.83rem",
                    "name": "Small",
                    "slug": "small"
                },
                {
                    "size": "1.0rem",
                    "name": "Medium",
                    "slug": "medium"
                },
                {
                    "size": "1.17rem",
                    "name": "Large",
                    "slug": "large"
                },
                {
                    "size": "1.5rem",
                    "name": "Extra large",
                    "slug": "x-large"
                },
                {
                    "size": "2rem",
                    "name": "Extra-Extra large",
                    "slug": "xx-large"
                }
            ],
            "fontFamilies": [
                {
                    "fontFamily": "-apple-system,BlinkMacSystemFont,\"Segoe UI\",Roboto,Oxygen-Sans,Ubuntu,Cantarell,\"Helvetica Neue\",sans-serif",
                    "slug": "system-fonts",
                    "name": "System Fonts"
                }
            ]
        },		
		"spacing": {
			"blockGap": null,
			"padding": false,
			"margin": false,
			"units": [
				"px",
				"em",
				"rem",
				"vh",
				"vw",
				"%"
			]
		},
		"useRootPaddingAwareAlignments": true
	},
	"styles": {
        "color": {
            "background": "var(--wp--preset--color--primary)",
            "text": "var(--wp--preset--color--secondary)"
        },
        "border": {
            "color": "none",
            "radius": "0",
            "style": "none",
            "width": "0"
        },
        "spacing": {
            "blockGap": "1rem",
            "margin": {
                "top": "1rem",
                "right": "1rem",
                "bottom": "1rem",
                "left": "1rem"
            },
            "padding": {
                "top": "1rem",
                "right": "1rem",
                "bottom": "1rem",
                "left": "1rem"
            }
        },
        "typography": {
            "fontFamily": "var(--wp--preset--font-family--system-fonts)",
            "fontSize": "var(--wp--preset--font-size--medium)",
            "fontStyle": "",
            "fontWeight": "",
            "letterSpacing": "",
            "lineHeight": "1.5",
            "textDecoration": "",
            "textTransform": ""
        },
        "blocks": {
            "core/archives": {},
            "core/audio": {},
            "core/avatar": {},
            "core/block": {},
            "core/button": {},
            "core/buttons": {},
            "core/calendar": {},
            "core/categories": {},
            "core/code": {},
            "core/column": {},
            "core/columns": {},
            "core/comment-author-name": {},
            "core/comment-content": {},
            "core/comment-date": {},
            "core/comment-edit-link": {},
            "core/comment-reply-link": {},
            "core/comments": {},
            "core/comments-pagination": {},
            "core/comments-pagination-next": {},
            "core/comments-pagination-numbers": {},
            "core/comments-pagination-previous": {},
            "core/comments-title": {},
            "core/comment-template": {},
            "core/cover": {},
            "core/details": {},
            "core/embed": {},
            "core/file": {},
            "core/footnotes": {},
            "core/freeform": {},
            "core/gallery": {},
            "core/group": {},
            "core/heading": {},
            "core/home-link": {},
            "core/html": {},
            "core/image": {},
            "core/latest-comments": {},
            "core/latest-posts": {},
            "core/legacy-widget": {},
            "core/list": {},
            "core/list-item": {},
            "core/loginout": {},
            "core/media-text": {},
            "core/missing": {},
            "core/more": {},
            "core/navigation": {},
            "core/navigation-link": {},
            "core/navigation-submenu": {},
            "core/nextpage": {},
            "core/page-list": {},
            "core/page-list-item": {},
            "core/paragraph": {},
            "core/pattern": {},
            "core/post-author": {},
            "core/post-author-biography": {},
            "core/post-author-name": {},
            "core/post-comments": {},
            "core/post-comments-form": {},
            "core/post-content": {},
            "core/post-date": {},
            "core/post-excerpt": {},
            "core/post-featured-image": {},
            "core/post-navigation-link": {},
            "core/post-template": {},
            "core/post-terms": {},
            "core/post-title": {},
            "core/preformatted": {},
            "core/pullquote": {},
            "core/query": {},
            "core/query-no-results": {},
            "core/query-pagination": {},
            "core/query-pagination-next": {},
            "core/query-pagination-numbers": {},
            "core/query-pagination-previous": {},
            "core/query-title": {},
            "core/quote": {},
            "core/read-more": {},
            "core/rss": {},
            "core/search": {},
            "core/separator": {},
            "core/shortcode": {},
            "core/site-logo": {},
            "core/site-tagline": {},
            "core/site-title": {},
            "core/social-link": {},
            "core/social-links": {},
            "core/spacer": {},
            "core/table": {},
            "core/tag-cloud": {},
            "core/template-part": {},
            "core/term-description": {},
            "core/text-columns": {},
            "core/verse": {},
            "core/video": {},
            "core/widget-group": {}
        },
        "elements": {
            "button": {},
            "caption": {},
            "cite": {},
            "h1": {},
            "h2": {},
            "h3": {},
            "h4": {},
            "h5": {},
            "h6": {},
            "heading": {},
            "link": {
                "color": {
                    "text": "var(--wp--preset--color--primary)"
                }
            }
        }
    },
	"templateParts": [
		{
			"area": "header",
			"name": "header",
			"title": "Header-Part"
		},
		{
			"area": "nav",
			"name": "nav",
			"title": "Navigation-Part"
		},
		{
			"area": "main",
			"name": "main",
			"title": "Main-Part"
		},
		{
			"area": "sidebar",
			"name": "sidebar",
			"title": "Aside-Part"
		},
		{
			"area": "footer",
			"name": "footer",
			"title": "Footer-Part"
		},
		{
			"area": "searchform",
			"name": "searchform",
			"title": "Search-Form-Part"
		},
		{
			"area": "comments",
			"name": "comments",
			"title": "Comments-Part"
		}
	],

	"version": 2
}
```

---

[^1]: https://wphierarchy.com/
[^2]: https://www.rarst.net/wordpress/front-page-logic/