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
enabled: true                                       # Enables or disables the theme
default_lang: en                                    # Fallback language if not defined elsewhere
dropdown:
  enabled: true                                     # Enables dropdown navigation in menu
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


{# ===== HEAD SECTION ===== #}

{# Get active theme configuration #}
{% set theme_config = attribute(config.themes, config.system.pages.theme) %}

{# Output active language (fallback to theme default) #}
{{ (grav.language.getActive ?: theme_config.default_lang)|e }}

{% block head %}

    {# Include meta tags (description, keywords, etc.) #}
    {% include 'partials/metadata.html.twig' %}

    {# Page title logic: If page has custom title → use it, otherwise fallback to site title #}
    {% if header.title %}{{ header.title|e }} | {% endif %}{{ site.title|e }}

    {# Favicon path (theme stream) #}
    {{ url('theme://images/favicon.svg') }}

    {# Canonical URL for SEO #}
    {{ page.url(true, true)|e }}

{% endblock head %}


{# Print CSS file for print media #}
{{ url('theme://css/print.css') }}


{# ===== ASSET SECTION ===== #}

{% block stylesheets %}
    {# Register stylesheets with Grav Asset Manager Priority controls load order (higher loads first) #}
    {% do assets.addCss('theme://css/reset.css', 100) %}
    {% do assets.addCss('theme://css/skeleton.css', 99) %}
    {% do assets.addCss('theme://css/style.css', 98) %}
    {% do assets.addCss('theme://css/theme.css', 97) %}
{% endblock %}

{% block javascripts %}
    {# Register JavaScript files #}
    {% do assets.addJs('https://code.jquery.com/jquery-4.0.0.min.js', 100) %}
{% endblock %}

{% block assets deferred %}
    {# Output registered CSS and JS #}
    {{ assets.css()|raw }}
    {{ assets.js()|raw }}
{% endblock %}

{# ===== BODY SECTION ===== #}

{# Body class block (can be extended by child templates) #}
{% block body_classes %}{{ body_classes }}{% endblock %}

{# Include header partial #}
{% block header %}
    {% include 'partials/header.html.twig' %}
{% endblock %}

{# Include navigation partial #}
{% block nav %}
    {% include 'partials/nav.html.twig' %}
{% endblock %}

{# Main content block #}
{% block main %}
    {{ page.title }}

    {% block content %}
        {{ page.content|raw }}
    {% endblock content %}
{% endblock main %}

{# Include sidebar (optional) #}
{% block aside %}
    {% include 'partials/aside.html.twig' %}
{% endblock %}

{# Include footer partial #}
{% block footer %}
    {% include 'partials/footer.html.twig' %}
{% endblock %}

{# Bottom JS (for deferred scripts) #}
{% block bottom %}
    {{ assets.js('bottom')|raw }}
{% endblock %}
```

#### header.html.twig

```twig
# Logo Path
{{ url('theme://images/logo.svg')|e }}

# Website title
{{ site.title }}
```

#### nav.html.twig

```twig
{# Loop through visible top-level pages #}
{% for page in pages.children %}

    {% if page.visible %}

        {# Add class if page is active or parent of active page #}
        {% set current_page = (page.active or page.activeChild) ? 'current_page_item' : '' %}

        {% if page.children.count > 0 %}
            {# Dropdown menu item #}
            <li class="menu-item menu-item-has-children {{ current_page }}">
                <a href="{{ page.url }}">{{ page.menu }}</a>

                <ul class="sub-menu">
                    {{ _self.loop(page) }}
                </ul>
            </li>
        {% else %}
            {# Single-level menu item #}
            <li class="menu-item {{ current_page }}">
                <a href="{{ page.url }}">{{ page.menu }}</a>
            </li>
        {% endif %}

    {% endif %}
{% endfor %}
```

#### default.html.twig

```twig
# Load base.html.twig
{% extends 'partials/base.html.twig' %}
```

#### error.html.twig

```twig
# Load base.html.twig
{% extends 'partials/base.html.twig' %}

# Override the main block
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
# Error response code
{{ 'ERROR'|t }} {{ page.header.http_response_code }}

# Link to start page
{{ base_url }}
```

#### home.html.twig

```twig
# Load base.html.twig
{% extends 'partials/base.html.twig' %}

# Override the main block
{% block main %}
    <main>
        <div class="row">
            <div class="column">
                {% block hero %}
                    {% include 'modular/hero.module.html.twig' %}
                {% endblock %}
            </div>
            <div class="column">
                {% block content %}
                    {{ page.content|raw }}
                {% endblock content %}
            </div>
        </div>
    </main>
{% endblock main %} 
```

#### blog.html.twig

```twig
# Load base.html.twig
{% extends 'partials/base.html.twig' %}

# Override the main block
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
{# Get blog posts from /blog recursively, ordered by date DESC #}
{% set collection = page.collection({items: {'@page.descendants': '/blog'}, order: {'by': 'date', 'dir': 'desc'}}) %}

{# Pagination settings #}
{% set perPage = 3 %}
{% set currentPage = uri.query('page')|default(1)|int %}
{% set totalItems = collection|length %}
{% set totalPages = (totalItems / perPage)|round(0, 'ceil') %}
{% set start = (currentPage - 1) * perPage %}
{% set paginated = collection|slice(start, perPage) %}

{# Date format (Admin → System → Pages fallback) #}
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
                <article class="blog-article">
                    {# --- Featured Image --- #}
                    {% set image = page.media[page.header.header_image] ?? page.media.images|first %}
                    {% if image %}
                        {{ image.cropZoom(640,360).html|raw }}
                    {% endif %}

                    {# --- Title --- #}
                    <h1>{{ page.title|e }}</h1>

                    {# --- Content --- #}
                    {% block content %}
                        {{ page.content|raw }}
                    {% endblock content %}
                </article>
            </div>
        </div>
    </main>
{% endblock main %}
```
