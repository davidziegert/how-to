# How To - Typo3 - Fluid Template Sitepackage [^1] [^2]

## Folder Structure Example

path:   typo3_installation/typo3conf/ext/site_package/

```
site_package
├── Configuration
│	├── TCA
│	│	└── Overrides
│	│		└── sys_template.php
│	└── TypoScript
│		├── constants.typoscript
│		├── setup.typoscript
│		└── Setup
│			└── Page.typoscript
├── Resources
│   ├── Private
│   │   ├── Language
│   │   ├── Layouts
│   │   │   └── Page
│   │   ├── Partials
│   │   │   └── Page
│   │   │   	├── Header.html
│   │   │   	├── Nav.html
│   │   │   	├── Main.html
│   │   │   	├── Aside.html
│   │   │   	└── Footer.html
│   │   ├── Templates
│   │   │   └── Page
│   │   │   	└── Default.html
│   │   └── .htaccess
│   └── Public
│       ├── Css     
│       │   └── custom.css
│       ├── Images
│       │   └── logo.png
│       ├── JavaScript
│       |   └── custom.js
│       ├── Fonts
│       |   └── custom.woff2
│       ├── Icons
│       |   └── custom.ico
│       └── Scss
│           └── custom.scss
├── composer.json
├── ext_emconf.php
└── ext_localconf.php
```

### \Resources\Private\

#### Language
- The directory Language/ may contain .xlf files that are used for the localization of labels and text strings (frontend as well as backend) by TYPO3. This topic is not strictly related to the Fluid template engine and is documented in section Internationalization and Localization.

#### Layouts

- HTML files, which build the overall layout of the website, are stored in the Layouts/ folder. Typically this is only one construct for all pages across the entire website. Pages can have different layouts of course, but page layouts do not belong into the Layout/ directory. They are stored in the Templates/ directory (see below). In other words, the Layouts/ directory should contain the global layout for the entire website with elements which appear on all pages (e.g. the company logo, navigation menu, footer area, etc.). This is the skeleton of your website.

#### Templates

- The most important fact about HTML files in the Templates/ directory has been described above already: this folder contains layouts, which are page- specific. Due to the fact that a website usually consists of a number of pages and some pages possibly show a different layout than others (e.g. number of columns), the Templates/ directory may contain one or multiple HTML files.

#### Partials

- The directory called Partials/ may contain small snippets of HTML template files. "Partials" are similar to templates, but their purpose is to represent small units, which are perfect to fulfil recurring tasks. A good example of a partial is a specially styled box with content that may appear on several pages. If this box would be part of a page layout, it would be implemented in one or more HTML files inside the Templates/ directory. If an adjustment of the box is required at one point in the future, this would mean that several template files need to be updated. However, if we store the HTML code of the box as a small HTML snippet into the Partials/ directory, we can include this snippet at several places. An adjustment only requires an update of the partial and therefore in one file only. 

- The use of partials is optional, whereas files in the Layouts/ and Templates/ directories are mandatory for a typical sitepackage extension. 

- The sitepackage extension described in this tutorial focuses on the implementation of pages, rather than specific content elements. Therefore, folders Layouts/, Templates/ and Partials/ all show a sub- directory Page/.
Language

- The directory Language/ may contain .xlf files that are used for the localization of labels and text strings (frontend as well as backend) by TYPO3. This topic is not strictly related to the Fluid template engine and is documented in section Internationalization and Localization.

#### .htaccess

```
Order deny,allow
Deny from all
```

#### \Resources\Private\Templates\Page\Default.html

---

<div class="wrapper">
    <f:render partial="Nav.html" arguments="{_all}"/>
    <f:render partial="Header.html" arguments="{_all}"/>
    <f:render partial="Main.html" arguments="{_all}"/>
    <f:render partial="Aside.html" arguments="{_all}"/>
    <f:render partial="Footer.html" arguments="{_all}"/>
</div>

---

##### \Resources\Private\Partials\Page\

###### Nav.html

---
<nav>
    <div class="row">
        <div>
            <button id="hamburger" onclick="toggleMobileMenu()">
                <span></span>
                <span></span>
                <span></span>
                <span></span>
            </button>
            <span>MENU</span>
        </div>

        <div id="menu">
            <ul class="main-menu">
                <f:for each="{mainMenu}" as="mainMenuItem">
                    <li class="menu-item {f:if(condition:'{mainMenuItem.children}',then:'dropdown')} {f:if(condition: mainMenuItem.active, then:'active')}">
                        <f:if condition="{mainMenuItem.children}">
                            <f:then>
                                <!-- Item has children -->
                                <a class="menu-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">{mainMenuItem.title}</a>
                                <ul class="sub-menu">
                                    <f:for each="{mainMenuItem.children}" as="subMenuItem">
                                        <li class="sub-menu-item {f:if(condition: mainMenuItem.children.active, then:'active')}">
                                            <a class="submenu-link" href="{subMenuItem.link}" target="{subMenuItem.target}" title="{subMenuItem.title}">{subMenuItem.title}</a>
                                        </li>
                                    </f:for>
                                </ul> 
                            </f:then>
                    
                            <f:else>
                                <!-- Item has no children -->
                                <a class="menu-link" href="{mainMenuItem.link}" target="{mainMenuItem.target}" title="{mainMenuItem.title}">{mainMenuItem.title}</a>
                            </f:else>
                        </f:if>
                    </li>
                </f:for>
            </ul>
        </div>
    </div>
