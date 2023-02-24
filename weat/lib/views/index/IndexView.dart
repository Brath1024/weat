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
