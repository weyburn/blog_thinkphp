<?php

namespace app\frontend\controller;

use \app\frontend\model\Tag as TagModel;

/**
 * 标签控制器
 * Class Category
 * @package app\frontend\controller
 */
class Tag extends FrontendBase
{
    /**
     * 标签页面视图
     * @return mixed
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function index()
    {
        $tags = TagModel::order('name', 'asc')->select();

        $this->assign('tags', $tags);

        return $this->fetch();
    }

    /**
     * 标签展示页面视图
     * @param $name
     * @return mixed|string
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function show($name)
    {
        $tag = TagModel::where('name', $name)->find();

        if (empty($tag)) {
            return '标签不存在';
        }

        $this->assign('tag', $tag);

        return $this->fetch();
    }
}
