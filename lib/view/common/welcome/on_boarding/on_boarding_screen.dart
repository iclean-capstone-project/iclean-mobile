import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/widgets/main_color_inkwell_full_size.dart';

import '../welcome/welcome_screen.dart';
import 'components/dot_indicator.dart';
import 'components/on_boarding_content.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;
  int _pageIndex = 0;

  final List<OnBoard> onboardData = [
    OnBoard(
        image: "assets/images/illustration_1.png",
        description: "Chúng tôi cung cấp dịch vụ chuyên nghiệp với mức giá thân thiện"),
    OnBoard(
        image: "assets/images/illustration_2.png",
        description:
            "Kết quả tốt nhất và sự hài lòng của bạn là mục tiêu hàng đầu của chúng tôi"),
    OnBoard(
        image: "assets/images/illustration_3.png",
        description: "Hãy tạo ra những thay đổi tuyệt vời cho ngôi nhà của bạn"),
  ];

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 48),
          //content
          Expanded(
            child: PageView.builder(
              itemCount: onboardData.length,
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _pageIndex = index;
                });
              },
              itemBuilder: (context, index) => OnBoardContent(
                  image: onboardData[index].image,
                  description: onboardData[index].description),
            ),
          ),

          //Dot indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(
                onboardData.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: DotIndicator(isActive: index == _pageIndex),
                ),
              ),
            ],
          ),

          //Inkwell Next/Started
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: MainColorInkWellFullSize(
              onTap: () {
                if (_pageIndex < onboardData.length - 1) {
                  _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease);
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WelcomeScreen()),
                  );
                }
              },
              text:
                  _pageIndex < onboardData.length - 1 ? "Tiếp tục" : "Bắt đầu",
            ),
          ),
        ],
      ),
    );
  }
}

class OnBoard {
  final String image, description;

  OnBoard({
    required this.image,
    required this.description,
  });
}
