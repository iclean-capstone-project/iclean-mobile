import 'dart:convert';

class ApiException implements Exception {
  final int statusCode;
  final String message;

  ApiException(this.statusCode, this.message);
}

class ResponseHandler {
  static void handleResponse(dynamic response) {
    final Map<String, dynamic> jsonMap =
        json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 401 && jsonMap.containsKey('error')) {
      throw ApiException(
          401, 'Tài khoản của bạn đã bị khóa, vui lòng thử lại sau!');
    }

    final responseObject = ResponseObject.fromJson(jsonMap);
    throw ApiException(response.statusCode, responseObject.message);
  }
}

class ResponseObject {
  String status;
  String message;
  Object? data;

  ResponseObject({
    required this.status,
    required this.message,
    this.data,
  });

  factory ResponseObject.fromJson(Map<String, dynamic> json) {
    String status = json['status'] ?? '';
    String message = json['message'] ?? '';
    if (status.contains('400')) {
      message = json['message'] ?? '';
      if (message.contains('Something wrong occur')) {
        message = 'Đã có lỗi xảy ra, vui lòng thử lại!';
      }
    } else if (status.contains('401')) {
      message = 'Phiên đã hết hạn, vui lòng đăng nhập lại!';
    } else if (status.contains('403')) {
      message = 'Bạn không thể truy cập vào chức năng này!';
    } else if (status.contains('500')) {
      message = 'Đã có lỗi xảy ra, vui lòng thử lại!';
    }
    return ResponseObject(
      status: status,
      message: message,
      data: json['data'],
    );
  }
}
