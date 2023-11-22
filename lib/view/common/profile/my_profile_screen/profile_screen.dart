import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/auth/log_in/log_in_screen.dart';
import 'package:iclean_mobile_app/auth/user_preferences.dart';
import 'package:iclean_mobile_app/models/account.dart';
import 'package:iclean_mobile_app/services/api_account_repo.dart';

import 'package:iclean_mobile_app/view/common/profile/location/location_screen.dart';
import 'package:iclean_mobile_app/view/common/profile/my_profile_screen/components/dark_mode.dart';
import 'package:iclean_mobile_app/view/common/profile/my_profile_screen/components/profile_inkwell.dart';
import 'package:iclean_mobile_app/view/common/profile/update_profile_screen/update_profile_screen.dart';
import 'package:iclean_mobile_app/view/common/profile/wallet/my_wallet/wallet_screen.dart';
import 'package:iclean_mobile_app/view/employee/set_time_working_screen/set_time_working_screen.dart';
import 'package:iclean_mobile_app/widgets/confirm_dialog.dart';
import 'package:iclean_mobile_app/widgets/qr_generator.dart';
import 'package:iclean_mobile_app/widgets/qr_scan_screen.dart';
import 'package:iclean_mobile_app/widgets/shimmer_loading.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<Account> fetchAccount() async {
    final ApiAccountRepository apiAccountRepository = ApiAccountRepository();
    try {
      final account = await apiAccountRepository.getAccount(context);

      return account;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> getRole() async {
    final role = await UserPreferences.getRole();
    return role!;
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
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Row(
                    children: [
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
                              return const Column(
                                children: [
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
                          //Avatar
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(account.avatar),
                              radius: 48,
                            ),
                          ),
                          const SizedBox(height: 16),
                          //name
                          Text(
                            account.fullName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Lato',
                            ),
                          ),
                          const SizedBox(height: 8),
                          ProfileInkWell(
                            icon: const Icon(Icons.person_outline),
                            text: "Cập nhật hồ sơ",
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UpdateProfileScreen(
                                          account: account)));
                            },
                          ),
                          FutureBuilder<String>(
                            future: getRole(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const ShimmerLoadingWidget.rectangular(
                                    height: 16);
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else if (snapshot.hasData) {
                                final role = snapshot.data!;
                                if (role == "employee") {
                                  return ProfileInkWell(
                                    icon: const Icon(Icons.person_outline),
                                    text: "Chọn giờ làm việc",
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SetTimeWorkingScreen()));
                                    },
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              } else {
                                return const SizedBox();
                              }
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
                            icon: const Icon(Icons.location_on_outlined),
                            text: "Vị trí",
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const QrGenerator()));
                            },
                          ),
                          ProfileInkWell(
                            icon: const Icon(Icons.location_on_outlined),
                            text: "QR Scanner",
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const QRViewExample()));
                            },
                          ),
                          ProfileInkWell(
                            icon: const Icon(Icons.wallet),
                            text: "Ví IcleanPay",
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MyWalletScreen()));
                            },
                          ),

                          ProfileInkWell(
                            icon: const Icon(Icons.notifications_outlined),
                            text: "Thông báo",
                            onTap: () {},
                          ),
                          ProfileInkWell(
                            icon: const Icon(Icons.payment_outlined),
                            text: "Thanh toán",
                            onTap: () {},
                          ),
                          ProfileInkWell(
                            icon: const Icon(Icons.language_outlined),
                            text: "Ngôn ngữ",
                            onTap: () {},
                          ),

                          const DarkModeButton(),
                          ProfileInkWell(
                            icon: const Icon(Icons.policy_outlined),
                            text: "Privacy Policy",
                            onTap: () {},
                          ),
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
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
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
