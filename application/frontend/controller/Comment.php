<?php

namespace app\frontend\controller;

use app\frontend\model\Comment as CommentModel;

/**
 * 评论控制器
 * Class Comment
 * @package app\frontend\controller
 */
class Comment extends FrontendBase
{
    /**
     * 新增评论
     * @return string|\think\response\Json
     */
    public function create()
    {
        if ($this->request->isGet()) {
            return '页面不存在';
        }

        $data = $this->request->only([
            'name',
            'email',
            'website',
            'content',
            'post_id',
            'reply_id',
            'reply_name'
        ]);

        // 基础校验数据
        $validate = validate('Comment');

        // 校验失败
        if (!$validate->check($data)) {
            return json([
                'status' => 400,
                'message' => $validate->getError(),
            ]);
        }

        // 校验成功
        $comment = new CommentModel();
        $comment->data($data);
        $comment->ip = $this->request->ip();

        if ($comment->save()) {
            // 添加评论成功
            return json([
                'status' => 200,
                'message' => '评论成功'
            ]);
        } else {
            //  添加评论失败
            return json([
                'status' => 400,
                'message' => '评论失败'
            ]);
        }
    }
}
