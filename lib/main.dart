import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:proto/controller/preferences_controller.dart';
import 'package:proto/riverpod.dart';
import 'package:proto/view/add_photo.dart';
import 'package:proto/view/birthday.dart';
import 'package:proto/view/camera.dart';
import 'package:proto/view/camera2.dart';
import 'package:proto/view/gender.dart';
import 'package:proto/view/nickname.dart';
import 'view/home.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(MobileAds.instance.initialize());
  final cameras = await availableCameras();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  String? lastVisitedPage =await PreferencesController().getLastVisitedPage();
  runApp(ProviderScope(child: MyApp(camera: cameras,initialRoute: lastVisitedPage!)));
}

class MyApp extends ConsumerWidget {
  final List<CameraDescription> camera;
  final String initialRoute;

  const MyApp({super.key,required this.camera,required this.initialRoute,});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    ref.read(riverpod).setCamera(camera);
    return MaterialApp(
      title: 'Proto',
      initialRoute: initialRoute,
      routes: {
        'home.dart': (context) => const MyHomePage(),
        'birthday.dart': (context) =>const Birthday(),
        'Addphoto.dart': (context) => Addphoto(),
        'camera.dart': (context) =>const Camera(),
        'camera2.dart': (context) => Camera2(),
        'gender.dart': (context) =>const Gender(),
        'nickname.dart': (context) =>const Nickname(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:const MyHomePage(),
    );
  }
}

