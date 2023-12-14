enum BookingStatus {
  rejected,
  cancelBySystem,
  notYet,
  approved,
  cancelByRenter,
  cancelByHelper,
  upcoming,
  inProcessing,
  finished,
  onCart,
  noMoney,
  reported,
}

BookingStatus mapStrBookingStatus(String value) {
  switch (value) {
    case "REJECTED":
      return BookingStatus.rejected;
    case "CANCEL_BY_SYSTEM":
      return BookingStatus.cancelBySystem;
    case "NOT_YET":
      return BookingStatus.notYet;
    case "APPROVED":
      return BookingStatus.approved;
    case "CANCEL_BY_RENTER":
      return BookingStatus.cancelByRenter;
    case "CANCEL_BY_HELPER":
      return BookingStatus.cancelByHelper;
    case "WAITING":
      return BookingStatus.upcoming;
    case "IN_PROCESS":
      return BookingStatus.inProcessing;
    case "FINISHED":
      return BookingStatus.finished;
    case "ON_CART":
      return BookingStatus.onCart;
    case "NO_MONEY":
      return BookingStatus.noMoney;
    case "REPORTED":
      return BookingStatus.reported;
    default:
      throw Exception('Invalid BookingStatus value');
  }
}

class StatusHistory {
  int id;
  DateTime createAt;
  BookingStatus bookingStatus;

  StatusHistory({
    required this.id,
    required this.createAt,
    required this.bookingStatus,
  });

  static BookingStatus _mapStrBookingStatus(String value) {
    return mapStrBookingStatus(value);
  }

  factory StatusHistory.fromJson(Map<String, dynamic> json) {
    final status = json['bookingDetailStatus'] as String;
    BookingStatus mappedStatus = _mapStrBookingStatus(status);
    return StatusHistory(
      id: json['statusHistoryId'],
      createAt: DateTime.parse(json['createAt'] ?? ""),
      bookingStatus: mappedStatus,
    );
  }
}
