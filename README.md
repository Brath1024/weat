---
title: 如何使用Flutter+SpringBoot+Mysql开发一个简易的抽奖APP（Android教学
---

## 微信公众号搜索InterviewCoder回复关键词《吃啥》获取源码以及开发教程~

![二维码mini](https://brath.oss-cn-shanghai.aliyuncs.com/pigo/%E4%BA%8C%E7%BB%B4%E7%A0%81mini.png)

# 前言：

### 	Weat 中文译为：吃啥

##### 		吃啥来自于女朋友的一个问题，问我可不可以做个抽奖的APP，奖品都是菜，抽中那个今天就做那个菜吃，我灵机一动，使用InterviewCoder公众号里面的chatGPT小程序编辑了下面的文案：

##### 		吃啥是一款新奇有趣的应用，旨在帮助你找到今天吃什么菜。它通过精心的菜谱抽奖模式，为你提供多样而有色彩的食物，让你的用餐经历变得更加美好。不仅如此，它还可以添加朋友和家人的偏好，为大家带来更多惊喜。加入吃啥，让你的用餐经历变得更加完美！



### 架构方面：

移动端：Flutter

后台服务：SpringBoot、Mysql

### 没有安装dart、flutter、Android Studio、vscode的同学可以看看以前的教程，这里就不 一 一 介绍了

本文将详细介绍weatapp的开发流程，前后端代码编写阶段，以及后台代码部署。



## 一、APP创建：

 1. 打开项目路径，输入cmd进入到命令行，输入 flutter create weat 进行flutter项目创建。

    ![image-20230223201656540](https://brath.oss-cn-shanghai.aliyuncs.com/pigo/image-20230223201656540.png)

 2. 打开Android Studio整理项目，修改仓库配置

    ```java
     maven { url 'https://maven.aliyun.com/repository/google' }
     maven { url 'https://maven.aliyun.com/repository/jcenter' }
     maven { url 'http://maven.aliyun.com/nexus/content/groups/public' }
    ```

    

![image-20230223201935306](https://brath.oss-cn-shanghai.aliyuncs.com/pigo/image-20230223201935306.png)

3.点击Open for Editing in Android Studio 进入安卓视图，拉取gradle库

![image-20230223202038338](https://brath.oss-cn-shanghai.aliyuncs.com/pigo/image-20230223202038338.png)

4.当Android主文件不暴红，说明配置完毕了，gradle库已经拉下来了

![image-20230223202433131](https://brath.oss-cn-shanghai.aliyuncs.com/pigo/image-20230223202433131.png)



## 二、APP启动：

​	1.打开一个安卓模拟器，有条件的同学可以直接使用真机，老师这里为了方便就直接用模拟器了

![image-20230223202625528](https://brath.oss-cn-shanghai.aliyuncs.com/pigo/image-20230223202625528.png)

​	2.使用vscode打开项目并启动flutter项目

![image-20230223203129146](https://brath.oss-cn-shanghai.aliyuncs.com/pigo/image-20230223203129146.png)

至此，一个flutter项目，创建完成，并启动了！



## 三、APP图标配置

需要打开两个网址：

https://logo.aliyun.com/logo#/name  阿里云LOGO服务

https://icon.wuruihong.com/ 图标工厂

1.打开阿里云LOGO 输入APP名字，吃啥

![image-20230223203651967](https://brath.oss-cn-shanghai.aliyuncs.com/pigo/image-20230223203651967.png)

2.生成图标：

![image-20230223203733745](https://brath.oss-cn-shanghai.aliyuncs.com/pigo/image-20230223203733745.png)



购买一个你喜欢的图标，如果不购买的话，自己在网上找一个也行，但是一定要有商业授权！

![image-20230223204102921](https://brath.oss-cn-shanghai.aliyuncs.com/pigo/image-20230223204102921.png)

得到图标后，进入图标工厂，生成一套ios和一套Android的图标文件：

![image-20230223205448783](C:/Users/Administrator/AppData/Roaming/Typora/typora-user-images/image-20230223205448783.png)

![image-20230223205507890](https://brath.oss-cn-shanghai.aliyuncs.com/pigo/image-20230223205507890.png)

进入安卓文件夹，将该目录的文件复制到你的项目下面 \android\app\src\main\res

![image-20230223205604112](https://brath.oss-cn-shanghai.aliyuncs.com/pigo/image-20230223205604112.png)

#### 成效：

![image-20230223210003933](https://brath.oss-cn-shanghai.aliyuncs.com/pigo/image-20230223210003933.png)



至此，APP图标设置完成！



## 四、APP后台开发（SpringBoot+Mysql）

#### 为什么先开发APP部分？，这个纯属个人习惯，我比较喜欢先有数据和接口，直接开发APP的感觉会更轻松！

#### 整理需求：

```
每次进入app随机获取食物列表
点击开始抽奖 随机跳转 点击停止 按钮回显食物名称 点击查看菜谱 弹窗提示做法
```

根据如上需求，我明确了客户到底想要什么

1.这是一个服务类型的APP，服务于不知道吃什么的客户

2.每次进入抽奖页面需要获取不同的菜谱奖品列表

3.这个页面需要有个按钮，可以来重置奖品，并且要限制次数

4.点击抽奖按钮，开始抽奖，再次点击，或者超过限制时间，停止选择，并将按钮置为：查看食谱

5.点击查看食谱，进入食谱详情，展示过程

根据我的聪明思考，画出了如下UI：

![image-20230223210734630](https://brath.oss-cn-shanghai.aliyuncs.com/pigo/image-20230223210734630.png)

### 开玩笑，画的很烂，但是就是这个意思！。

那么，开始开发后台数据，为我们的APP提供一个接口~！

经过一系列操作，得到以下数据：

```sql
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for iv_dishes
-- ----------------------------
DROP TABLE IF EXISTS `iv_dishes`;
CREATE TABLE `iv_dishes`  (
  `id` int(50) NOT NULL AUTO_INCREMENT COMMENT '唯一ID',
  `dishes_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜品名字',
  `dishes_step` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜品做法',
  `dishes_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜品图片地址',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '菜品表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of iv_dishes
-- ----------------------------
INSERT INTO `iv_dishes` VALUES (1, '凉拌黄瓜虾仁', '1.小米辣 白芝麻蒜未辣椒面 淋上少许热油\r\n2.生抽2勺 油 醋各1代糖半勺搅匀备用\r\n3.虾煮熟去壳 木耳焯水捞出 黄瓜拍块\r\n4.淋上酱汁拌匀即可', 'https://brath.oss-cn-shanghai.aliyuncs.com/pigo/image-20230224081935481.png');
INSERT INTO `iv_dishes` VALUES (2, '低卡酱油鸡蛋', '1.生抽4勺 醋2香油1勺一把葱花\r\n2.鸡蛋冷水下锅煮8分钟盖盖焖1分钟后泡冷水\r\n3.温开水4勺搅匀\r\n4.鸡蛋剥壳切对半淋上酱汁拌匀即可', 'https://brath.oss-cn-shanghai.aliyuncs.com/pigo/image-20230224082035768.png');
INSERT INTO `iv_dishes` VALUES (3, '低卡葱香鸡腿', '1.蒜末 葱花 白艺麻小米辣淋上少许热油\r\n2.生抽1勺 许盐搅匀\r\n3.鸡腿熟捞出微凉后撕成小块\r\n4.淋上酱汁拌匀即可', 'https://brath.oss-cn-shanghai.aliyuncs.com/pigo/image-20230224082101091.png');
INSERT INTO `iv_dishes` VALUES (4, '低卡平菇炒蛋', '1.鸡蛋炒熟盛出\r\n2.油热下从蒜炒香\r\n3.下平菇炒出汁，倒入炒好的鸡蛋\r\n4.生抽 油 辣椒粉各1勺 少许盐炒匀即可', 'https://brath.oss-cn-shanghai.aliyuncs.com/pigo/image-20230224082137439.png');
INSERT INTO `iv_dishes` VALUES (5, '凉拌虾仁西兰花', '1.蒜未 葱花 辣椒面白芝麻淋上少许热油\r\n2.生抽2勺 醋各1勺搅拌均匀\r\n3.西兰花焯水捞出，虾焯水去壳鸡蛋白切块\r\n4.淋上酱汁拌匀即可', 'https://brath.oss-cn-shanghai.aliyuncs.com/pigo/image-20230224082204322.png');
INSERT INTO `iv_dishes` VALUES (6, '凉拌黄瓜木耳鸡蛋', '1.木耳鸡蛋各煮熟捞出 黄瓜拍块\r\n2.生抽2勺醋香油各11勺温开水拌匀即可开吃', 'https://brath.oss-cn-shanghai.aliyuncs.com/pigo/image-20230224082230282.png');
INSERT INTO `iv_dishes` VALUES (7, '凉拌黄瓜豆腐', '1.白芝麻辣椒面小米辣,蒜未 葱花 淋少许热油\r\n2.生抽2勺 醋油各1勺 少许盐代糖拌匀\r\n3.黄瓜拍块去籽豆腐煮熟捞出\r\n4.撒上香葱淋上酱汁拌匀即可', 'https://brath.oss-cn-shanghai.aliyuncs.com/pigo/image-20230224082404878.png');
INSERT INTO `iv_dishes` VALUES (8, '木耳炒鸡蛋', '1.鸡蛋炒熟盛出\r\n2.蒜未和胡萝人炒软倒木耳炒熟再倒鸡蛋\r\n3.耗油生抽各1勺少许盐-小半碗淀粉水\r\n4.炒匀下葱段即可', 'https://brath.oss-cn-shanghai.aliyuncs.com/pigo/image-20230224082512562.png');

SET FOREIGN_KEY_CHECKS = 1;

```



接下来创建一个SpringBoot项目，并写出entity、 controller、service、impl、mapper、xml等需要的代码

entity：

```
/**
 * <p>
 * 菜品表
 * </p>
 *
 * @author Brath
 * @since 2023-02-23
 */
@Data
@EqualsAndHashCode(callSuper = false)
@TableName("iv_dishes")
@ApiModel(value="IvDishes对象", description="菜品表")
public class IvDishes implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "唯一ID")
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @ApiModelProperty(value = "菜品名字")
    private String dishesName;

    @ApiModelProperty(value = "菜品做法")
    private String dishesStep;

    @ApiModelProperty(value = "菜品图片地址")
    private String dishesUrl;
}
```

controller：

```java
/**
 * <p>
 * 菜品表 前端控制器
 * </p>
 *
 * @author Brath
 * @since 2023-02-23
 */
@RestController
@RequestMapping("/dishes")
public class IvDishesController {

    /***
     * SLF4J日志
     */
    private Logger logger = LoggerFactory.getLogger(IvDishesController.class);

    /**
     * 菜品服务接口
     */
    @Autowired
    private IvDishesService dishesService;

    /***
     * 获取菜品列表
     *
     * @param page
     * @param size
     * @return
     */
    @GetMapping("/getDishes")
    public Object getDishes(@RequestParam(value = "page", defaultValue = "1") Integer page, @RequestParam(value = "size", defaultValue = "8") Integer size) {
        logger.info("【用户服务】获取菜品列表,开始");
        Map<Object, Object> result = new HashMap<>();
        IPage<IvDishes> prizeRecords = dishesService.getDishes(page, size);
        if (CollectionUtils.isEmpty(prizeRecords.getRecords())) {
            result.put("fail", ResponseCode.DATA_DOES_NOT_EXIST);
            logger.error("【用户服务】获取菜品列表,服务错误:{}", ResponseCode.DATA_DOES_NOT_EXIST);
        }
        result.put("prizeRecords", prizeRecords.getRecords());
        logger.info("【用户服务】获取菜品列表,完毕");
        return ResponseUtil.ok(result);
    }
}

```

service：

```java
/**
 * <p>
 * 菜品表 服务类
 * </p>
 *
 * @author Brath
 * @since 2023-02-23
 */
public interface IvDishesService extends IService<IvDishes> {

    /**
     * 获取菜品列表
     *
     * @param page
     * @param size
     * @return
     */
    IPage<IvDishes> getDishes(Integer page, Integer size);

}
```

impl：

```java
/**
 * <p>
 * 菜品表 服务实现类
 * </p>
 *
 * @author Brath
 * @since 2023-02-23
 */
@Service
public class IvDishesServiceImpl extends ServiceImpl<IvDishesMapper, IvDishes> implements IvDishesService {

    /**
     * 获取菜品列表
     *
     * @param page
     * @param size
     * @return
     */
    @Override
    public IPage<IvDishes> getDishes(Integer page, Integer size) {
        return baseMapper.getDishes(new Page<>(page, size), new QueryWrapper<>());
    }
}
```

mapper：

```java
/**
 * <p>
 * 菜品表 Mapper 接口
 * </p>
 *
 * @author Brath
 * @since 2023-02-23
 */
@Mapper
public interface IvDishesMapper extends BaseMapper<IvDishes> {

    /**
     * 获取菜品列表
     *
     * @param objectPage
     * @param objectQueryWrapper
     * @return
     */
    IPage<IvDishes> getDishes(Page<Object> objectPage, QueryWrapper<Object> objectQueryWrapper);

}
```

xml：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="cn.brath.mapper.IvDishesMapper">

    <!-- 通用查询映射结果 -->
    <resultMap id="DishesMap" type="cn.brath.entity.IvDishes">
        <id column="id" property="id"/>
        <result column="dishes_name" property="dishesName"/>
        <result column="dishes_step" property="dishesStep"/>
        <result column="dishes_url" property="dishesUrl"/>
    </resultMap>
    <select id="getDishes" resultType="cn.brath.entity.IvDishes">
        select d.*
        from iv_dishes d
        ORDER BY RAND()
    </select>

</mapper>
```

application.yaml配置：

```yaml
server:
  port: 9999
spring:
  datasource:
    druid:
      driver-class-name: com.mysql.jdbc.Driver
      url: jdbc:mysql://127.0.0.1:3306/iv-user-services?createDatabaseIfNotExist=true&useSSL=false&useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Shanghai&nullCatalogMeansCurrent=true
      username: 'root'
      password: 'root'
      initial-size: 10
      max-active: 100
      min-idle: 10
      max-wait: 6000
      pool-prepared-statements: true
      max-pool-prepared-statement-per-connection-size: 20
      time-between-eviction-runs-millis: 60000
      min-evictable-idle-time-millis: 300000
      #Oracle需要打开注释
      #      validation-query: SELECT 1 FROM DUAL
      test-while-idle: true
      test-on-borrow: false
      test-on-return: false
      stat-view-servlet:
        enabled: true
        url-pattern: /druid/*
        #login-username: admin
        #login-password: admin
        #达梦数据库，需要注释掉，其他数据库可以打开
      filter:
        stat:
          log-slow-sql: true
          slow-sql-millis: 1000
          merge-sql: false
        wall:
          config:
            multi-statement-allow: true
```

经过如上一系列配置，我们项目启动成功并可以访问到接口：

![image-20230224124319493](https://brath.oss-cn-shanghai.aliyuncs.com/pigo/image-20230224124319493.png)

接下来只要把程序部署上线就搞定了！



部署后台程序：

将我们的Dockerfile、运行脚本、jar包传入服务器

![image-20230224124656682](https://brath.oss-cn-shanghai.aliyuncs.com/pigo/image-20230224124656682.png)

Dockerfile:

```dockerfile
#java8环境
FROM openkbs/jdk11-mvn-py3

#root用户
USER root

#设置时区
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#Auth
MAINTAINER Brath

#设置工作目录集
WORKDIR /root/weatWork

#复制jars和命令
ADD *.jar /root/weatWork/
ADD run.sh /root/weatWork/run.sh

#脚本权限设置
RUN chmod +x /root/weatWork/run.sh

#暴露端口
EXPOSE 9999

```



### 1.Dockerfile打包镜像

```shell
1.进入工作目录
2.docker build -t weat .
```

![image-20230224124821870](https://brath.oss-cn-shanghai.aliyuncs.com/pigo/image-20230224124821870.png)

### 2.运行容器

```shell
docker run -dit -p 9999:9999 --privileged=true -P  --name  weat weat /bin/bash -c "tail -f /dev/null" -g "daemon off;"
```

![image-20230224124959281](https://brath.oss-cn-shanghai.aliyuncs.com/pigo/image-20230224124959281.png)

### 3.启动Jar包

```shell
#进入容器
docker exec -it weat bash
#运行脚本
sh run.sh
#查看日志
tail -100f weatlog.log
```

![image-20230224125037992](https://brath.oss-cn-shanghai.aliyuncs.com/pigo/image-20230224125037992.png)

### 4.联调接口

![image-20230224125210437](https://brath.oss-cn-shanghai.aliyuncs.com/pigo/image-20230224125210437.png)

## 五、APP移动端开发（Flutter）

#### weatApp架构设计大概如下：

```
lib:

​	common 通用层

​	core 核心层

​	routers 路由曾

​	utils 工具层

​	viewmodel 视图模型层

​	views 视图层
```

需要安装的依赖：

```yml
  #网络请求
  dio: ^4.0.6
  #getx 
  get: ^4.6.5
  #透明弹出框
  fluttertoast: ^8.0.8
  #屏幕适配
  flutter_screenutil: ^5.5.3+2
  #全局状态管理
  provider: ^6.0.1
  #轮播图
  flutter_swiper_plus: ^2.0.4
  # GET WIDGET UI库
  getwidget: ^2.0.5
  #图片缓存
  cached_network_image: ^3.2.0
  #图片放大缩小
  photo_view: ^0.13.0
  #权限申请
  permission_handler: ^9.2.0
  #贝壳组件库
  bruno: ^2.2.0
  #easyloading
  flutter_easyloading: ^3.0.3
```

### 代码如下：

#### common.dart

```dart
import 'dart:io';
import 'dart:math';

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import 'package:weat/main.dart';

/*
 * Common组件库
 * @Auth: Brath
 */

/*
 * 获取title的AppBar
 */
AppBar getAppBar(String title, {required context}) {
  return AppBar(
      toolbarHeight: 40.0.h,
      centerTitle: true,
      shadowColor: Color.fromARGB(255, 59, 82, 76),
      backgroundColor: Colors.transparent,
      leading: null,
      leadingWidth: 30.w,
      elevation: 0.0,
      actions: [],
      title: (Text(
        title,
        style: TextStyle(
            fontSize: 16.sp,
            color: Colors.black,
            fontFamily: '',
            fontWeight: FontWeight.bold),
      )));
}

/*
 * 获取卡片圆形背景容器
 */
class getCardContainer extends StatelessWidget {
  getCardContainer({
    Key? key,
    this.isBorder,
    this.BorderCircular,
    this.width,
    this.height,
    this.widget,
    this.margin,
  }) : super(key: key);

  bool? isBorder;
  double? BorderCircular;
  double? height;
  double? width;
  Widget? widget;
  EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: isBorder == true
          ? BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[200]!,
                  offset: Offset(1.w, 1.h),
                  blurRadius: 1.r,
                  spreadRadius: 1.r,
                ),
              ],
              border: Border.all(color: Colors.white, width: 1.w), // border
              borderRadius:
                  BorderRadius.circular((BorderCircular ?? 15.r)), // 圆角
            )
          : null,
      width: width,
      height: height,
      child: widget,
    );
  }
}
```

#### ZoomImage.dart

```dart
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ZoomImage extends StatefulWidget {
  ZoomImage({Key? key, this.url}) : super(key: key);
  String? url;
  @override
  State<StatefulWidget> createState() {
    return _ZoomImage();
  }
}

class _ZoomImage extends State<ZoomImage> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<Offset>? _animation;
  Offset _offset = Offset.zero;
  double _scale = 1.0;
  Offset? _normalizedOffset;
  double? _previousScale;
  final double _kMinFlingVelocity = 600.0;
  bool _isEnlarge = false;
  bool _isHideTitleBar = false;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller?.addListener(() {
      setState(() {
        _offset = _animation!.value;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }

  Offset _clampOffset(Offset offset) {
    final Size size = context.size!;
    // widget的屏幕宽度
    final Offset minOffset = Offset(size.width, size.height) * (1.0 - _scale);
    // 限制他的最小尺寸
    return Offset(
        offset.dx.clamp(minOffset.dx, 0.0), offset.dy.clamp(minOffset.dy, 0.0));
  }

  _handleOnScaleStart(ScaleStartDetails details) {
    setState(() {
      _isHideTitleBar = true;
      _previousScale = _scale;
      _normalizedOffset = (details.focalPoint - _offset) / _scale;
      // 计算图片放大后的位置
      _controller!.stop();
    });
  }

  _handleOnScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      _scale = (_previousScale! * details.scale).clamp(1.0, 3.0);
      // 限制放大倍数 1~3倍
      _offset = _clampOffset(details.focalPoint - _normalizedOffset! * _scale);
      // 更新当前位置
    });
  }

  _handleOnScaleEnd(ScaleEndDetails details) {
    _setSystemUi();
    final double magnitude = details.velocity.pixelsPerSecond.distanceSquared;
    if (magnitude < _kMinFlingVelocity) return;
    final Offset direction = details.velocity.pixelsPerSecond / magnitude;
    // 计算当前的方向
    final double distance = (Offset.zero & context.size!).shortestSide;
    // 计算放大倍速，并相应的放大宽和高，比如原来是600*480的图片，放大后倍数为1.25倍时，宽和高是同时变化的
    _animation = _controller!.drive(Tween<Offset>(
        begin: _offset, end: _clampOffset(_offset + direction * distance)));
    _controller!
      ..value = 0.0
      ..fling(velocity: magnitude / 1000.0);
  }

  _onDoubleTap() {
    _isHideTitleBar = true;
    _setSystemUi();
    Size size = context.size!;
    _isEnlarge = !_isEnlarge;
    setState(() {
      if (!_isEnlarge) {
        _scale = 2.0;
        _offset = Offset(-(size.width / 2), -(size.height / 2));
      } else {
        _scale = 1.0;
        _offset = Offset.zero;
      }
    });
  }

  _onTap() {
    setState(() {
      _isHideTitleBar = !_isHideTitleBar;
    });
    _setSystemUi();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [_bodyView(), _titleBar()],
    );
  }

  _bodyView() {
    return GestureDetector(
      onScaleStart: _handleOnScaleStart,
      onScaleUpdate: _handleOnScaleUpdate,
      onScaleEnd: _handleOnScaleEnd,
      onDoubleTap: _onDoubleTap,
      onTap: _onTap,
      child: Container(
        color: _isHideTitleBar ? Colors.black : Colors.white,
        child: SizedBox.expand(
          child: ClipRect(
            child: Transform(
              transform: Matrix4.identity()
                ..translate(_offset.dx, _offset.dy)
                ..scale(_scale),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 700.0.w,
                      height: 600.0.h,
                      child: Image.network(widget.url!)),
                  Container()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _titleBar() {
    return Offstage(
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(
            top: MediaQueryData.fromWindow(window).padding.top,
            left: ScreenUtil().setWidth(24)),
        color: const Color.fromARGB(255, 32, 32, 32),
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width,
        child: GestureDetector(
          child: Icon(
            Icons.arrow_back,
            size: 30.0.w,
            color: Colors.white,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      offstage: _isHideTitleBar,
    );
  }

  _setSystemUi() {
    if (_isHideTitleBar) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual);
    }
  }
}
```

#### Global.dart

```dart
import 'package:dio/dio.dart';

class Global {
  static String BaseUrl = 'http://127.0.0.1:9999/';

  /*请求dio对象 */
  late Dio dio;
  /*通用超时 */
  int timeOut = 50000;
  /*请求单例 */
  static Global? _instance;

  /*获取实例 */
  static Global? getInstance() {
    if (_instance == null) _instance = Global();
    return _instance;
  }

  Global() {
    dio = Dio();
    dio.options = BaseOptions(
        baseUrl: BaseUrl,
        connectTimeout: timeOut,
        sendTimeout: timeOut,
        receiveTimeout: timeOut,
        contentType: Headers.jsonContentType,
        headers: {
          "Access-Control-Allow-Origin": "*",
        });
    // 请求拦截器 and 响应拦截机 and 错误处理
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      print("\n================== 请求数据 ==========================");
      print("url = ${options.uri.toString()}");
      print("headers = ${options.headers}");
      print("params = ${options.data}");
      print("\n================== 请求数据 ==========================");
      return handler.next(options);
    }, onResponse: (response, handler) {
      print("\n================== 响应数据 ==========================");
      print("code = ${response.statusCode}");
      print("data = ${response.data}");
      print("\n================== 响应数据 ==========================");
      handler.next(response);
    }, onError: (DioError e, handler) {
      print("\n================== 错误响应数据 ======================");
      print("type = ${e.type}");
      print("message = ${e.message}");
      print("\n================== 错误响应数据 ======================");
      return handler.next(e);
    }));
  }
}
```

#### routes.dart

```dart
// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:weat/views/index/IndexView.dart';

Map<String, WidgetBuilder> routes = {
  "/": (context) => IndexView(),
};

/*
 * 渐隐跳转路由
 */
void opcityPush(BuildContext context, Widget view, {int? milliseconds}) {
  Navigator.push(
    context,
    PageRouteBuilder(
      transitionDuration:
          Duration(milliseconds: milliseconds ?? 300), //动画时间为300毫秒
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation secondaryAnimation) {
        return FadeTransition(
          //使用渐隐渐入过渡,
          opacity: animation,
          child: view, //路由B
        );
      },
    ),
  );
}

/*
 * 带路由树跳转
 */
void Push(BuildContext context, Widget view) {
  Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => view,
      ));
}

void NavigatorPop(BuildContext context) {
  Navigator.of(context).pop();
}

/*
 * 返回上一级路由树，没有上级会黑屏
 */
void Pop(BuildContext context, Widget view) {
  Navigator.pop(
      context,
      CupertinoPageRoute(
        builder: (context) => view,
      ));
}
```

#### showmessage_util.dart

```dart
// ignore_for_file: prefer_equal_for_default_values, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// @author brath
/// @创建时间：2022/5/10
/// 封装自定义弹框
class DialogUtils {
  /// 显示普通消息
  static showMessage(String msg,
      {toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 2,
      textColor: Colors.black,
      backgroundColor: Colors.grey,
      fontSize: 16.0}) {
    // 先关闭弹框再显示对应弹框
    Fluttertoast.cancel();
    Fluttertoast.showToast(
      msg: msg,
      toastLength: toastLength,
      webShowClose: true,
      gravity: gravity,
      textColor: textColor,
      timeInSecForIosWeb: timeInSecForIosWeb,
      backgroundColor: Colors.grey[50],
      fontSize: 13.0.sp,
    );
  }
```

#### index_viewmodel.dart

```dart
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class IndexViewModel extends ChangeNotifier {
  bool? isLotte = false;
  Map? currentDishes = {};

  bool? get getIsLotte {
    return isLotte;
  }

  void setIsLotte(bool isLotte) {
    this.isLotte = isLotte;
    notifyListeners();
  }

  Map? get getCurrentDishes {
    return currentDishes;
  }

  void setCurrentDishes(Map currentDishes) {
    this.currentDishes = currentDishes;
    notifyListeners();
  }
}

```

#### IndexView.dart

```dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import 'package:weat/common/ZoomImage.dart';
import 'package:weat/core/Global.dart';
import 'package:weat/routers/routes.dart';
import 'package:weat/utils/showmessage_util.dart';
import 'package:weat/viewmodel/index_viewmodel.dart';
import 'package:weat/views/index/DishesDetail.dart';

/*
 * 首页视图
 */
class IndexView extends StatefulWidget {
  const IndexView({Key? key}) : super(key: key);

  @override
  State<IndexView> createState() => _IndexViewState();
}

class _IndexViewState extends State<IndexView> {
  @override
  Widget build(BuildContext context) {
    return const LotterView();
  }
}

/*
 * 轮播抽奖页面
 */
class LotterView extends StatefulWidget {
  const LotterView({Key? key}) : super(key: key);

  @override
  State<LotterView> createState() => _LotterViewState();
}

class _LotterViewState extends State<LotterView> {
  //抽奖控制器
  final SimpleLotteryController _simpleLotteryController =
      SimpleLotteryController();

  int page = 1;
  int size = 8;

  //奖品列表
  List dishesList = [];

  //奖品loding
  bool load = false;

  //初始化奖品列表
  _initPrizeList() async {
    Global.getInstance()!.dio.get("dishes/getDishes", queryParameters: {
      'page': 1,
      'size': 8,
    }).then((value) => {
          dishesList = value.data['data']['prizeRecords'],
          load = true,
          setState(() {})
        });
  }

  @override
  void initState() {
    super.initState();
    _initPrizeList();
  }

  @override
  void dispose() {
    _simpleLotteryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: ListView(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft, //左中
                    end: Alignment.bottomRight, //右中
                    colors: [
                      Theme.of(context).primaryColor,
                      const Color.fromRGBO(180, 0, 0, 0.1),
                      const Color.fromRGBO(187, 0, 0, 0.1),
                      Theme.of(context).primaryColor
                    ]),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 50.h),
                    child: Wrap(
                      children: [
                        Text('今日菜品',
                            style: TextStyle(
                              fontSize: 32.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'jinbu',
                              color: Colors.white,
                            )),
                        Text(
                          '大放送',
                          style: TextStyle(
                              fontSize: 32.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'jinbu',
                              color: const Color.fromARGB(255, 252, 217, 61)),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.h),
                    alignment: Alignment.center,
                    child: Text(
                      '猜猜今天是什么菜系？',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                        fontFamily: 'jinbu',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: EdgeInsets.all(12.0.sp),
                    child: Container(
                      height: 400.h,
                      padding: EdgeInsets.all(14.sp),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft, //左中
                              end: Alignment.bottomRight, //右中
                              colors: [
                                Theme.of(context).primaryColor,
                                const Color.fromRGBO(180, 0, 0, 0.1),
                                const Color.fromRGBO(187, 0, 0, 0.1),
                                Theme.of(context).primaryColor
                              ]),
                          // color: const Color.fromARGB(255, 205, 221, 235),
                          border: Border.all(
                              color: Colors.transparent, width: 14.w),
                          borderRadius:
                              BorderRadius.all(Radius.elliptical(20.r, 20.r))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          load
                              ? SimpleLotteryWidget(
                                  dishesList: dishesList,
                                  simpleLotteryController:
                                      _simpleLotteryController)
                              : SizedBox(
                                  width: double.infinity,
                                  height: 260.h,
                                  child: const GFLoader(
                                      type: GFLoaderType.ios,
                                      loaderColorOne: Colors.blue,
                                      loaderColorTwo: Colors.blue,
                                      loaderColorThree: Colors.blue,
                                      duration: Duration(milliseconds: 300)),
                                ),
                          //抽奖按钮
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 400),
                            child: Provider.of<IndexViewModel>(context,
                                        listen: true)
                                    .getIsLotte!
                                ? SizedBox(
                                    height: 34.h,
                                    width: MediaQuery.of(context).size.width -
                                        120.w,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.red[200], //chan
                                        onPrimary: Colors
                                            .white, //change text color of button
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.r),
                                        ),
                                        elevation: 3.0.h,
                                      ),
                                      onPressed: () {
                                        //跳转详情页面
                                        Push(
                                            context,
                                            DishesDetailView(
                                                dishes:
                                                    Provider.of<IndexViewModel>(
                                                            context,
                                                            listen: false)
                                                        .getCurrentDishes));
                                        //设置状态
                                        Provider.of<IndexViewModel>(context,
                                                listen: false)
                                            .setIsLotte(false);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 4.w,
                                          ),
                                          Text(
                                            '点击查看：${Provider.of<IndexViewModel>(context, listen: false).getCurrentDishes!['dishesName']}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontFamily: '',
                                                color: Colors.white,
                                                fontSize: 14.0.sp),
                                          ),
                                        ],
                                      ),
                                    ))
                                : SizedBox(
                                    height: 34.h,
                                    width: MediaQuery.of(context).size.width -
                                        220.w,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.red[200], //chan
                                        onPrimary: Colors
                                            .white, //change text color of button
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.r),
                                        ),
                                        elevation: 3.0.h,
                                      ),
                                      onPressed: () {
                                        //开始抽奖
                                        _simpleLotteryController.start(
                                            Random.secure().nextInt(2)); //开启
                                        setState(() {});
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 4.w,
                                          ),
                                          Text(
                                            '吃啥',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontFamily: '',
                                                color: Colors.white,
                                                fontSize: 14.0.sp),
                                          ),
                                        ],
                                      ),
                                    )),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//奖品参数
