import 'parsleyjs';
import layer from 'layui-layer';
import './__comment.scss';

$(() => {
    if ($(document.body).hasClass('page--post-show')) {
        const jsBtnReply = $('.js-btn-reply');
        const jsBtnReplyCancel = $('.js-btn-reply-cancel');
        const commentForm = $('.comment-form');
        const commentContentInput = $('.comment-form #contentInput');

        jsBtnReply.on('click', function () {
            const replyId = $(this).data('replyId');
            const replyName = $(this).data('replyName');
            jsBtnReplyCancel.show();
            commentForm.data('replyId', replyId).data('replyName', replyName);
            commentContentInput.val('').attr('placeholder', `回复 ${replyName}`).focus();
        });

        jsBtnReplyCancel.on('click', function () {
            $(this).hide();
            commentForm.removeData('replyId').removeData('replyName');
            commentContentInput.val('').attr('placeholder', '说说你的看法').blur();
        });

        commentForm.parsley().on('form:submit', function () {
            const baseUrl = $(document.body).data('baseUrl');
            const currentUrl = $(document.body).data('currentUrl');

            const requestFormData = commentForm.serialize();
            const requestPostId = commentForm.data('postId');
            const requestReplyId = commentForm.data('replyId');
            const requestReplyName = commentForm.data('replyName');
            const requestData = `${requestFormData}&post_id=${requestPostId}&reply_id=${requestReplyId}&reply_name=${requestReplyName}`;

            $.ajax({
                url: `${baseUrl}/comment`,
                type: 'POST',
                dataType: 'json',
                data: requestData,
            }).done((response) => {
                console.log(response);
                if (response.status === 200) {
                    layer.msg(response.message, { icon: 6, time: 2000 }, function () {
                        window.location.href = currentUrl;
                    });
                } else {
                    layer.msg(response.message, { icon: 5, time: 2000 });
                }
            }).fail((err) => {
                console.log(err);
                layer.msg(`【${err.status}】${err.statusText}`, { time: 2000 });
            });
            return false;
        });
    }
});
