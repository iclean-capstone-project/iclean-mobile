import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/view/user/home/components/banner_slider.dart';

import '../../../models/account.dart';
import '../../../models/services.dart';
import 'components/welcome_content.dart';

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

  List<Service> services = [
    Service(id: 1, name: "Giặt thảm", icon: "assets/images/clean_tham.jpg"),
    Service(
        id: 2, name: "Vệ sinh kính", icon: "assets/images/clean_kinh.png"),
    Service(id: 3, name: "Giặt ủi", icon: "assets/images/giat_ui.png"),
    Service(
        id: 4,
        name: "Dọn nhà vệ sinh",
        icon: "assets/images/don_nha_ve_sinh.png"),
    Service(id: 5, name: "Nấu ăn", icon: "assets/images/nau_an.png"),
    Service(id: 6, name: "Decor", icon: "assets/images/decor.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //top
              welcome_content(userLogin: userLogin),
              
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
              //slider
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.count(
                    crossAxisCount: 3,
                    //physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    childAspectRatio: (80 / 72),
                    children: [
                      for (int i = 0; i < services.length; i++)
                        Container(
                          margin: const EdgeInsets.all(16),
                          //padding: const EdgeInsets.all(0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: ColorPalette.greyColor,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(.1),
                                blurRadius: 4.0,
                                spreadRadius: .05,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              InkWell(
                                // onTap: () {
                                //   Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => EmployeeServiceScreen(
                                //         service: services[i],
                                //       ),
                                //     ),
                                //   );
                                // },
                                child: Container(
                                  margin: const EdgeInsets.all(8),
                                  child: Image.asset(
                                    services[i].icon,
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: LayoutBuilder(
                                  builder: (BuildContext context,
                                      BoxConstraints constraints) {
              
                                    return Text(
                                      services[i].name,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'Lato',
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 2,
                                      softWrap: true,
                                      textAlign: TextAlign.center,
                                    );
                                  },
                                ),
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
    );
  }
}


