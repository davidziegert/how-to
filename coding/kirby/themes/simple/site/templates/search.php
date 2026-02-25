<?php snippet('header') ?>
<?php snippet('nav') ?>
<main>
    <div class="row">
        <div class="column">
            <!-- TITLE -->
            <h1><?= $page->title()->esc() ?></h1>

            <!-- SEARCH RESULTS -->
            <?php if ($results->count() === 0): ?>
                <p><?= t('search.empty') ?></p>
            <?php else: ?>
                <p><?= t('search.found') ?></p>
            <?php endif ?>

            <?php foreach ($results as $result): ?>
                <blockquote>
                    <p class="search-result-title"><?= $result->title()->esc() ?></p>
                    <?= $result->text()->excerpt(250)->kirbytext() ?>
                    <a href="<?= $result->url() ?>"><?= t('read.more') ?></a>
                </blockquote>
            <?php endforeach ?>
        </div>
    </div>
</main>
<?php snippet('aside') ?>
<?php snippet('footer') ?>