# GRAV

## Config

### Site configuration

```
Path: ./grav/system/config/site.yaml
```

```
title: Grav                                         # Global site title (used in templates via site.title)
default_lang: en                                    # Default language (used if multi-language is enabled)

author:
  name: John Appleseed                              # Default author (accessible via site.author.name)
  email: 'john@example.com'                         # Default author email

metadata:
  generator: 'Grav'                                 # Meta generator tag
  description: 'Simple One Page Theme for Grav'     # Default meta description
  keywords: 'HTML, CSS, Grav, Theme, One Page'      # Default meta keywords
  robots: 'noindex, nofollow'                       # Robots directive
```

## Themes

### Folder Structure

```
[GRAV/USER/THEMES/THEMENAME]
├── css                                             // Stylesheets
├── images                                          // Theme images (logo, favicon, etc.)
├── js                                              // JavaScript files
├── templates                                       // Twig template files
│   ├── modular                                     // Modular page blocks
│   │   ├── error.module.html.twig
│   │   └── footer.html.twig
│   ├── partials                                    // Reusable template parts
│   │   ├── base.html.twig
│   │   ├── header.html.twig
│   │   ├── nav.html.twig
│   │   ├── aside.html.twig
│   │   └── footer.html.twig
│   ├── home.html.twig                              // Start Page-Template
│   ├── default.html.twig                           // Default Page-Template
│   ├── error.html.twig                             // Error Page-Template
│   ├── blog.html.twig                              // Blog Page-Template
│   └── item.html.twig                              // Blog-Item Page-Template
├── blueprints.yaml                                 // Admin panel configuration for theme
├── themename.php                                   // Theme class (optional logic/hooks)
├── themename.yaml                                  // Default theme configuration
├── screenshot.jpg                                  // 1009px x 1009px theme preview
└── thumbnail.jpg                                   // 300px x 300px theme thumbnail
```

### Snippets

#### themename.yaml

```yaml
enabled: true # Enables or disables the theme
default_lang: en # Fallback language if not defined elsewhere
dropdown:
  enabled: true # Enables dropdown navigation in menu
```

#### themename.php

```php
<?php

namespace Grav\Theme;

use Grav\Common\Theme;

/**
 * Theme class
 * Used to add custom logic, event hooks, or asset handling.
 */

class Simple extends Theme {}
```

#### blueprints.yaml

```yaml
# Theme metadata (shown in Admin panel)

name: Simple
slug: simple
type: theme
version: 1.0.0
description: "Simple theme for Grav CMS"
icon: microchip

author:
  name: Team Simple
  email: simple@example.com
  url: localhost

homepage: localhost
demo: localhost
bugs: localhost
license: MIT

dependencies:
  - { name: grav, version: ">=1.7.0" }

# Admin form configuration
form:
  validation: strict
  fields:
    dropdown.enabled:
      type: toggle
      label: Dropdown in Navigation
      highlight: 1
      default: 1
      options:
        1: Enabled
        0: Disabled
      validate:
        type: bool
```

#### base.html.twig

```twig
{% set theme_config = attribute(config.themes, config.system.pages.theme) %}

<!doctype html>
<html lang="{{ (grav.language.getActive ?: theme_config.default_lang)|e }}">
  <head>
    {% block head %}
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="canonical" href="{{ page.url(true, true)|e }}" />
        {% include 'partials/metadata.html.twig' %}

        <!-- Open Graph Meta Tags -->
        <meta property="og:title" content="{{ site.title }}" />
        <meta property="og:description" content="{{ site.description }}" />
        <meta property="og:image" content="{{ url('theme://images/favicon.svg') }}" />
        <meta property="og:site_name" content="{{ site.title }}" />
        <meta property="og:url" content="{{ page.url(true, true) }}" />

        <!-- Title Tag -->
        <title>{% if header.title %}{{ header.title|e }} | {% endif %}{{ site.title|e }}</title>

        <!-- FavIcons -->
        <link rel="icon" type="image/x-icon" href="{{ url('theme://images/favicon.svg') }}" />
    {% endblock head %}

    <!-- Print -->
    <link rel="stylesheet" href="{{ url('theme://css/print.css') }}" media="print" />

    <!-- Styles -->
    {% block stylesheets %}
        {% do assets.addCss('theme://css/reset.css', 100) %}
        {% do assets.addCss('theme://css/skeleton.css', 99) %}
        {% do assets.addCss('theme://css/style.css', 98) %}
        {% do assets.addCss('theme://css/theme.css', 97) %}
    {% endblock %}

    {% block javascripts %}
        {% do assets.addJs('https://code.jquery.com/jquery-4.0.0.min.js', 100) %}
    {% endblock %}

    {% block assets deferred %}
        {{ assets.css()|raw }}
        {{ assets.js()|raw }}
    {% endblock %}
  </head>
  <body class="{% block body_classes %}{{ body_classes }}{% endblock %}">
    <div class="wrapper">
        {% block header %}
            {% include 'partials/header.html.twig' %}
        {% endblock %}
        {% block nav %}
            {% include 'partials/nav.html.twig' %}
        {% endblock %}

        {% block main %}
            <main>
                <div class="row">
                    <div class="column">
                        <h1>{{ page.title|e }}</h1>
                        {% block content %}
                            {{ page.content|raw }}
                        {% endblock content %}
                    </div>
                </div>
            </main>
        {% endblock main %}

        {% block aside %}
            {% include 'partials/aside.html.twig' %}
        {% endblock %}
        {% block footer %}
            {% include 'partials/footer.html.twig' %}
        {% endblock %}

        <!-- Scripts -->
        {% block bottom %}
            {{ assets.js('bottom')|raw }}
        {% endblock %}
    </body>
</html>
```

