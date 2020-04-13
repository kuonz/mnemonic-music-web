import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Network {

  static Dio _dio;

  static init() {
    _dio = Dio();
  }

  static Future<Response> post(String url, Map<String, dynamic> params) {
    return _dio.post(url, queryParameters: params);
  }
}