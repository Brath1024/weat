// ignore_for_file: prefer_equal_for_default_values, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// @author brath
/// @创建时间：2022/5/10
/// 封装自定义弹框
class DialogUtils {
  /// 基础弹框
  static alert(
    BuildContext context, {
    String? title,
    String content = "",
    GestureTapCallback? confirm,
    GestureTapCallback? cancle,
    List<Widget>? actions, // 自定义按钮
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              title ?? '提示',
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 14.sp),
            ),
            content: Text(content),
            actions: actions ??
                <Widget>[
                  InkWell(
                    onTap: () {
                      if (cancle != null) {
                        cancle();
                      }
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 20, bottom: 5.0.h),
                      child: const Text(
                        "取消",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (confirm != null) {
                        confirm();
                      }
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 10, bottom: 5.0.h),
                      child: Text(
                        "确定",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  )
                ],
          );
        });
  }

  /// 自定义Widget弹框
  static alertWidget(
    BuildContext context, {
    String? title,
    Widget? widget,
    GestureTapCallback? confirm,
    GestureTapCallback? cancle,
    bool? isOne = false,
    List<Widget>? actions, // 自定义按钮
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return isOne!
              ? AlertDialog(
                  title: widget,
                )
              : AlertDialog(
                  title: title != null || title != ""
                      ? Center(
                          child: Text(
                            title ?? '提示',
                            style: TextStyle(
                                color: Colors.grey[500], fontSize: 13.sp),
                          ),
                        )
                      : Container(),
                  content: widget,
                  actions: actions ??
                      <Widget>[
                        InkWell(
                          onTap: () {
                            if (cancle != null) {
                              cancle();
                            }
                            Navigator.of(context).pop();
                          },
                          child: Padding(
                            padding:
                                EdgeInsets.only(right: 20.0.h, bottom: 5.0.h),
                            child: const Text(
                              "取消",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (confirm != null) {
                              confirm();
                            }
                            Navigator.of(context).pop();
                          },
                          child: Padding(
                            padding:
                                EdgeInsets.only(right: 10.0.h, bottom: 5.0.h),
                            child: Text(
                              "确定",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                      ],
                );
        });
  }

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

  /// 显示错误消息
  static showErrorMessage(String msg,
      {toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      fontSize: 16.0}) {
    showMessage(msg,
        toastLength: toastLength,
        gravity: gravity,
        timeInSecForIosWeb: timeInSecForIosWeb,
        backgroundColor: backgroundColor,
        fontSize: fontSize);
  }

  /// 显示警告信息
  static showWaringMessage(String msg,
      {toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.orangeAccent,
      fontSize: 16.0}) {
    showMessage(msg,
        toastLength: toastLength,
        gravity: gravity,
        timeInSecForIosWeb: timeInSecForIosWeb,
        backgroundColor: backgroundColor,
        fontSize: fontSize);
  }

  /// 显示成功消息
  static showSuccessMessage(String msg,
      {toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: const Color(0xFF66BB6A),
      fontSize: 16.0}) {
    showMessage(msg,
        toastLength: toastLength,
        gravity: gravity,
        timeInSecForIosWeb: timeInSecForIosWeb,
        backgroundColor: backgroundColor,
        fontSize: fontSize);
  }

  /// 自定义消息：无路由参数
  static showErrorMessageByNullRoutes(
      {toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      fontSize: 16.0}) {
    showMessage("程序猿小哥哥开发中~",
        toastLength: toastLength,
        gravity: gravity,
        timeInSecForIosWeb: timeInSecForIosWeb,
        backgroundColor: backgroundColor,
        fontSize: fontSize);
  }
}
