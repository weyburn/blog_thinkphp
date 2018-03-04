<?php

namespace app\backend\model;

use think\Model;
use traits\model\SoftDelete;

class Comment extends Model
{
    use SoftDelete;

    protected $pk = 'id';
    protected $table = 'comments';
    protected $createTime = 'created_at';
    protected $updateTime = 'updated_at';
    protected $deleteTime = 'deleted_at';

    public function post()
    {
        return $this->belongsTo('Post', 'post_id')->field('id,title,published_at');
    }
}
