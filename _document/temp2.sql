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
  (1, 'weyburn', 'weyburn@126.com', '$2a$08$T6ZdAYt./FB1/fZoR4Qj6.Kh.T4Ihg2xpNBwBG7XkFSxofp.yzeT2', 'GwY45OToCpx0orhBP3jdzcF7jcelHJOkkIQe4nwGE9CDqfwz7zWpDes1LYp6', '2018-02-07 07:42:01', '2018-02-07 07:58:45', NULL);
-- --------------------------------------------------------
