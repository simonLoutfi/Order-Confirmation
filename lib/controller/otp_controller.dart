import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:proto/repository/authentication.dart';
import 'package:proto/view/settings.dart';

class OTPController {
  final XFile image;
  final List<CameraDescription> camera;

  OTPController({required this.image, required this.camera});

 void verifyOTP(String otp, BuildContext context) async {
  var isVerified = await Authentication.instance.verifyOTP(otp);
  
  if (isVerified && context.mounted) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Settings(image: image, camera: camera),
      ),
    );
  } else if (context.mounted) {
    Navigator.pop(context);
  }
}

}
