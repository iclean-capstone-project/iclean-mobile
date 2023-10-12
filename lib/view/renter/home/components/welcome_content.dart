import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';

import '../../../../models/account.dart';
import '../../../common/location/location_screen.dart';

class WelcomeContent extends StatelessWidget {
  const WelcomeContent({
    super.key,
    required this.userLogin,
  });

  final Account userLogin;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        image: DecorationImage(
          image: AssetImage('assets/images/banner_1.png'),
          fit: BoxFit.cover,
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
                    backgroundImage: AssetImage(userLogin.profilePicture),
                    radius: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: SizedBox(
                      width: 320,
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
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LocationScreen()));
                            },
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
                color: Colors.white),
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
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
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
                          color: Colors.black,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "120 000 VND",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Lato',
                            color: Colors.black,
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
                          color: Colors.black,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "120 000 VND",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Lato',
                            color: Colors.black,
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
    );
  }
}
