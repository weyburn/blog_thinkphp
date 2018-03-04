<?php

namespace app\backend\validate;

use think\Validate;

class Post extends Validate
{
    protected $rule = [
        'title' => 'require|max:255',
        'status' => 'require|integer|in:0,1',
        'content' => 'require',
        'category_id' => 'require|integer',
        'tag_id' => 'array'
    ];

    protected $message = [
        'title.require' => '文章标题为必填项',
        'title.max' => '文章标题不得超过255个字符',
        'status.require' => '状态为必填项',
        'status.integer' => '状态必须为整数',
        'status.in' => '状态必须为0或1',
        'content.require' => '文章内容为必填项',
        'category_id.require' => '分类id为必填项',
        'category_id.integer'=>'分类id必须为整数',
        'tag_id.array' => '标签id必须为数组'
    ];
}
