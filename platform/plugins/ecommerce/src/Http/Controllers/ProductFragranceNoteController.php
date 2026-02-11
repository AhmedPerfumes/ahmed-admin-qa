<?php

namespace Botble\Ecommerce\Http\Controllers;

use Botble\Base\Http\Controllers\BaseController;
use Illuminate\Http\Request;
use Exception;
use Botble\Ecommerce\Models\ProductFragranceNote;
use Botble\Ecommerce\Forms\ProductFragranceNoteForm;
use Botble\Ecommerce\Tables\ProductFragranceNoteTable;
use Botble\Base\Http\Responses\BaseHttpResponse;
use Botble\Base\Forms\FormBuilder;

class ProductFragranceNoteController extends BaseController
{
    /**
     * @param ProductFragranceNoteTable $table
     * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
     */
    public function index(ProductFragranceNoteTable $table)
    {
        page_title()->setTitle('Fragrance Profiles');

        return $table->renderTable();
    }

    /**
     * @return string
     */
    public function create(FormBuilder $formBuilder)
    {
        page_title()->setTitle('Create New Fragrance Profile');

        return $formBuilder->create(ProductFragranceNoteForm::class)->renderForm();
    }

    /**
     * @param Request $request
     * @param BaseHttpResponse $response
     * @return BaseHttpResponse
     */
    public function store(Request $request, BaseHttpResponse $response)
    {
        $fragranceNote = ProductFragranceNote::query()->create($request->input());

        return $response
            ->setPreviousUrl(route('product-fragrance-notes.index'))
            ->setNextUrl(route('product-fragrance-notes.edit', $fragranceNote->id))
            ->setMessage(trans('core/base::notices.create_success_message'));
    }

    /**
     * @param int $id
     * @return string
     */
    public function edit(int $id, FormBuilder $formBuilder)
    {
        $fragranceNote = ProductFragranceNote::query()->findOrFail($id);

        page_title()->setTitle('Edit Fragrance Profile "' . $fragranceNote->itemFamily . '"');

        return $formBuilder
            ->create(ProductFragranceNoteForm::class, ['model' => $fragranceNote])
            ->renderForm();
    }

    /**
     * @param int $id
     * @param Request $request
     * @param BaseHttpResponse $response
     * @return BaseHttpResponse
     */
    public function update(int $id, Request $request, BaseHttpResponse $response)
    {
        $fragranceNote = ProductFragranceNote::query()->findOrFail($id);

        $fragranceNote->fill($request->input());
        $fragranceNote->save();

        return $response
            ->setPreviousUrl(route('product-fragrance-notes.index'))
            ->setMessage(trans('core/base::notices.update_success_message'));
    }

    /**
     * @param int $id
     * @param Request $request
     * @param BaseHttpResponse $response
     * @return BaseHttpResponse
     */
    public function destroy(int $id, Request $request, BaseHttpResponse $response)
    {
        try {
            $fragranceNote = ProductFragranceNote::query()->findOrFail($id);
            $fragranceNote->delete();

            return $response->setMessage(trans('core/base::notices.delete_success_message'));
        } catch (Exception $exception) {
            return $response
                ->setError()
                ->setMessage($exception->getMessage());
        }
    }
}