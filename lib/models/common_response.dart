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
