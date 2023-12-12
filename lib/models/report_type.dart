class ReportType {
  int reportTypeId;
  String reportName;

  ReportType({
    required this.reportTypeId,
    required this.reportName,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReportType &&
          runtimeType == other.runtimeType &&
          reportName == other.reportName;

  @override
  int get hashCode => reportName.hashCode;

  factory ReportType.fromJson(Map<String, dynamic> json) {
    return ReportType(
      reportTypeId: json['reportTypeId'],
      reportName: json['reportName'] ?? "",
    );
  }
}
