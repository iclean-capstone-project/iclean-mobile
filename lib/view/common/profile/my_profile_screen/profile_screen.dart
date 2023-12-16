// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/auth/log_in/log_in_screen.dart';
import 'package:iclean_mobile_app/auth/user_preferences.dart';
import 'package:iclean_mobile_app/models/account.dart';
import 'package:iclean_mobile_app/services/api_account_repo.dart';
import 'package:iclean_mobile_app/services/handle_exception_api.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/view/common/notification/notification_screen.dart';
import 'package:iclean_mobile_app/view/common/profile/location/location_screen.dart';
import 'package:iclean_mobile_app/view/common/profile/my_profile_screen/components/profile_inkwell.dart';
import 'package:iclean_mobile_app/view/common/profile/point/point_screen/point_screen.dart';
import 'package:iclean_mobile_app/view/common/profile/regis_become_helper/regis_become_helper_screen.dart';
import 'package:iclean_mobile_app/view/common/profile/update_profile_screen/update_profile_screen.dart';
import 'package:iclean_mobile_app/view/common/profile/wallet/my_wallet/wallet_screen.dart';
import 'package:iclean_mobile_app/view/helper/nav_bar_bottom/helper_screen.dart';
import 'package:iclean_mobile_app/view/helper/time_working/time_working_screen.dart';
import 'package:iclean_mobile_app/view/renter/nav_bar_bottom/renter_screen.dart';
import 'package:iclean_mobile_app/widgets/confirm_dialog.dart';
import 'package:iclean_mobile_app/widgets/shimmer_loading.dart';

