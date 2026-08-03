<?php

namespace Botble\Ecommerce\Forms;

use Botble\Base\Facades\Assets;
use Botble\Base\Facades\Html;
use Botble\Base\Forms\FieldOptions\ContentFieldOption;
use Botble\Base\Forms\FieldOptions\EditorFieldOption;
use Botble\Base\Forms\FieldOptions\MediaImageFieldOption;
use Botble\Base\Forms\FieldOptions\NameFieldOption;
use Botble\Base\Forms\FieldOptions\NumberFieldOption;
use Botble\Base\Forms\FieldOptions\OnOffFieldOption;
use Botble\Base\Forms\FieldOptions\SelectFieldOption;
use Botble\Base\Forms\FieldOptions\StatusFieldOption;
use Botble\Base\Forms\Fields\EditorField;
use Botble\Base\Forms\Fields\MediaImageField;
use Botble\Base\Forms\Fields\MediaImagesField;
use Botble\Base\Forms\Fields\MultiCheckListField;
use Botble\Base\Forms\Fields\NumberField;
use Botble\Base\Forms\Fields\OnOffField;
use Botble\Base\Forms\Fields\SelectField;
use Botble\Base\Forms\Fields\TagField;
use Botble\Base\Forms\Fields\TextField;
use Botble\Base\Forms\Fields\TreeCategoryField;
use Botble\Base\Forms\FormAbstract;
use Botble\Ecommerce\Enums\GlobalOptionEnum;
use Botble\Ecommerce\Enums\ProductTypeEnum;
use Botble\Ecommerce\Facades\EcommerceHelper;
use Botble\Ecommerce\Facades\ProductCategoryHelper;
use Botble\Ecommerce\Forms\Fronts\Auth\FieldOptions\TextFieldOption;
use Botble\Ecommerce\Http\Requests\ProductRequest;
use Botble\Ecommerce\Models\Brand;
use Botble\Ecommerce\Models\GlobalOption;
use Botble\Ecommerce\Models\Product;
use Botble\Ecommerce\Models\ProductAttributeSet;
use Botble\Ecommerce\Models\ProductCollection;
use Botble\Ecommerce\Models\ProductLabel;
use Botble\Ecommerce\Models\ProductVariation;
use Botble\Ecommerce\Models\Tax;
use Botble\Ecommerce\Tables\ProductVariationTable;
use Botble\Ecommerce\Models\ProductFragranceNote;
use Botble\Base\Enums\BaseStatusEnum;
use Botble\Base\Forms\FieldOptions\HtmlFieldOption;
use Botble\Base\Forms\Fields\HtmlField;
use Botble\Slug\Forms\Fields\PermalinkField;
use Botble\Base\Forms\FieldOptions\DescriptionFieldOption;
use Botble\Base\Forms\Fields\TextareaField;

