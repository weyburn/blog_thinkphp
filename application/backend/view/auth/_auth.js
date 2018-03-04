import Parsley from 'parsleyjs';
import layer from 'layui-layer';
import './_auth.scss';

$(() => {
    console.log('#AUTH');
    // 后台登录页面
    if ($(document.body).hasClass('page--auth-login')) {
        console.log('--auth-login');
        const backendBaseUrl = $(document.body).data('endUrl');
        console.log(backendBaseUrl);

        // 处理登录
        $('.js-btn-submit').on('click', function () {
            const formData = $('.login-form').serialize();
            Parsley.on('form:submit', function () {
                $.ajax({
                    url: `${backendBaseUrl}/login`,
                    data: formData,
                    dataType: 'json',
                    type: 'POST',
                }).done(function (response) {
                    console.log(response);
                    if (response.status === 200) {
                        // 登录成功
                        layer.msg(response.message, { icon: 6, time: 2000 }, () => {
                            window.location.href = backendBaseUrl;
                        });
                    } else {
                        // 登录失败
                        layer.msg(response.message, { icon: 5, time: 2000 });
                    }
                }).fail((err) => {
                    console.log(err);
                    layer.msg(`【${err.status}】${err.statusText}`, { time: 2000 });
                });
                return false;
            });
        });
    }
});
