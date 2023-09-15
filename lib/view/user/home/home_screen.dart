import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/view/user/home/components/banner_slider.dart';

import '../../../models/account.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  Account userLogin = Account(
      id: 1,
      fullname: "Quang Linh",
      profilePicture: "assets/images/bp.jpg",
      dateOfBirth: DateTime.now(),
      phone: "0123456789",
      email: "linhlt28@gmail.com",
      role: "user",
      address:
          "S102 Vinhomes Grand Park, Nguyễn Xiễn, P. Long Thạnh Mỹ, Tp. Thủ Đức");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(149, 117, 205, 1),
                    Color.fromRGBO(103, 58, 183, 1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage(userLogin.profilePicture),
                            radius: 24,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: SizedBox(
                              width: 286,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        userLogin.fullname,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Lato',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  GestureDetector(
                                    // onTap: () {
                                    //   Navigator.push(
                                    //       context,
                                    //       MaterialPageRoute(
                                    //           builder: (context) =>
                                    //               LocationScreen()));
                                    // },
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            userLogin.address,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Lato',
                                              color: Colors.white,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            //maxLines: 3,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        // onTap: () {
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => MyBookmarkScreen()));
                        // },
                        child: const Icon(
                          Icons.turned_in_not_outlined,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 24),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      border: Border.all(
                        color: ColorPalette.greyColor,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 8),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            "Khám phá và trải nghiệm các dịch vụ gia đình ngay hôm nay.",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Lato',
                              color: Colors.white,
                              //fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        const Divider(color: ColorPalette.greyColor),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: const [
                                Icon(
                                  IconData(
                                    0xe0b2,
                                    fontFamily: 'MaterialIcons',
                                  ),
                                  size: 24,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "120 000 VND",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Lato',
                                    color: Colors.white,
                                    //fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            //Divider(),
                            Row(
                              children: const [
                                Icon(
                                  IconData(
                                    0xe0b2,
                                    fontFamily: 'MaterialIcons',
                                  ),
                                  size: 24,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "120 000 VND",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Lato',
                                    color: Colors.white,
                                    //fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16.0, left: 24),
              child: Text(
                "What's news?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lato',
                  fontSize: 18,
                ),
              ),
            ),
            const Center(child: BannerSlider()),
            const Padding(
              padding: EdgeInsets.only(top: 16.0, left: 24),
              child: Text(
                "Dịch vụ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lato',
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
