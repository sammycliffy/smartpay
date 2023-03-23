import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_pay/api/api_response.dart';

import '../app/locator.dart';
import '../constants/routes.dart';
import '../screens/widgets/custom_toast.dart';
import 'endpoints.dart';

class ApiClient {
  static final _dio = Dio(
    BaseOptions(baseUrl: Endpoints.baseURL),
  );

  static final _defaultHeader = {
    'Content-Type': 'application/json',
  };
  static String get _token => "";
  static Future get(
    String endpoint, {
    dynamic queryParameters,
    bool useToken = true,
  }) async {
    final result = await _makeRequest(
      () async {
        final header = _defaultHeader;

        if (useToken) {
          header.addAll(
            {'Authorization': 'Bearer $_token'},
          );
        }
        log(_token);
        final options = Options(headers: header);
        log("${_dio.options.baseUrl}/$endpoint");

        final response = await _dio.get(endpoint,
            queryParameters: queryParameters, options: options);
        return response.data;
      },
    );
    return result;
  }

  static Future post(
    String endpoint, {
    required dynamic body,
    bool useToken = true,
  }) async {
    final result = await _makeRequest(
      () async {
        final header = _defaultHeader;

        if (useToken) {
          header.addAll(
            {'Authorization': 'Bearer $_token'},
          );
        }

        final options = Options(headers: header);
        log("${_dio.options.baseUrl}$endpoint $body");

        final response =
            await _dio.post(endpoint, data: body, options: options);

        return response.data;
      },
    );

    return result;
  }

  /// [Handlers]

  static Future _makeRequest(Function request) async {
    final router = locator<GoRouter>();
    try {
      final result = await request();
      log(result.toString());

      return SuccessResponse.toApiResponse(result);
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        // router.push(AppRoutes.login);
      }

      log(e.toString());
      log(e.response!.data.toString());

      _handleDioError(ApiResponse.toApiResponse(e.response!.data));
      return ApiResponse.toApiResponse(e.response!.data);
    } on SocketException catch (e) {
      _handleSocketException(e);
      return "${e.message}";
    } catch (e) {
      return e.toString();
    }
  }

  static void _handleDioError(ApiResponse response) {
    log("it has reached here");
    ToastUtils.showToast(response.error!);
    inspect(response.title);
  }

  static void _handleSocketException(SocketException e) {
    debugPrint('Check Internet');
  }

  // static String _getToken() {
  //   String token = locator<LocalStorageService>().getDataFromDisk(Keys.userKey);
  //   print("from $token");
  //   return json.decode(token);
  // }
}
