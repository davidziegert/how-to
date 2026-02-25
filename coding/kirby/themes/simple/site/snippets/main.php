<main>
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