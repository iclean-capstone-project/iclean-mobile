import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/auth/log_in/log_in_screen.dart';
import 'package:iclean_mobile_app/auth/user_preferences.dart';
import 'package:iclean_mobile_app/models/account.dart';
import 'package:iclean_mobile_app/view/common/location/location_screen.dart';
import 'package:iclean_mobile_app/view/common/profile/my_profile_screen/components/dark_mode.dart';
import 'package:iclean_mobile_app/view/common/profile/my_profile_screen/components/profile_inkwell.dart';
import 'package:iclean_mobile_app/view/common/profile/update_profile_screen/update_profile_screen.dart';

import '../../../../widgets/confirm_dialog.dart';

class ProfileScreen extends StatefulWidget {
  final Account account;
  const ProfileScreen({super.key, required this.account});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
                    builder: (BuildContext context) => LogInScreen()),
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
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  children: const [
                    Text(
                      "Profile",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lato',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              //Avatar
              Column(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.account.avatar),
                    radius: 48,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.account.fullName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Lato',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ProfileInkWell(
                icon: const Icon(Icons.person_outline),
                text: "Cập nhật hồ sơ",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              UpdateProfileScreen(account: widget.account)));
                },
              ),
              ProfileInkWell(
                icon: const Icon(Icons.location_on_outlined),
                text: "Vị trí",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LocationScreen()));
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
                  overlayColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.hovered)) {
                        return Colors.red.withOpacity(0.2);
                      } else {
                        return Colors.transparent;
                      }
                    },
                  ),
                  mouseCursor: MaterialStateProperty.all<MouseCursor>(
                      SystemMouseCursors.click),
                ),
                onPressed: () => showLogoutConfirmationDialog(context),
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
          ),
        )),
      ),
    );
  }
}
