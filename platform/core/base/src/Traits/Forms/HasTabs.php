<?php

namespace Botble\Base\Traits\Forms;

use Botble\Base\Forms\FormTab;

trait HasTabs
{
    public function hasTabs(): static
    {
        $this->template('core/base::forms.form-tabs');

        return $this;
    }

    public function addTab(FormTab $tab): static
    {
        $this->hasTabs();

        $id = $tab->getId();

        $content = view('core/base::forms.tabs.tab-content', ['id' => $id, 'content' => $tab->getContent()]);

        add_filter(
            BASE_FILTER_REGISTER_CONTENT_TABS,
            fn (?string $html) => $html . view('core/base::forms.tabs.tab-item', ['id' => $id, 'label' => $tab->getLabel()]),
            999
        );

        add_filter(
            BASE_FILTER_REGISTER_CONTENT_TAB_INSIDE,
            fn (?string $html): ?string => $html . $content,
            999
        );

        return $this;
    }

    public function addTabs(array $tabs): static
    {
        foreach ($tabs as $tab) {
            $this->addTab($tab);
        }

        return $this;
    }
}
