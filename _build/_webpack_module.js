const ExtractTextPlugin = require('extract-text-webpack-plugin');
const path = require('path');
const webpackPath = require('./_webpack_path');

const webpackModule = {};
webpackModule.rules = [
    // 解析js或jsx
    {
        test: /\.(js|jsx)$/,
        exclude: /node_modules/,
        use: [
            {
                loader: 'babel-loader',
                options: {
                    presets: ['es2015'],
                    plugins: ['transform-runtime'],
                },
            },
        ],
    },
    // 解析Vue
    /*
    {
        test: /\.(vue)$/,
        use: [
            {
                loader: 'vue-loader',
                options: {
                    loaders: {
                        scss: 'vue-style-loader!css-loader!sass-loader',
                    },
                },
            },
        ],
    },
    */
    // 解析artTemplate
    /*
    {
        test: /\.(art)$/,
        use: [
            {
                loader: 'art-template-loader',
                options: {},
            },
        ],
    },
    */
    // 解析scss、sass、css
    {
        test: /\.(scss|sass|css)$/,
        use: ExtractTextPlugin.extract({
            use: [
                {
                    loader: 'css-loader',
                    options: {
                        minimize: webpackPath.isDist,
                    },
                },
                {
                    loader: 'postcss-loader',
                    options: {
                        plugins: () => [
                            require('autoprefixer')({
                                browsers: [
                                    '> 5% in CN',
                                    'last 5 versions',
                                    'iOS >= 9',
                                    'Chrome >= 52',
                                    'Safari >= 9',
                                    'ff >= 52',
                                    'ie >= 10',
                                ],
                            }),
                        ],
                    },
                },
                {
                    loader: 'sass-loader',
                },
            ],
            fallback: 'style-loader',
        }),
    },
    // 解析图片
    {
        test: /\.(png|jpg|jpeg|gif|svg)$/,
        use: [
            {
                loader: 'url-loader',
                options: {
                    limit: 8,
                    name: '/images/[name]_[hash].[ext]',
                },
            },
        ],
        exclude: path.resolve(__dirname, '../public/assets/font'),
    },
    // 解析字体
    {
        test: /\.(woff|woff2|svg|eot|ttf)$/,
        use: [
            {
                loader: 'url-loader',
                options: {
                    limit: 8,
                    name: '/fonts/[name].[ext]?ver=[hash:4]',
                },
            },
        ],
    },
];

// 导出一个对象，对象有rules属性（数组）
module.exports = webpackModule;
