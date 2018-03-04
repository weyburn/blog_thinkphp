<?php

namespace app\backend\controller;

use think\Config;
use think\Controller;

class BackendBase extends Controller
{
    public function _initialize()
    {
        $isDist = !Config::get('app_debug');
        $prefix = $isDist ? '' : '____';

        if (file_exists(ROOT_PATH . "public/static/{$prefix}themes/backend.php")) {
            $_gStaticFiles = require_once ROOT_PATH . "public/static/{$prefix}themes/backend.php";
            $this->assign('_gStaticFiles', $_gStaticFiles);
        }
    }
}
