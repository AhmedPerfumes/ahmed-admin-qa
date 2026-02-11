<?php

namespace Botble\Ecommerce\Tables;

use Botble\Base\Enums\BaseStatusEnum;
use Botble\Ecommerce\Models\ProductFragranceNote;
use Botble\Table\Abstracts\TableAbstract;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Relations\Relation;
use Illuminate\Database\Query\Builder as QueryBuilder;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Auth;

class ProductFragranceNoteTable extends TableAbstract
{
    public function setup(): void
    {
        $this
            ->model(ProductFragranceNote::class);
    }

    public function ajax(): JsonResponse
    {
        $isModal = request()->input('is_modal');

        $data = $this->table
            ->eloquent($this->query())
            ->editColumn('itemFamily', function (ProductFragranceNote $item) {
                if (!Auth::user()->hasPermission('product-fragrance-notes.edit')) {
                    return $item->itemFamily;
                }
                return '<a href="' . route('product-fragrance-notes.edit', $item->id) . '" target="_blank">' . $item->itemFamily . '</a>';
            })
            ->editColumn('checkbox', function (ProductFragranceNote $item) {
                return $this->getCheckbox($item->id);
            })
            ->editColumn('created_at', function (ProductFragranceNote $item) {
                return $item->created_at->format('d-m-Y');
            })
            ->editColumn('status', function (ProductFragranceNote $item) {
                return $item->status->toHtml();
            })
            ->addColumn('operations', function (ProductFragranceNote $item) use ($isModal) {
                if ($isModal) {
                    return '<button class="btn btn-primary btn-sm select-this-fragrance-profile" data-id="' . $item->id . '" data-name="' . e($item->itemFamily) . '">Select</button>';
                }
                return $this->getOperations('product-fragrance-notes.edit', 'product-fragrance-notes.destroy', $item);
            });

        return $this->toJson($data);
    }

    public function query(): Relation|Builder|QueryBuilder
    {
        $query = $this
            ->getModel()
            ->query()
            ->select([
                'id',
                'itemFamily',
                'created_at',
                'status',
            ]);

        return $this->applyScopes($query);
    }

    public function columns(): array
    {
        return [
            'id' => [
                'title' => trans('core/base::tables.id'),
                'width' => '20px',
            ],
            'itemFamily' => [
                'title' => 'Profile Name',
                'class' => 'text-start',
            ],
            'created_at' => [
                'title' => trans('core/base::tables.created_at'),
                'width' => '100px',
            ],
            'status' => [
                'title' => trans('core/base::tables.status'),
                'width' => '100px',
            ],
        ];
    }

    public function buttons(): array
    {
        return $this->addCreateButton(route('product-fragrance-notes.create'), 'product-fragrance-notes.create');
    }

    public function bulkActions(): array
    {
        return $this->addDeleteAction(route('product-fragrance-notes.deletes'), 'product-fragrance-notes.destroy', parent::bulkActions());
    }

    public function getBulkChanges(): array
    {
        return [
            'itemFamily' => [
                'title' => 'Profile Name',
                'type' => 'text',
                'validate' => 'required|max:120',
            ],
            'status' => [
                'title' => trans('core/base::tables.status'),
                'type' => 'select',
                'choices' => BaseStatusEnum::labels(),
                'validate' => 'required|in:' . implode(',', BaseStatusEnum::values()),
            ],
            'created_at' => [
                'title' => trans('core/base::tables.created_at'),
                'type' => 'date',
            ],
        ];
    }
}