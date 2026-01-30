<?php

namespace Botble\Page\Forms;

use Botble\Base\Forms\FieldOptions\ContentFieldOption;
use Botble\Base\Forms\FieldOptions\DescriptionFieldOption;
use Botble\Base\Forms\FieldOptions\NameFieldOption;
use Botble\Base\Forms\FieldOptions\SelectFieldOption;
use Botble\Base\Forms\FieldOptions\StatusFieldOption;
use Botble\Base\Forms\Fields\EditorField;
use Botble\Base\Forms\Fields\MediaImageField;
use Botble\Base\Forms\Fields\SelectField;
use Botble\Base\Forms\Fields\TextareaField;
use Botble\Base\Forms\Fields\TextField;
use Botble\Base\Forms\FormAbstract;
use Botble\Page\Http\Requests\PageRequest;
use Botble\Page\Models\Page;
use Botble\Page\Supports\Template;

class PageForm extends FormAbstract
{
    public function setup(): void
    {
        $this
            ->model(Page::class)
            ->setValidatorClass(PageRequest::class)
            ->hasTabs()
            ->add('name_row_open', 'html', ['html' => '<div class="row">',])
            ->add('name_ar', TextField::class, NameFieldOption::make()->label(trans('Name arabic'))->placeholder(trans('Name arabic'))->maxLength(120)->required()->wrapperAttributes(['class' => 'form-group col-12 col-md-6'])->toArray()) //placeholder change to name_ar and take name and name_ar in one line
            ->add('name', TextField::class, NameFieldOption::make()->maxLength(120)->required()->wrapperAttributes(['class' => 'form-group col-12 col-md-6'])->toArray())
            ->add('name_row_close', 'html', ['html' => '</div>',])

            ->add('description_row_start', 'html', ['html' => '<div class="row">'])
            ->add('description_ar', TextareaField::class, DescriptionFieldOption::make()->label(trans('Description Arabic'))->placeholder(trans('Description Arabic'))->wrapperAttributes(['class' => 'form-group col-md-6'])->toArray()) //placeholder change to description_ar
            ->add('description', TextareaField::class, DescriptionFieldOption::make()->label(trans('Description'))->placeholder(trans('Description'))->wrapperAttributes(['class' => 'form-group col-md-6'])->toArray())
            ->add('description_row_end', 'html', ['html' => '</div>'])

            ->add('link', TextField::class)

            ->add('content_row_start', 'html', ['html' => '<div class="row">'])
            ->add('content_ar', EditorField::class, ContentFieldOption::make()->allowedShortcodes()->label(trans('Content Arabic'))->placeholder(trans('Content Arabic'))->wrapperAttributes(['class' => 'form-group col-md-6'])->toArray()) //placeholder change to content_ar
            ->add('content', EditorField::class, ContentFieldOption::make()->allowedShortcodes()->label(trans('Content'))->placeholder(trans('Content'))->wrapperAttributes(['class' => 'form-group col-md-6'])->toArray())
            ->add('content_row_end', 'html', ['html' => '</div>'])

            ->add('status', SelectField::class, StatusFieldOption::make()->toArray())
            ->when(Template::getPageTemplates(), function (PageForm $form, array $templates) {
                return $form
                    ->add(
                        'template',
                        SelectField::class,
                        SelectFieldOption::make()
                            ->label(trans('core/base::forms.template'))
                            ->required()
                            ->choices($templates)
                            ->toArray()
                    );
            })
            ->add('image', MediaImageField::class)
            ->add('mobile_image', MediaImageField::class)
            ->setBreakFieldPoint('status');
    }
}
