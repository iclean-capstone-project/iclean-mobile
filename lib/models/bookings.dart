class Booking {
  int id, renterId, empId, jobId, workTime, price;
  String renterName, empName, status, location, jobName, description, jobImage;
  DateTime timestamp;
  Booking({
    required this.id,
    required this.renterId,
    required this.renterName,
    required this.empId,
    required this.empName,
    required this.status,
    required this.workTime,
    required this.timestamp,
    required this.price,
    required this.location,
    required this.jobId,
    required this.jobName,
    required this.description,
    required this.jobImage,
  });
}
