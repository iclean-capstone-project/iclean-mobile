class Booking {
  int id, renterId, empId, jobId, workTime, price;
  int? discount;
  String renterName, empName, status, location, jobName, description, jobImage;
  DateTime timeCreateBooking, timestamp;
  DateTime? workStart, workEnd;
  Booking({
    required this.id,
    required this.renterId,
    required this.renterName,
    required this.empId,
    required this.empName,
    required this.status,
    required this.workTime,
    required this.timestamp,
    required this.discount,
    required this.timeCreateBooking,
    required this.workStart,
    required this.workEnd,
    required this.price,
    required this.location,
    required this.jobId,
    required this.jobName,
    required this.description,
    required this.jobImage,
  });
}
