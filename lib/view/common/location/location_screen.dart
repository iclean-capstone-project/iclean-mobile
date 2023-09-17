import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/widgets/main_color_inkwell_full_size.dart';

import '../../../models/address.dart';

class LocationScreen extends StatelessWidget {
  LocationScreen({super.key});

  List<Address> listAddressSaved = [
    Address(
        id: 3,
        userId: 1,
        addressName: 'S102 Vinhomes Grand Park',
        description:
            '492 Nguyen Xien, P. Long Thanh My, TP. Thu Duc, Thanh Pho Ho Chi Minh, Viet Nam',
        isDefault: true),
    Address(
        id: 1,
        userId: 1,
        addressName: 'home',
        description:
            '492 Nguyen Xien, P. Long Thanh My, TP. Thu Duc, Thanh Pho Ho Chi Minh, Viet Nam',
        isDefault: false),
    Address(
        id: 2,
        userId: 1,
        addressName: 'home2',
        description:
            '1210 Huynh Van Luy, P. Phu My, TP. Thu Dau Mot, Tinh Binh Duong, Viet Nam',
        isDefault: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 18,
                    ),
                  ),
                  const Text(
                    "Vị trí của bạn",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Lato',
                    ),
                  ),
                  const Icon(
                    Icons.arrow_back_ios,
                    size: 18,
                    color: Colors.white,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Divider(
                  thickness: 0.5,
                  color: Colors.grey[400],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    for (int i = 0; i < listAddressSaved.length; i++)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    listAddressSaved[i].isDefault
                                        ? Icons.circle_rounded
                                        : Icons.circle_outlined,
                                    color: Colors.deepPurple.shade300,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 16),
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              listAddressSaved[i].addressName,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Lato',
                                              ),
                                            ),
                                            GestureDetector(
                                              // onTap: () {
                                              //   Navigator.push(
                                              //       context,
                                              //       MaterialPageRoute(
                                              //           builder: (context) =>
                                              //               UpdateLocationScreen(
                                              //                   address:
                                              //                       listAddressSaved[
                                              //                           i])));
                                              // },
                                              child: const Text(
                                                "Edit",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Lato',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Text(listAddressSaved[i].description,
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 12,
                                              fontFamily: 'Lato',
                                            ),
                                            textAlign: TextAlign.justify,
                                            maxLines: null),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            if (i != listAddressSaved.length - 1)
                              Divider(
                                thickness: 0.5,
                                color: Colors.grey[400],
                              ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: MainColorInkWellFullSize(onTap: (){}, text: "Thêm vị trí mới",),
      ),
    );
  }
}
