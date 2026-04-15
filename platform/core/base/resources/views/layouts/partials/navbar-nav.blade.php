<ul @class(['navbar-nav', $navbarClass ?? null])>
    @foreach (DashboardMenu::getAll() as $menu)
        @include('core/base::layouts.partials.navbar-nav-item', [
            'menu' => $menu,
            'autoClose' => $autoClose,
            'isNav' => true,
        ])
    @endforeach
    {{-- <li>
        <a href='{{ route('smsa.index') }}' class="nav-link">
            <svg class="icon  svg-icon-ti-ti-article" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                <path d="M3 4m0 2a2 2 0 0 1 2 -2h14a2 2 0 0 1 2 2v12a2 2 0 0 1 -2 2h-14a2 2 0 0 1 -2 -2z"></path>
                <path d="M7 8h10"></path>
                <path d="M7 12h10"></path>
                <path d="M7 16h10"></path>
            </svg>
            &nbsp;&nbsp;SMSA Shipping
        </a>
    </li> --}}
    <li>
        <a href='{{ route('promotions.index') }}' class="nav-link">
            <svg class="icon svg-icon-ti-ti-discount" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><path d="M9 15l6 -6"></path><circle cx="9.5" cy="9.5" r=".5" fill="currentColor"></circle><circle cx="14.5" cy="14.5" r=".5" fill="currentColor"></circle><path d="M12 12m-9 0a9 9 0 1 0 18 0a9 9 0 1 0 -18 0"></path></svg>
            &nbsp;&nbsp;Promotion Master
        </a>
    </li>
</ul>
