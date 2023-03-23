import '../helpers/string_formater.dart';

class ApiResponse {
  dynamic message;
  String? title;
  bool? status;
  String? error;
  ApiResponse({this.title, this.message, this.status, this.error});

  static ApiResponse toApiResponse(Map<String, dynamic> response) {
    return ApiResponse(
        title: response["title"],
        message: response["message"],
        status: response["status"],
        error: getValue(response["errors"], response["message"]));
  }
}

class SuccessResponse {
  bool? status;
  String? message;
  dynamic data;

  SuccessResponse({this.message, this.status, this.data});
  static SuccessResponse toApiResponse(Map<String, dynamic> response) {
    return SuccessResponse(
        message: response["message"],
        data: response["data"],
        status: response["status"]);
  }
}