class SimpleLotteryValue {
  SimpleLotteryValue(
      {this.target = 0, this.isFinish = false, this.isPlaying = false});

  /// 中奖目标
  int target = 0;

  bool isPlaying = false;
  bool isFinish = false;

  SimpleLotteryValue copyWith({
    int target = 0,
    bool isPlaying = false,
    bool isFinish = false,
  }) {
    return SimpleLotteryValue(
        target: target, isFinish: isFinish, isPlaying: isPlaying);
  }

  @override
  String toString() {
    return "target : $target , isPlaying : $isPlaying , isFinish : $isFinish";
  }
}

//抽奖控制器
class SimpleLotteryController extends ValueNotifier {
  SimpleLotteryController() : super(SimpleLotteryValue());

  /// 开启抽奖
  ///
  /// [target] 中奖目标
  void start(int target) {
    // 九宫格抽奖里范围为0~8
    assert(target >= 0 && target <= 8);
    if (value.isPlaying) {
      return;
    }
    value = value.copyWith(target: target, isPlaying: true);
  }

  void finish() {
    value = value.copyWith(isFinish: true);
  }
}

/*
 * 奖品列表容器 
 */
class SimpleLotteryWidget extends StatefulWidget {
  final SimpleLotteryController simpleLotteryController;
  final List dishesList;
  const SimpleLotteryWidget(
      {Key? key,
      required this.dishesList,
      required this.simpleLotteryController})
      : super(key: key);

