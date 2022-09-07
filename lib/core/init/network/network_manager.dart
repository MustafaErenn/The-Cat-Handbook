import 'dart:io';

import 'package:dio/dio.dart';

import '../../base/model/base_model.dart';

class NetworkManager {
  static NetworkManager? _instance;
  static NetworkManager get instance {
    _instance ??= NetworkManager._init();
    return _instance!;
  }

  late Dio _dio;
  NetworkManager._init() {
    _dio = Dio(BaseOptions(baseUrl: "https://api.thecatapi.com/v1/"));
  }

  Future<List<T>?> dioGet<T extends BaseModel>(String path, T model) async {
    final response = await _dio.get(path);
    switch (response.statusCode) {
      case HttpStatus.ok:
        final body = response.data;
        if (body is List) {
          return body.map((e) => model.fromJson(e)).toList().cast<T>();
        }
    }
    return null;
  }
}
