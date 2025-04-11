<?php

namespace Botble\Ecommerce\Exporters;

use Botble\Base\Enums\BaseStatusEnum;
use Botble\DataSynchronize\Exporter\ExportColumn;
use Botble\DataSynchronize\Exporter\ExportCounter;
use Botble\DataSynchronize\Exporter\Exporter;
use Botble\Ecommerce\Models\ProductCategory;
use Illuminate\Support\Collection;

class ProductCategoryExporter extends Exporter
{
    public function getLabel(): string
    {
        return trans('plugins/ecommerce::product-categories.name');
    }

    public function columns(): array
    {
        return [
            ExportColumn::make('name'),
            ExportColumn::make('slug'),
            ExportColumn::make('description'),
            ExportColumn::make('status')
                ->dropdown(BaseStatusEnum::values()),
            ExportColumn::make('order'),
            ExportColumn::make('image'),
            ExportColumn::make('is_featured')
                ->boolean(),
            ExportColumn::make('icon'),
            ExportColumn::make('icon_image'),
        ];
    }

    public function counters(): array
    {
        return [
            ExportCounter::make()
                ->label(trans('plugins/blog::posts.export.total'))
                ->value(ProductCategory::query()->count()),
        ];
    }

    public function hasDataToExport(): bool
    {
        return ProductCategory::query()->exists();
    }

    public function collection(): Collection
    {
        return ProductCategory::query()->get();
    }
}
