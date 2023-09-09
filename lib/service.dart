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

  Future<Either<List<UserModel>, String>> getPosts(String path,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress}) async {
    try {
      var response = await Api().dio.get<List<dynamic>>(
            path,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
            onReceiveProgress: onReceiveProgress,
          );
      if (response.statusCode == 200) {
        List<dynamic> responseData = response.data ?? [];
        List<UserModel> users =
            responseData.map((data) => UserModel.fromJson(data)).toList();
        return left(users);
      }
      throw "something went wrong";
    } on DioException catch (e) {
      return right(e.toString());
    }
  }

  Future<Either<UserModel, String>> getPost(String path,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress}) async {
    try {
      var response = await Api().dio.get<Map<String, dynamic>>(
            path,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
            onReceiveProgress: onReceiveProgress,
          );
      if (response.statusCode == 200) {
        debugPrint(response.toString());
        return left(UserModel.fromJson(response.data as Map<String, dynamic>));
      }
      throw "something went wrong";
    } on DioException catch (e) {
      debugPrint("Status code : ${e.response?.statusCode.toString()}");
      return right(e.toString());
    }
  }

// int userId, String title, String body
  Future<Either<UserModel, String>> createPost(
      String path, int userId, String title, String body,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) async {
    try {
      final response = await Api().dio.post<Map<String, dynamic>>(
            path,
            data: {'userId': userId, 'title': title, 'body': body},
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress,
          );
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint(response.toString());
        return left(UserModel.fromJson(response.data as Map<String, dynamic>));
      }
      throw "something went wrong";
    } on DioException catch (e) {
      debugPrint("Status code : ${e.response?.statusCode.toString()}");
      return right(e.toString());
    }
  }

  Future<Either<UserModel, String>> updatePost(
      String path, int postId, int userId, String title, String body,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) async {
    try {
      final response = await Api().dio.put<Map<String, dynamic>>(
            path,
            data: {'userId': userId, 'title': title, 'body': body},
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress,
          );
      if (response.statusCode == 200) {
        debugPrint(response.toString());
        return left(UserModel.fromJson(response.data as Map<String, dynamic>));
      }
      throw "something went wrong";
    } on DioException catch (e) {
      debugPrint("Status code : ${e.response?.statusCode.toString()}");
      return right(e.toString());
    }
  }

  Future<void> deletePost(String path, String postId,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) async {
    try {
      final response = await Api().dio.delete(
            '/$path/$postId',
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
          );

      if (response.statusCode == 204 ||
          response.statusCode == 202 ||
          response.statusCode == 200) {
        debugPrint(response.toString());
        debugPrint('Delete Success แล้วเด้อ');
      }
    } on DioException catch (e) {
      debugPrint("Status code : ${e.response?.statusCode.toString()}");
      throw Exception("Failed to Delete post : $postId");
    }
  }
}
