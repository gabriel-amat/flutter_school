import 'package:dio/dio.dart';

class AppHttpClient {
  Dio dio = Dio();

  static AppHttpClient? _instance;

  static AppHttpClient get instance {
    if (_instance != null) return _instance!;
    _instance = AppHttpClient._init();
    return _instance!;
  }

  AppHttpClient._init() {
    dio.options = BaseOptions(
      baseUrl: "http://127.0.0.1:8000",
      contentType: Headers.jsonContentType,
    );
  }
}