class ProductForm extends FormAbstract
{
    public function setup(): void
    {
        $this->addAssets();

        $brands = Brand::query()->pluck('name', 'id')->all();

        $productCollections = ProductCollection::query()->pluck('name', 'id')->all();

        $productLabels = ProductLabel::query()->pluck('name', 'id')->all();

        $productId = null;
        $selectedCategories = [];
        $tags = null;
        $totalProductVariations = 0;

        if ($this->getModel()) {
            $productId = $this->getModel()->id;

            $selectedCategories = $this->getModel()->categories()->pluck('category_id')->all();

            $totalProductVariations = ProductVariation::query()->where('configurable_product_id', $productId)->count();

            $tags = $this->getModel()->tags()->pluck('name')->implode(',');
        }

        $this
            ->setupModel(new Product())
            ->setValidatorClass(ProductRequest::class)
            ->setFormOption('files', true)
            ->add('row_name_open', HtmlField::class, HtmlFieldOption::make()->content('<div class="row g-3 align-items-start mb-2">')->toArray())
            ->add('name', TextField::class, NameFieldOption::make()->required()->wrapperAttributes(['class' => 'col-md-6'])->toArray())
            ->add('name_ar', TextField::class, TextFieldOption::make()->label('Product Name (Arabic / الاسم بالعربية)')->placeholder('أدخل اسم المنتج باللغة العربية')->wrapperAttributes(['class' => 'col-md-6'])->toArray())
            ->add('row_name_close', HtmlField::class, HtmlFieldOption::make()->content('</div>')->toArray())
            ->add('slug', PermalinkField::class, ['model' => $this->getModel(), 'colspan' => 'full',])
            ->add('row_desc_open', HtmlField::class, HtmlFieldOption::make()->content('<div class="row g-3 align-items-start mb-2">')->toArray())
            ->add('description', EditorField::class, EditorFieldOption::make()->label(trans('core/base::forms.description'))->placeholder(trans('core/base::forms.description_placeholder'))->wrapperAttributes(['class' => 'col-md-6'])->toArray())
            ->add('description_ar', EditorField::class, EditorFieldOption::make()->label('Short Description (Arabic / الوصف القصير بالعربية)')->placeholder('أدخل الوصف القصير باللغة العربية')->wrapperAttributes(['class' => 'col-md-6'])->toArray())
            ->add('row_desc_close', HtmlField::class, HtmlFieldOption::make()->content('</div>')->toArray())
            ->add('row_content_open', HtmlField::class, HtmlFieldOption::make()->content('<div class="row g-3 align-items-start mb-2">')->toArray())
            ->add('content', EditorField::class, ContentFieldOption::make()->allowedShortcodes()->wrapperAttributes(['class' => 'col-md-6'])->toArray())
            ->add('content_ar', EditorField::class, ContentFieldOption::make()->label('Content (Arabic / المحتوى بالعربية)')->allowedShortcodes()->wrapperAttributes(['class' => 'col-md-6'])->toArray())
            ->add('row_content_close', HtmlField::class, HtmlFieldOption::make()->content('</div>')->toArray())
            ->add('notes_tabs_open', HtmlField::class, HtmlFieldOption::make()->content('
                <div class="card mb-3">
                    <div class="card-header">
                        <h4 class="card-title mb-0">Fragrance Notes Profile</h4>
                    </div>
                    <div class="card-body">
            ')->toArray())
            ->add('top_notes_pane_open', HtmlField::class, HtmlFieldOption::make()->content('<h5 class="mb-2">Top Notes</h5><div class="row g-3">')->toArray())
            ->add('top_note_image', MediaImageField::class, MediaImageFieldOption::make()->label('Top Note Image')->wrapperAttributes(['class' => 'col-md-4'])->toArray())
            ->add('top_note_description', TextareaField::class, DescriptionFieldOption::make()->label('Top Note Description')->placeholder('Enter top note description...')->maxLength(10000)->rows(4)->wrapperAttributes(['class' => 'col-md-4'])->toArray())
            ->add('top_note_description_ar', TextareaField::class, DescriptionFieldOption::make()->label('Top Note Description (Arabic)')->placeholder('أدخل وصف المكونات العليا باللغة العربية...')->maxLength(10000)->rows(4)->wrapperAttributes(['class' => 'col-md-4'])->toArray())
            ->add('top_notes_pane_close', HtmlField::class, HtmlFieldOption::make()->content('</div><hr class="my-4">')->toArray())
            ->add('heart_notes_pane_open', HtmlField::class, HtmlFieldOption::make()->content('<h5 class="mb-2">Heart Notes</h5><div class="row g-3">')->toArray())
            ->add('heart_note_image', MediaImageField::class, MediaImageFieldOption::make()->label('Heart Note Image')->wrapperAttributes(['class' => 'col-md-4'])->toArray())
            ->add('heart_note_description', TextareaField::class, DescriptionFieldOption::make()->label('Heart Note Description')->placeholder('Enter heart note description...')->maxLength(10000)->rows(4)->wrapperAttributes(['class' => 'col-md-4'])->toArray())
            ->add('heart_note_description_ar', TextareaField::class, DescriptionFieldOption::make()->label('Heart Note Description (Arabic)')->placeholder('أدخل وصف المكونات الوسطى باللغة العربية...')->maxLength(10000)->rows(4)->wrapperAttributes(['class' => 'col-md-4'])->toArray())
            ->add('heart_notes_pane_close', HtmlField::class, HtmlFieldOption::make()->content('</div><hr class="my-4">')->toArray())
            ->add('base_notes_pane_open', HtmlField::class, HtmlFieldOption::make()->content('<h5 class="mb-2">Base Notes</h5><div class="row g-3">')->toArray())
            ->add('base_note_image', MediaImageField::class, MediaImageFieldOption::make()->label('Base Note Image')->wrapperAttributes(['class' => 'col-md-4'])->toArray())
            ->add('base_note_description', TextareaField::class, DescriptionFieldOption::make()->label('Base Note Description')->placeholder('Enter base note description...')->maxLength(10000)->rows(4)->wrapperAttributes(['class' => 'col-md-4'])->toArray())
            ->add('base_note_description_ar', TextareaField::class, DescriptionFieldOption::make()->label('Base Note Description (Arabic)')->placeholder('أدخل وصف المكونات الأساسية باللغة العربية...')->maxLength(10000)->rows(4)->wrapperAttributes(['class' => 'col-md-4'])->toArray())
            ->add('base_notes_pane_close', HtmlField::class, HtmlFieldOption::make()->content('</div>')->toArray())
            ->add('notes_tabs_close', HtmlField::class, HtmlFieldOption::make()->content('
                    </div>
                </div>
            ')->toArray())
            ->add('images[]', MediaImagesField::class, [
                'label' => 'Product Images',
                'values' => $productId ? $this->getModel()->images : [],
            ])

            ->addMetaBoxes([ 'with_related' => [ 'title' => null, 'content' => Html::tag('div', '', [ 'class' => 'wrap-relation-product', 'data-target' => route('products.get-relations-boxes', $productId ?: 0),]), 'wrap' => false, 'priority' => 9999, ], ])
            ->when(!EcommerceHelper::isDisabledPhysicalProduct(), function () {
                $this->add('product_type', 'hidden', [
                    'value' => request()->input('product_type') ?: ProductTypeEnum::PHYSICAL,
                ]);
            })

            ->add('status', SelectField::class, StatusFieldOption::make()->toArray())
            ->add('is_featured', OnOffField::class, OnOffFieldOption::make()->label(trans('core/base::forms.is_featured'))->defaultValue(false)->toArray())
            ->add('categories[]', TreeCategoryField::class, SelectFieldOption::make()->label(trans('plugins/ecommerce::products.form.categories'))->choices(ProductCategoryHelper::getActiveTreeCategories())->selected(old('categories', $selectedCategories))->addAttribute('card-body-class', 'p-0')->toArray())
            ->when($brands, function () use ($brands) {
                $this
                    ->add(
                        'brand_id',
                        SelectField::class,
                        SelectFieldOption::make()
                            ->label(trans('plugins/ecommerce::products.form.brand'))
                            ->choices($brands)
                            ->searchable()
                            ->emptyValue(trans('plugins/ecommerce::brands.select_brand'))
                            ->allowClear()
                            ->toArray()
                    );
            })
            ->add(
                'image',
                MediaImageField::class,
                MediaImageFieldOption::make()
                    ->label(trans('plugins/ecommerce::products.form.featured_image'))
                    ->toArray()
            )
            ->when($productCollections, function () use ($productCollections) {
                $selectedProductCollections = [];

                if ($this->getModel() && $this->getModel()->getKey()) {
                    $selectedProductCollections = $this->getModel()
                        ->productCollections()
                        ->pluck('product_collection_id')
                        ->all();
                }

                $this
                    ->add('product_collections[]', MultiCheckListField::class, [
                        'label' => trans('plugins/ecommerce::products.form.collections'),
                        'choices' => $productCollections,
                        'value' => old('product_collections', $selectedProductCollections),
                    ]);
            })
            ->when($productLabels, function () use ($productLabels) {
                $selectedProductLabels = [];

                if ($this->getModel() && $this->getModel()->getKey()) {
                    $selectedProductLabels = $this->getModel()->productLabels()->pluck('product_label_id')->all();
                }

                $this
                    ->add('product_labels[]', MultiCheckListField::class, [
                        'label' => trans('plugins/ecommerce::products.form.labels'),
                        'choices' => $productLabels,
                        'value' => old('product_labels', $selectedProductLabels),
                    ]);
            })
            ->when(EcommerceHelper::isTaxEnabled(), function () {
                $taxes = Tax::query()->orderBy('percentage')->get()->pluck('title_with_percentage', 'id')->all();

                if ($taxes) {
                    $selectedTaxes = [];
                    if ($this->getModel() && $this->getModel()->getKey()) {
                        $selectedTaxes = $this->getModel()->taxes()->pluck('tax_id')->all();
                    } elseif ($defaultTaxRate = get_ecommerce_setting('default_tax_rate')) {
                        $selectedTaxes = [$defaultTaxRate];
                    }

                    $this->add('taxes[]', MultiCheckListField::class, [
                        'label' => trans('plugins/ecommerce::products.form.taxes'),
                        'choices' => $taxes,
                        'value' => old('taxes', $selectedTaxes),
                    ]);
                }
            })
            ->when(EcommerceHelper::isCartEnabled(), function (ProductForm $form) {
                $form
                    ->add(
                        'minimum_order_quantity',
                        NumberField::class,
                        NumberFieldOption::make()
                            ->label(trans('plugins/ecommerce::products.form.minimum_order_quantity'))
                            ->helperText(trans('plugins/ecommerce::products.form.minimum_order_quantity_helper'))
                            ->defaultValue(0)
                            ->toArray()
                    )
                    ->add(
                        'maximum_order_quantity',
                        NumberField::class,
                        NumberFieldOption::make()
                            ->label(trans('plugins/ecommerce::products.form.maximum_order_quantity'))
                            ->helperText(trans('plugins/ecommerce::products.form.maximum_order_quantity_helper'))
                            ->defaultValue(0)
                            ->toArray()
                    );
            })
            // ->add('tag', TagField::class, [
            //     'label' => trans('plugins/ecommerce::products.form.tags'),
            //     'value' => $tags,
            //     'attr' => [
            //         'placeholder' => trans('plugins/ecommerce::products.form.write_some_tags'),
            //         'data-url' => route('product-tag.all'),
            //     ],
            // ])
            ->setBreakFieldPoint('status');

        if (EcommerceHelper::isEnabledProductOptions()) {
            $this
                ->addMetaBoxes([
                    'product_options_box' => [
                        'title' => trans('plugins/ecommerce::product-option.name'),
                        'content' => view('plugins/ecommerce::products.partials.product-option-form', [
                            'options' => GlobalOptionEnum::options(),
                            'globalOptions' => GlobalOption::query()->pluck('name', 'id')->all(),
                            'product' => $this->getModel(),
                            'routes' => [
                                'ajax_option_info' => route('global-option.ajaxInfo'),
                            ],
                        ]),
                        'priority' => 4,
                    ],
                ]);
        }

        $productAttributeSets = ProductAttributeSet::getAllWithSelected($productId, []);

        $this
            ->addMetaBoxes([
                'attribute-sets' => [
                    'content' => '',
                    'before_wrapper' => '<div class="d-none product-attribute-sets-url" data-url="' . route('products.product-attribute-sets') . '">',
                    'after_wrapper' => '</div>',
                    'priority' => 3,
                ],
            ]);

        if (! $totalProductVariations) {
            $this
                ->removeMetaBox('variations')
                ->addMetaBoxes([
                    'general' => [
                        'title' => trans('plugins/ecommerce::products.overview'),
                        'content' => view(
                            'plugins/ecommerce::products.partials.general',
                            [
                                'product' => $productId ? $this->getModel() : null,
                                'isVariation' => false,
                                'originalProduct' => null,
                            ]
                        ),
                        'before_wrapper' => '<div id="main-manage-product-type">',
                        'priority' => 2,
                    ],
                    'attributes' => [
                        'title' => trans('plugins/ecommerce::products.attributes'),
                        'content' => view('plugins/ecommerce::products.partials.add-product-attributes', [
                            'product' => $this->getModel(),
                            'productAttributeSets' => $productAttributeSets,
                            'addAttributeToProductUrl' => $this->getModel()->id
                                ? route('products.add-attribute-to-product', $this->getModel()->id)
                                : null,
                        ]),
                        'header_actions' => $productAttributeSets->isNotEmpty()
                            ? view('plugins/ecommerce::products.partials.product-attribute-actions')
                            : null,
                        'after_wrapper' => '</div>',
                        'priority' => 3,
                    ],
                ]);
        } elseif ($productId) {
            $productVariationTable = app(ProductVariationTable::class)
                ->setProductId($productId)
                ->setProductAttributeSets($productAttributeSets);

            if (EcommerceHelper::isEnabledSupportDigitalProducts() && $this->getModel()->isTypeDigital()) {
                $productVariationTable->isDigitalProduct();
            }

            $this
                ->removeMetaBox('general')
                ->addMetaBoxes([
                    'variations' => [
                        'title' => trans('plugins/ecommerce::products.product_has_variations'),
                        'content' => view('plugins/ecommerce::products.partials.configurable', [
                            'product' => $this->getModel(),
                            'productAttributeSets' => $productAttributeSets,
                            'productVariationTable' => $productVariationTable,
                        ]),
                        'header_actions' => view(
                            'plugins/ecommerce::products.partials.product-variation-actions',
                            ['product' => $this->getModel()]
                        ),
                        'has_table' => true,
                        'before_wrapper' => '<div id="main-manage-product-type">',
                        'after_wrapper' => '</div>',
                        'priority' => 3,
                        'render' => false,
                    ],
                ])
                ->addAfter('brand_id', 'sku', TextField::class, TextFieldOption::make()->label(trans('plugins/ecommerce::products.sku')));
        }

        if ($productId && is_in_admin(true)) {
            add_filter('base_action_form_actions_extra', function () {
                return view('plugins/ecommerce::forms.duplicate-action', ['product' => $this->getModel()])->render();
            });
        }

        $this->add('collection_script', 'html', [
            'html' => '
            <script>
                $(document).ready(function () {
                    function toggleCollectionItems(isCollection) {
                        if (isCollection) {
                            $("#collection_items_wrapper").show();
                        } else {
                            $("#collection_items_wrapper").hide();
                        }
                    }

                    // Initial check on page load
                    var isCollectionChecked = $("#is_collection").is(":checked");
                    toggleCollectionItems(isCollectionChecked);

                    // Listen for changes
                    $(document).on("change", "#is_collection", function () {
                        toggleCollectionItems($(this).is(":checked"));
                    });
                });
            </script>
            '
        ]);
    }

    public function addAssets(): void
    {
        Assets::addStyles('datetimepicker')
            ->addScripts([
                'moment',
                'datetimepicker',
                'input-mask',
                'jquery-ui',
            ])
            ->addStylesDirectly('vendor/core/plugins/ecommerce/css/ecommerce.css')
            ->addScriptsDirectly('vendor/core/plugins/ecommerce/js/edit-product.js');
    }
}
