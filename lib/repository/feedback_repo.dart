import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/feedback.dart';

abstract class FeedbackRepository {
  Future<void> feedback(
      BuildContext context, int id, double rate, String feedback);
  Future<List<FeedbackModel>> getFeedBack(
      int id, int serviceId, BuildContext context);
}
