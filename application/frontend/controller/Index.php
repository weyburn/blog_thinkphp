<?php

namespace app\frontend\controller;

use app\frontend\model\Post as PostModel;

/**
 * 前端首页控制器
 * Class index
 * @package app\frontend\controller
 */
class Index extends FrontendBase
{
    /**
     * 首页页面视图
     * @return mixed
     * @throws \think\exception\DbException
     */
    public function index()
    {
        $posts = PostModel::where('status', 1)->order('published_at', 'desc')
            ->paginate(5);

        $this->assign('posts', $posts);

        return $this->fetch();
    }
}
