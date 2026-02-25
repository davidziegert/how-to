# KIRBY

## Themes

### Folder Structure

```
[ROOT/]
├── assets/
│   ├── css/                            // Compiled & custom stylesheets
│   ├── img/                            // Theme images (logo, icons, etc.)
│   ├── fonts/                          // (optional) Webfonts
│   └── js/                             // JavaScript files
├── content/                            // All content in .txt files (multilang)
│   ├── error/
│   │   ├── error.en.txt
│   │   └── error.de.txt
│   ├── 1_home/
│   │   ├── home.en.txt
│   │   └── home.de.txt
│   ├── 2_default/
│   │   ├── default.en.txt
│   │   └── default.de.txt
│   ├── search/
│   │   ├── search.en.txt
│   │   └── search.de.txt
│   ├── site.en.txt                     // Global site fields (EN)
│   └── site.de.txt                     // Global site fields (DE)
├── kirby/                              // Kirby core (DO NOT MODIFY)
│   └── ...
├── media/                              // Auto-generated (thumbs, cache)
│   └── ...
├── site/                               // Your actual project logic
│   ├── blueprints/
│   │   ├── pages/
│   │   │   ├── default.yml
│   │   │   ├── error.yml
│   │   │   ├── home.yml
│   │   │   ├── link.yml
│   │   │   └── search.yml
│   │   ├── files/                      // File blueprints
│   │   │   └── image.yml
│   │   ├── blocks/                     // If using Kirby Blocks
│   │   │   └── text.yml
│   │   ├── fields/                     // Reusable custom fields
│   │   │   └── seo.yml
│   │   └── site.yml                    // Site blueprint
│   ├── config/
│   │   └── config.php
│   ├── controllers/
│   │   └── search.php
│   ├── languages/
│   │   ├── de.php
│   │   └── en.php
│   ├── models/                         // Custom page models (optional)
│   │   └── ...
│   ├── plugins/                        // Custom or third-party plugins
│   │   └── ...
│   ├── snippets/
│   │   ├── aside.php
│   │   ├── footer.php
│   │   ├── header.php
│   │   ├── main.php
│   │   ├── nav.php
│   │   └── seo-meta.php
│   ├── templates/
│   │   ├── default.php
│   │   ├── error.php
│   │   ├── home.php
│   │   ├── link.php
│   │   └── search.php
│   ├── helpers.php                     // Custom global helper functions
│   └── routes.php                      // Custom routes
├── storage/                            // Session & cache (Kirby 4+)
│   └── ...
└── index.php                           // Entry point
```

### Snippets

#### site.x.txt

```txt
Title: Title of the Webseite

----

Subtitle: if necessary the subtitle, otherwise delete

----

Author: Max Mustermann

----

Keywords: Keywords for SEO
```

#### site.yml

```yml
title: Site

sections:
  pages:
    type: pages
    template:
      - default
      - error
      - home
      - search
      - link
```

#### default.yml

```yml
title: Default Site

columns:
  main:
    width: 2/3
    sections:
      fields:
        type: fields
        fields:
          text:
            type: textarea
            size: huge
  sidebar:
    width: 1/3
    sections:
      pages:
        type: pages
        template:
          - default
          - link
      files:
        type: files
```

#### error.yml

```yml
title: Error Site

columns:
  main:
    width: 3/3
    sections:
      fields:
        type: fields
        fields:
          text:
            type: textarea
            size: huge
```

#### home.yml

```yml
title: Root Site

columns:
  main:
    width: 2/3
    sections:
      fields:
        type: fields
        fields:
          text:
            type: textarea
            size: huge
  sidebar:
    width: 1/3
    sections:
      pages:
        type: pages
        template:
          - default
          - link
      files:
        type: files
```

#### link.yml

```yml
title: Link

fields:
  link:
    label: URL
    type: url
```

#### search.yml

