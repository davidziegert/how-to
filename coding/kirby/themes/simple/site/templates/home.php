<?php snippet('header') ?>
<?php snippet('nav') ?>
<main>
    <div class="row hero">
        <div class="column">
            <div class="box-hero">
                <span class="hero-title">Hero</span>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="column">
            <!-- TITLE -->
            <h1><?= $page->title()->esc() ?></h1>
            <!-- CONTENT -->
            <?php if ($page->text()->isNotEmpty()): ?>
                <?= $page->text()->kirbytext() ?>
            <?php endif ?>
        </div>
    </div>
</main>
<?php snippet('aside') ?>
<?php snippet('footer') ?>