</nav>
---

###### Header.html

---
<header>
    <div class="row">
        <div class="title">
            title not found
        </div>
        <div>
            <f:if condition="{languageMenu}">
                <ul id="language" class="language-menu">
                    <f:for each="{languageMenu}" as="item">
                    <li class="{f:if(condition: item.active, then: 'active')} {f:if(condition: item.available, else: ' text-muted')}">
                        <f:if condition="{item.available}">
                            <f:then>
                                <a href="{item.link}" hreflang="{item.hreflang}" title="{item.navigationTitle}"><span>{item.navigationTitle}</span></a>
                            </f:then>
                            <f:else>
                                <span>{item.navigationTitle}</span>
                            </f:else>
                        </f:if>
                    </li>
                    </f:for>
                </ul>
            </f:if>
        </div>
    </div>
</header>
---

###### Main.html

---
<main>
    <div class="row">
        <f:if condition="{breadcrumb}">
            <ol class="breadcrumb">
                <f:for each="{breadcrumb}" as="item">
                    <li class="breadcrumb-item{f:if(condition: item.current, then: ' active')}" >
                        <f:if condition="{item.current}">
                            <f:then>
                                <span class="divider">&raquo;</span><span class="breadcrumb-text">{item.title}</span>
                            </f:then>
                            <f:else>
                                <a class="breadcrumb-link" href="{item.link}" title="{item.title}"><span class="breadcrumb-text">{item.title}</span></a>
                            </f:else>
                        </f:if>
                    </li>
                </f:for>
            </ol>
        </f:if>   
    </div>
    <div class="row">
        <f:for each="{mainContent}" as="contentElement">
            <f:cObject typoscriptObjectPath="tt_content.{contentElement.data.CType}" data="{contentElement.data}" table="tt_content"/>
        </f:for>
    </div>
</main>
---

###### Aside.html

###### Footer.html

### \Configuration\TCA\Overrides\sys_template.php

---
<?php

	defined('TYPO3') or die();

	$extensionKey = 'site_package';

	\TYPO3\CMS\Core\Utility\ExtensionManagementUtility::addStaticFile(
		$extensionKey,
		'Configuration/TypoScript/',
		'Fluid Content Elements'
	);
---

### \Configuration\TsConfig\

### \Configuration\TypoScript\

#### constants.typoscript

---
@import 'EXT:fluid_styled_content/Configuration/TypoScript/constants.typoscript'

page {
  fluidtemplate {
    layoutRootPath = EXT:site_package/Resources/Private/Layouts/Page/
    partialRootPath = EXT:site_package/Resources/Private/Partials/Page/
    templateRootPath = EXT:site_package/Resources/Private/Templates/Page/
  }
}
---

#### setup.typoscript

---
@import 'EXT:fluid_styled_content/Configuration/TypoScript/setup.typoscript'
@import 'EXT:site_package/Configuration/TypoScript/Setup/*.typoscript'
---

### \Configuration\TypoScript\Setup\Page.typoscript

---
page = PAGE

// Part 1: Global Site Configuration

config {
   pageTitleSeparator = -
   pageTitleSeparator.noTrimWrap = | | |

   admPanel = 1
}

// Part 2: Meta Tags

page {
   meta {
      X-UA-Compatible = IE=edge
      X-UA-Compatible.attribute = http-equiv
      author = AUTHORNAME
      description = DESCRIPTION
      keywords = KEYWORD
   }
}

// Part 3: Open Graph Tags

page {
   meta {
      og:title = OG-TITLE
      og:title.attribute = property
      og:site_name = OG-SITENAME
      og:site_name.attribute = property
      og:description = OG:DESCRIPTION
      og:description.attribute = property
      og:locale = en_GB
      og:locale.attribute = property
      og:image.cObject = IMG_RESOURCE
      og:image.cObject.file = EXT:site_package/Resources/Public/Images/og_image.png
      og:url = https://www.yourserver.url
   }
}

// Part 4: CSS

page {
   includeCSS {
      file_01 = EXT:site_package/Resources/Public/Css/reset.css
      file_02 = EXT:site_package/Resources/Public/Css/custom.css
      file_03 = https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css
      file_04 = https://cdn.jsdelivr.net/gh/jpswalsh/academicons@1/css/academicons.min.css
   }
}

