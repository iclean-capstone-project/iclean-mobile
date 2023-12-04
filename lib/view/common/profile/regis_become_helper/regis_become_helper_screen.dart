import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/view/common/profile/regis_become_helper/choose_service_for_helper_screen.dart';
import 'package:iclean_mobile_app/widgets/my_app_bar.dart';
import 'package:iclean_mobile_app/widgets/my_bottom_app_bar.dart';
import 'package:iclean_mobile_app/widgets/my_textfield.dart';
import 'package:iclean_mobile_app/widgets/select_photo_options_screen.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class RegisBecomeHelperScreen extends StatefulWidget {
  const RegisBecomeHelperScreen({super.key});

  @override
  State<RegisBecomeHelperScreen> createState() =>
      _RegisBecomeHelperScreenState();
}

class _RegisBecomeHelperScreenState extends State<RegisBecomeHelperScreen> {
  final emailController = TextEditingController();
  File? _image1, _image2;
  bool isFirstImage = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future _pickImage(ImageSource source, bool isFirstImage) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      setState(() {
        if (isFirstImage) {
          _image1 = img;
        } else {
          _image2 = img;
        }
        Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      // ignore: avoid_print
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

  void _showSelectPhotoOptions(BuildContext context, bool isFirstImage) {
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
                onTap: (source) => _pickImage(source, isFirstImage),
              ),
            );
          }),
    );
  }

  bool _validateInputs() {
    return emailController.text.isNotEmpty &&
        _image1 != null &&
        _image2 != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: const MyAppBar(text: ""),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 48,
                child: MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Chúng tôi sẽ liên hệ với bạn để thông báo những thông tin giúp bạn có thể làm việc chất lượng thông qua email này.',
                style: TextStyle(
                  fontSize: 14,
                  color: ColorPalette.greyColor,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 16),
              const Text(
                'CCCD',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Mặt trước',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Lato',
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    setState(() {
                      isFirstImage = true;
                    });
                    _showSelectPhotoOptions(context, isFirstImage);
                  },
                  child: SizedBox(
                    height: 162,
                    width: 257,
                    child: _image1 == null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'assets/images/default_profile.png',
                              fit: BoxFit.cover,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              _image1!,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Mặt sau',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Lato',
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    setState(() {
                      isFirstImage = false;
                    });
                    _showSelectPhotoOptions(context, isFirstImage);
                  },
                  child: SizedBox(
                    height: 162,
                    width: 257,
                    child: _image2 == null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'assets/images/default_profile.png',
                              fit: BoxFit.cover,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              _image2!,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomAppBar(
        text: "Tiếp tục",
        onTap: () {
          if (_validateInputs()) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChooseServiceForHelperScreen(
                  image1: _image1!,
                  image2: _image2!,
                  email: emailController.text,
                ),
              ),
            );
          } else {
            // Show an error message or perform other actions for invalid inputs.
            // For example, you can display a SnackBar.

          }
        },
      ),
    );
  }
}
