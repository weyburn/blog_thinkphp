<?php

namespace app\backend\controller;

use app\backend\model\Category as CategoryModel;
use  app\backend\model\Post as PostModel;
use app\backend\model\Tag as TagModel;
use think\Db;

/**
 * 文章控制器
 * Class Post
 * @package app\backend\controller
 */
class Post extends BackendBase
{
    /**
     * 文章列表视图
     * @return mixed
     * @throws \think\exception\DbException
     */
    public function index()
    {
        $posts = PostModel::all();

        $this->assign('posts', $posts);

        return $this->fetch();
    }

    /**
     * 文章详情视图
     * @param $id
     * @return mixed|string
     * @throws \think\exception\DbException
     */
    public function read($id)
    {
        $post = PostModel::get($id);

        if (empty($post)) {
            return '文章不存在';
        }

        $prev_post_id = PostModel::where('id', '<', $id)->max('id');
        $next_post_id = PostModel::where('id', '>', $id)->min('id');

        $this->assign([
            'post' => $post,
            'prev_post_id' => $prev_post_id,
            'next_post_id' => $next_post_id
        ]);

        return $this->fetch('show');
    }

    /**
     * 新增文章视图
     * @return mixed
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function create()
    {
        $categories = CategoryModel::order('name', 'asc')->field('id,name')->select();
        $tags = TagModel::order('name', 'asc')->field('id,name')->select();


        $this->assign([
            'categories' => $categories,
            'tags' => $tags
        ]);

        return $this->fetch();
    }

    /**
     * 新增文章
     * @return \think\response\Json
     * @throws \Exception
     */
    public function save()
    {
        // 获取请求数据
        $data = $this->request->only([
            'title',
            'status',
            'category_id',
            'content',
            'tag_id',
        ]);

        // 校验数据
        $validate = validate('Post');

        // 校验失败
        if (!$validate->check($data)) {
            return json([
                'status' => 400,
                'message' => $validate->getError(),
            ]);
        }

        // 校验成功
        $post = new PostModel();
        $post->data($data);

        // 当状态为发布（即status = 1）时，获取发布时间
        if ($data['status'] == 1) {
            $post->published_at = date('Y-m-d H:i:s', time());
        }

        // 启动数据库事务
        Db::startTrans();

        try {
            $post->allowField(true)->save();
            // 如果设置选择了标签
            if (isset($data['tag_id'])) {
                $post->tags()->saveAll($data['tag_id']);
            }
            // 提交事务
            Db::commit();
            // 新增文章成功
            return json([
                'status' => 200,
                'message' => '新增成功'
            ]);
        } catch (\Exception $exception) {
            // 回滚事务
            Db::rollback();
            // 新增文章失败
            return json([
                'status' => 400,
                'message' => '新增文章失败'
            ]);
        }
    }

    /**
     * 编辑文章视图
     * @param $id
     * @return mixed|string
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function edit($id)
    {
        $post = PostModel::get($id);

        if (empty($post)) {
            return '文章不存在';
        }

        $categories = CategoryModel::order('name', 'asc')->field('id,name')->select();
        $tags = TagModel::order('name', 'asc')->field('id,name')->select();

        $tagArr = $post->tags->column('name', 'id');

        $this->assign([
            'post' => $post,
            'categories' => $categories,
            'tags' => $tags,
            'tagArr' => $tagArr
        ]);

        return $this->fetch();
    }

    /**
     * 更新文章
     * @param $id
     * @return \think\response\Json
     * @throws \Exception
     * @throws \think\exception\DbException
     */
    public function update($id)
    {
        // 获取请求数据
        $data = $this->request->only([
            'title',
            'status',
            'category_id',
            'content',
            'tag_id',
        ]);

        // 校验数据
        $validate = validate('Post');

        // 校验失败
        if (!$validate->check($data)) {
            return json([
                'status' => 400,
                'message' => $validate->getError(),
            ]);
        }

        // 校验成功
        $post = PostModel::get($id);
        $post->title = $data['title'];
        $post->status = $data['status'];
        $post->category_id = $data['category_id'];
        $post->content = $data['content'];

        // 当修改前发布时间不存在、修改后状态为发布（即status = 1）时，获取发布时间
        if (empty($post->published_at) && $data['status'] == 1) {
            $post->published_at = date('Y-m-d H:i:s', time());
        }

        // 启动数据库事务
        Db::startTrans();
        try {
            $post->save();
            // 判断中间表要删除的关联和要增加的关联
            $oldTagArr = $post->tags->column('id');
            $newTagArr = isset($data['tag_id']) ? $data['tag_id'] : [];
            $detachTagArr = array_diff($oldTagArr, $newTagArr);
            $saveTagArr = array_diff($newTagArr, $oldTagArr);
            if (!is_null($detachTagArr)) {
                $post->tags()->detach($detachTagArr);
            }
            if (!is_null($saveTagArr)) {
                $post->tags()->saveAll($saveTagArr);
            }
            // 提交事务
            Db::commit();
            // 新增文章成功
            return json([
                'status' => 200,
                'message' => '修改成功'
            ]);
        } catch (\Exception $exception) {
            Db::rollback();
            // 更新文章失败
            return json([
                'status' => 400,
                'message' => '修改失败'
            ]);
        }
    }


    /**
     * 删除文章
     * @param $id
     * @return \think\response\Json
     * @throws \think\exception\DbException
     */
    public
    function delete($id)
    {
        $post = PostModel::get($id);

        if ($post->delete()) {
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
