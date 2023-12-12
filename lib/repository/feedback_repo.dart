import 'package:flutter/material.dart';

abstract class FeedbackRepository {
  Future<void> feedback(
      BuildContext context, int id, double rate, String feedback);
}
