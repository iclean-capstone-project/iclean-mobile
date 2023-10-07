import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/account.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/view/renter/booking_service/service_details_screen.dart';
import 'package:iclean_mobile_app/view/renter/home/components/banner_slider.dart';

import '../../../models/services.dart';
import 'components/welcome_content.dart';

class HomeScreen extends StatelessWidget {
  final Account userLogin;
  HomeScreen({super.key, required this.userLogin});

  List<Service> services = [
    Service(
      id: 1,
      name: "Vệ sinh Sofa - Rèm - Đệm - Thảm",
      icon: "assets/images/clean_tham.jpg",
      imagePath:
          "https://media.product.which.co.uk/prod/images/original/gm-7085653b-1747-4e8d-a2e9-2f16e651b9a1-cleaning-a-sofa-2-002-vacuum.jpg",
    ),
    Service(
      id: 2,
      name: "Vệ sinh chung",
      icon: "assets/images/clean_kinh.png",
      imagePath:
          "https://www.cnet.com/a/img/resize/2817482ad16098ea3b01d4c3c85c6409ee494013/hub/2023/04/14/9cacb2b9-c38a-4454-a82c-947b632e0710/clean-empty-house-gettyimages-1031043754.jpg?auto=webp&fit=crop&height=675&width=1200",
    ),
    Service(
      id: 3,
      name: "Vệ sinh kính",
      icon: "assets/images/clean_kinh.png",
      imagePath:
          "https://www.bhg.com/thmb/KRuk3RP7ghIWEMPGya73wSzreII=/3000x0/filters:no_upscale():strip_icc()/cleaning-products-tools-best-homemade-window-cleaner-03-aed804b8d9034941be9eba785dff7f7d.jpg",
    ),
    Service(
      id: 4,
      name: "Chăm sóc trẻ em",
      icon: "assets/images/don_nha_ve_sinh.png",
      imagePath:
          "https://www.uhhospitals.org/-/media/Images/Blog/Taking-Care-Of-Young-Children_Blog-MainArticleImage.jpg?h=450&w=720&la=en&hash=40145A742107D6F0A5A4CB73354C159A32AFB4A1",
    ),
    Service(
      id: 5,
      name: "Vệ sinh bể cá",
      icon: "assets/images/nau_an.png",
      imagePath:
          "https://www.hepper.com/wp-content/uploads/2022/09/washing-cleaning-fish-tank-1.jpg",
    ),
    Service(
      id: 6,
      name: "Vệ sinh máy lạnh",
      icon: "assets/images/decor.png",
      imagePath:
          "https://thumbor.forbes.com/thumbor/fit-in/x/https://www.forbes.com/home-improvement/wp-content/uploads/2022/07/featured-image-clean-ac.jpeg.jpg",
    ),
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
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ServiceDetailsScreen(
                                service: services[i],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.all(16),
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
                              Container(
                                margin: const EdgeInsets.all(8),
                                child: Image.asset(
                                  services[i].icon,
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.contain,
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
