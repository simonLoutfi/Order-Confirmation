import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:proto/controller/otp_controller.dart';
import 'package:proto/view/phone.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class Otp extends StatefulWidget {

    final List<CameraDescription> camera;
    final XFile image;

    const Otp({super.key, required this.camera, required this.image});

  @override
  OtpState createState() => OtpState();
}

class OtpState extends State<Otp> {

    @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/stock.png'),
                ),
              ),
              height: height,
            ),
            Container(
              height: height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    Color.fromARGB(200, 0, 0, 0),
                    Color.fromARGB(200, 59, 2, 65),
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50, left: 20),
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color.fromARGB(255, 123, 123, 123), width: 2),
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          
                          icon: const Icon(Icons.close, color: Color.fromARGB(255, 123, 123, 123)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Phone(camera: widget.camera,image: widget.image,)),
                            );
                          },
                        ),
                      ),
                    
                ),
              SizedBox(
                width: width*0.9,
                child: const Padding(
                  padding: EdgeInsets.only(left: 20, top: 70),
                  child: Text(
                    "Enter the OTP number you received on the entered phone number",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      
                    ),
                  ),
                ),

              ),
                
                Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: 
                  OtpTextField(
                      numberOfFields: 6,
                      borderColor: Colors.grey,
                      showFieldAsBox: true, 
                      onCodeChanged: (String code) {         
                      },
                      onSubmit: (String verificationCode){
                        OTPController(camera: widget.camera,image: widget.image).verifyOTP(verificationCode,context);

                      }, 
                  ),
                 
                ),
              ],
            ),
          ],
        ),
      ),
    
    );
  }
}
