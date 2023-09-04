import 'package:dio/dio.dart';

class Api {
  static final _singleton = Api._internal(); // สร้างจาก internal constructor

  // ทำให้เป็น singleton โดยใช้ factory
  factory Api() => _singleton;
  late Dio dio;

  // internal constructor
  Api._internal() {
    // initial dio
    dio = Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com'));
  }
}

// ex. การเรียกใช้
// Api().nameMethod
// Api().property