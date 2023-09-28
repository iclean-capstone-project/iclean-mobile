import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:timelines/timelines.dart';

class MyTimeline extends StatelessWidget {
  const MyTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -24.0),
      child: Timeline.tileBuilder(
        shrinkWrap: true,
        theme: TimelineThemeData(
          direction: Axis.horizontal,
        ),
        builder: TimelineTileBuilder.connected(
          connectionDirection: ConnectionDirection.before,
          itemExtentBuilder: (_, index) => 120.0,
          itemCount: 3,
          contentsBuilder: (_, index) {
            if (index == 2) {
              return Column(
                children: const [
                  Text(
                    'Hoàn Thành',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Lato',
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '22:07',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Lato',
                    ),
                  ),
                ],
              );
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: const [
                  Text(
                    'Đã đặt',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Lato',
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '21:52',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Lato',
                    ),
                  ),
                ],
              ),
            );
          },
          indicatorBuilder: (_, index) {
            if (index == 2) {
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 24,
                ),
              );
            } else {
              // Default dot indicator for other items
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: DotIndicator(
                  color: ColorPalette.greyColor,
                  size: 8,
                ),
              );
            }
          },
          connectorBuilder: (_, index, ___) {
            // Replace with your timeline connector for each item
            return const SolidLineConnector(
              color: ColorPalette.greyColor,
              thickness: 0.5,
            );
          },
        ),
      ),
    );
  }
}
