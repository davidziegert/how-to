# Installation

```code
composer require fastvolt/markdown
```

## Basic Usage

```php
use FastVolt\Helper\Markdown;

$text = "## Hello, World";

// initialize markdown object
$markdown = new Markdown(); // or Markdown::new()

// set markdown content
$markdown->setContent($text);

// compile as raw HTML
echo $markdown->toHtml();
```