```yml
title: Search Site

columns:
  main:
    width: 3/3
    sections:
      fields:
        type: fields
        fields:
          text:
            type: textarea
            size: huge
```

#### config.php

```php
<?php

return [
  'languages' => true,
  'debug' => false,
];
```

#### search.php

```php
<?php

return function ($site) {

  $query = get('q');
  $results = $site->search($query, 'title|text');
  $results = $results->paginate(20);

  return [
    'query' => $query,
    'results' => $results,
    'pagination' => $results->pagination()
  ];

};
```

#### en.php

```php
<?php

return [
    'code' => 'en',
    'default' => false,
    'direction' => 'ltr',
    'locale' => [
        'LC_ALL' => 'en_US'
    ],
    'name' => 'English',
    'translations' => [
        'language.select' => 'Please select language:',
        'error.msg' => 'Sorry, but we can not find the page you are looking for.',
        'back.home' => 'back to homepage',
        'read.more' => 'read more',
        'search.empty' => 'We are sorry, nothing was found that matches your search criteria!',
        'search.found' => 'Found on pages:',
        'search.submit' => 'Search'
    ],
    'url' => NULL
];
```

#### header.php

```php
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
```

#### nav.php

```php
<?php if ($items = $pages->listed() and $items->isNotEmpty()): ?>
    <nav id="nav">
        <div class="row">
            <div class="column">
                <menu class="main-menu">
                    <?php foreach ($items as $item): ?>
                        <?php $children = $item->children()->listed(); ?>
                        <?php $classes = ['menu-item'];
                        if ($children->isNotEmpty()) $classes[] = 'menu-item-has-children';
                        if ($item->isActive()) $classes[] = 'current-page-item';
                        ?>
                        <li class="<?= implode(' ', $classes) ?>">
                            <a href="<?= $item->url() ?>"><?= $item->title()->esc() ?></a>
                            <?php if ($children->isNotEmpty()): ?>
                                <ul class="sub-menu">
                                    <?php foreach ($children as $child): ?>
                                        <?php $grandchildren = $child->children()->listed(); ?>
                                        <?php $childClasses = ['menu-item'];
                                        if ($grandchildren->isNotEmpty()) $childClasses[] = 'menu-item-has-children';
                                        if ($child->isActive()) $childClasses[] = 'current-page-item'; ?>
                                        <li class="<?= implode(' ', $childClasses) ?>"><a href="<?= $child->url() ?>"><?= $child->title()->esc() ?></a>
                                            <?php if ($grandchildren->isNotEmpty()): ?>
                                                <ul class="sub-menu">
                                                    <?php foreach ($grandchildren as $grandchild): ?>
                                                        <li class="menu-item <?= $grandchild->isActive() ? 'current-page-item' : '' ?>"><a href="<?= $grandchild->url() ?>"><?= $grandchild->title()->esc() ?></a></li>
                                                    <?php endforeach ?>
                                                </ul>
                                            <?php endif ?>
                                        </li>
                                    <?php endforeach ?>
                                </ul>
                            <?php endif ?>
                        </li>
                    <?php endforeach ?>
                </menu>
            </div>
        </div>
    </nav>
<?php endif ?>
```

#### main.php

```php
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
```

#### aside.php

```php
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
```

#### footer.php

```php
        <footer>
            <div class="row">
                <div class="column">
                    <div class="box-theme">
                    <span class="footer-theme">Theme: kirby v.3</span>
                    </div>
                </div>
            </div>
        </footer>
    </div>

    <!-- Scripts -->
    <?= js('assets/js/script.js', ['defer' => true]) ?>
</body>

</html>
```

#### home.php

```php
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
```

#### error.php

```php
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
```

#### default.php

```php
<?php snippet('header') ?>
<?php snippet('nav') ?>
<?php snippet('main') ?>
<?php snippet('aside') ?>
<?php snippet('footer') ?>
```

#### link.php

```php
<?php go($page->link(), 301); ?>
```

#### search.php

```php
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
```
