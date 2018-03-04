import layer from 'layui-layer';
import Parsley from 'parsleyjs';
import 'summernote/dist/summernote-bs4';
import 'summernote/dist/lang/summernote-zh-CN';
import './_post.scss';

// 暴露 $ 给浏览器的 window
window.$ = $;

$(() => {
    console.log('#POST');
    // 文章模块
    if ($(document.body).hasClass('page--post')) {
        console.log('--post');
        const backendBaseUrl = $(document.body).data('endUrl');
        console.log(backendBaseUrl);

        // 文章列表页面
        if ($(document.body).hasClass('page--post-index')) {
            console.log('--post-index');

            // 删除文章
            $('.post-list').on('click', '.js-btn-delete', function () {
                console.log('--post-delete');
                const mId = $(this).data('mId');
                layer.confirm(`确定删除文章【#${mId}】`, { icon: 3, title: '提示' }, function () {
                    $.ajax({
                        url: `${backendBaseUrl}/post/${mId}`,
                        type: 'DELETE',
                        dataType: 'json',
                    }).done((response) => {
                        console.log(response);
                        if (response.status === 200) {
                            layer.msg(`文章【#${mId}】${response.message}`, { icon: 6, time: 2000 }, function () {
                                window.location.href = `${backendBaseUrl}/post`;
                            });
                        } else {
                            layer.msg(`文章【#${mId}】${response.message}`, { icon: 5, time: 2000 });
                        }
                    }).fail((err) => {
                        console.log(err);
                        layer.msg(`【${err.status}】${err.statusText}`, { time: 2000 });
                    });
                });
            });

            // 获取选择中id
            const postCheck = $('.post-check');
            const postAllCheck = $('.post-all-check');
            $.allChecked(postCheck, postAllCheck);
            $('.js-btn-get-check').on('click', function () {
                const postIdArr = [];
                postCheck.filter(':checked').each(function () {
                    postIdArr.push($(this).val());
                });
                console.log(postIdArr);
            });
        }

        // 新增文章页面
        if ($(document.body).hasClass('page--post-create')) {
            console.log('--post-create');

            // 新增分类
            const postForm = $('.post-form');
            postForm.parsley().on('form:submit', function () {
                $.ajax({
                    url: `${backendBaseUrl}/post`,
                    type: 'POST',
                    dataType: 'json',
                    data: $('.post-form').serialize(),
                }).done((response) => {
                    console.log(response);
                    if (response.status === 200) {
                        layer.msg(`文章${response.message}`, { icon: 6, time: 2000 }, function () {
                            window.location.href = `${backendBaseUrl}/post`;
                        });
                    } else {
                        layer.msg(`文章${response.message}`, { icon: 5, time: 2000 });
                    }
                }).fail((err) => {
                    console.log(err);
                    layer.msg(`【${err.status}】${err.statusText}`, { time: 2000 });
                });
                return false;
            });
        }

        // 编辑文章页面
        if ($(document.body).hasClass('page--post-edit')) {
            console.log('--post-edit');

            // 修改分类
            $('.post-form-edit').on('click', '.js-btn-submit', function () {
                const mId = $(this).data('mId');
                Parsley.on('form:submit', function () {
                    $.ajax({
                        url: `${backendBaseUrl}/post/${mId}`,
                        type: 'PUT',
                        dataType: 'json',
                        data: $('.post-form-edit').serialize(),
                    }).done((response) => {
                        console.log(response);
                        if (response.status === 200) {
                            layer.msg(`文章【${mId}】${response.message}`, { icon: 6, time: 2000 }, function () {
                                window.location.href = `${backendBaseUrl}/post`;
                            });
                        } else {
                            layer.msg(`文章【${mId}】${response.message}`, { icon: 5, time: 2000 });
                        }
                    }).fail((err) => {
                        console.log(err);
                        layer.msg(`【${err.status}】${err.statusText}`, { time: 2000 });
                    });
                    return false;
                });
            });
        }
    }
});
