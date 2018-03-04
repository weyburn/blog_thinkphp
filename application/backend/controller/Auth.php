<?php

namespace app\backend\controller;

use app\backend\model\User as UserModel;
use Hautelook\Phpass\PasswordHash;
use think\Session;

/**
 * 后台登录控制器
 * Class Auth
 * @package app\backend\controller
 */
class Auth extends BackendBase
{
    /**
     * 登录视图
     * @return mixed
     */
    public function index()
    {
        // 新增数据
//        $passwordHasher = new PasswordHash(8, false);
//        $hashPassword = $passwordHasher->HashPassword('123456');
//        $user = UserModel::create([
//            'name' => 'weyburn',
//            'email' => 'weyburn@126.com',
//            'password' => $hashPassword
//        ]);
//        dump($user);

        // 更新数据
//        $user = UserModel::where('name', 'weyburn')->update([
//            'email' => '695397572@qq.com'
//        ]);
//        dump($user);

        // 软删除数据
//        $user = UserModel::destroy(['name' => 'weyburn']);
//        dump($user);

        // 恢复软删除数据
//        $user = UserModel::onlyTrashed()->where('name', 'weyburn')->update(['deleted_at' => null]);
//        dump($user !== false);

        return $this->fetch('login');
    }

    /**
     * 处理登录
     * @return \think\response\Json
     * @throws \think\exception\DbException
     */
    public function login()
    {
        // 获取请求数据
        $data = $this->request->only([
            'username',
            'password'
        ]);

        // 校验数据
        $validate = validate('Login');

        // 校验失败
        if (!$validate->check($data)) {
            return json([
                'status' => 400,
                'message' => $validate->getError(),
            ]);
        }

        // 校验账号是否存在
        $user = UserModel::get([
            'email' => $data['username']
        ]);

        if (empty($user)) {
            // 账号存在，且密码正确
            return json([
                'status' => 400,
                'message' => '账号不存在',
            ]);
        }

        // 建议密码是否正确
        $passwordHasher = new PasswordHash(8, false);
        $passwordMatch = $passwordHasher->CheckPassword($data['password'], $user->password);

        if ($passwordMatch) {
            // 账号存在，且密码正确
            Session::set('status', '登录成功', 'weyburnAdmin');
            return json([
                'status' => 200,
                'message' => '登录成功',
            ]);
        } else {
            return json([
                'status' => 400,
                'message' => '密码错误',
            ]);
        }
    }

    /**
     * 注销登录
     */
    public function logout()
    {
        Session::delete('status', 'weyburnAdmin');

        $this->redirect('/admin/login');
    }
}
