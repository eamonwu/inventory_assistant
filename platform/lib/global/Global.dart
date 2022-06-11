import 'package:dio/dio.dart';

class Global {
  static Global? _instance;
  late Dio dio;
  String? token;
  Map? user;
  late bool online;

  static Global? getInstance() {
    _instance ??= Global();
    return _instance;
  }

  Global() {
    dio = Dio();
    dio.options = BaseOptions(
      // baseUrl: "http://192.168.31.240:8888/assistant/",

      // baseUrl: "http://2.0.0.1:8888/assistant/",
      baseUrl: "http://8.136.81.197:8888/assistant/",
      connectTimeout: 5000,
      sendTimeout: 5000,
      receiveTimeout: 5000,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    );
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioError e, handler) {
        //请求失败处理
      },
    ));
  }
}
