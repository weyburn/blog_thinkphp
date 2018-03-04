// 全局provide
const provide = {
    $: 'jquery',
    jquery: 'jquery',
    jQuery: 'jquery',
    Popper: 'popper.js',
    // popper: 'popper.js',
};

// 别名alias
const resolve = {
    alias: {
        // vue$: 'vue/dist/vue.esm.js',
        // 'popper.js': 'popper.js/dist/umd/popper.js',
        // jquery: 'jquery',
        // swiper$: 'swiper/dist/js/swiper.module.js',
        // swiper$: 'swiper/src/swiper.js',
        // swiper$: 'swiper/dist/js/swiper.js', // for swiper 4.0
    },
};

// 通过script标签直接从外部导入externals (src mode)
const externals = {
    // jquery: 'jQuery',
    // distpicker: 'window.Distpicker',
    // swiper: 'Swiper',
    // 'popper.js': 'window.Popper',
    // dropzone: 'Dropzone',
};

module.exports = { provide, resolve, externals };
