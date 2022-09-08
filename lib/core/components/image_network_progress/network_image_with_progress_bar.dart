import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NetworkImageWithProgressBar extends StatelessWidget {
  final String imagePath;
  const NetworkImageWithProgressBar({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        imagePath,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return LottieBuilder.asset("assets/lottie/cat_loading.json");

          // Center(
          //   child: CircularProgressIndicator(
          //     value: loadingProgress.expectedTotalBytes != null
          //         ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
          //         : null,
          //   ),
          // );
        },
      ),
    );
  }
}
