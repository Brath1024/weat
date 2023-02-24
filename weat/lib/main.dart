// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable, sized_box_for_whitespace, avoid_types_as_parameter_names, avoid_single_cascade_in_expression_statements, prefer_const_literals_to_create_immutables, unused_import, import_of_legacy_library_into_null_safe, await_only_futures, unnecessary_new, unnecessary_const, avoid_print, avoid_unnecessary_containers, body_might_complete_normally_nullable, constant_identifier_names, unused_element, non_constant_identifier_names

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
