// ignore_for_file: avoid_print

import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/account.dart';
import 'package:iclean_mobile_app/models/wallet.dart';
import 'package:iclean_mobile_app/services/api_account_repo.dart';
import 'package:iclean_mobile_app/services/api_wallet_repo.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:iclean_mobile_app/auth/user_preferences.dart';
import 'package:iclean_mobile_app/services/constant.dart';
import 'package:iclean_mobile_app/widgets/my_app_bar.dart';
import 'package:iclean_mobile_app/widgets/my_bottom_app_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/widgets/my_textfield.dart';
import 'package:iclean_mobile_app/widgets/select_photo_options_screen.dart';

import 'components/comfirm_dialog.dart';

class SetProfileScreen extends StatefulWidget {
  const SetProfileScreen({super.key, required this.role});

  final String role;

  @override
  State<SetProfileScreen> createState() => _SetProfileScreenState();
}

class _SetProfileScreenState extends State<SetProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  File? _image;
  final nameController = TextEditingController();
  bool initDateTime = false;
  DateTime? _selectedDate;
  String imgPath = '';

  @override
  void initState() {
    super.initState;
  }

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      setState(() {
        _image = img;
        Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  void _showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.28,
          maxChildSize: 0.4,
          minChildSize: 0.28,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: SelectPhotoOptionsScreen(
                onTap: _pickImage,
              ),
            );
          }),
    );
  }

  // Define validation name function
  String? validateFullname(String? value) {
    if (value!.isEmpty) {
      return 'Please enter full name.';
    }
    if (!RegExp(r'^[A-Z][a-zA-Z]*((\s)?([A-Z][a-zA-Z]*))*$').hasMatch(value)) {
      return 'Please enter valid name.';
    }
    return null;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: ColorPalette.mainColor,
              onPrimary: Colors.white,
              surface: ColorPalette.mainColor,
              onSurface: Colors.black,
            ),
            textTheme: const TextTheme(
              bodyLarge: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
              labelLarge: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<Account> fetchAccount() async {
    final ApiAccountRepository apiAccountRepository = ApiAccountRepository();

    try {
      final account = await apiAccountRepository.getAccount();
      return account;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Wallet> fetchMoney() async {
    final ApiWalletRepository apiWalletRepository = ApiWalletRepository();
    try {
      final money = await apiWalletRepository.getMoney();
      return money;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> setNewAccount(String fullName, DateTime dateOfBirth, File image,
      String role, BuildContext context) async {
    final uri = Uri.parse('${BaseConstant.baseUrl}/auth/register');

    final accessToken = await UserPreferences.getAccessToken();
    var request = http.MultipartRequest(
      'POST',
      uri,
    );

    request.headers.addAll({
      'Authorization': 'Bearer $accessToken',
    });

    String dob = DateFormat('dd-MM-yyyy').format(_selectedDate!);

    request.fields['fullName'] = fullName;
    request.fields['dateOfBirth'] = dob;
    request.files.add(
      await http.MultipartFile.fromPath('fileImage', image.path),
    );
    request.fields['role'] = role;
    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) => const ConfirmDialog(),
        );
      } else {
        throw Exception(
            'Failed to set profile. Status: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(text: "Cập nhập hồ sơ"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                //Avatar
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: Center(
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        _showSelectPhotoOptions(context);
                      },
                      child: Center(
                        child: Container(
                            height: 146,
                            width: 146,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: _image == null
                                  ? const CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "assets/images/default_profile.png"),
                                      radius: 72,
                                    )
                                  : CircleAvatar(
                                      backgroundImage: FileImage(_image!),
                                      radius: 200.0,
                                    ),
                            )),
                      ),
                    ),
                  ),
                ),

                //Name TextField
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: SizedBox(
                    height: 48,
                    child: MyTextField(
                      controller: nameController,
                      hintText: 'Tên',
                    ),
                  ),
                ),

                //Dob TextField
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: MyTextField(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        _selectDate(context);
                        setState(() {
                          initDateTime = true;
                        });
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Icon(
                          Icons.edit_calendar,
                          size: 24,
                        ),
                      ),
                    ),
                    controller: TextEditingController(
                        text: _selectedDate == null
                            ? ''
                            : DateFormat('dd/MM/yyyy').format(_selectedDate!)),
                    hintText: 'Ngày sinh',
                  ),
                ),

                if (_selectedDate == null && initDateTime)
                  const Text(
                    'Please select a date',
                    style: TextStyle(
                      color: Colors.red,
                      fontFamily: 'Lato',
                      fontSize: 12,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: MyBottomAppBar(
        text: "Tiếp tục",
        onTap: () {
          setNewAccount(nameController.text, _selectedDate!, _image!,
              widget.role, context);
        },
      ),
    );
  }
}
