<?php

namespace app\frontend\model;

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

    public function publishedPosts()
    {
        return $this->belongsToMany('Post','post_tag')->where('status', 1)
            ->order('published_at', 'desc')->field('title,published_at');
    }
}

