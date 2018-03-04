<?php

namespace app\frontend\model;

use think\Model;
use traits\model\SoftDelete;

class Category extends Model
{
    use SoftDelete;

    protected $pk = 'id';
    protected $table = 'categories';
    protected $createTime = 'created_at';
    protected $updateTime = 'updated_at';
    protected $deleteTime = 'deleted_at';

    public function publishedPosts()
    {
        return $this->hasMany('Post', 'category_id')
            ->where('status', 1)->order('published_at', 'desc')
            ->field('id,title,published_at');
    }
}
