<?php

namespace Botble\Page\Models;

use Botble\ACL\Models\User;
use Botble\Base\Casts\SafeContent;
use Botble\Base\Enums\BaseStatusEnum;
use Botble\Base\Models\BaseModel;
use Botble\Revision\RevisionableTrait;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Page extends BaseModel
{
    use RevisionableTrait;

    protected $table = 'pages';

    protected bool $revisionEnabled = true;

    protected bool $revisionCleanup = true;

    protected int $historyLimit = 20;

    protected array $dontKeepRevisionOf = ['content'];

    protected $fillable = [
        'name',
        'name_ar',
        'content',
        'content_ar',
        'image',
        'mobile_image',
        'template',
        'description',
        'description_ar',
        'status',
        'user_id',
        'link'
    ];

    protected $casts = [
        'status' => BaseStatusEnum::class,
        'name' => SafeContent::class,
        'name_ar' => SafeContent::class,
        'description' => SafeContent::class,
        'description_ar' => SafeContent::class,
        'template' => SafeContent::class,
    ];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class)->withDefault();
    }
}
