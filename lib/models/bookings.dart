class Booking {
  int id, renterId, empId, jobId, workTime, statusId;
  String location, description;
  double totalPrice;
  DateTime timeCreated, timeWork;
  DateTime? timeStart, timeEnd, timeCancel;
  int? discount;
  Booking({
    required this.id,
    required this.renterId,
    required this.empId,
    required this.jobId,
    required this.location,
    required this.workTime,
    required this.description,
    required this.timeWork,
    required this.totalPrice,
    required this.timeCreated,
    required this.timeStart,
    required this.timeEnd,
    required this.timeCancel,
    required this.discount,
    required this.statusId,
  });
}
