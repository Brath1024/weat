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
