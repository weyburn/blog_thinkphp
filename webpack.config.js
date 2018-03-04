const CleanWebpackPlugin = require('clean-webpack-plugin');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const ExtractTextPlugin = require('extract-text-webpack-plugin');

const webpackModule = require('./_build/_webpack_module');
const webpackPlugins = require('./_build/_webpack_plugin');
const webpackPath = require('./_build/_webpack_path');
const webpackShimming = require('./_build/_webpack_shimming');

// 先清除掉之前的文件
webpackPlugins.push(new CleanWebpackPlugin(
    [
        `${webpackPath.STATIC_SUBDIR_PREFIX}scripts`,
        `${webpackPath.STATIC_SUBDIR_PREFIX}styles`,
        `${webpackPath.STATIC_SUBDIR_PREFIX}themes`,
        `${webpackPath.STATIC_DIR}/images`,
        `${webpackPath.STATIC_DIR}/fonts`,
    ],
    {
        root: webpackPath.STATIC_DIR,
        verbose: true,
        dry: false,
    }
));

// 打包 css 样式
webpackPlugins.push(new ExtractTextPlugin({
    filename: `${webpackPath.STATIC_SUBDIR_PREFIX}styles/[name]${webpackPath.isChunkhash}.css`,
}));

// 动态输出 html
const htmlWebpackList = {
    frontend: {
        filename: `${webpackPath.STATIC_SUBDIR_PREFIX}themes/frontend.php`,
        template: './application/frontend/view/_base/frontend.ejs',
        chunks: ['frontend'],
    },
    backend: {
        filename: `${webpackPath.STATIC_SUBDIR_PREFIX}themes/backend.php`,
        template: './application/backend/view/_base/backend.ejs',
        chunks: ['backend'],
    },
};

Object.keys(htmlWebpackList).forEach((key) => {
    webpackPlugins.push(new HtmlWebpackPlugin({
        title: key,
        filename: htmlWebpackList[key].filename,
        template: htmlWebpackList[key].template,
        inject: false,
        chunks: htmlWebpackList[key].chunks,
        // 如何让webpack HtmlWebpackPlugin插件生成html插入js 的时候 按chunks 顺序插入？
        // https://segmentfault.com/q/1010000008621650?_ea=1700642
        chunksSortMode: (chk1, chk2) => {
            const chks = htmlWebpackList[key].chunks;
            const order1 = chks.indexOf(chk1.names[0]);
            const order2 = chks.indexOf(chk2.names[0]);
            return order1 - order2;
        },
        hash: false,
    }));
});

// 导出 webpack 配置对象
module.exports = {
    entry: {
        frontend: `${webpackPath.APP_DIR}/frontend/view/_base/frontend.js`,
        backend: `${webpackPath.APP_DIR}/backend/view/_base/backend.js`,
    },
    output: {
        path: webpackPath.STATIC_DIR,
        filename: `${webpackPath.STATIC_SUBDIR_PREFIX}scripts/[name]${webpackPath.isChunkhash}.js`,
        publicPath: '/static',
        sourceMapFilename: `${webpackPath.STATIC_SUBDIR_PREFIX}scripts/[name]${webpackPath.isChunkhash}.js.map`,
        chunkFilename: `${webpackPath.STATIC_SUBDIR_PREFIX}scripts/[name]${webpackPath.isChunkhash}.js`,
    },
    plugins: webpackPlugins,
    module: webpackModule,
    devtool: webpackPath.isDist ? false : 'cheap-source-map',
    resolve: webpackShimming.resolve,
    externals: webpackShimming.externals,
};

