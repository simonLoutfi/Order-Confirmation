import 'package:flutter/material.dart';
import 'package:proto/repository/authentication.dart';
import 'package:proto/view/settings.dart';

class OTPController {
 void verifyOTP(String otp, BuildContext context) async {
  var isVerified = await Authentication.instance.verifyOTP(otp);
  
  if (isVerified && context.mounted) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Settings(),
      ),
    );
  } else if (context.mounted) {
    Navigator.pop(context);
  }
}

}
