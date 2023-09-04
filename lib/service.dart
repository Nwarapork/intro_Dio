import 'package:intro_dio/api.dart';
import 'package:intro_dio/models/user_model.dart';

class Service {
  static final _singleton =
      Service._internal(); // สร้างจาก internal constructor

  // ทำให้เป็น singleton โดยใช้ factory
  factory Service() => _singleton;

  // internal constructor
  Service._internal();

  Future<List<UserModel>> getPosts() async {
    var response = await Api().dio.get<List<dynamic>>('/posts');
    List<dynamic> responseData = response.data ?? [];
    List<UserModel> users =
        responseData.map((data) => UserModel.fromJson(data)).toList();
    return users;
  }
}
