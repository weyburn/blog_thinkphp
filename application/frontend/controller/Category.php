<?php

namespace app\frontend\controller;

use app\frontend\model\Category as CategoryModel;

/**
 * 分类控制器
 * Class Category
 * @package app\frontend\controller
 */
class Category extends FrontendBase
{
    /**
     * 分类页面视图
     * @return mixed
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function index()
    {
        $categories = CategoryModel::order('name', 'asc')->select();

        $this->assign('categories', $categories);

        return $this->fetch();
    }

    /**
     * 分类展示页面视图
     * @param $name
     * @return mixed|string
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function show($name)
    {
        $category = CategoryModel::where('name', $name)->find();

        if (empty($category)) {
            return '分类不存在';
        }

        $this->assign('category', $category);

        return $this->fetch();
    }
}

