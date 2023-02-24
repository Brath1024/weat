// ignore_for_file: file_names, unused_field, body_might_complete_normally_nullable, prefer_conditional_assignment, import_of_legacy_library_into_null_safe, non_constant_identifier_names, avoid_print, avoid_types_as_parameter_names, unused_local_variable, slash_for_doc_comments

import 'package:dio/dio.dart';

class Global {
  static String BaseUrl = 'http://127.0.0.1:9999/';

  // 是否为release版
  static bool get isRelease => const bool.fromEnvironment("dart.vm.product");

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
