<?php

namespace app\backend\model;

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

    public function posts()
    {
        return $this->hasMany('Post', 'category_id')
            ->order('published_at', 'desc')
            ->field('id,title,published_at');
    }
}
