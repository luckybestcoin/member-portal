<nav class="pcoded-navbar">
    <div class="pcoded-inner-navbar main-menu">
        <div class="pcoded-navigatio-lavel">Navigation</div>
        <ul class="pcoded-item pcoded-left-item">
        @php
            $currentUrl = '/'.Request::path();

            function renderSubMenu($value, $currentUrl) {
                $subMenu = '';
                $GLOBALS['sub_level'] += 1 ;
                foreach ($value as $key => $menu) {
                    $GLOBALS['active'][$GLOBALS['sub_level']] = '';
                    $currentLevel = $GLOBALS['sub_level'];
                        $GLOBALS['subparent_level'] = '';

                        $subSubMenu = '';
                        $hasSub = (!empty($menu['sub_menu'])) ? 'pcoded-hasmenu' : '';
                        $hasTitle = (!empty($menu['title'])) ? '<span class="pcoded-mtext">'. $menu['title'] .'</span>' : '';

                        if (!empty($menu['sub_menu'])) {
                            $subMenu .= '<ul class="pcoded-submenu">';
                            $subSubMenu .= renderSubMenu($menu['sub_menu'], $currentUrl);
                            $subSubMenu .= '</ul>';
                        }

                        $active = ($currentUrl === $menu['url']? 'active pcoded-trigger' : '');

                        if ($active) {
                            $GLOBALS['parent_active'] = true;
                            $GLOBALS['active'][$GLOBALS['sub_level'] - 1] = true;
                        }
                        if (!empty($GLOBALS['active'][$currentLevel])) {
                            $active = 'active pcoded-trigger';
                        }

                        $subMenu .= '
                            <li class="'. $hasSub .' '. $active .'">
                                <a href="'. $menu['url'] .'">'. $hasTitle .'</a>
                                '. $subSubMenu .'
                            </li>
                        ';
                }
                return $subMenu;
            }

            foreach (config('sidebar.menu') as $key => $menu) {
                $GLOBALS['parent_active'] = '';

                $hasSub = (!empty($menu['sub_menu'])) ? 'pcoded-hasmenu' : '';
                $hasIcon = (!empty($menu['icon'])) ? '<span class="pcoded-micon"><i class="'.$menu['icon'].'"></i></span>' : '';
                $hasTitle = (!empty($menu['title'])) ? '<span class="pcoded-mtext">'. $menu['title'] .'</span>' : '';

                $subMenu = '';

                if (!empty($menu['sub_menu'])) {
                    $GLOBALS['sub_level'] = 0;
                    $subMenu .= '<ul class="pcoded-submenu">';
                    $subMenu .= renderSubMenu($menu['sub_menu'], $currentUrl);
                    $subMenu .= '</ul>';
                }
                $active = ($currentUrl === $menu['url']? 'active pcoded-trigger' : '');
                $active = empty($active) && !empty($GLOBALS['parent_active']) ? 'active pcoded-trigger' : $active;

                echo '
                    <li class="'. $hasSub .' '. $active .'">
                        <a href="'. $menu['url'] .'">
                            '. $hasIcon .'
                            '. $hasTitle .'
                        </a>
                        '. $subMenu .'
                    </li>
                ';
            }
        @endphp
        </ul>
    </div>
</nav>
