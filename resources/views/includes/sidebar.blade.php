
        <!-- Main Sidebar Container -->
        <aside class="main-sidebar elevation-1 sidebar-light-primary">
            <!-- Brand Logo -->
            <a href="/" class="brand-link text-sm">
                <img src="/images/luckybestcoin.png" alt="{{ config("app.name") }}" class="brand-image ">
            </a>

            <!-- Sidebar -->
            <div class="sidebar">
                <!-- Sidebar user panel (optional) -->
                <div class="user-panel mt-3 pb-3 mb-3 d-flex">
                    <div class="image">
                        <img src="/images/user.png" alt="User Image">
                    </div>
                    <div class="info">
                        <a href="#" class="d-block">
                        {{ auth()->user()->member_name }}
                        </a>
                    </div>
                </div>

                <!-- SidebarSearch Form -->
                <div class="form-inline">
                    <div class="input-group" data-widget="sidebar-search">
                    <input class="form-control form-control-sidebar" type="search" placeholder="Search" aria-label="Search">
                    <div class="input-group-append">
                        <button class="btn btn-sidebar">
                        <i class="fas fa-search fa-fw"></i>
                        </button>
                    </div>
                    </div>
                </div>

                <!-- Sidebar Menu -->
                <nav class="mt-2">
                    <ul class="nav nav-pills nav-sidebar flex-column nav-legacy text-sm nav-child-indent" data-widget="treeview" role="menu" data-accordion="false">
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
                                    $hasSub = (!empty($menu['sub_menu'])) ? 'has-sub' : '';
                                    $hasCaret = (!empty($menu['sub_menu'])) ? '<i class="fas fa-angle-left right"></i>' : '';
                                    $hasTitle = (!empty($menu['title'])) ? $menu['title'] : '';

                                    if (!empty($menu['sub_menu'])) {
                                        $subSubMenu .= '<ul class="nav nav-treeview">';
                                        $subSubMenu .= renderSubMenu($menu['sub_menu'], $currentUrl);
                                        $subSubMenu .= '</ul>';
                                    }

                                    $active = $currentUrl == $menu['url']? 'active' : '';

                                    if ($active) {
                                        $GLOBALS['parent_active'] = true;
                                        $GLOBALS['active'][$GLOBALS['sub_level'] - 1] = true;
                                    }

                                    if (!empty($GLOBALS['active'][$currentLevel])) {
                                        $active = 'active';
                                    }

                                    $subMenu .= '
                                        <li class="nav-item '. $hasSub .'">
                                            <a href="'.($menu['url'] == 'javascript:;'? $menu['url']: url($menu['url'])) .'" class="nav-link '. $active .'"><i class="far fa-circle nav-icon"></i><p>'. $hasCaret . $hasTitle .'</p></a>
                                            '. $subSubMenu .'
                                        </li>
                                    ';
                            }
                            return $subMenu;
                        }

                        foreach (config('sidebar.menu') as $key => $menu) {
                            $GLOBALS['parent_active'] = '';

                            $hasTitle = (!empty($menu['title'])) ? $menu['title'] : '';
                            $hasCaret = !empty($menu['sub_menu']) ? '<i class="right fas fa-angle-left"></i>': '';

                            $subMenu = '';

                            if (!empty($menu['sub_menu'])) {
                                $GLOBALS['sub_level'] = 0;
                                $subMenu .= '<ul class="nav nav-treeview">';
                                $subMenu .= renderSubMenu($menu['sub_menu'], $currentUrl);
                                $subMenu .= '</ul>';
                                $active = strpos($currentUrl, $menu['url']) === 0? 'menu-open' : '';
                                $active = empty($active) && !empty($GLOBALS['parent_active']) ? 'menu-open' : $active;
                            }else{
                                $active = strpos($currentUrl, $menu['url']) === 0? 'active' : '';
                            }

                            echo '
                                <li class="nav-item '. (!empty($menu['sub_menu'])? $active: '') .'">
                                    <a href="'. $menu['url'] .'" class="nav-link '.(strlen($active) > 0? 'active': '').'">
                                        '. $menu['icon'] .'
                                        <p>'. $hasTitle .' '.$hasCaret.'</p>
                                    </a>
                                    '.$subMenu.'
                                </li>
                            ';
                        }
                    @endphp
                    <!-- Add icons to the links using the .nav-icon class
                        with font-awesome or any other icon font library -->
                    </ul>
                </nav>
                <!-- /.sidebar-menu -->
            </div>
            <!-- /.sidebar -->
        </aside>
