import layer from 'layui-layer';
import './__comment.scss';

$(() => {
    console.log('#COMMENT');
    // 评论模块
    if ($(document.body).hasClass('page--comment')) {
        console.log('--comment');
        const backendBaseUrl = $(document.body).data('endUrl');
        console.log(backendBaseUrl);

        // 评论列表页面
        if ($(document.body).hasClass('page--comment-index')) {
            console.log('--comment-index');

            // 删除评论
            $('.comment-list').on('click', '.js-btn-delete', function () {
                console.log('--comment-delete');
                const mId = $(this).data('mId');
                layer.confirm(`确定删除评论【#${mId}】`, { icon: 3, title: '提示' }, function () {
                    $.ajax({
                        url: `${backendBaseUrl}/comment/${mId}`,
                        type: 'DELETE',
                        dataType: 'json',
                    }).done((response) => {
                        console.log(response);
                        if (response.status === 200) {
                            layer.msg(`评论【#${mId}】${response.message}`, { icon: 6, time: 2000 }, function () {
                                window.location.href = `${backendBaseUrl}/comment`;
                            });
                        } else {
                            layer.msg(`评论【#${mId}】${response.message}`, { icon: 5, time: 2000 });
                        }
                    }).fail((err) => {
                        console.log(err);
                        layer.msg(`【${err.status}】${err.statusText}`, { time: 2000 });
                    });
                });
            });

            // 获取选中id
            const commentCheck = $('.comment-check');
            const commentAllCheck = $('.comment-all-check');
            $.allChecked(commentCheck, commentAllCheck);
            $('.js-btn-get-check').on('click', function () {
                const commentIdArr = [];
                commentCheck.filter(':checked').each(function () {
                    commentIdArr.push($(this).val());
                });
                console.log(commentIdArr);
            });
        }

        // 评论详情页面
        if ($(document.body).hasClass('page--comment-show')) {
            console.log('--comment-show');

            // 修改评论状态
            $('.comment-show-list').on('click', '.js-btn-update', function () {
                console.log('--comment-update');
                const mId = $(this).data('mId');
                $.ajax({
                    url: `${backendBaseUrl}/comment/${mId}`,
                    type: 'PUT',
                    dataType: 'json',
                }).done((response) => {
                    console.log(response);
                    if (response.status === 200) {
                        layer.msg(`评论【${mId}】状态${response.message}`, { icon: 6, time: 2000 }, () => {
                            window.location.href = `${backendBaseUrl}/comment/${mId}`;
                        });
                    } else {
                        layer.msg(`评论【${mId}】状态${response.message}`, { icon: 5, time: 2000 });
                    }
                }).fail((err) => {
                    console.log(err);
                    layer.msg(`【${err.status}】${err.statusText}`, { time: 2000 });
                });
            });
        }
    }
});
