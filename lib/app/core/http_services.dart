import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as getx;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class APIService extends getx.GetxService {
  late final Dio _dio;
  late final CacheOptions _dioCacheOption;

  static APIService get instance => getx.Get.find<APIService>();

  static const String _baseUrl = 'https://fakestoreapi.com';
  String? url;
  dynamic route;

  APIService({this.url, this.route}) {
    BaseOptions options = BaseOptions(
      receiveTimeout: const Duration(seconds: 20),
      connectTimeout: const Duration(seconds: 20),
    );

    _dio = Dio(options);

    _dioCacheOption = CacheOptions(
      store: MemCacheStore(maxSize: 10485760, maxEntrySize: 1048576),
      policy: CachePolicy.forceCache,
      maxStale: const Duration(days: 7),
      priority: CachePriority.normal,
      keyBuilder: CacheOptions.defaultCacheKeyBuilder,
      allowPostMethod: false,
    );

    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestBody: true,
          requestHeader: true,
          responseHeader: false,
        ),
      );
    }
  }

  Future<dynamic> get({
    String? endpoint,
    String? fullUrl,
    String version = '',
  }) async {
    try {
      String completedURL = fullUrl ??
          Uri.parse(
                  '$_baseUrl${version.isNotEmpty ? '/$version' : ''}${endpoint ?? ''}')
              .toString();

      final response = await _dio.get(
        completedURL,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
        ),
      );

      return response;
    } on DioException catch (error) {
      String message = _handleError(error);
      log("API Error: $message");
      throw CustomException(message, error.response?.statusCode ?? 0);
    } catch (e) {
      log("Unexpected error: $e");
      throw CustomException("Unexpected error occurred", 500);
    }
  }

  Future<dynamic> post({
    String? endpoint,
    String? fullUrl,
    String version = '',
    Map<String, dynamic>? data,
  }) async {
    try {
      String completedURL = fullUrl ??
          Uri.parse(
                  '$_baseUrl${version.isNotEmpty ? '/$version' : ''}${endpoint ?? ''}')
              .toString();

      final response = await _dio.post(
        completedURL,
        data: data,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
        ),
      );

      return response;
    } on DioException catch (error) {
      String message = _handleError(error);
      log("API POST Error: $message");
      throw CustomException(message, error.response?.statusCode ?? 0);
    } catch (e) {
      log("Unexpected POST error: $e");
      throw CustomException("Unexpected error occurred", 500);
    }
  }

  String _handleError(DioException error) {
    String errorDescription = "";
    switch (error.type) {
      case DioExceptionType.cancel:
        errorDescription = "Request to API server was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        errorDescription = "Connection timeout with API server";
        break;
      case DioExceptionType.connectionError:
        errorDescription =
            "Connection to API server failed due to internet connection";
        break;
      case DioExceptionType.receiveTimeout:
        errorDescription = "Receive timeout in connection with API server";
        break;
      case DioExceptionType.badResponse:
        String errorMessage = "";
        if (error.response?.data["errors"] != null) {
          errorMessage =
              "${error.response?.data["message"]}\n${concatenateErrorMessages(error.response?.data["errors"])}";
        } else {
          errorMessage = error.response?.data["message"] ??
              "Something went wrong, please try again later";
        }

        errorDescription = errorMessage;
        break;
      case DioExceptionType.sendTimeout:
        errorDescription = "Send timeout in connection with API server";
        break;
      case DioExceptionType.badCertificate:
        errorDescription = "Error Bad Certificate";
        break;
      case DioExceptionType.unknown:
        errorDescription = "Unknown Error occur";
        break;
    }
    return errorDescription;
  }

  String concatenateErrorMessages(Map<String, dynamic> errorMap) {
    List<String> messages = [];

    errorMap.forEach((key, value) {
      if (value is List) {
        messages.addAll([...value]);
      } else if (value is String) {
        messages.add(value);
      }
    });

    return messages.join('\n');
  }
}

class CustomException implements Exception {
  final String message;
  final int errorCode;

  CustomException(this.message, this.errorCode);

  @override
  String toString() {
    return 'CustomException: $message (Error Code: $errorCode)';
  }
}