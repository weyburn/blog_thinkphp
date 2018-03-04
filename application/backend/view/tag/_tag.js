import layer from 'layui-layer';
import Parsley from 'parsleyjs';
import './_tag.scss';

$(() => {
    console.log('#TAG');
    // 标签模块
    if ($(document.body).hasClass('page--tag')) {
        console.log('--tag');
        const backendBaseUrl = $(document.body).data('endUrl');
        console.log(backendBaseUrl);

        // 标签列表页面
        if ($(document.body).hasClass('page--tag-index')) {
            console.log('--tag-index');

            // 删除标签
            $('.tag-list').on('click', '.js-btn-delete', function () {
                console.log('--tag-delete');
                const mId = $(this).data('mId');
                const postCount = $(this).data('postCount');
                if (postCount > 0) {
                    layer.msg(`标签【#${mId}】存在文章，不能删除`, { icon: 4, time: 2000 });
                    return;
                }
                layer.confirm(`确定删除标签【#${mId}】`, { icon: 3, title: '提示' }, function () {
                    $.ajax({
                        url: `${backendBaseUrl}/tag/${mId}`,
                        type: 'DELETE',
                        dataType: 'json',
                    }).done((response) => {
                        console.log(response);
                        if (response.status === 200) {
                            layer.msg(`标签【#${mId}】${response.message}`, { icon: 6, time: 2000 }, function () {
                                window.location.href = `${backendBaseUrl}/tag`;
                            });
                        } else {
                            layer.msg(`标签【#${mId}】${response.message}`, { icon: 5, time: 2000 });
                        }
                    }).fail((err) => {
                        console.log(err);
                        layer.msg(`【${err.status}】${err.statusText}`, { time: 2000 });
                    });
                });
            });

            // 获取选中id
            const tagCheck = $('.tag-check');
            const tagAllCheck = $('.tag-all-check');
            $.allChecked(tagCheck, tagAllCheck);
            $('.js-btn-get-check').on('click', function () {
                const tagIdArr = [];
                tagCheck.filter(':checked').each(function () {
                    tagIdArr.push($(this).val());
                });
                console.log(tagIdArr);
            });
        }

        // 新增标签页面
        if ($(document.body).hasClass('page--tag-create')) {
            console.log('--tag-create');

            // 新增标签
            const tagForm = $('.tag-form');
            tagForm.parsley().on('form:submit', function () {
                $.ajax({
                    url: `${backendBaseUrl}/tag`,
                    type: 'POST',
                    dataType: 'json',
                    data: $('.tag-form').serialize(),
                }).done((response) => {
                    console.log(response);
                    if (response.status === 200) {
                        layer.msg(`标签${response.message}`, { icon: 6, time: 2000 }, function () {
                            window.location.href = `${backendBaseUrl}/tag`;
                        });
                    } else {
                        layer.msg(`标签${response.message}`, { icon: 5, time: 2000 });
                    }
                }).fail((err) => {
                    console.log(err);
                    layer.msg(`【${err.status}】${err.statusText}`, { time: 2000 });
                });
                return false;
            });
        }

        // 编辑标签页面
        if ($(document.body).hasClass('page--tag-edit')) {
            console.log('--tag-edit');

            // 修改标签
            $('.tag-form-edit').on('click', '.js-btn-submit', function () {
                const mId = $(this).data('mId');
                Parsley.on('form:submit', function () {
                    $.ajax({
                        url: `${backendBaseUrl}/tag/${mId}`,
                        type: 'PUT',
                        dataType: 'json',
                        data: $('.tag-form-edit').serialize(),
                    }).done((response) => {
                        console.log(response);
                        if (response.status === 200) {
                            layer.msg(`标签【${mId}】${response.message}`, { icon: 6, time: 2000 }, function () {
                                window.location.href = `${backendBaseUrl}/tag`;
                            });
                        } else {
                            layer.msg(`标签【${mId}】${response.message}`, { icon: 5, time: 2000 });
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