#### header.html.twig

```twig
<header>
    <div class="row">
        <div class="column">
            <div class="box-logo">
                <img class="header-logo" id="header-logo" src="{{ url('theme://images/logo.svg')|e }}" alt="image loading" loading="lazy" />
            </div>
            <div class="box-title">
                <span class="header-title">{{ site.title }}</span>
            </div>
        </div>
    </div>
</header>
```

#### nav.html.twig

```twig
<nav id="nav">
    <div class="row">
        <div class="column">
            <menu class="main-menu">
                {% for page in pages.children %}
                    {% if page.visible %}
                        {% set current_page = (page.active or page.activeChild) ? 'current_page_item' : '' %}
                        {% if page.children.count > 0 %}
                            <li class="menu-item menu-item-has-children {{ current_page }}"><a href="{{ page.url }}">{{ page.menu }}</a>
                            <ul class="sub-menu">
                                {{ _self.loop(page) }}
                            </ul>
                        {% else %}
                            <li class="menu-item {{ current_page }}"><a href="{{ page.url }}">{{ page.menu }}</a>
                        {% endif %}
                    {% endif %}
                {% endfor %}
            </main>
        </div>
    </div>
</nav>
```

#### aside.html.twig

```twig
<aside>
    <div class="row">
        <div class="column">
            {% block error %}
                {% include 'modular/search.module.html.twig' %}
            {% endblock %}
        </div>
    </div>
</aside>
```

#### search.module.html.twig

```twig
<div class="box-search">
    <form method="get" action="./search">
        <input type="text" name="q" value="" placeholder="..." />
        <button type="submit">Search</button>
    </form>
</div>
```

#### default.html.twig

```twig
{% extends 'partials/base.html.twig' %}
```

#### error.html.twig

```twig
{% extends 'partials/base.html.twig' %}

{% block main %}
    <main>
        <div class="row">
            <div class="column">
                {% block error %}
                    {% include 'modular/error.module.html.twig' %}
                {% endblock %}
            </div>
        </div>
    </main>
{% endblock main %}
```

#### error.module.html.twig

```twig
<div class="box-error">
    <h1>{{ 'ERROR'|t }} {{ page.header.http_response_code }}</h1>
    <p>Sorry, but we can't find the page you are looking for.</p>
    <a href="{{ base_url }}" rel="nofollow">Go Back</a>
</div>
```

#### home.html.twig

```twig
{% extends 'partials/base.html.twig' %}

{% block main %}
    <main>
        <div class="row hero">
            <div class="column">
                {% block hero %}
                    {% include 'modular/hero.module.html.twig' %}
                {% endblock %}
            </div>
        </div>
        <div class="row">
            <div class="column">
                {% block content %}
                    {{ page.content|raw }}
                {% endblock content %}
            </div>
        </div>
    </main>
{% endblock main %}
```

#### hero.module.html.twig

```twig
<div class="box-hero">
    <span class="hero-title">Hero</span>
</div>
```

#### blog.html.twig

```twig
{% extends 'partials/base.html.twig' %}

{% block main %}
    <main>
        <div class="row">
            <div class="column">
                {% block blog %}
                    {% include 'modular/blog.module.html.twig' %}
                {% endblock %}
            </div>
        </div>
    </main>
{% endblock main %}
```

