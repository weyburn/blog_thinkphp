<?php

namespace app\frontend\model;

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

    public function publishedPost()
    {
        return $this->belongsTo('Post', 'post_id')->where('status', 1)->field('id,title,published_at');
    }
}

