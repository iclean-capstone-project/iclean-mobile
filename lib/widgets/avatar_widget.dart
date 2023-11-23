import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class AvatarWidget extends StatelessWidget {
  final String imagePath;
  const AvatarWidget({
    super.key,
    required this.imagePath,
  });

  Future<bool> isNetworkImageValid(String imageUrl) async {
    try {
      final response = await http.head(Uri.parse(imageUrl));
      return response.statusCode >= 200 && response.statusCode < 300;
    } catch (e) {
      // Handle any exceptions, such as network errors
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isNetworkImageValid(imagePath),
      builder: (context, snapshot) {
        if (snapshot.hasError || !(snapshot.data ?? false)) {
          // If the network image is invalid or there's an error, display the fallback asset image
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/images/default_profile.png',
              width: 96,
              height: 96,
              fit: BoxFit.cover,
            ),
          );
        } else {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imagePath,
              width: 96,
              height: 96,
              fit: BoxFit.cover,
            ),
          );
        }
      },
    );
  }
}
