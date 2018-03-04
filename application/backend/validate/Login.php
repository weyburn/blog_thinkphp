<?php

namespace app\backend\validate;

use think\Validate;

class Login extends Validate
{
    protected $rule = [
        'username' => 'require|email|max:64',
        'password' => 'require'
    ];

    protected $message = [
        'username.require' => '账号不能为空',
        'username.email' => '账号必须是有效邮箱',
        'username.max' => '账号不得超过64个字符',
        'password.require' => '密码不能为空'
    ];
}
