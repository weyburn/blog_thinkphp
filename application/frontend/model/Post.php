<?php

namespace app\frontend\model;

use think\Model;
use traits\model\SoftDelete;

class Post extends Model
{
    use SoftDelete;

    protected $pk = 'id';
    protected $table = 'posts';
    protected $createTime = 'created_at';
    protected $updateTime = 'updated_at';
    protected $deleteTime = 'deleted_at';

    public function category()
    {
        return $this->belongsTo('Category', 'category_id')->field('id,name');
    }

    public function tags()
    {
        return $this->belongsToMany('Tag','post_tag')->order('name','asc')->field('id,name');
    }

    public function comments()
    {
        return $this->hasMany('Comment', 'post_id')->order('created_at','desc');
    }
}
