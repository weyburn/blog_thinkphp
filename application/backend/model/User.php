<?php

namespace app\backend\model;

use think\Model;
use traits\model\SoftDelete;


class User extends Model
{
    use SoftDelete;
    protected $pk = 'id';
    protected $table = 'users';
    protected $createTime = 'created_at';
    protected $updateTime = 'updated_at';
    protected $deleteTime = 'deleted_at';
//    protected $hidden = ['password', 'remember_token'];

}
