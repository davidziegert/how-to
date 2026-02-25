<?php snippet('header') ?>
<?php snippet('nav') ?>
<main>
    <div class="row">
        <div class="column">
            <!-- TITLE -->
            <h1><?= $page->title()->esc() ?></h1>
            <!-- CONTENT -->
            <p><?= t('error.msg') ?></p>
            <a href="<?= $site->url() ?>"><?= t('back.home') ?></a>
        </div>
    </div>
</main>
<?php snippet('aside') ?>
<?php snippet('footer') ?>