  @override
  State<SimpleLotteryWidget> createState() => _SimpleLotteryWidgetState();
}

class _SimpleLotteryWidgetState extends State<SimpleLotteryWidget>
    with TickerProviderStateMixin {
  Future<int>? future; // 标识

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        return Container(
            margin: EdgeInsets.all(5.h),
            width: double.infinity,
            height: 280.h,
            child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8.w,
                    mainAxisSpacing: 8.h),
                itemBuilder: (context, index) {
                  if (index != 4) {
                    return commodity(index);
                  }
                  return Image.network(
                    'https://brath.cloud/app_log.png',
                    fit: BoxFit.cover,
                  );
                }));
      },
    );
  }

  // 奖品列表
  Widget commodity(int index) {
    final int toIndex;
    toIndex = _deserializeMap[index];
    return GestureDetector(
      onTap: () {
        opcityPush(context,
            ZoomImage(url: '${widget.dishesList[toIndex]['dishesUrl']}'));
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
              color: widget.dishesList[toIndex]['id']! > 5
                  ? Colors.red[300]!.withAlpha(32)
                  : widget.dishesList[toIndex]['id']! >= 4 &&
                          widget.dishesList[toIndex]['id'] <= 5
                      ? Colors.amber[300]!.withAlpha(32)
                      : Colors.blue[300]!.withAlpha(32),
            ),
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    '${widget.dishesList[toIndex]['dishesUrl']}',
                    fit: BoxFit.cover,
                    width: 60.w,
                    height: 60.w,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    '${widget.dishesList[toIndex]['dishesName']}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'jinbu',
                      fontSize: 9.sp,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
              decoration: BoxDecoration(
            color: index == _currentSelect
                ? Colors.yellow.withOpacity(0.5)
                : Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
          )),
        ],
      ),
    );
  }

  Animation? _selectedIndexTween;
  AnimationController? _startAnimateController;
  int _currentSelect = -1;
  int _target = 0;

  /// 旋转的圈数
  final int repeatRound = 4;
  VoidCallback? _listener;

  /// 选中下标的映射
  final Map _selectMap = {0: 0, 1: 3, 2: 6, 3: 7, 4: 8, 5: 5, 6: 2, 7: 1};

  //反下标的映射
  final Map _deserializeMap = {
    0: 0,
    3: 1,
    4: 8,
    6: 2,
    7: 3,
    8: 4,
    5: 5,
    2: 6,
    1: 7
  };
  simpleLotteryWidgetState() {
    _listener = () {
      // 开启抽奖动画
      if (widget.simpleLotteryController.value.isPlaying) {
        _startAnimateController?.reset();
        _target = widget.simpleLotteryController.value.target;
        _selectedIndexTween = _initSelectIndexTween(_target);

        _startAnimateController?.forward();
      }
    };
  }

  /// 初始化tween
  ///
  /// [target] 中奖的目标
  Animation _initSelectIndexTween(int target) =>
      StepTween(begin: 0, end: repeatRound * 8 + target).animate(
          CurvedAnimation(
              parent: _startAnimateController!, curve: Curves.easeOutQuart));

  @override
  void initState() {
    super.initState();

    future = Future.value(42);

    _startAnimateController =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    _selectedIndexTween = _initSelectIndexTween(_target);

    //开启动画
    simpleLotteryWidgetState();

    // 控制监听
    widget.simpleLotteryController.addListener(_listener!);

    // 动画监听
    _startAnimateController?.addListener(() {
      // 更新选中的下标
      _currentSelect = _selectMap[_selectedIndexTween?.value % 8];

      if (_startAnimateController!.isCompleted) {
        widget.simpleLotteryController.finish();
        _currentSelect = -1;
        dynamic dishes = widget.dishesList[_target];

        Provider.of<IndexViewModel>(context, listen: false).setIsLotte(true);
        Provider.of<IndexViewModel>(context, listen: false)
            .setCurrentDishes(dishes);
        DialogUtils.showMessage('恭喜你，今天做：${dishes['dishesName']}，点击按钮查看菜品做法！');
      }

      setState(() {});
    });
  }

  @override
  void deactivate() {
    widget.simpleLotteryController.removeListener(_listener!);
    super.deactivate();
  }

  @override
  void dispose() {
    _startAnimateController?.dispose();
    super.dispose();
  }
}