#### blog.module.html.twig

```twig
{# --- get all posts recursively --- #}
{% set collection = page.collection({items: {'@page.descendants': '/blog'}, order: {'by': 'date', 'dir': 'desc'}}) %}
{% set perPage = 3 %}

{# --- get current page from query string --- #}
{% set currentPage = uri.query('page')|default(1)|int %}
{% set totalItems = collection|length %}
{% set totalPages = (totalItems / perPage)|round(0, 'ceil') %}
{% set start = (currentPage - 1) * perPage %}
{% set paginated = collection|slice(start, perPage) %}

{# --- date format --- #}
{% set dateformat = admin.page.dateformat ?: config.system.pages.dateformat.short ?: "F d, Y" %}

{# --- content --- #}
<h1>{{ page.title|e }}</h1>

<div class="box-blog">
    {% for post in paginated %}
        <div class="blog-post-item">
            {# --- Featured Image --- #}
            {% set image = post.media[post.header.header_image] ?? post.media.images|first %}
            {% if image %}
                <div class="post-image">
                    {{ image.cropZoom(320,180).html|raw }}
                </div>
            {% endif %}

            <div class="post-content">
                {# --- Title --- #}
                <div class="post-title">
                    {{ post.title|e }}
                </div>

                {# --- Date --- #}
                <div class="post-date">
                    {{ post.date|date(dateformat)|e }}
                </div>

                {# --- Excerpt --- #}
                <div class="post-excerpt">
                    {{ post.summary(150)|raw }}
                </div>

                {# --- URL (visible link) --- #}
                <div class="post-url">
                    <a href="{{ post.url|e }}">read more</a>
                </div>
            </div>
        </div>
    {% else %}
        <p>No posts found.</p>
    {% endfor %}
</div>

{# --- Pagination --- #}
{% if totalPages > 1 %}
<div class="box-blog-pagination">

    {% if currentPage > 1 %}
        <a href="{{ page.url }}?page={{ currentPage - 1 }}">
            &laquo; Previous
        </a>
    {% endif %}

    {% for i in 1..totalPages %}
        {% if i == currentPage %}
            <span class="current">{{ i }}</span>
        {% else %}
            <a href="{{ page.url }}?page={{ i }}">{{ i }}</a>
        {% endif %}
    {% endfor %}

    {% if currentPage < totalPages %}
        <a href="{{ page.url }}?page={{ currentPage + 1 }}">
            Next &raquo;
        </a>
    {% endif %}

</div>
{% endif %}
```

#### item.html.twig

```twig
{% extends 'partials/base.html.twig' %}

{% block main %}
    <main>
        <div class="row">
            <div class="column">
                {# --- Title --- #}
                <h1>{{ page.title|e }}</h1>

                {# --- Article --- #}
                <article class="blog-article">
                    <div class="blog-article-left">
                        {# --- Featured Image --- #}
                        {% set image = page.media[page.header.header_image] ?? page.media.images|first %}
                        {% if image %}
                            {{ image.cropZoom(640,360).html|raw }}
                        {% endif %}
                    </div>
                    <div class="blog-article-right">
                        {# --- Content --- #}
                        {% block content %}
                            {{ page.content|raw }}
                        {% endblock content %}
                    </div>
                </article>
            </div>
        </div>
    </main>
{% endblock main %}
```

#### search.html.twig

```twig
{% extends 'partials/base.html.twig' %}

{% block main %}
    <main>
        <div class="row">
            <div class="column">

                {# --- Search query --- #}
                {% set query = uri.query('q') %}
                {% set results = [] %}

                {# --- Title --- #}
                <h1>Search Results for: "{{ query }}"</h1>

                {# --- Search results --- #}
                {% if query %}
                    {% set searchTerm = query|trim|lower %}

                    {% for p in grav.pages.all() %}
                        {% if p.published and p.template != 'search' %}

                            {% set title = p.title|lower %}
                            {% set content = p.content|striptags|lower %}

                            {% if searchTerm in title or searchTerm in content %}
                                {% set results = results|merge([p]) %}
                            {% endif %}

                        {% endif %}
                    {% endfor %}

                    {% if results|length > 0 %}
                        <p>Found on pages:</p>
                        <ul>
                            {% for p in results %}
                                <li><a href="{{ p.url }}">{{ p.title }}</a></li>
                            {% endfor %}
                        </ul>
                    {% else %}
                        <p>No results found.</p>
                    {% endif %}
                {% endif %}
            </div>
        </div>
    </main>
{% endblock main %}
```
