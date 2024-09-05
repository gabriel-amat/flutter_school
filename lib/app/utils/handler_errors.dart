import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../config/custom_snack.dart';

class HandlerErrors {
  static final snack = Modular.get<CustomSnack>();

  static error(DioException e, String msg) {
    if (e.response != null) {
      snack.error(text: e.response!.data['message']);
    } else {
      snack.error(text: msg);
    }
  }
}
