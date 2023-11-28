import 'package:flutter/material.dart';

class EmptyCartContent extends StatelessWidget {
  const EmptyCartContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'Giỏ hàng của bạn đang trống.',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'Hãy đặt dịch vụ ngay',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
