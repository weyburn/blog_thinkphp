<?php

namespace app\backend\validate;

use think\Validate;

class Category extends Validate
{
    protected $rule = [
        'name' => 'require|chsDash|max:36'
    ];

    protected $message = [
        'name.require' => '分类名称为必填项',
        'name.chsDash' => '分类名称仅允许汉字、字母、数字、破折号（-）以及下划线（_）',
        'name.max' => '分类名称不得超过36个字符'
    ];
}



