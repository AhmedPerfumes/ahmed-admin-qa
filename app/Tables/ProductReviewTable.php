<?php

namespace App\Tables;

use App\Models\ProductReview;
use Botble\Base\Facades\BaseHelper; // Botble's helper
use Botble\Base\Facades\Html;       // Use Botble's HTML helper, NOT Laravel's
use Botble\Table\Abstracts\TableAbstract;
use Botble\Table\Actions\Action;
use Botble\Table\Actions\DeleteAction;
use Botble\Table\Columns\Column;
use Botble\Table\Columns\IdColumn;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\JsonResponse;

class ProductReviewTable extends TableAbstract
{
    public function setup(): void
    {
        $this->model(ProductReview::class);

        $this->addActions([
            Action::make('view')
                ->icon('ti ti-eye')
                ->color('info')
                ->route('product-reviews.show')
                ->label('View Details'),
            DeleteAction::make()->route('product-reviews.destroy')
                ->confirmation(
                    'Move this review to the trash?',
                    'The review will be hidden but can be recovered from the database.',
                    'Yes, move to trash'
                ),
        ]);
    }

    public function query(): Builder
    {
        $query = $this->model->select([
            'id',
            'product_id',
            'customer_name',
            'star',
            'comment',
            'status',
            'created_at',
        ]);

        $query->with(['product']);

        return $this->applyScopes($query);
    }

    public function columns(): array
    {
        return [
            IdColumn::make(),
            Column::make('product_name')
                ->title('Product')
                ->alignStart(),
            Column::make('customer_name')
                ->title('Customer')
                ->alignStart(),
            Column::make('star')
                ->title('Rating'),
            Column::make('comment')
                ->title('Comment')
                ->alignStart(),
            Column::make('status')
                ->title('Status'),
            Column::make('created_at')
                ->title('Created At'),
        ];
    }

    public function ajax(): JsonResponse
    {
        $data = $this->table
            ->eloquent($this->query())
            ->editColumn('product_name', function (ProductReview $item) {
                if (!$item->product || !$item->product->id) {
                    return 'N/A';
                }
                // THE FIX: This now uses the correct, built-in Botble Html helper.
                return Html::link(
                    route('products.edit', $item->product->id),
                    $item->product->name
                );
            })
            ->editColumn('status', function (ProductReview $item) {
                // This uses Botble's helper to create a nice status badge.
                return BaseHelper::renderBadge($item->status);
            });

        return $this->toJson($data);
    }
}