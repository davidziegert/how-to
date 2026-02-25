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