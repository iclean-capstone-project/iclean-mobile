import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/report_type.dart';

abstract class ReportRepository {
  Future<List<ReportType>> getReportType(BuildContext context);
  Future<void> report(BuildContext context, int id, int reportTypeId,
      String detail, List<File> images);
}
