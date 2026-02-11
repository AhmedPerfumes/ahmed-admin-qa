<?php

namespace Botble\Ecommerce\Forms;

use Botble\Base\Forms\FormAbstract;
use Botble\Base\Enums\BaseStatusEnum;
use Botble\Ecommerce\Models\ProductFragranceNote;
use Botble\Base\Forms\FieldOptions\TextFieldOption;
use Botble\Base\Forms\FieldOptions\EditorFieldOption;
use Botble\Base\Forms\FieldOptions\MediaImageFieldOption;
use Botble\Base\Forms\Fields\TextField;
use Botble\Base\Forms\Fields\EditorField;
use Botble\Base\Forms\Fields\MediaImageField;
use Botble\Base\Forms\Fields\SelectField;

class ProductFragranceNoteForm extends FormAbstract
{
    public function setup(): void
    {
        $this
            ->setupModel(new ProductFragranceNote())
            ->setFormOption('class', 'p-4')
            ->add('general_header', 'html', ['html' => '<h4>General Information</h4><hr>'])
            ->add('row_start_1', 'html', ['html' => '<div class="row">'])
                ->add('itemFamily', TextField::class, TextFieldOption::make()->label('Profile Name / Item Family')->required()->wrapperAttributes(['class' => 'form-group col-md-12'])->toArray())
            ->add('row_end_1', 'html', ['html' => '</div>'])

            ->add('notes_header', 'html', ['html' => '<h4 class="mt-4">Note Details</h4><hr>'])
            ->add('row_start_2', 'html', ['html' => '<div class="row">'])
                // --- TOP NOTES COLUMN ---
                ->add('top_notes_col_start', 'html', ['html' => '<div class="col-md-4"><h5 class="mb-3">Top Notes</h5>'])
                    ->add('top_note', TextField::class, TextFieldOption::make()->label('Top Note(s)')->placeholder('e.g., Tropical Fruits, Tangerine, Rose')->toArray())
                    ->add('top_note_ar', TextField::class, TextFieldOption::make()->label('Top Note(s) (Arabic)')->toArray())
                    ->add('top_note_image', MediaImageField::class, MediaImageFieldOption::make()->label('Top Note Image')->toArray())
                    ->add('top_note_description', EditorField::class, EditorFieldOption::make()->label('Top Note Description')->rows(4)->toArray())
                    ->add('top_note_description_ar', EditorField::class, EditorFieldOption::make()->label('Top Note Description (Arabic)')->rows(4)->toArray())
                ->add('top_notes_col_end', 'html', ['html' => '</div>'])

                // --- HEART NOTES COLUMN ---
                ->add('heart_notes_col_start', 'html', ['html' => '<div class="col-md-4"><h5 class="mb-3">Heart Notes</h5>'])
                    ->add('heart_note', TextField::class, TextFieldOption::make()->label('Heart Note(s)')->toArray())
                    ->add('heart_note_ar', TextField::class, TextFieldOption::make()->label('Heart Note(s) (Arabic)')->toArray())
                    ->add('heart_note_image', MediaImageField::class, MediaImageFieldOption::make()->label('Heart Note Image')->toArray())
                    ->add('heart_note_description', EditorField::class, EditorFieldOption::make()->label('Heart Note Description')->rows(4)->toArray())
                    ->add('heart_note_description_ar', EditorField::class, EditorFieldOption::make()->label('Heart Note Description (Arabic)')->rows(4)->toArray())
                ->add('heart_notes_col_end', 'html', ['html' => '</div>'])

                // --- BASE NOTES COLUMN ---
                ->add('base_notes_col_start', 'html', ['html' => '<div class="col-md-4"><h5 class="mb-3">Base Notes</h5>'])
                    ->add('base_note', TextField::class, TextFieldOption::make()->label('Base Note(s)')->toArray())
                    ->add('base_note_ar', TextField::class, TextFieldOption::make()->label('Base Note(s) (Arabic)')->toArray())
                    ->add('base_note_image', MediaImageField::class, MediaImageFieldOption::make()->label('Base Note Image')->toArray())
                    ->add('base_note_description', EditorField::class, EditorFieldOption::make()->label('Base Note Description')->rows(4)->toArray())
                    ->add('base_note_description_ar', EditorField::class, EditorFieldOption::make()->label('Base Note Description (Arabic)')->rows(4)->toArray())
                ->add('base_notes_col_end', 'html', ['html' => '</div>'])
            ->add('row_end_2', 'html', ['html' => '</div>'])

            ->add('status', SelectField::class, [
                'label' => trans('core/base::tables.status'),
                'label_attr' => ['class' => 'control-label required'],
                'choices' => BaseStatusEnum::labels(),
            ])
            ->setBreakFieldPoint('status');
    }
}