<!DOCTYPE html>
<html lang="<?= $kirby->languageCode() ?>">

<head>
    <!-- Site Meta Tags -->
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="robots" content="index, follow" />
    <meta name="mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="author" content="<?= $site->author()->esc() ?>">
    <meta name="description" content="<?= $page->text()->excerpt(200)->esc() ?>">
    <meta name="keywords" content="<?= $site->keywords()->esc() ?>">
    <link rel="canonical" href="<?= $page->url() ?>">

    <!-- Open Graph Meta Tags -->
    <?php $locale = $kirby->language()->locale();
    $ogLocale = is_array($locale) ? reset($locale) : $locale; ?>
    <meta property="og:locale" content="<?= str_replace('_', '-', htmlspecialchars($ogLocale)) ?>">
    <meta property="og:site_name" content="<?= $site->title()->esc() ?>">
    <meta property="og:url" content="<?= $page->url() ?>">
    <meta property="og:type" content="website">
    <meta property="og:title" content="<?= $page->title()->esc() ?>">
    <meta property="og:description" content="<?= $page->text()->excerpt(200)->esc() ?>">

    <?php if ($asset = asset('assets/img/opengraph.jpg')): ?>
        <meta property="og:image" content="<?= $asset->url() ?>">
    <?php endif ?>

    <!-- Title Tag -->
    <title>
        <?php if ($page->isHomePage()): ?>
            <?= $site->title()->esc() ?>
        <?php else: ?>
            <?= $page->title()->esc() ?> | <?= $site->title()->esc() ?>
        <?php endif ?>
    </title>

    <!-- Icons -->
    <?php if ($asset = asset('assets/img/favicon.svg')): ?>
        <link rel="shortcut icon" type="image/x-icon" href="<?= $asset->url() ?>">
        <link rel="apple-touch-icon" href="<?= $asset->url() ?>">
    <?php endif ?>

    <!-- Styles -->
    <?= css('assets/css/print.css', ['media' => 'print']) ?>
    <?= css('assets/css/reset.css') ?>
    <?= css('assets/css/skeleton.css') ?>
    <?= css('assets/css/style.css') ?>
    <?= css('assets/css/theme.css') ?>
</head>

<body>
    <div class="wrapper">
        <header>
            <div class="row">
                <div class="column">
                    <div class="box-logo">
                        <?php if ($asset = asset('assets/img/logo.svg')): ?>
                            <img class="header-logo" src="<?= $asset->url() ?>" alt="image loading" loading="lazy" />
                        <?php endif ?>
                    </div>
                    <div class="box-title">
                        <span class="header-title"><?= $site->title() ?></span>
                        <span class="header-subtitle"><?= $site->subtitle() ?></span>
                    </div>
                </div>
            </div>
        </header>