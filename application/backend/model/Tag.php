<?php

namespace app\backend\model;

use think\Model;
use traits\model\SoftDelete;

class Tag extends Model
{
    use SoftDelete;

    protected $pk = 'id';
    protected $table = 'tags';
    protected $createTime = 'created_at';
    protected $updateTime = 'updated_at';
    protected $deleteTime = 'deleted_at';

    public function posts()
    {
        return $this->belongsToMany('Post','post_tag')
            ->order('published_at', 'desc');
    }
}