import 'components/dark_mode.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var isHelper = UserPreferences.isHelper();

  Future<Account> fetchAccount() async {
    final ApiAccountRepository apiAccountRepository = ApiAccountRepository();
    try {
      final account = await apiAccountRepository.getAccount(context);
      return account;
    } catch (e) {
      await HandleExceptionApi.handleException(
          context, e); // Handle the exception
      // Return a default or null value, depending on your implementation
      rethrow;
    }
  }

  setIsHelper(bool value) async {
    await UserPreferences.setIsHelper(value);
  }

  void showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmDialog(
            title: "Đăng xuất khỏi tài khoản của bạn?",
            confirm: "Đăng xuất",
            onTap: () async {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const LogInScreen()),
                (Route<dynamic> route) => false,
              );
              ApiAccountRepository apiAccount = ApiAccountRepository();
              await apiAccount.deleteFcmToken();
              await UserPreferences.logout();
            });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                //Tittle
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    children: const [
                      Text(
                        "Hồ sơ",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Lato',
                        ),
                      ),
                    ],
                  ),
                ),
                FutureBuilder(
                  future: fetchAccount(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Column(
                        children: [
                          const ShimmerLoadingWidget.circular(
                              height: 96, width: 96),
                          const SizedBox(height: 16),
                          ShimmerLoadingWidget.rectangular(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: 18),
                          const SizedBox(height: 24),
                          Column(
                            children: List.generate(10, (index) {
                              return Column(
                                children: const [
                                  ShimmerLoadingWidget.rectangular(height: 16),
                                  SizedBox(height: 24),
                                ],
                              );
                            }),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final account = snapshot.data!;
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UpdateProfileScreen(
                                                      account: account)));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundImage:
                                                  NetworkImage(account.avatar),
                                              radius: 24,
                                            ),
                                            const SizedBox(width: 16),
                                            Text(
                                              account.fullName,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Lato',
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Icon(
                                          Icons.keyboard_arrow_right,
                                          size: 28,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 4),
                                    child: Divider(
                                      color: ColorPalette.greyColor,
                                    ),
                                  ),
                                  if (account.roleName == 'employee' &&
                                      isHelper == false)
                                    GestureDetector(
                                      onTap: () async {
                                        await UserPreferences.setIsHelper(true);
                                        setState(() {
                                          isHelper = UserPreferences.isHelper();
                                        });
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const HelperScreens()));
                                      },
                                      child: Row(
                                        children: const [
                                          SizedBox(width: 8),
                                          Icon(
                                            Icons.transfer_within_a_station,
                                            color: ColorPalette.greyColor,
                                            size: 24,
                                          ),
                                          SizedBox(width: 8),
                                          Flexible(
                                            child: Text(
                                              'Chuyển đến màn hình của người giúp việc',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: ColorPalette.greyColor,
                                                fontFamily: 'Lato',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (account.roleName == 'employee' &&
                                      isHelper == true)
                                    GestureDetector(
                                      onTap: () async {
                                        await setIsHelper(false);
                                        await UserPreferences.setIsHelper(
                                            false);
                                        setState(() {
                                          isHelper = UserPreferences.isHelper();
                                        });
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const RenterScreens()));
                                      },
                                      child: Row(
                                        children: const [
                                          SizedBox(width: 8),
                                          Icon(
                                            Icons.transfer_within_a_station,
                                            color: ColorPalette.greyColor,
                                            size: 24,
                                          ),
                                          SizedBox(width: 8),
                                          Flexible(
                                            child: Text(
                                              'Chuyển đến màn hình của người thuê dịch vụ',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: ColorPalette.greyColor,
                                                fontFamily: 'Lato',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (account.roleName == 'renter' &&
                                      !account.isRegistration!)
                                    GestureDetector(
                                      onTap: () async {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const RegisBecomeHelperScreen()));
                                      },
                                      child: Row(
                                        children: const [
                                          SizedBox(width: 8),
                                          Icon(
                                            Icons.add_circle_rounded,
                                            color: ColorPalette.greyColor,
                                            size: 24,
                                          ),
                                          SizedBox(width: 8),
                                          Flexible(
                                            child: Text(
                                              'Đăng ký để trở thành người giúp việc',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: ColorPalette.greyColor,
                                                fontFamily: 'Lato',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (account.roleName == 'renter' &&
                                      account.isRegistration!)
                                    Row(
                                      children: const [
                                        SizedBox(width: 8),
                                        Icon(
                                          Icons.add_circle_rounded,
                                          color: ColorPalette.greyColor,
                                          size: 24,
                                        ),
                                        SizedBox(width: 8),
                                        Flexible(
                                          child: Text(
                                            'Bạn đã đăng ký, vui lòng đợi phản hồi của chúng tôi',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: ColorPalette.greyColor,
                                              fontFamily: 'Lato',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (account.roleName == "employee")
                            ProfileInkWell(
                              icon: const Icon(Icons.person_outline),
                              text: "Lịch làm việc",
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const TimeWorkingScreen()));
                              },
                            ),
                          ProfileInkWell(
                            icon: const Icon(Icons.location_on_outlined),
                            text: "Vị trí",
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LocationScreen()));
                            },
                          ),
                          ProfileInkWell(
                            icon: const Icon(Icons.wallet),
                            text: "Ví IcleanPay",
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyWalletScreen()));
                            },
                          ),
                          ProfileInkWell(
                            icon: const Icon(Icons.wallet),
                            text: "Iclean Point",
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MyPointScreen()));
                            },
                          ),
                          ProfileInkWell(
                            icon: const Icon(Icons.notifications_outlined),
                            text: "Thông báo",
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const NotificationScreen()));
                            },
                          ),
                          // ProfileInkWell(
                          //   icon: const Icon(Icons.payment_outlined),
                          //   text: "Thanh toán",
                          //   onTap: () {},
                          // ),
                          // ProfileInkWell(
                          //   icon: const Icon(Icons.language_outlined),
                          //   text: "Ngôn ngữ",
                          //   onTap: () {},
                          // ),
                          const DarkModeButton(),
                          // ProfileInkWell(
                          //   icon: const Icon(Icons.policy_outlined),
                          //   text: "Privacy Policy",
                          //   onTap: () {},
                          // ),
                          ProfileInkWell(
                            icon: const Icon(Icons.list_alt_outlined),
                            text: "Điều khoản sử dụng",
                            onTap: () {},
                          ),
                          TextButton(
                            style: ButtonStyle(
                              overlayColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.hovered)) {
                                    return Colors.red.withOpacity(0.2);
                                  } else {
                                    return Colors.transparent;
                                  }
                                },
                              ),
                              mouseCursor:
                                  MaterialStateProperty.all<MouseCursor>(
                                      SystemMouseCursors.click),
                            ),
                            onPressed: () =>
                                showLogoutConfirmationDialog(context),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: const [
                                    Icon(
                                      Icons.logout,
                                      color: Colors.red,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "Đăng xuất",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Lato',
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    }
                    return const Divider();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
