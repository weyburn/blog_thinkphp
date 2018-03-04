<?php

namespace app\frontend\controller;

use think\Config;
use think\Controller;
use app\frontend\model\Category as CategoryModel;
use app\frontend\model\Post as PostModel;
use app\frontend\model\Tag as TagModel;


class FrontendBase extends Controller
{
    public function _initialize()
    {
        $isDist = !Config::get('app_debug');
        $prefix = $isDist ? '' : '____';

        if (file_exists(ROOT_PATH . "public/static/{$prefix}themes/frontend.php")) {
            $_gStaticFiles = require_once ROOT_PATH . "public/static/{$prefix}themes/frontend.php";
            $this->assign('_gStaticFiles', $_gStaticFiles);
        }

        $postCount = count(PostModel::all(['status' => 1]));
        $tagCount = count(TagModel::all());
        $categoryCount = count(CategoryModel::all());

        $this->assign('count', ['postCount' => $postCount, 'categoryCount' => $categoryCount, 'tagCount' => $tagCount]);
    }
}
