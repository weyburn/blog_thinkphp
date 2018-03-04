<?php

namespace app\backend\validate;

use think\Validate;

class Tag extends Validate
{
    protected $rule = [
        'name' => 'require|chsDash|max:36'
    ];

    protected $message = [
        'name.require' => '标签名称为必填项',
        'name.chsDash' => '标签名称仅允许汉字、字母、数字、破折号（-）以及下划线（_）',
        'name.max' => '标签名称不得超过36个字符'
    ];
}
