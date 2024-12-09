import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'view/home.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
//import 'view/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(MobileAds.instance.initialize());
  final cameras = await availableCameras();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  runApp(MyApp(camera: cameras,));
}

class MyApp extends StatelessWidget {
  final List<CameraDescription> camera;

  const MyApp({super.key,required this.camera});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Proto',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(camera: camera,),
    );
  }
}

