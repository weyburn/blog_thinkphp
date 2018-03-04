<?php

namespace app\frontend\controller;

use app\frontend\model\Post as PostModel;

/**
 * 归档控制器
 * Class Archive
 * @package app\frontend\controller
 */
class Archive extends FrontendBase
{
    /**
     * 归档页面视图
     * @return mixed
     */
    public function index()
    {
        $posts = PostModel::where('status', 1)->order('published_at', 'desc')
            ->column('title', 'published_at');

        $this->assign('posts', $posts);

        return $this->fetch();
    }
}
