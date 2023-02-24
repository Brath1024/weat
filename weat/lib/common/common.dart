// ignore_for_file: prefer_const_constructors, prefer_if_null_operators, camel_case_types, sized_box_for_whitespace, avoid_unnecessary_containers, non_constant_identifier_names, unnecessary_new, unused_import, prefer_const_literals_to_create_immutables, unnecessary_null_comparison, curly_braces_in_flow_control_structures, constant_identifier_names

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
