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
