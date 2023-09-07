import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:intro_dio/api.dart';
import 'package:intro_dio/models/user_model.dart';

class Service {
  static final _singleton =
      Service._internal(); // สร้างจาก internal constructor

  // ทำให้เป็น singleton โดยใช้ factory
  factory Service() => _singleton;

  // internal constructor
  Service._internal();

  Future<Either<List<UserModel>, String>> getPosts() async {
    try {
      var response = await Api().dio.get<List<dynamic>>('/posts');
      List<dynamic> responseData = response.data ?? [];
      List<UserModel> users =
          responseData.map((data) => UserModel.fromJson(data)).toList();
      return left(users);
    } catch (e) {
      return right(e.toString());
    }
  }

  Future<Either<UserModel, String>> getPost(int postId) async {
    try {
      var response =
          await Api().dio.get<Map<String, dynamic>>('/postss/$postId');
      debugPrint(response.toString());
      return left(UserModel.fromJson(response.data as Map<String, dynamic>));
    } on DioException catch (e) {
      debugPrint("Status code : ${e.response?.statusCode.toString()}");
      return right(e.toString());
    }
  }

  Future<Either<UserModel, String>> createPost(
      int userId, String title, String body) async {
    try {
      final response = await Api().dio.post<Map<String, dynamic>>('/posts',
          data: {'userId': userId, 'title': title, 'body': body});
      debugPrint(response.toString());
      return left(UserModel.fromJson(response.data as Map<String, dynamic>));
    } on DioException catch (e) {
      debugPrint("Status code : ${e.response?.statusCode.toString()}");
      return right(e.toString());
    }
  }

  Future<Either<UserModel, String>> updatePost(
      int postId, int userId, String title, String body) async {
    try {
      final response = await Api().dio.put<Map<String, dynamic>>(
        '/posts/$postId',
        data: {'userId': userId, 'title': title, 'body': body},
      );
      debugPrint(response.toString());
      return left(UserModel.fromJson(response.data as Map<String, dynamic>));
    } on DioException catch (e) {
      debugPrint("Status code : ${e.response?.statusCode.toString()}");
      return right(e.toString());
    }
  }

  Future<void> deletePost(int postId) async {
    try {
      await Api().dio.delete('/posts/$postId');
      debugPrint('Delete Success แล้วเด้อ');
    } on DioException catch (e) {
      debugPrint("Status code : ${e.response?.statusCode.toString()}");
      throw Exception("Failed to Delete post : $postId");
    }
  }
}
