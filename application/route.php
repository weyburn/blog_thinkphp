<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006~2018 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: liu21st <liu21st@gmail.com>
// +----------------------------------------------------------------------
use \think\Route;


/**
 * FRONTEND
 */
// index
Route::get('/', 'frontend/index/index');
// archive
Route::get('/archive', 'frontend/Archive/index');
// category
Route::get('/category', 'frontend/Category/index');
Route::get('/category/:name', 'frontend/Category/show');
// tag
Route::get('/tag', 'frontend/Tag/index');
Route::get('/tag/:name', 'frontend/Tag/show');
// about
Route::get('/about', 'frontend/About/index');
// post
Route::get('/post/:title', 'frontend/Post/show');
// comment
Route::rule('/comment', 'frontend/Comment/create', 'GET|POST');


/**
 * BACKEND
 */
Route::group('admin',function (){
    Route::get('login', 'backend/auth/index');
    Route::post('login', 'backend/auth/login');
    Route::get('logout', 'backend/auth/logout');

    Route::group('',function(){
        Route::get('/', 'backend/index/index');
        Route::resource('category', 'backend/Category');
        Route::resource('post', 'backend/Post');
        Route::resource('tag', 'backend/Tag');
        Route::resource('comment', 'backend/Comment', ['except' => ['create', 'save', '	edit']]);
    },['after_behavior'=>'\app\backend\behavior\LoginCheck']);
});
