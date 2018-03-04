<?php

namespace app\backend\controller;

use app\backend\model\Category as CategoryModel;

/**
 * 分类控制器
 * Class Category
 * @package app\backend\controller
 */
class Category extends BackendBase
{
//     请求类型      生成路由规则               对应操作方法
//     GET          /resource                    index
//     GET	        /resource/:id	             read
//     GET          /resource/create             create
//     POST         /resource	                 save
//     GET	        /resource/:id/edit           edit
//     PUT          /resource/:id	             update
//     DELETE	    /resource/:id	             delete

    /**
     * 分类列表视图
     * @return mixed
     * @throws \think\exception\DbException
     */
    public function index()
    {
        $categories = CategoryModel::all();

        $this->assign('categories', $categories);

        return $this->fetch();
    }

    /**
     * 分类详情视图
     * @param $id
     * @return mixed
     * @throws \think\exception\DbException
     */
    public function read($id)
    {
        $category = CategoryModel::get($id);

        if (empty($category)) {
            die('分类不存在');
        }

        $prev_category_id = CategoryModel::where('id', '<', $id)->max('id');
        $next_category_id = CategoryModel::where('id', '>', $id)->min('id');

        $this->assign([
            'category' => $category,
            'prev_category_id' => $prev_category_id,
            'next_category_id' => $next_category_id
        ]);

        return $this->fetch('show');
    }

    /**
     * 新增分类视图
     * @return mixed
     */
    public function create()
    {
        return $this->fetch();
    }

    /**
     * 新增分类
     * @return \think\response\Json
     */
    public function save()
    {
        // 获取请求数据
        $data = $this->request->only('name');

        // 校验数据
        $validate = validate('Category');

        // 校验失败
        if (!$validate->check($data)) {
            return json([
                'status' => 400,
                'message' => $validate->getError(),
            ]);
        }

        // 校验成功
        $category = new CategoryModel($data);

        // 校验成功
        if ($category->save()) {
            // 新增分类成功
            return json([
                'status' => 200,
                'message' => '新增成功'
            ]);
        } else {
            // 新增分类失败
            return json([
                'status' => 400,
                'message' => '新增失败'
            ]);
        }
    }

    /**
     * 编辑分类视图
     * @param $id
     * @return mixed|string
     * @throws \think\exception\DbException
     */
    public function edit($id)
    {
        $category = CategoryModel::get($id);

        if (empty($category)) {
            return '分类不存在';
        }

        $this->assign('category', $category);

        return $this->fetch();
    }

    /**
     * 更新分类
     * @param $id
     * @return \think\response\Json
     * @throws \think\exception\DbException
     */
    public function update($id)
    {
        // 获取请求数据
        $data = $this->request->only('name');

        // 校验数据
        $validate = validate('Category');

        // 校验失败
        if (!$validate->check($data)) {
            return json([
                'status' => 400,
                'message' => $validate->getError(),
            ]);
        }

        // 校验成功
        $category = CategoryModel::get($id);

        $category->name = $data['name'];
        if ($category->save() !== false) {
            // 更新分类成功
            return json([
                'status' => 200,
                'message' => '修改成功'
            ]);
        } else {
            // 更新分类失败
            return json([
                'status' => 400,
                'message' => '修改失败'
            ]);
        }

    }

    /**
     * 删除分类
     * @param $id
     * @return \think\response\Json
     * @throws \think\exception\DbException
     */
    public function delete($id)
    {
        $category = CategoryModel::get($id);

        if (count($category->posts)) {
            return json([
                'status' => 400,
                'message' => '存在文章，不能删除'
            ]);
        }

        if ($category->delete()) {
            return json([
                'status' => 200,
                'message' => '删除成功'
            ]);
        } else {
            return json([
                'status' => 400,
                'message' => '删除失败'
            ]);
        }
    }
}
