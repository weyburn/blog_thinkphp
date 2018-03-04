CREATE DATABASE IF NOT EXISTS `tp_weyburn_blog` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
use `tp_weyburn_blog`;


-- --------------------------------------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '分类id',
  `name` varchar(36) NOT NULL DEFAULT '' COMMENT '分类名称',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '分类表';

INSERT INTO `categories` (`id`, `name`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, '技术水波文', '2018-01-26 13:18:12', '2018-02-20 05:45:44', NULL),
(2, '叙事高手', '2018-01-26 19:38:35', '2018-02-20 05:45:49', NULL),
(3, '碎碎念', '2018-01-26 19:41:29', '2018-02-20 05:45:55', NULL),
(4, '随笔', '2018-01-26 21:58:58', '2018-02-20 05:46:01', NULL),
(5, 'ReadingList', '2018-01-26 22:00:31', '2018-02-20 05:46:06', NULL),
(6, '收藏链接', '2018-01-26 22:00:52', '2018-02-20 05:43:48', NULL);
-- --------------------------------------------------------


-- --------------------------------------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '评论id',
  `name` varchar(40) NOT NULL DEFAULT '' COMMENT '评论者名称',
  `email` varchar(64) NOT NULL DEFAULT '' COMMENT '评论者邮箱',
  `website` varchar(120) NULL DEFAULT NULL COMMENT '评论者网址',
  `ip` varchar(40) NULL DEFAULT NULL COMMENT '评论者ip地址',
  `content` varchar(300) NOT NULL DEFAULT '' COMMENT '评论内容',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态(0为未读,1为已读)',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间',
  `post_id` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '博客id',
  `reply_id` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '回复id',
  `reply_name` varchar(40) NULL DEFAULT NULL COMMENT '回复名称',
  FOREIGN KEY (`post_id`) REFERENCES posts(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评论表';

INSERT INTO `comments` (`id`, `name`, `email`, `website`, `ip`, `content`, `status`, `created_at`, `updated_at`, `deleted_at`, `post_id`, `reply_id`, `reply_name`) VALUES
(1, 'James', 'James@qq.com', 'James.com', '127.0.0.1', '很好，非常好', 1, '2018-02-13 15:45:00', '2018-02-22 15:39:48', NULL, 6, NULL, NULL),
(2, 'Wade', 'Wade@qq.com', 'Wade.com', '127.0.0.1', '赞同', 1, '2018-02-13 15:47:28', '2018-02-22 15:39:43', NULL, 6, 1, 'James'),
(3, 'Tracy', 'Tracy@qq.com', 'Tracy.com', '127.0.0.1', '好好好', 1, '2018-02-13 22:18:58', '2018-02-22 15:39:34', NULL, 6, NULL, NULL),
(4, 'Weyburn', 'Weyburn@qq.com', 'Weyburn.com', '127.0.0.1', 'a11jk1h', 1, '2018-02-13 22:20:34', '2018-02-22 15:39:26', NULL, 6, 2, 'Wade'),
(5, 'Test', 'Test@qq.com', 'Test.com', '127.0.0.1', '<script>alert(\'123\')</script>', 1, '2018-02-17 19:28:05', '2018-02-22 15:41:21', NULL, 6, NULL, NULL);
-- --------------------------------------------------------


-- --------------------------------------------------------
DROP TABLE IF EXISTS `posts`;
CREATE TABLE `posts`(
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '文章id',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '文章标题',
  `content` text NOT NULL DEFAULT '' COMMENT '文章内容',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态(0为草稿,1为发布)',
  `view_count` int(6) UNSIGNED NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间',
  `published_at` timestamp NULL DEFAULT NULL COMMENT '发布时间',
  `category_id` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '分类id',
  FOREIGN KEY (`category_id`) REFERENCES categories(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '文章表';

INSERT INTO `posts` (`id`, `title`, `content`, `status`, `view_count`, `created_at`, `updated_at`, `deleted_at`, `published_at`, `category_id`) VALUES
(1, '希桅的第一次面试', '<p>路上车来车往。“红灯停绿灯行，这个世界能够一致的规则貌似不多”，希桅望着车窗天马行空的想着。</p><p>世界需要规则，但同时又不能完全遵行规则。这本身就是一件多么矛盾的事情。中庸之道只是一个结论，这个结论的推进过程估计充斥着各种矛盾的上下波动。时期不同，环境不同，心态不同。同样的条件背景，有人追求本质极致，有人追求无为而治。微观变数聚集而成宏观不变。</p><p>希桅是一个乐观主义差不多派，他的乐观也是差不多的。这个时候，他正在车上，去往一场面试。在车上他胡乱的想着一些不着边际的事情，完全没有为接下来的面试考虑。希桅虽然性格优柔寡断，但他有船到桥头自然直，以及抱佛脚不够优雅两个护盾驱使他表现的有那么点从容。</p><!--more--><p>学校的课希桅仅上了开学第一节，领了新书后再没有踏过教室的门。既然闲着也是闲着，于是他决定出去找份工做，今天正是他的第一次面试。与往常一样，他睡到快中午。然后草草地洗过，草草地吃过被忽略的早餐，然后悠然地出发。坐公车对他来说是一件愉快的事情，在公车上他可以无聊地想一些无聊的事情来打发无聊。</p><p>准时一词绝对不能用在希桅身上，而今天他意外的提前到了面试的公司。想来，第一次面试对于他来说还是比较重大的。接待他的是一个年轻的女孩，估计二十来岁，给希桅引到一间办公室并倒了杯水就此消失不见。</p>', 1, 3442, '2018-01-26 19:54:37', '2018-02-23 16:03:33', NULL, '2016-03-23 01:00:00', 2),
(2, 'AngularJS 应用单元测试起步', '<p>AngularJS 很重视测试，所以提供了很多特性使得编写测试变得更容易。AngularJS 应用的单元测试与普通的 JavaScript 应用测试有些不同。</p><p>AngularJS 应用是以 module（模块）为单位来组织应用，将不同的功能放进各自的模块。测试可以从整个应用级别，或者从特定的模块开始。正是由于测试可以从模块开始，在测试的时候需要指定引用的模块。</p><p>为AngularJS 应用在启动的时候，会寻找 <code>ng-app</code> 指定的模块，而后创建一个 <code>$rootScope</code> 以及一个管理依赖的 <code>$injector</code>，而后依赖将通过 <code>$injector</code> 自动注入。在测试的时候，需要手动处理这个过程。因为在编写测试的时候，希望的是能够进行单元性的测试，能够针对特定的模块进行测试。所以在编写 AngularJS 测试的时候，我们需要手动去引用某个模块 ，同时手动创建 <code>$rootScope</code> 和手动引入依赖。</p><!--more--><p>AngularJS 提供了 <a href=\"http://#\">ngModule</a> 这个模块，包含一些方法用来处理这个过程。这个过程主要使用到的是两个方法，分别是 <code>module</code> 以及 <code>inject</code> 方法。前者用于引入模块，后者用于处理依赖。例如：</p>', 1, 4432, '2018-01-26 19:53:10', '2018-02-23 16:03:31', NULL, '2016-06-04 19:53:10', 4),
(3, '聊聊 NexT 主题', '<p><a href=\"http://#\">NexT 主题</a> 快满一周岁了，值此之际，碎碎念一下（没有干货）。正如我在 <a href=\"http://#\">V2EX 分享</a> 时的介绍一样，NexT 的前身叫做 <a href=\"http://#\">Notes</a>。在做 Notes 主题的时候，基于当时的需求出发点，从好听上来讲是简洁，不好听就是简陋（真直接，脸红）。</p>\r\n<figure>\r\n<img src=\"http://notes.iissnan.com/uploads/something-about-next/theme-next.jpg\" title=\"NexT Theme\" style=\"width: 100%;\">\r\n<figcaption>NexT Theme</figcaption>\r\n</figure>\r\n<!--more--><p>Notes 开发于我刚接触 <a href=\"http://#\">Hexo</a> 时。当时我拥有一个基于 <a href=\"http://#\">WordPress</a> 的独立博客，这个博客主要用来写比较完整的技术类文章。在拖延症与技术挫的主观加客观因素综合作用下，这个独立博客也是产出寥寥。然而在丑小鸭能变美丽天鹅的唯美段子的安利下，我也是每天勤勤恳恳钻研技术（折腾不休）。每日阅读各路教程，搜索各种解决方案，追根溯源探索背后的原理，企图从根本上回答 “我是谁？我从哪里来？我要到哪里去？” 这类哲学问题。</p>', 1, 29992, '2018-01-26 19:45:10', '2018-02-23 16:03:28', NULL, '2016-10-19 19:45:10', 3),
(4, '记近期电脑设备升级一事', '<p>十一月真是一个忙碌的季节，电商平台携商家精心布局撒网等鱼入网，买家手握巨款蠢蠢欲动，物流赶忙提升内容分发系统的高效性与健壮性，一副生机勃勃的画面。作为不怎么热衷购物的我在这番阵势下也激动的跃跃欲试，为了做好热身运动，我提前升级了下电脑设备。那买买买的节奏可谓十分轻快明朗，让人欲罢不能。钱要花在刀刃上，这是我获得的人生的第二条真谛，还挺早获得的，就是执行力不够。我把这个错误归结为冲动的欲望在作祟，但很明显是自我欺骗，显然应该怪商家太会营销打广告。</p>\r\n<figure>\r\n<img src=\"http://notes.iissnan.com/uploads/upgrade-computer-components/shut-up-and-take-my-money.jpg\" title=\"闭嘴，一手交钱一手交货\" style=\"width: 100%;\">\r\n<figcaption>闭嘴，一手交钱一手交货</figcaption>\r\n</figure>\r\n<!--more--><p>常话说的好，高富玩表，土豪玩车，屌丝玩电脑。作为一名屌丝中的战斗机，那电脑必须玩得溜。人生真谛第三条，既然决定做一件事情，就把这叫事情做好，无关贫富贵贱，此乃工匠本色。看着那些陪伴多年，依然坚守岗位默默奋斗的电子设备，我想是时候了，是时候来个咸鱼翻身，再扑腾一阵子。</p>', 1, 14200,  '2018-01-26 19:41:04', '2018-02-24 07:26:47', NULL, '2016-11-02 19:41:04', 2),
(5, 'NexT Documentations Reload', '<p>尽管简单易用一直是 NexT 主题的首要目标，但现实与想法总是有那么一个缝隙，难怪有人说诗要源于生活后低于生活，着实有着深刻的哲学道理。那么无论这背后是什么样的原因导致，总结起来就是 NexT 不好用。在初期使用者比较少的情况，还可以有耐心的一个个解答；后来发现一直在回答类似的问题，加上要做和想做的事情太多而无暇顾及，于是就想写一份文档缓和一下这个问题。</p>\r\n<figure>\r\n<img src=\"http://notes.iissnan.com/uploads/next-documentations-reload/brand-new.png\" title=\"New Documentations for NexT\" style=\"width: 100%;\">\r\n<figcaption>New Documentations for NexT</figcaption>\r\n</figure><!--more-->\r\n<h2>前季剧情回顾</h2><p>起先，我使用 Hexo 搭建了第一版的 NexT 使用文档站点。UI 框架选择的是 <a href=\"http://#\">Semantic UI</a>，并且新建了一个主题称为 <a href=\"http://#\">Luminosa</a>。然而我发现要在 Markdown 里使用 Semantic UI 的组件有点麻烦，以及 Hexo 在解析 Markdown 时会自动加上很多空行的问题。不得已之下，只能创建了几个 Tag Plugins 封装了一下使用到的 Semantic UI 的组件。<br></p>', 1, 18601, '2018-01-26 19:36:58', '2018-02-23 16:03:22', NULL, '2017-03-15 19:36:58', 4),
(6, '使用 Travis CI 自动更新 GitHub Pages', '<p>每次更改完 <a href=\"http://#\">NexT 文档</a> 都要手动部署到 GitHub Pages，重复的次数多了就显得很麻烦，出错的几率也会变大。文档源码放置在 master 分支，最终部署文件在 gh-pages 分支。当在 master 分支更改某些内容之后，通过运行 gulp dist 来生成最终部署的 HTML 文件到 dist 目录，随后再进入 dist 目录初始化 git 仓库、添加文件、提交文件，最后将提交强制推送到远程 gh-pages 分支（因当心我会误将最终部署的 HTML 文件提交到 master 分支导致源码丢失，我在 GitHub 上把 master 分支给锁定了）。除此之外还有另外一个问题：如果 master 分支有 Pull Requests，我需要先将更新取回本地，然后编译更新再提交回远程 gh-pages 分支。</p><!--more--><h2>年轻的想法</h2><p>于是，我就想这说将这个过程自动化。首先考虑了使用 <a href=\"http://#\">GitHub Webhooks</a>，这是 Github 提供的一种机制，使应用能与 Github 通讯。这种机制实际上就是 Pub/Sub，当 Github 监测到资源（如仓库）有变化就往预先设定的 URL 发送一个 POST 请求（Pub），告知变化情况，而后接收变化的服务器（Sub）即可做一些额外的事情。</p><p>这个思路需要有一个服务器并启动一个服务来接收 Github 的请求。这里又有种不同的策略，这两种策略都是基于源码放置在 Github 的前提。第一个是源码将最终文档直接部署在这台服务器上（如使用 Nginx），当接收到 Github 通知直接编译更新到服务器指定的文件夹下即可。另一种策略是当服务器接收到通知后编译更新，而后将编译后的版本提交到 Github 仓库的 gh-pages 分支，让 Github 做 Host。</p>', 1, 38908, '2018-01-26 19:24:32', '2018-02-24 06:14:54', NULL, '2017-03-21 19:24:32', 1),
(7, '代码测试', '<pre><code>(function ($) {<br>&nbsp; &nbsp; function AllChecked(checkElement, allCheckElement) {<br>&nbsp; &nbsp; &nbsp; &nbsp; this.checkElement = checkElement;<br>&nbsp; &nbsp; &nbsp; &nbsp; this.allCheckElement = allCheckElement;<br>&nbsp; &nbsp; &nbsp; &nbsp; this._init();<br>&nbsp; &nbsp; }<br>&nbsp; &nbsp; AllChecked.prototype = {<br>&nbsp; &nbsp; &nbsp; &nbsp; _init: function () {<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; // eslint-disable-next-line prefer-destructuring<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; const checkElement = this.checkElement;<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; // eslint-disable-next-line prefer-destructuring<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; const allCheckElement = this.allCheckElement;<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; checkElement.on(\'click\', function () {<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (checkElement.filter(\':checked\').length === checkElement.length) {<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; allCheckElement.prop(\'checked\', true);<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; } else {<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; allCheckElement.prop(\'checked\', false);<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; });<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; allCheckElement.on(\'click\', function () {<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (allCheckElement.prop(\'checked\')) {<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; checkElement.prop(\'checked\', true);<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; } else {<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; checkElement.prop(\'checked\', false);<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; });<br>&nbsp; &nbsp; &nbsp; &nbsp; },<br>&nbsp; &nbsp; };<br>&nbsp; &nbsp; $.extend({<br>&nbsp; &nbsp; &nbsp; &nbsp; allChecked: function (checkElement, allCheckElement) {<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; // eslint-disable-next-line no-new<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; new AllChecked(checkElement, allCheckElement);<br>&nbsp; &nbsp; &nbsp; &nbsp; },<br>&nbsp; &nbsp; });<br>}(jQuery));</code></pre><p><br></p>', 1, 10, '2018-02-23 15:22:01', '2018-02-24 06:43:54', NULL, '2018-02-12 16:00:00', 5);
-- --------------------------------------------------------


-- --------------------------------------------------------
DROP TABLE IF EXISTS `post_tag`;
CREATE TABLE `post_tag` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '关联id',
  `post_id` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '文章id',
  `tag_id` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '标签id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间',
  FOREIGN KEY (`post_id`) REFERENCES posts(`id`),
  FOREIGN KEY (`tag_id`) REFERENCES tags(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '文章标签关联表';

INSERT INTO `post_tag` (`id`, `post_id`, `tag_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 1, '2018-02-18 13:21:40', '2018-02-18 13:21:40', NULL),
(2, 1, 2, '2018-02-18 13:21:40', '2018-02-18 13:21:40', NULL),
(3, 1, 3, '2018-02-18 13:21:40', '2018-02-18 13:21:40', NULL),
(4, 1, 4, '2018-02-18 13:21:41', '2018-02-18 13:21:41', NULL),
(5, 1, 5, '2018-02-18 13:21:41', '2018-02-18 13:21:41', NULL),
(6, 1, 6, '2018-02-18 13:21:41', '2018-02-18 13:21:41', NULL),
(7, 2, 7, '2018-02-18 13:24:48', '2018-02-18 13:24:48', NULL),
(8, 2, 8, '2018-02-18 13:21:51', '2018-02-18 13:21:51', NULL),
(9, 2, 9, '2018-02-18 13:21:51', '2018-02-18 13:21:51', NULL),
(10, 2, 10, '2018-02-18 13:21:51', '2018-02-18 13:21:51', NULL),
(11, 2, 11, '2018-02-18 13:21:51', '2018-02-18 13:21:51', NULL),
(12, 2, 12, '2018-02-18 13:21:51', '2018-02-18 13:21:51', NULL),
(13, 3, 13, '2018-02-18 13:24:59', '2018-02-18 13:24:59', NULL),
(14, 3, 14, '2018-02-18 13:22:04', '2018-02-18 13:22:04', NULL),
(15, 3, 15, '2018-02-18 13:22:04', '2018-02-18 13:22:04', NULL),
(16, 3, 16, '2018-02-18 13:22:04', '2018-02-18 13:22:04', NULL),
(17, 3, 17, '2018-02-18 13:22:04', '2018-02-18 13:22:04', NULL),
(18, 4, 18, '2018-02-18 13:25:12', '2018-02-18 13:25:12', NULL),
(19, 4, 19, '2018-02-18 13:25:12', '2018-02-18 13:25:12', NULL),
(20, 4, 20, '2018-02-18 13:22:15', '2018-02-18 13:22:15', NULL),
(21, 4, 21, '2018-02-18 13:22:15', '2018-02-18 13:22:15', NULL),
(22, 4, 22, '2018-02-18 13:22:15', '2018-02-18 13:22:15', NULL),
(23, 4, 23, '2018-02-18 13:22:15', '2018-02-18 13:22:15', NULL),
(24, 5, 24, '2018-02-18 13:25:25', '2018-02-18 13:25:25', NULL),
(25, 5, 25, '2018-02-18 13:25:25', '2018-02-18 13:25:25', NULL),
(26, 5, 26, '2018-02-18 13:22:26', '2018-02-18 13:22:26', NULL),
(27, 5, 27, '2018-02-18 13:22:26', '2018-02-18 13:22:26', NULL),
(28, 5, 28, '2018-02-18 13:22:26', '2018-02-18 13:22:26', NULL),
(29, 5, 29, '2018-02-18 13:22:26', '2018-02-18 13:22:26', NULL),
(30, 6, 2, '2018-02-18 13:27:20', '2018-02-18 13:27:20', NULL),
(31, 6, 5, '2018-02-18 13:27:20', '2018-02-18 13:27:20', NULL),
(32, 6, 8, '2018-02-18 13:27:20', '2018-02-18 13:27:20', NULL),
(33, 6, 11, '2018-02-18 13:27:20', '2018-02-18 13:27:20', NULL),
(34, 6, 14, '2018-02-18 13:27:20', '2018-02-18 13:27:20', NULL),
(35, 6, 16, '2018-02-18 13:27:20', '2018-02-18 13:27:20', NULL),
(36, 6, 19, '2018-02-18 13:27:20', '2018-02-18 13:27:20', NULL),
(37, 6, 22, '2018-02-18 13:27:20', '2018-02-18 13:27:20', NULL),
(38, 6, 25, '2018-02-18 13:27:20', '2018-02-18 13:27:20', NULL),
(39, 6, 28, '2018-02-18 13:27:20', '2018-02-18 13:27:20', NULL),
(40, 7, 1, '2018-02-18 13:28:07', '2018-02-18 13:28:07', NULL),
(41, 7, 3, '2018-02-18 13:28:07', '2018-02-18 13:28:07', NULL),
(42, 7, 5, '2018-02-18 13:28:07', '2018-02-18 13:28:07', NULL);
-- --------------------------------------------------------


-- --------------------------------------------------------
DROP TABLE IF EXISTS `tags`;
CREATE TABLE `tags` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '标签id',
  `name` varchar(36) NOT NULL DEFAULT '' COMMENT '标签名称',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '标签表';

INSERT INTO `tags` (`id`, `name`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Bootstrap', '2018-01-28 06:49:39', '2018-01-28 06:49:39', NULL),
(2, 'CSS', '2018-01-28 06:49:52', '2018-01-28 06:49:52', NULL),
(3, 'CSS3', '2018-01-28 06:50:00', '2018-01-28 06:50:00', NULL),
(4, 'Canvas', '2018-01-28 06:50:09', '2018-01-28 06:50:09', NULL),
(5, 'DOM', '2018-01-28 06:50:16', '2018-01-28 06:50:16', NULL),
(6, 'Font', '2018-01-28 06:50:24', '2018-01-28 06:50:24', NULL),
(7, 'Git', '2018-01-28 06:50:36', '2018-01-28 06:50:36', NULL),
(8, 'GitHub', '2018-01-28 06:50:47', '2018-01-28 06:50:47', NULL),
(9, 'Chrome', '2018-01-28 06:51:03', '2018-01-28 06:51:03', NULL),
(10, 'HTML', '2018-01-28 06:51:12', '2018-01-28 06:51:12', NULL),
(11, 'HTML5', '2018-01-28 06:51:18', '2018-01-28 06:51:18', NULL),
(12, 'IE', '2018-01-28 06:51:25', '2018-01-28 06:51:25', NULL),
(13, 'JavaScript', '2018-01-28 06:51:32', '2018-01-28 06:51:32', NULL),
(14, 'LESS', '2018-01-28 06:51:39', '2018-01-28 06:51:39', NULL),
(15, 'MySQL', '2018-01-28 06:51:45', '2018-01-28 06:51:45', NULL),
(16, 'NPM', '2018-01-28 06:51:52', '2018-01-28 06:51:52', NULL),
(17, 'Nodejs', '2018-01-28 06:52:11', '2018-01-28 06:52:11', NULL),
(18, 'ReadingList', '2018-01-28 06:52:20', '2018-01-28 06:52:20', NULL),
(19, 'SASS', '2018-01-28 06:52:33', '2018-01-28 06:52:33', NULL),
(20, 'SVG', '2018-01-28 06:52:39', '2018-01-28 06:52:39', NULL),
(21, 'SCSS', '2018-01-28 06:52:49', '2018-01-28 06:52:49', NULL),
(22, 'Windows', '2018-01-28 06:52:57', '2018-01-28 06:52:57', NULL),
(23, 'jQuery', '2018-01-28 06:53:04', '2018-01-28 06:53:04', NULL),
(24, 'npm', '2018-01-28 06:53:15', '2018-01-28 06:53:15', NULL),
(25, '编辑器', '2018-01-28 06:53:22', '2018-01-28 06:53:22', NULL),
(26, '设计模式', '2018-01-28 06:53:29', '2018-01-28 06:53:29', NULL),
(27, '阅读笔记', '2018-01-28 06:53:35', '2018-01-28 06:53:35', NULL),
(28, '随笔', '2018-01-28 06:53:42', '2018-01-28 06:53:42', NULL),
(29, '测试', '2018-02-04 01:42:15', '2018-02-04 01:42:15', NULL);
-- --------------------------------------------------------


-- --------------------------------------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '用户id',
  `name` varchar(40) NOT NULL COMMENT '用户名字',
  `email` varchar(64) NOT NULL COMMENT '邮箱',
  `password` varchar(255) NOT NULL COMMENT '密码',
  `remember_token` varchar(255)  NULL DEFAULT NULL COMMENT '记住登录',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间',
  UNIQUE KEY (`name`),
  UNIQUE KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '用户表';

INSERT INTO `users` (`id`, `name`, `email`, `password`, `remember_token`, `created_at`, `updated_at`, `deleted_at`) VALUES
  (1, 'weyburn', '695397572@qq.com', '$2a$08$TJAvfU70SOBUvKhdYN7Q/.uTJePQly4cGV7U71shgIbEjzVFtgvb.', 'GwY45OToCpx0orhBP3jdzcF7jcelHJOkkIQe4nwGE9CDqfwz7zWpDes1LYp6', '2018-02-07 07:42:01', '2018-02-07 07:58:45', NULL);
-- --------------------------------------------------------
