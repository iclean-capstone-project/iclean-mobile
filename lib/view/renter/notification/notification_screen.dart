import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/noti.dart';

import 'components/noti_content.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    List<Noti> notis = [
      Noti(
        id: 1,
        details: "Đơn #00834 của bạn đang được duyệt từ nhân viên",
        status: 'unconfirm',
        timestamp: DateTime.now(),
        isRead: false,
        deleted: false,
      ),
      Noti(
        id: 2,
        details:
            "Đơn #98956 của bạn đã được xác nhận, vui lòng chờ nhân viên của chúng tôi!",
        status: 'undone',
        timestamp: DateTime.now(),
        isRead: false,
        deleted: false,
      ),
      Noti(
        id: 3,
        details:
            "Công việc thuộc đơn #98442 đã được hoàn thành, bạn có thể đánh giá dịch vụ của chúng tôi!",
        status: 'done',
        timestamp: DateTime.now(),
        isRead: false,
        deleted: false,
      ),
      Noti(
        id: 4,
        details: "Đơn #95242 đã bị hủy từ nhân viên",
        status: 'cancel',
        timestamp: DateTime.now(),
        isRead: false,
        deleted: false,
      ),
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Notification",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Lato',
                        ),
                      ),
                      Text(
                        "See all",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Lato',
                            color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              NotiContent(notis: notis),
            ],
          ),
        ),
      ),
    );
  }
}
