import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/account.dart';

import 'package:iclean_mobile_app/view/renter/home/components/banner_slider.dart';

import '../../../models/services.dart';
import 'components/list_service.dart';

import 'components/welcome_content.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key, required this.account});

  final Account account;

  final List<Service> services = [
    Service(
      id: 1,
      name: "Vệ sinh Sofa - Rèm - Đệm - Thảm",
      icon: "assets/images/clean_tham.png",
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
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //top
              WelcomeContent(account: account),

              const Padding(
                padding: EdgeInsets.only(top: 16.0, left: 24),
                child: Text(
                  "Có gì mới?",
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
              ListService(services: services, account: account),
            ],
          ),
        ),
      ),
    );
  }
}