//获取当前奖品出现的次数
getNumberTimesCurrentPrizeAppears(String? id, List<dynamic> arr) {
  //定义集合
  Map obj = {};
  List idList = [];
  for (var i = 0; i < arr.length; i++) {
    idList.add(arr[i]['id']);
  }
  for (var i = 0; i < idList.length; i++) {
    if (obj.containsValue([idList[i]])) {
      obj[idList[i]]++;
    } else {
      obj[idList[i]] = 1;
    }
  }
  return obj[int.parse(id!)];
}

int next(int min, int max) {
  int res = min + Random().nextInt(max - min + 1);
  return res;
}
```

#### DishesDetail.dart

```dart
import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:weat/common/common.dart';

class DishesDetailView extends StatefulWidget {
  DishesDetailView({Key? key,required this.dishes}) : super(key: key);
  var dishes;
  @override
  State<DishesDetailView> createState() => _DishesDetailViewState();
}

class _DishesDetailViewState extends State<DishesDetailView> {
  List steplist = [];
  @override
  void initState() {
    super.initState();
    //分割步骤
    steplist = widget.dishes['dishesStep'].toString().split('\r\n');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        BrnDialogManager.showConfirmDialog(context,
            showIcon: false,
            barrierDismissible: false,
            title: "你正在做菜，要退出吗~",
            confirm: "退出",
            cancel: "不", onConfirm: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        }, onCancel: () {
          Navigator.of(context).pop();
        });
        return Future.value(false);
      },
      child: Scaffold(
          appBar: getAppBar(widget.dishes['dishesName'], context: context),
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ImageFulWidget(imageList: [widget.dishes['dishesUrl']]),
              ),
              getCardContainer(
                margin: EdgeInsets.only(
                    top: 10.h, bottom: 10.h, left: 10.w, right: 10.w),
                height: 220.0.h,
                isBorder: true,
                BorderCircular: 5.r,
                width: double.infinity,
                widget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10.w, top: 10.h),
                      child: BrnCSS2Text.toTextView(
                        '步骤：',
                        maxLines: 1,
                        textOverflow: TextOverflow.ellipsis,
                        defaultStyle:
                            TextStyle(fontSize: 20.sp, fontFamily: 'jinbu'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.w, top: 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: steplist.map((e) {
                          return Container(
                            margin: EdgeInsets.only(top: 5.h),
                            child: BrnCSS2Text.toTextView(
                              '$e',
                              maxLines: 1,
                              textOverflow: TextOverflow.ellipsis,
                              defaultStyle: TextStyle(
                                  fontSize: 13.sp, fontFamily: 'jinbu'),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}

/*
 * 顶部轮播图Widget
 */
class ImageFulWidget extends StatelessWidget {
  ImageFulWidget({
    Key? key,
    required this.imageList,
  }) : super(key: key);

  List<String>? imageList;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.h), bottom: Radius.circular(20.h)),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.25,
        width: MediaQuery.of(context).size.width - 60.0.w,
        child: Swiper(
          autoplay: false,
          duration: 2000,
          curve: Curves.linearToEaseOut,
          itemBuilder: (BuildContext context, int index) {
            return Image.network(
              imageList![index],
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width - 60.0.w,
              fit: BoxFit.cover,
            );
          },
          itemCount: imageList!.length,
          pagination: SwiperPagination(
            builder: DotSwiperPaginationBuilder(
              size: 8.sp, // 设置未选中的小点大小
              activeSize: 10.sp, // 设置选中的小点大小
              color: const Color.fromARGB(255, 219, 219, 219), // 设置为未选中的小点颜色
              activeColor: Colors.blue, // 设置选中的小点颜色
            ),
          ),
          control: const SwiperControl(color: Colors.transparent),
        ),
      ),
    );
  }
}
```

#### main.dart

```dart
import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:weat/routers/routes.dart';
import 'package:weat/viewmodel/index_viewmodel.dart';

