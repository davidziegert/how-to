<?php
/* Block comments.php from direct calling */
if (!defined('ABSPATH')) {
    exit;
}

/* Loop all Comments to this Post-ID */
$comments = get_comments(array(
    'status'  => 'approve',
    'post_id' => get_the_ID(),
));

/* Prints all Comments */
if ($comments):
    foreach ($comments as $comment):

        echo '<code>';
        echo '<ul>';
        echo '<li>';
        echo comment_ID();
        echo '</li>';
        echo '<li>';
        echo esc_html(get_comment_date('j. F Y', $comment));
        echo '</li>';
        echo '<li>';
        echo esc_html(get_comment_time('H:i', false, $comment));
        echo '</li>';
        echo '<li>';
        echo '<a href="';
        echo esc_url(get_comment_author_url($comment));
        echo '">';
        echo esc_html(get_comment_author($comment));
        echo '</a>';
        echo '</li>';
        echo '<li>';
        echo wp_kses_post(get_comment_text($comment));
        echo '</li>';
        echo '</ul>';
        echo '</code>';

    endforeach;
endif;
?>

<hr>

<?php if (comments_open()) : ?>
    <!-- Comment-Form-Template -->
    <form class="comment-form" action="<?php echo esc_url(site_url('/wp-comments-post.php')); ?>" method="post">
        <fieldset>
            <!-- Comment-Author-Name -->
            <label for="author">Author</label>
            <input type="text" name="author" id="author" size="20" tabindex="1" required />
            <!-- Comment-Author-EMail -->
            <label for="email">E-Mail</label>
            <input type="email" name="email" id="email" size="20" tabindex="2" required />
            <!-- Comment-Author-URL -->
            <label for="url">URL</label>
            <input type="url" name="url" id="url" size="20" tabindex="3" />
            <!-- Comment-Text -->
            <label for="comment">Comment</label>
            <textarea name="comment" id="comment" rows="10" tabindex="4" required></textarea>
            <?php comment_id_fields(); ?> <?php do_action('comment_form', get_the_ID()); ?>
            <input name="submit" type="submit" id="submit" value="Post" tabindex="5" />
        </fieldset>
    </form>
<?php endif; ?>