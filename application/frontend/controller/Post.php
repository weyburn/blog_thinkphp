<?php

namespace app\frontend\controller;

use  app\frontend\model\Post as PostModel;

/**
 * 文章控制器
 * Class Post
 * @package app\frontend\controller
 */
class Post extends FrontendBase
{
    /**
     * 文章展示页面视图
     * @param $title
     * @return mixed|string
     * @throws \think\Exception
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function show($title)
    {
        $post = PostModel::Where([
            'title' => $title,
            'status' => 1
        ])->find();

        if (empty($post)) {
            return '文章不存在';
        }

        $post->setInc('view_count');

        $prev_post_title = PostModel::where('status', 1)
            ->whereTime('published_at', '<', $post->published_at)
            ->order('published_at', 'desc')->limit(1)->value('title');

        $next_post_title = PostModel::where('status', 1)
            ->whereTime('published_at', '>', $post->published_at)
            ->order('published_at', 'desc')->limit(1)->value('title');

        $this->assign([
            'post' => $post,
            'prev_post_title' => $prev_post_title,
            'next_post_title' => $next_post_title,
        ]);

        return $this->fetch();
    }
}
