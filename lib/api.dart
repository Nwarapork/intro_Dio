import 'package:dio/dio.dart';

class Api {
  static final _singleton = Api._internal(); // สร้างจาก internal constructor

  // ทำให้เป็น singleton โดยใช้ factory
  factory Api() => _singleton;
  late Dio dio;

  // internal constructor
  Api._internal() {
    // initial dio
    dio = Dio(
      BaseOptions(
          baseUrl: 'https://jsonplaceholder.typicode.com',
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          responseType: ResponseType.json,
          headers: {
            'Accept': 'application/json',
          }),
    );
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        
      },
    ));
    
  }
}

// ex. การเรียกใช้
// Api().nameMethod
// Api().property