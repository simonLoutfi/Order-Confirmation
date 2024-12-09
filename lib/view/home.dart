import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'birthday.dart';

class MyHomePage extends StatelessWidget {
  final List<CameraDescription> camera;
  const MyHomePage({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    

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
                              MaterialPageRoute(builder: (context) => Birthday(camera: camera,)),
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
