import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiException implements Exception {
  ApiException(this.message, [this.statusCode]);
  final String message;
  final int? statusCode;

  @override
  String toString() => message;
}

class ApiClient {
  ApiClient._() {
    // Prints every request and response in the Run tab. Remove before release.
    _dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }
  static final ApiClient instance = ApiClient._();

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://mock-api.getcalley.com/api/service',
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
    ),
  );

  Future<dynamic> get(String path, {Map<String, dynamic>? query}) async {
    try {
      final res = await _dio.get(path, queryParameters: query);
      return res.data;
    } on DioException catch (e) {
      debugPrint('API ERROR: status=${e.response?.statusCode} body=${e.response?.data} error=${e.error}');
      throw ApiException(_messageFrom(e), e.response?.statusCode);
    }
  }

  Future<dynamic> post(String path,
      {Map<String, dynamic>? data, Map<String, dynamic>? query}) async {
    try {
      final res = await _dio.post(path, data: data, queryParameters: query);
      return res.data;
    } on DioException catch (e) {
      debugPrint('API ERROR: status=${e.response?.statusCode} body=${e.response?.data} error=${e.error}');
      throw ApiException(_messageFrom(e), e.response?.statusCode);
    }
  }

  String _messageFrom(DioException e) {
    final d = e.response?.data;
    if (d is Map && (d['message'] ?? d['error']) != null) {
      return (d['message'] ?? d['error']).toString();
    }
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Request timed out';
      case DioExceptionType.connectionError:
        return 'No internet connection';
      default:
        return 'Something went wrong';
    }
  }
}