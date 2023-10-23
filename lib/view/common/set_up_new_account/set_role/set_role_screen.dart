import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/view/common/set_up_new_account/set_proflie/set_profile_screen.dart';
import 'package:iclean_mobile_app/widgets/main_color_inkwell_full_size.dart';

class SetRoleScreen extends StatefulWidget {
  const SetRoleScreen({super.key});

  @override
  State<SetRoleScreen> createState() => _SetRoleScreenState();
}

class _SetRoleScreenState extends State<SetRoleScreen> {
  String? _selectedRole;

  String? validateDropdown(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Please select a value';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          child: Column(
            children: [
              const Text(
                "Bạn muốn đăng ký với vai trò",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Lato',
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 48,
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    hintText: 'Chọn vai trò',
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(
                        color: ColorPalette.greyColor,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(
                        color: ColorPalette.mainColor,
                      ),
                    ),
                    fillColor: Theme.of(context).colorScheme.primary,
                    filled: true,
                    hintStyle: const TextStyle(
                      color: ColorPalette.greyColor,
                      fontFamily: 'Lato',
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.secondary,
                    fontFamily: 'Lato',
                  ),
                  value: _selectedRole,
                  onChanged: (String? value) {
                    _selectedRole = value;
                  },
                  items:
                      <String>['Khách hàng', 'Nhân viên'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  validator: (value) => validateDropdown(value),
                ),
              ),
              const SizedBox(height: 24),
              MainColorInkWellFullSize(
                onTap: () {
                  if (_selectedRole == 'Khách hàng') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const SetProfileScreen(role: "renter")));
                  }
                },
                text: "Tiếp tục",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
