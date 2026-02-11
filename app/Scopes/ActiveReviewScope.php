<?php

namespace App\Scopes;

use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Scope;

class ActiveReviewScope implements Scope
{
    /**
     * This function automatically adds a "WHERE status != 'deleted'"
     * to every query for the ProductReview model.
     */
    public function apply(Builder $builder, Model $model): void
    {
        $builder->where('status', '!=', 'deleted');
    }
}