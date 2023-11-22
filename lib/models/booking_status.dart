enum BookingStatus {
  rejected,
  notYet,
  approved,
  employeeAccepted,
  renterCanceled,
  employeeCanceled,
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
    case "NOT_YET":
      return BookingStatus.notYet;
    case "APPROVED":
      return BookingStatus.approved;
    case "EMPLOYEE_ACCEPTED":
      return BookingStatus.employeeAccepted;
    case "RENTER_CANCELED":
      return BookingStatus.renterCanceled;
    case "EMPLOYEE_CANCELED":
      return BookingStatus.employeeCanceled;
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
      createAt: DateTime.parse(json['createAt']),
      bookingStatus: mappedStatus,
    );
  }
}
