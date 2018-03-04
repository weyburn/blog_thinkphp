<?php

namespace app\frontend\validate;

use think\Validate;

class Comment extends Validate
{
    protected $rule = [
        'name' => 'require|max:40',
        'email' => 'require|email|max:64',
        'website' => 'max:120',
        'content' => 'require|max:300',
        'post_id' => 'require|integer',
        'reply_id' => 'integer',
        'reply_name' => 'max:40'
    ];

    protected $message = [
        'name.require'=>'称呼为必填项',
        'name.max'=>'称呼不得超过40个字符',
        'email.require'=>'邮箱为必填项',
        'email.email'=>'邮箱格式不正确',
        'email.max'=>'邮箱不得超过64个字符',
        'website.max'=>'网址不得超过120个字符',
        'content.require'=>'评论内容为必填项',
        'content.max'=>'评论内容不得超过300个字符',
        'post_id.require'=>'所评文章id为必填项',
        'post_id.integer'=>'所评文章id必须为整数',
        'reply_id.integer' => '回复id必须为整数',
        'reply_name.max' => '被回复称呼不得超过40个字符'
    ];
}