//全局路由key
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/*
 * 主函数
 */
void main() async {
  initializeDateFormatting().then((_) => runApp(MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => IndexViewModel()),
        ],
        child: MyApp(),
      )));

  //安卓屏蔽顶部阴影
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

//根节点
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _init();
  }

//全局路由key
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// 程序初始化
  _init() async {
    await EasyLoading.init();
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.yellow
      ..backgroundColor = Colors.green
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.yellow
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false;

    await WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations(
      [
        // 竖屏 Portrait 模式
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(375, 667),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.blueGrey, //全局主题颜色
              splashColor: Colors.transparent, // 点击时的高亮效果设置为透明
              // backgroundColor: Color.fromARGB(255, 255, 255, 255), //系统背景主题颜色
              backgroundColor: Color(0xFFF3F4F6), //系统背景主题颜色
              highlightColor: Colors.transparent, // 长按时的扩散效果设置为透明
              primaryColor: Color.fromARGB(188, 0, 0, 97), //系统原色
              focusColor: Color.fromARGB(235, 73, 74, 116), //焦点主题颜色
              hoverColor: Color.fromARGB(235, 103, 104, 172), //悬停主题颜色
              disabledColor: Color.fromARGB(235, 105, 106, 133), //禁用主题颜色
              primaryColorLight: Colors.white, // 白色主题颜色
              primaryColorDark: Color.fromARGB(235, 73, 74, 116), //黑色主题颜色
              selectedRowColor: Color.fromARGB(255, 104, 80, 145), //选中效果颜色
              appBarTheme: AppBarTheme(backgroundColor: Colors.white),
              buttonTheme: ButtonThemeData(
                focusColor: Color.fromARGB(235, 73, 74, 116),
                hoverColor: Color.fromARGB(235, 103, 104, 172),
              ),
              tabBarTheme: TabBarTheme(
                labelColor: Color.fromARGB(235, 103, 104, 172),
              ),
              progressIndicatorTheme: ProgressIndicatorThemeData(
                color: Color.fromARGB(235, 101, 102, 158),
              ),
            ),
            navigatorKey: navigatorKey,
            routes: routes,
            debugShowCheckedModeBanner: false,
            initialRoute: "/", //初始化进入加载页面
            builder: (context, widget) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: widget!,
              );
            },
          );
        });
  }
}

```

### 代码编写完毕后 flutter build apk 打包到真机运行

# 最终呈现出我们想要的效果：

![image-20230224132323576](https://brath.oss-cn-shanghai.aliyuncs.com/pigo/image-20230224132323576.png)



抽奖中：

![image-20230224132344126](https://brath.oss-cn-shanghai.aliyuncs.com/pigo/image-20230224132344126.png)

中奖：

![](https://brath.oss-cn-shanghai.aliyuncs.com/pigo/image-20230224132344126.png)

详情：

![image-20230224132350748](https://brath.oss-cn-shanghai.aliyuncs.com/pigo/image-20230224132350748.png)



### 本期教程到此结束，欢迎你的观看~

## 微信公众号搜索InterviewCoder回复关键词《吃啥》获取源码以及开发教程~

![二维码mini](https://brath.oss-cn-shanghai.aliyuncs.com/pigo/%E4%BA%8C%E7%BB%B4%E7%A0%81mini.png)







