<?php

namespace app\backend\controller;

use app\backend\model\Comment as CommentModel;

/**
 * 评论控制器
 * Class Comment
 * @package app\backend\controller
 */
class Comment extends BackendBase
{
    /**
     * 评论列表视图
     * @return mixed
     */
    public function index()
    {
        $comments = CommentModel::all();

        $this->assign('comments', $comments);

        return $this->fetch();
    }

    /**
     * 评论详情视图
     * @param $id
     * @return string
     */
    public function read($id)
    {
        $comment = CommentModel::get($id);

        if (empty($comment)) {
            return '评论不存在';
        }

        $prev_comment_id = CommentModel::where('id', '<', $id)->max('id');
        $next_comment_id = CommentModel::where('id', '>', $id)->min('id');

        $this->assign([
            'comment' => $comment,
            'prev_comment_id' => $prev_comment_id,
            'next_comment_id' => $next_comment_id
        ]);

        return $this->fetch('show');
    }

    /**
     * 修改评论状态
     * @param $id
     * @return \think\response\Json
     */
    public function update($id)
    {
        $comment = CommentModel::get($id);
        $comment->status = 1;

        if ($comment->save()) {
            // 更新评论状态成功
            return json([
                'status' => 200,
                'message' => '修改成功'
            ]);
        } else {
            // 更新评论状态失败
            return json([
                'status' => 400,
                'message' => '修改失败'
            ]);
        }
    }

    /**
     * 删除评论
     * @param $id
     * @return \think\response\Json
     */
    public function delete($id)
    {
        $comment = CommentModel::get($id);

        if ($comment->delete()) {
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
