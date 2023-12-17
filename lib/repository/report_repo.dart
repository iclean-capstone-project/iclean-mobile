import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/report_type.dart';

abstract class ReportRepository {
  Future<List<ReportType>> getReportType(BuildContext context);
  Future<void> report(BuildContext context, int id, int reportTypeId,
      String detail, File? image1, File? image2, File? image3);
}
