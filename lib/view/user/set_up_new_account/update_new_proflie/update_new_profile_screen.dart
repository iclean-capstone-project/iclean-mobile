import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/view/user/set_up_new_account/update_new_location/update_new_location_screen.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../widgets/main_color_inkwell_full_size.dart';
import '../../../../widgets/my_textfield.dart';
import '../../../../widgets/top_bar.dart';
import '../../../../widgets/select_photo_options_screen.dart';

class UpdateNewProfileScreen extends StatefulWidget {
  const UpdateNewProfileScreen({super.key});

  @override
  State<UpdateNewProfileScreen> createState() => _UpdateNewProfileScreenState();
}

class _UpdateNewProfileScreenState extends State<UpdateNewProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  File? _image;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  bool initDateTime = false;
  DateTime? _selectedDate;

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

  // Define validation email function
  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Please enter email';
    } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(value)) {
      return 'Email is invalid';
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
              bodyText1: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
              button: TextStyle(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  //TopBar
                  const TopBar(text: "Cập nhập hồ sơ"),

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
                                            "assets/images/default_profile.jpg"),
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
                    child: SizedBox(
                      height: 48,
                      child: TextFormField(
                        controller: TextEditingController(
                            text: _selectedDate == null
                                ? ''
                                : DateFormat('dd/MM/yyyy')
                                    .format(_selectedDate!)),
                        obscureText: false,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            borderSide:
                                BorderSide(color: ColorPalette.greyColor),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            borderSide:
                                BorderSide(color: ColorPalette.mainColor),
                          ),
                          fillColor: ColorPalette.textFieldColorLight,
                          filled: true,
                          hintText: 'Ngày sinh',
                          hintStyle: const TextStyle(
                            color: ColorPalette.greyColor,
                            fontFamily: 'Lato',
                          ),
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
                          suffixIconColor: ColorPalette.greyColor,
                          //focusColor: ColorPalette.mainColor,
                        ),
                      ),
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

                  //Email TextField
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: MyTextField(
                        controller: emailController,
                        hintText: 'Email',
                        validator: (value) => validateEmail(value)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(
              thickness: 0.5,
              color: Colors.grey[400],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: MainColorInkWellFullSize(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const UpdateNewLocationScreen()));
                },
                text: "Tiếp tục",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
