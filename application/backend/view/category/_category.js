import layer from 'layui-layer';
import Parsley from 'parsleyjs';
import './_category.scss';

$(() => {
    console.log('#CATEGORY');
    // 分类模块
    if ($(document.body).hasClass('page--category')) {
        console.log('--category');
        const backendBaseUrl = $(document.body).data('endUrl');
        console.log(backendBaseUrl);

        // 分类列表页面
        if ($(document.body).hasClass('page--category-index')) {
            console.log('--category-index');

            // 删除分类
            $('.category-list').on('click', '.js-btn-delete', function () {
                console.log('--category-delete');
                const mId = $(this).data('mId');
                const postCount = $(this).data('postCount');
                if (postCount > 0) {
                    layer.msg(`分类【#${mId}】存在文章，不能删除`, { icon: 4, time: 2000 });
                    return;
                }
                layer.confirm(`确定删除分类【#${mId}】`, { icon: 3, title: '提示' }, function () {
                    $.ajax({
                        url: `${backendBaseUrl}/category/${mId}`,
                        type: 'DELETE',
                        dataType: 'json',
                    }).done((response) => {
                        console.log(response);
                        if (response.status === 200) {
                            layer.msg(`分类【#${mId}】${response.message}`, { icon: 6, time: 2000 }, function () {
                                window.location.href = `${backendBaseUrl}/category`;
                            });
                        } else {
                            layer.msg(`分类【#${mId}】${response.message}`, { icon: 5, time: 2000 });
                        }
                    }).fail((err) => {
                        console.log(err);
                        layer.msg(`【${err.status}】${err.statusText}`, { time: 2000 });
                    });
                });
            });

            // 获取选中id
            const categoryCheck = $('.category-check');
            const categoryAllCheck = $('.category-all-check');
            $.allChecked(categoryCheck, categoryAllCheck);
            $('.js-btn-get-check').on('click', function () {
                const categoryIdArr = [];
                categoryCheck.filter(':checked').each(function () {
                    categoryIdArr.push($(this).val());
                });
                console.log(categoryIdArr);
            });
        }

        // 新增分类页面
        if ($(document.body).hasClass('page--category-create')) {
            console.log('--category-create');

            // 新增分类
            const categoryForm = $('.category-form');
            categoryForm.parsley().on('form:submit', function () {
                $.ajax({
                    url: `${backendBaseUrl}/category`,
                    type: 'POST',
                    dataType: 'json',
                    data: $('.category-form').serialize(),
                }).done((response) => {
                    console.log(response);
                    if (response.status === 200) {
                        layer.msg(`分类${response.message}`, { icon: 6, time: 2000 }, function () {
                            window.location.href = `${backendBaseUrl}/category`;
                        });
                    } else {
                        layer.msg(`分类${response.message}`, { icon: 5, time: 2000 });
                    }
                }).fail((err) => {
                    console.log(err);
                    layer.msg(`【${err.status}】${err.statusText}`, { time: 2000 });
                });
                return false;
            });
        }

        // 编辑分类页面
        if ($(document.body).hasClass('page--category-edit')) {
            console.log('--category-edit');

            // 修改分类
            $('.category-form-edit').on('click', '.js-btn-submit', function () {
                const mId = $(this).data('mId');
                Parsley.on('form:submit', function () {
                    $.ajax({
                        url: `${backendBaseUrl}/category/${mId}`,
                        type: 'PUT',
                        dataType: 'json',
                        data: $('.category-form-edit').serialize(),
                    }).done((response) => {
                        console.log(response);
                        if (response.status === 200) {
                            layer.msg(`分类【${mId}】${response.message}`, { icon: 6, time: 2000 }, function () {
                                window.location.href = `${backendBaseUrl}/category`;
                            });
                        } else {
                            layer.msg(`分类【${mId}】${response.message}`, { icon: 5, time: 2000 });
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
