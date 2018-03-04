<?php

namespace app\frontend\controller;

/**
 * 关于控制器
 * Class About
 * @package app\frontend\controller
 */
class About extends FrontendBase
{
    /**
     * 关于页面视图
     * @return mixed
     */
    public function index()
    {
        return $this->fetch();
    }
}
