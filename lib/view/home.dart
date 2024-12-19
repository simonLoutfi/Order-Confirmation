import 'package:flutter/material.dart';
import 'package:proto/controller/preferences_controller.dart';
import 'birthday.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:developer' as developer;


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    _setupFirebaseMessaging();
  }

  void _setupFirebaseMessaging() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    developer.log('Message received while in foreground:');
    developer.log('Title: ${message.notification?.title}');
    developer.log('Body: ${message.notification?.body}');
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    developer.log('Message opened from background:');
    developer.log('Title: ${message.notification?.title}');
    developer.log('Body: ${message.notification?.body}');
  });

  FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
    if (message != null) {
      developer.log('Notification caused app to open:');
      developer.log('Title: ${message.notification?.title}');
      developer.log('Body: ${message.notification?.body}');
    }
  });
}

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    
    PreferencesController().saveLastVisitedPage("home.dart");

    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              alignment: Alignment.topCenter,
              width: width,
              height: height,
                  child: Image.asset(
                  'assets/images/order1.png',
                  fit: BoxFit.fill,
                  width: width,
                  height: height*0.70,
                ), 
              
            ),
            SizedBox(
              width: width,
              height: height*1/3,
                child: DecoratedBox(
                  decoration:const BoxDecoration(
                      color: Colors.black, 
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 70,left: 70),
                          child: Text(
                          "Ready to confirm your package?",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                          textAlign: TextAlign.center,
                        ),
                          
                          ),
                          

                        const SizedBox(height: 20),
                        const Text(
                          "Start now by filling your order info!",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Birthday()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            minimumSize: Size(width*0.85, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: const Text("Continue",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    ),
              ),
          ],
        ),
      ),
    );
  }
}
