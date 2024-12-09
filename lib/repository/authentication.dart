import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authentication {
  Authentication._privateConstructor();
  static final Authentication instance = Authentication._privateConstructor();

  final _auth = FirebaseAuth.instance;
  final ValueNotifier<String> verificationId = ValueNotifier('');
  
  void phoneAuthentication(String? phoneNb) async{
    
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNb,  
      verificationCompleted: (PhoneAuthCredential credentials) async{
        await _auth.signInWithCredential(credentials);
      },
      verificationFailed: (e){
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
      }, 
      codeSent: (verificationId, resendToken) async {
        this.verificationId.value = verificationId; 
        
      },
      codeAutoRetrievalTimeout: (verificationId){
        
      }
    );
  }

  Future<bool> verifyOTP(String otp) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: otp,
      );
      UserCredential userCredential = await _auth.signInWithCredential(credential);
      print("User signed in: ${userCredential.user?.uid}");
      return userCredential.user != null;
    } catch (e) {
      print("Error during sign-in: $e");
      return false;
    }
  }


}