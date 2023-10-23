import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/view/common/location/location_screen.dart';
import 'package:iclean_mobile_app/widgets/main_color_inkwell_full_size.dart';

class LocationDialog extends StatelessWidget {
  const LocationDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        width: 310,
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.asset(
                "assets/images/Confirmed.png",
                fit: BoxFit.cover,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text(
                "Vui lòng cập nhật vị trí",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lato',
                  color: ColorPalette.mainColor,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                "Có vẻ như bạn vẫn chưa cập nhật vị trí của mình. Hãy cập nhật vị trí để có thể đặt dịch vụ nhé!",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Lato',
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: MainColorInkWellFullSize(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LocationScreen()));
                },
                text: "Cập nhập vị trí",
              ),
            )
          ],
        ),
      ),
    );
  }
}
