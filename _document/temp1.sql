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
  (1, 'weyburn', '695397572@qq.com', '$2y$10$0hysLcC.P0EcVORF/zvgnObXVsdIJAvY32lGAvR9y/zze2QDavmKW', 'ifJSSTg5PAsbHHqEbTKsyydWcTTcgJHtoX7Qf7JJGMJuGowu7W73l3ykBnCR', '2018-02-07 07:42:01', '2018-02-07 07:58:45', NULL);
-- --------------------------------------------------------
