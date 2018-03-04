const webpack = require('webpack');
const UglifyJSPlugin = require('uglifyjs-webpack-plugin');
const webpackShimming = require('./_webpack_shimming');
const webpackPath = require('./_webpack_path');

const webpackPlugins = [];

webpackPlugins.push(new webpack.IgnorePlugin(/^\.\/locale$/, /moment$/));

// Scope Hoisting-作用域提升
// 提升代码在浏览器中的执行速度
webpackPlugins.push(new webpack.optimize.ModuleConcatenationPlugin());

// 全局 Shimming （即不需要 import 直接用）
webpackPlugins.push(new webpack.ProvidePlugin(webpackShimming.provide));

// 一些第三方的库会在开发模式下有更多的调试输出
// 这里判断是打包本地用(isDist 为 FALSE）还是生成环境用（isDist)
if (webpackPath.isDist) {
    console.log('NODE_ENV  :  production');
    // 部署plugin
    webpackPlugins.push(
        new webpack.DefinePlugin({
            'process.env': {
                NODE_ENV: '"production"',
            },
        }),
        new webpack.optimize.OccurrenceOrderPlugin(),
        new UglifyJSPlugin(),
    );
} else {
    // 开发plugin
    webpackPlugins.push(new webpack.DefinePlugin({
        'process.env': {
            NODE_ENV: '"development"',
        },
    }));
}

// source map
// 开启SOURCE MAP 方便开发的时候调试
webpackPlugins.push(new UglifyJSPlugin({ sourceMap: !webpackPath.isDist }));

// 导出该插件数组
module.exports = webpackPlugins;
