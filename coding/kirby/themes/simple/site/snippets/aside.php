<aside>
    <div class="row">
        <div class="column">
            <div class="box-language">
                <!-- LANGUAGES -->
                <p><?= t('language.select') ?></p>
                <ul class="lang-menu">
                    <?php foreach ($kirby->languages() as $language): ?>
                        <li class="<?= $kirby->language()->code() === $language->code() ? 'active' : '' ?>">
                            <a href="<?= $page->url($language->code()) ?>" hreflang="<?= $language->code() ?>"><?= $language->name() ?></a>
                        </li>
                    <?php endforeach ?>
                </ul>
            </div>
        </div>
        <div class="column">
            <div class="box-search">
                <!-- SEARCH -->
                <form action="<?= page('search')->url() ?>" method="get">
                    <input id="search" type="search" name="q" value="<?= esc(get('q') ?? '') ?>" placeholder="<?= t('search.placeholder', '...') ?>" aria-label="<?= t('search.label', 'Search') ?>">
                    <button type="submit"><?= t('search.submit') ?></button>
                </form>
            </div>
        </div>
    </div>
</aside>