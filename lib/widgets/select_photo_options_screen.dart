import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 're_usable_select_photo_button.dart';

class SelectPhotoOptionsScreen extends StatelessWidget {
  final Function(ImageSource source) onTap;
  const SelectPhotoOptionsScreen({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -35,
            child: Container(
              width: 50,
              height: 6,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.5),
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Column(
            children: [
              SelectPhoto(
                onTap: () => onTap(ImageSource.gallery),
                icon: Icons.image,
                textLabel: 'Chọn từ thư viện ảnh',
              ),
              const SizedBox(
                height: 8,
              ),
              const Center(
                child: Text(
                  'or',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Lato',
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              SelectPhoto(
                onTap: () => onTap(ImageSource.camera),
                icon: Icons.camera_alt_outlined,
                textLabel: 'Chụp từ Camera',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