// Part 5: Favicon

page {
   shortcutIcon = EXT:site_package/Resources/Public/Icons/favicon.ico
}

// Part 6: Fluid Template

page {
   10 = FLUIDTEMPLATE
   10 {
         templateName = Default
		 
         templateRootPaths {
            0 = EXT:site_package/Resources/Private/Templates/Page/
         }
         partialRootPaths {
            0 = EXT:site_package/Resources/Private/Partials/Page/
         }
         layoutRootPaths {
            0 = EXT:site_package/Resources/Private/Layouts/Page/
         }

		dataProcessing {
         // Part 6.1: Navigation Menu
			10 = TYPO3\CMS\Frontend\DataProcessing\MenuProcessor
         10 {
            levels = 2
            expandAll = 1
            includeSpacer = 1
            as = mainMenu
         }

			// Part 6.2: Breadcrumbs
         20 = TYPO3\CMS\Frontend\DataProcessing\MenuProcessor
         20 {
            special = rootline
            special.range = 0|-1
            includeNotInMenu = 0
            begin = 2
            as = breadcrumb
         }

			// Part 6.3: Language Menu
         30 = TYPO3\CMS\Frontend\DataProcessing\LanguageMenuProcessor
         30 {
            languages = auto
            as = languageMenu
         }

			// Part 6.4: Main Content
			40 = TYPO3\CMS\Frontend\DataProcessing\DatabaseQueryProcessor
			40 {
				table = tt_content
				orderBy = sorting
				where = colPos = 0
				as = mainContent
			}
		}
	}
}

// Part 7: JavaScript

page {
  includeJSFooter {
      jquery = https://code.jquery.com/jquery-3.6.3.slim.min.js
      jquery.external = 1
      file_01 = EXT:site_package/Resources/Public/JavaScript/custom.js
  }
}
---

### composer.json

```
{
	"name": "brand/site-package",
	"type": "typo3-cms-extension",
	"description": "Example site package from the site package tutorial",
	"authors": [{"name": "Your Name", "role": "Developer", "homepage": "https://yourserver.url"}],
	"require": {"typo3/cms-core": "^12.0.0|dev-main", "typo3/cms-fluid-styled-content": "^12.0.0|dev-main"},
	"homepage": "https://yourserver.url",
    "license": ["GPL-2.0-or-later"],
	"keywords": ["typo3", "site package"],
	"autoload": {"psr-4": {"Brand\\OwnPackage\\": "Classes/"}},
	"extra": {"typo3/cms": {"extension-key": "site_package"}}
}
```

### ext_emconf.php

```
<?php
	$EM_CONF[$_EXTKEY] = [
		'title' => 'TYPO3 Site Package',
		'description' => 'TYPO3 Site Package',
		'category' => 'templates',
		'author' => 'your name',
		'author_email' => 'your mail',
		'author_company' => 'your company',
		'version' => '1.0.0',
		'state' => 'stable',
		'constraints' => [
			'depends' => [
				'typo3' => '12.0.0-12.99.99',
				'fluid_styled_content' => '12.0.0-12.99.99'
			],
			'conflicts' => [
			],
		],
		'uploadfolder' => 0,
		'createDirs' => '',
		'clearCacheOnLoad' => 1
	];
```

### ext_localconf.php

```
<?php
    use TYPO3\CMS\Core\Utility\ExtensionManagementUtility;
    defined('TYPO3') or die();
```

## Extension installation without composer

- If TYPO3 has been installed the legacy way, by extracting the source package into the web directory without using PHP composer follow this tutorial for installation of the site-package extension:
By using this method, extensions (e.g. the sitepackage extension) can be installed using the Extension Manager, which is a module found in the backend of TYPO3.
It is highly recommended that you work locally on your machine using for example ddev.
Copy the directory site_package (including all files and sub-directories) to the following directory in your TYPO3 instance: typo3conf/ext/.
You can also create a ZIP file of the content of your site_package folder and name it site_package.zip. It is important that the ZIP archive does not contain the directory site_package and its files and directories inside this folder. The files and folders must be directly located on the first level of ZIP archive.

## Extension installation with Extension manager

- First of all, login at the backend of TYPO3 as a user with administrator privileges. At the left side you find a section Admin Tools with a module Extensions. Open this module and make sure, the drop down box on the right hand side shows Installed Extensions. If you have already uploaded the site package extension, search for "Site Package". If you created a ZIP file, upload the ZIP'ed extension by clicking the upload icon. Once the site package extension appears in the list, you can activate it by clicking the "plus" icon.

---

## Typo3 - Templates

- ### [First Try](/files/site_package.zip)

---

[^1]: https://docs.typo3.org/m/typo3/tutorial-sitepackage/main/en-us/
[^2]: https://docs.typo3.org/m/typo3/tutorial-sitepackage/main/en-us/Summary/Index.html
