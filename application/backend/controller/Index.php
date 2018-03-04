<?php

namespace app\backend\controller;

/**
 * 后台首页控制器
 * Class index
 * @package app\backend\controller
 */
class Index extends BackendBase
{
    /**
     * 后台首页视图
     * @return mixed
     */
    public function index()
    {
        return $this->fetch();
    }
}
