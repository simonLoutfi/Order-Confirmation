import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:proto/controller/authentication_controller.dart';
import 'package:proto/view/camera2.dart';
import 'package:proto/view/otp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'dart:developer' as developer;



class Phone extends StatefulWidget {
    final List<CameraDescription> camera;
    final XFile image;

    const Phone({super.key, required this.camera, required this.image});

  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  final TextEditingController _controller = TextEditingController();
  String initialCountry = 'LB';
  PhoneNumber number = PhoneNumber(isoCode: 'LB', dialCode: '+961', phoneNumber: '');
  String? validatedNumber;

  Future<void> _saveValues(PhoneNumber phoneNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('phone', phoneNumber.phoneNumber! );
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    final pad=width*0.075;


    return Scaffold(
      body: Center(
        child: 
           Stack(children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    'assets/images/stock.png',
                  ),
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
                            
                            icon:const Icon(Icons.arrow_back_ios_new_rounded, color: Color.fromARGB(255, 123, 123, 123)),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Camera2(camera: widget.camera,image: widget.image,)),
                              );
                            },
                          ),
                        ),
                      ),
              
            Padding(
              padding: EdgeInsets.only(left:pad, top: 70, right: 20),
              child:  
              SizedBox(
                width: width*0.7,
                child: const Text(
                  "Enter your phone number",
                  style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30
                   ),
                  ),
              )            
                
            ),
            Padding(
              padding: EdgeInsets.only(top: 70, left: pad),
              child: Container(
                width: width * 0.85,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: InternationalPhoneNumberInput(
                onInputChanged: (PhoneNumber value) {
                  developer.log("Phone Number Input Changed: ${value.phoneNumber}");
                  
                },
                onInputValidated: (bool isValid) {
                  developer.log("Phone Number is Valid: $isValid");
                },
                selectorConfig:const SelectorConfig(
                  selectorType: PhoneInputSelectorType.DROPDOWN,
                ),
                ignoreBlank: false,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                selectorTextStyle: const TextStyle(color: Colors.white,backgroundColor: Colors.black),
                initialValue: number,
                textFieldController: _controller,
                formatInput: true,
                keyboardType: TextInputType.phone,
                inputDecoration:const InputDecoration(
                  labelText: 'Phone Number',
                  labelStyle: TextStyle(color: Colors.white), 
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey), 
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), 
                  ),
                  
                ),
                textStyle: const TextStyle(
                  color: Colors.white, 
                  fontSize: 16,       
                ),
              ),
              ),
              
            ),
             Padding(
              padding: EdgeInsets.only(top: 30, left: pad),
              child:
            ElevatedButton(
              onPressed: () async {
                              if(_controller.text.isEmpty){
                                ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Enter you phone number!"),
                                      ),
                                    );

                              }else{
                                try {
                                  PhoneNumber parsedNumber = await PhoneNumber.getRegionInfoFromPhoneNumber(
                                    _controller.text,
                                    initialCountry,
                                  );
                                  validatedNumber = parsedNumber.phoneNumber;

                                  _saveValues(parsedNumber);

                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          validatedNumber != null
                                              ? "Valid number: $validatedNumber"
                                              : "Invalid phone number",
                                        ),
                                      ),
                                    );

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Otp(
                                          camera: widget.camera,
                                          image: widget.image,
                                        ),
                                      ),
                                    );
                                  }
                                  if (validatedNumber != null) {
                                    AuthenticationController().phoneAuthentication(validatedNumber);
                                  }

                                } catch (e) {
                                  if(context.mounted){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Invalid phone number format!"),
                                    ),
                                  );
                                  }
                                  
                                }

                                
                                
                              }

                            },

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                minimumSize: Size(width*0.85, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text("Confirm",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
            ),)

              ],
            )
            
          ]),  

      ),
     
    );
  }
}
