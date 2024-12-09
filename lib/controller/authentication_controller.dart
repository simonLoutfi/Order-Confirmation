import 'package:proto/repository/authentication.dart';

class AuthenticationController {

  void phoneAuthentication(String? phoneNb){
    Authentication.instance.phoneAuthentication(phoneNb);
  }
}