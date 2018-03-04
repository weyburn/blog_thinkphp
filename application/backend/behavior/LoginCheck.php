<?php

namespace app\backend\behavior;

use think\Session;

class LoginCheck
{
    public function run()
    {
        if (Session::get('status', 'weyburnAdmin') != '登录成功') {
            return redirect('/admin/login');
        }
    }
}
