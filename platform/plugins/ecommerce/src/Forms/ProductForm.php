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

class ProductForm extends FormAbstract
{
    public function setup(): void
    {
        $this->addAssets();

        $brands = Brand::query()->pluck('name', 'id')->all();

        $productCollections = ProductCollection::query()->pluck('name', 'id')->all();

        $productLabels = ProductLabel::query()->pluck('name', 'id')->all();

        $productId = null;
        $selectedFragranceNoteId = null;
        if ($this->getModel() && $this->getModel()->id) {
            $product = $this->getModel();
            $fragranceNote = $product->fragranceNote()->first();
            if ($fragranceNote) {
                $selectedFragranceNoteId = $fragranceNote->id;
            }
        }
        $fragranceProfiles = ProductFragranceNote::query()
            ->where('status', BaseStatusEnum::PUBLISHED)
            ->pluck('itemFamily', 'id')
            ->all();

        $selectedCategories = [];
        $tags = null;
        $totalProductVariations = 0;

        if ($this->getModel()) {
            $productId = $this->getModel()->id;

            $selectedCategories = $this->getModel()->categories()->pluck('category_id')->all();

            $totalProductVariations = ProductVariation::query()->where('configurable_product_id', $productId)->count();

            $tags = $this->getModel()->tags()->pluck('name')->implode(',');
        }

        $collectionItemValues = '';
        if ($this->getModel() && $this->getModel()->is_collection) {
            $items = $this->getModel()->collectionItems()->with('childProduct')->get();
            $values = [];
            foreach ($items as $item) {
                if ($item->childProduct) {
                    // This is a real product
                    $values[] = 'product--' . $item->childProduct->id . ':' . $item->childProduct->name;
                } else {
                    // This is a custom text item
                    $values[] = $item->custom_item_name;
                }
            }
            $collectionItemValues = implode(',', $values);
        }

        $this
            ->setupModel(new Product())
            ->setValidatorClass(ProductRequest::class)
            ->setFormOption('files', true);

            $this->add('tabs_nav', 'html', [
                'html' => '
                <ul class="nav nav-tabs" id="product-tabs" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="general-tab" data-bs-toggle="tab" data-bs-target="#tab_general" type="button" role="tab" aria-controls="tab_general" aria-selected="true">General Information</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="collection-tab" data-bs-toggle="tab" data-bs-target="#tab_collection" type="button" role="tab" aria-controls="tab_collection" aria-selected="true">Collection Information</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="categorization-tab" data-bs-toggle="tab" data-bs-target="#tab_categorization" type="button" role="tab" aria-controls="tab_categorization" aria-selected="false">Categorization</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="notes-tab" data-bs-toggle="tab" data-bs-target="#tab_notes" type="button" role="tab" aria-controls="tab_notes" aria-selected="false">Fragrance Notes</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="specs-tab" data-bs-toggle="tab" data-bs-target="#tab_specifications" type="button" role="tab" aria-controls="tab_specifications" aria-selected="false">Item Specifications</button>
                    </li>
                </ul>',
            ]);
            $this->add('tabs_content_start', 'html', ['html' => '<div class="tab-content" id="product-tabs-content">']);

            // --- TAB 1: GENERAL INFORMATION ---
            $this->add('general_tab_start', 'html', ['html' => '<div class="tab-pane fade show active" id="tab_general" role="tabpanel" aria-labelledby="general-tab">']);

            $this->add('general_header', 'html', ['html' => '<h4 class="mt-4 h2">General</h4><hr>'])
            ->add('name_row_open', 'html', ['html' => '<div class="row">',])
            ->add('name_ar', TextField::class, NameFieldOption::make()->label(trans('core/base::forms.name_ar'))->placeholder(trans('core/base::forms.name_ar_placeholder'))->required()->wrapperAttributes(['class' => 'form-group col-12 col-md-6'])->toArray())
            ->add('name', TextField::class, NameFieldOption::make()->required()->wrapperAttributes(['class' => 'form-group col-12 col-md-6'])->toArray())
            ->add('name_row_close', 'html', ['html' => '</div>',])

            ->add('description_row_start', 'html', ['html' => '<div class="row">'])
            ->add('description', EditorField::class, EditorFieldOption::make()->label(trans('core/base::forms.description'))->placeholder(trans('core/base::forms.description_placeholder'))->required()->wrapperAttributes(['class' => 'form-group col-md-6'])->toArray())
            ->add('description_ar', EditorField::class, EditorFieldOption::make()->label(trans('core/base::forms.description_ar'))->placeholder(trans('core/base::forms.description_ar_placeholder'))->required()->wrapperAttributes(['class' => 'form-group col-md-6'])->toArray())
            ->add('description_row_end', 'html', ['html' => '</div>'])

            // ->add('content_row_start', 'html', ['html' => '<div class="row">'])
            // ->add('content', EditorField::class, ContentFieldOption::make()->allowedShortcodes()->wrapperAttributes(['class' => 'form-group col-md-6'])->toArray())
            // ->add('content_ar', EditorField::class, ContentFieldOption::make()->label('Content (Arabic)')->allowedShortcodes()->wrapperAttributes(['class' => 'form-group col-md-6'])->toArray())
            // ->add('content_row_end', 'html', ['html' => '</div>'])

            // ->add('fragrance_row_start', 'html', ['html' => '<div class="row">'])
            // ->add('fragrance_notes', EditorField::class, ContentFieldOption::make()->label('Fragrance Notes')->allowedShortcodes()->wrapperAttributes(['class' => 'form-group col-md-6'])->toArray())
            // ->add('fragrance_notes_ar', EditorField::class, ContentFieldOption::make()->label('Fragrance Notes (Arabic)')->allowedShortcodes()->wrapperAttributes(['class' => 'form-group col-md-6'])->toArray())
            // ->add('fragrance_row_end', 'html', ['html' => '</div>'])
            ->add('images[]', MediaImagesField::class, ['label' => trans('plugins/ecommerce::products.form.image'), 'values' => $productId ? $this->getModel()->images : [],]);
        $this->add('general_tab_end', 'html', ['html' => '</div>']);

        // --- TAB: COLLECTION DETAILS ---
        $this->add('collection_tab_start', 'html', ['html' => '<div class="tab-pane fade" id="tab_collection" role="tabpanel" aria-labelledby="collection-tab">'])
            ->add('collection_header', 'html', ['html' => '<h4 class="mt-4 h2">Collection Details</h4><hr>'])
            ->add('collection_row_open', 'html', ['html' => '<div class="row">'])
            ->add('is_collection', OnOffField::class, [
                'label' => 'Is this a collection?',
                'label_attr' => ['class' => 'control-label'],
                'default_value' => false,
                'wrapper' => [ 'class' => 'form-group col-12 mb-3', ],
            ])
            ->add('collection_items_wrapper', 'html', [
                'html' => '<div id="collection_items_wrapper" class="col-12" style="display: none;">',
            ])
            ->add('collection_items', TagField::class, [
                'label' => 'Items in Collection',
                'label_attr' => ['class' => 'control-label'],
                'value' => $collectionItemValues,
                'wrapper' => [ 'class' => 'form-group', ],
                'attr' => [
                    'placeholder' => 'Search for products or type a custom item',
                    'data-url' => route('products.get-for-tag-input'),
                ],
            ])
            ->add('collection_items_wrapper_end', 'html', [ 'html' => '</div>', ])
            ->add('collection_row_close', 'html', ['html' => '</div>'])
            ->add('collection_tab_end', 'html', ['html' => '</div>']);

        // --- TAB 2: CATEGORIZATION ---
        $this->add('categorization_tab_start', 'html', ['html' => '<div class="tab-pane fade" id="tab_categorization" role="tabpanel" aria-labelledby="categorization-tab">']);
        // --- Section 1: Categorization (3-column layout) ---
        $this->add('categories_header', 'html', ['html' => '<h4 class="mt-4 h2">Categorization</h4><hr>'])
            ->add('categories_row_start', 'html', ['html' => '<div class="row">'])
            // ->add('itemCategory_1', TextField::class, TextFieldOption::make()->label('Item Category 1')->wrapperAttributes(['class' => 'form-group col-md-6'])->toArray())
            // ->add('itemCategory_2', TextField::class, TextFieldOption::make()->label('Item Category 2')->wrapperAttributes(['class' => 'form-group col-md-6'])->toArray())
            // ->add('itemCategory_3', TextField::class, TextFieldOption::make()->label('Item Category 3')->wrapperAttributes(['class' => 'form-group col-md-6'])->toArray())
            // ->add('itemCategory_4', TextField::class, TextFieldOption::make()->label('Item Category 4')->wrapperAttributes(['class' => 'form-group col-md-6'])->toArray())
            // ->add('itemCategory_5', TextField::class, TextFieldOption::make()->label('Item Category 5')->wrapperAttributes(['class' => 'form-group col-md-6'])->toArray())
            ->add('product_family', TextField::class, TextFieldOption::make()->label('Product Family')->wrapperAttributes(['class' => 'form-group col-md-6'])->toArray())
            ->add('categories_row_end', 'html', ['html' => '</div>']);
        $this->add('categorization_tab_end', 'html', ['html' => '</div>']);

        // --- Section 2: Fragrance Notes (with Dropdown and Create Button) ---
        $this->add('notes_tab_start', 'html', ['html' => '<div class="tab-pane fade" id="tab_notes" role="tabpanel" aria-labelledby="notes-tab">']);
        $this->add('notes_header', 'html', ['html' => '<h4 class="mt-4 h2">Fragrance Profile</h4><hr>']);

        $this->add('fragrance_note_id_wrapper_start', 'html', [
            'html' => '<div class="form-group mb-3">
                            <label for="fragrance_note_id" class="control-label">Select Profile</label>
                            <div >',
        ]);

        $this->add('fragrance_note_id', SelectField::class, [
            'label' => false, // Label is provided by the wrapper now
            'choices' => [0 => '-- None --'] + $fragranceProfiles,
            'selected' => $selectedFragranceNoteId,
            'attr' => [
                'class' => 'form-control select-search-full',
            ],
        ]);

        $this->add('fragrance_note_id_wrapper_end', 'html', [
            'html' => '    <a href="' . route('product-fragrance-notes.create') . '" class="btn btn-primary" target="_blank" title="Create New Profile">
                                <i class="fa fa-plus"></i> Create
                            </a>
                        </div>
                    </div>',
        ]);

        $this->add('notes_tab_end', 'html', ['html' => '</div>']);

        // --- Section 3: Item Specifications ---
        $this->add('specs_tab_start', 'html', ['html' => '<div class="tab-pane fade" id="tab_specifications" role="tabpanel" aria-labelledby="specifications-tab">']);
        $this->add('specs_header', 'html', ['html' => '<h4 class="mt-4 h2">Item Specifications</h4><hr>'])
            ->add('specs_row_start', 'html', ['html' => '<div class="row">'])
            // ->add('size', TextField::class, TextFieldOption::make()->label('Size')->wrapperAttributes(['class' => 'form-group col-md-3'])->toArray())
            ->add('tag', TagField::class, [
                'label' => trans('plugins/ecommerce::products.form.quantity'),
                'value' => $tags,
                'attr' => [
                    'placeholder' => trans('plugins/ecommerce::products.form.write_some_tags'),
                    'data-url' => route('product-tag.all'),
                ],
            ])
            ->add('fragrance_type', SelectField::class, SelectFieldOption::make()->label('Fragrance Type')
                ->choices([
                    'Personal Fragrance (By Concentration)' => [
                        'parfum' => 'Extrait de Parfum / Parfum',
                        'edp' => 'Eau de Parfum (EDP)',
                        'edt' => 'Eau de Toilette (EDT)',
                        'edc' => 'Eau de Cologne (EDC)',
                    ],
                    'Personal Fragrance (By Form)' => [
                        'concentrated_oil' => 'Concentrated Oil',
                        'dehn_al_oud' => 'Dehn al Oud',
                        'hair_mist' => 'Hair Mist',
                        'body_gel' => 'Body Gel',
                    ],
                    'Home & Traditional Fragrance' => [
                        'bakhoor' => 'Bakhoor',
                        'oud_maattar' => 'Oud Maattar',
                        'air_freshener' => 'Air Freshener',
                    ],
                    'other' => 'Other',
                ])->emptyValue('Select Fragrence Type...')->required()->wrapperAttributes(['class' => 'form-group col-md-3'])->toArray())
            // ->add('badge', SelectField::class, [ 'label' => 'Badges', 'choices' => [ 'bestseller' => 'Best Seller', 'newlaunch' => 'New Launch', 'onlineexclusive' => 'Online Exclusive', 'buyonegetone' => 'Buy One Get One', ], 'values' => $productId ? $this->getModel()->badge : [], 'attr' => [ 'class' => 'form-control select-multiple', 'multiple' => true, ], 'wrapper' => ['class' => 'form-group col-md-3'], ])
            ->add('dispenser_type', SelectField::class, SelectFieldOption::make()->label('Dispenser Type')
                ->choices([
                    'spray' => 'Spray / Atomizer (for Perfumes, Mists)',
                    'serum' => 'Serum Press (for Gels, Lotions)',
                    'dabber_stick' => 'Dabber / Stick Applicator (for Oils)',
                    'solid_incense' => 'Solid / Incense (for Bakhoor, Maattar)',
                    'jar' => 'Jar / Pot (for Gels, Bakhoor)',
                    'tube' => 'Tube (for Gels)',
                    'reed_diffuser' => 'Reed Diffuser (for Air Fresheners)',
                    'dropper' => 'Dropper',
                    'other' => 'Other',
                ])->emptyValue('Select Dispenser Type...')->required()->wrapperAttributes(['class' => 'form-group col-md-3'])->toArray())
            ->add('fragrance_category', TextField::class, TextFieldOption::make()->label('Fragrance Category')->placeholder('e.g., Occidental, Unisex')->wrapperAttributes(['class' => 'form-group col-md-6'])->toArray())

            ->add('item_profile', TextField::class, TextFieldOption::make()->label('Item Profile')->wrapperAttributes(['class' => 'form-group col-md-6'])->toArray())
            ->add('item_classification', TextField::class, TextFieldOption::make()->label('Item Classification')->wrapperAttributes(['class' => 'form-group col-md-6'])->toArray())

            ->add('longevity', TextField::class, TextFieldOption::make()->label('Longevity')->wrapperAttributes(['class' => 'form-group col-md-6'])->toArray())
            ->add('occasion', TextField::class, TextFieldOption::make()->label('Occasion')->wrapperAttributes(['class' => 'form-group col-md-6'])->toArray())
            ->add('additional_details', TextField::class, TextFieldOption::make()->label('Additional Details')->wrapperAttributes(['class' => 'form-group col-md-6'])->toArray())

            ->add('how_to_use', TextField::class, TextFieldOption::make()->label('How to Use')->wrapperAttributes(['class' => 'form-group col-md-6'])->toArray())
            ->add('ingredients', TextField::class, TextFieldOption::make()->label('Ingredients')->wrapperAttributes(['class' => 'form-group col-md-6'])->toArray())
            ->add('story', TextField::class, TextFieldOption::make()->label('Story')->wrapperAttributes(['class' => 'form-group col-md-6'])->toArray())

            ->add('specs_row_end', 'html', ['html' => '</div>']);
        $this->add('specs_tab_end', 'html', ['html' => '</div>']);
        $this->add('tabs_content_end', 'html', ['html' => '</div>']);


        $this->addMetaBoxes([ 'with_related' => [ 'title' => null, 'content' => Html::tag('div', '', [ 'class' => 'wrap-relation-product', 'data-target' => route('products.get-relations-boxes', $productId ?: 0),]), 'wrap' => false, 'priority' => 9999, ], ])
            ->when(! EcommerceHelper::isDisabledPhysicalProduct(), function () {
                $this->add('product_type', 'hidden', [
                    'value' => request()->input('product_type') ?: ProductTypeEnum::PHYSICAL,
                ]);
            });

        $this->add('status', SelectField::class, StatusFieldOption::make()->toArray())
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
