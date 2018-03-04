<?php

namespace app\backend\controller;

use app\backend\model\Tag as TagModel;

/**
 * 标签控制器
 * Class Tag
 * @package app\backend\controller
 */
class Tag extends BackendBase
{
    /**
     * 标签列表视图
     * @return mixed
     * @throws \think\exception\DbException
     */
    public function index()
    {
        $tags = TagModel::all();

        $this->assign('tags', $tags);

        return $this->fetch();
    }

    /**
     * 标签详情视图
     * @param $id
     * @return mixed
     * @throws \think\exception\DbException
     */
    public function read($id)
    {
        $tag = TagModel::get($id);

        if (empty($tag)) {
            die('标签不存在');
        }

        $prev_tag_id = TagModel::where('id', '<', $id)->max('id');
        $next_tag_id = TagModel::where('id', '>', $id)->min('id');

        $this->assign([
            'tag' => $tag,
            'prev_tag_id' => $prev_tag_id,
            'next_tag_id' => $next_tag_id
        ]);

        return $this->fetch('show');
    }

    /**
     * 新增标签视图
     * @return mixed
     */
    public function create()
    {
        return $this->fetch();
    }

    /**
     * 新增标签
     * @return \think\response\Json
     */
    public function save()
    {
        // 获取请求数据
        $data = $this->request->only('name');

        // 校验数据
        $validate = validate('Tag');

        // 校验失败
        if (!$validate->check($data)) {
            return json([
                'status' => 400,
                'message' => $validate->getError(),
            ]);
        }

        // 校验成功
        $tag = new TagModel($data);

        // 校验成功
        if ($tag->save()) {
            // 新增标签成功
            return json([
                'status' => 200,
                'message' => '新增成功'
            ]);
        } else {
            // 新增标签失败
            return json([
                'status' => 400,
                'message' => '新增失败'
            ]);
        }
    }

    /**
     * 编辑标签视图
     * @param $id
     * @return mixed|string
     * @throws \think\exception\DbException
     */
    public function edit($id)
    {
        $tag = TagModel::get($id);

        if (empty($tag)) {
            return '标签不存在';
        }

        $this->assign('tag', $tag);

        return $this->fetch();
    }

    /**
     * 更新标签
     * @param $id
     * @return \think\response\Json
     * @throws \think\exception\DbException
     */
    public function update($id)
    {
        // 获取请求数据
        $data = $this->request->only('name');

        // 校验数据
        $validate = validate('Tag');

        // 校验失败
        if (!$validate->check($data)) {
            return json([
                'status' => 400,
                'message' => $validate->getError(),
            ]);
        }

        // 校验成功
        $tag = TagModel::get($id);

        $tag->name = $data['name'];
        if ($tag->save() !== false) {
            // 更新标签成功
            return json([
                'status' => 200,
                'message' => '修改成功'
            ]);
        } else {
            // 更新标签失败
            return json([
                'status' => 400,
                'message' => '修改失败'
            ]);
        }

    }

    /**
     * 删除标签
     * @param $id
     * @return \think\response\Json
     * @throws \think\exception\DbException
     */
    public function delete($id)
    {
        $tag = TagModel::get($id);

        if (count($tag->posts)) {
            return json([
                'status' => 400,
                'message' => '存在文章，不能删除'
            ]);
        }

        if ($tag->delete()) {
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
