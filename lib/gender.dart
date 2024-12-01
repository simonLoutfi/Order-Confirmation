import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:proto/addPhoto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'nickname.dart';

class Gender extends StatefulWidget {
    final List<CameraDescription> camera;


    Gender({required this.camera});

  @override
  State<Gender> createState() => _GenderState();
}

class _GenderState extends State<Gender> {

  Future<void> _saveValues(gender) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('gender', gender);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    

    return Scaffold(
      body: Center(
        child: 
           Stack(children: <Widget>[
            Container(
              decoration: BoxDecoration(
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
              decoration: BoxDecoration(
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
              Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            
                            icon: Icon(Icons.arrow_back_ios_new_rounded, color: const Color.fromARGB(255, 123, 123, 123)),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Nickname(camera: widget.camera)),
                              );
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50, right: 20),
                        child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color.fromARGB(255, 123, 123, 123),
                                        width: 2, 
                                      ),
                                      color: Colors.transparent,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "75%",
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 123, 123, 123),
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: CircularProgressIndicator(
                                      value: 0.75,
                                      color: Colors.white,
                                      strokeWidth: 2,
                                      backgroundColor: Colors.transparent, // Ensure transparency behind progress
                                    ),
                                  ),
                                ],
                              ),
                    )
                  
                ],
            ),
            Padding(
              padding:const EdgeInsets.only(left:20, top: 70, right: 20),
              child:   
                SizedBox(
                  width: width*0.7,
                  child:Column(children: [
                    Text(
                      "Which gender do you identify as?",
                      style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30
                      ),
                      ),
                      SizedBox(height: 15,),
                      Text(
                        "Your gender helps us fix the issue in a more optimized way",
                        style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15
                        ),
                      )
                  ],) 
                )           

            ),
            SizedBox(height: 50,),
            Center(
                  child: 
                    InkWell(
                      onTap: () {
                        _saveValues("male");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Addphoto(
                              camera: widget.camera,
                            ),
                          ),
                        );
                      },
                      child: Container(
                      width: width*0.85,
                      height: 67,
                      decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            color: const Color.fromARGB(120, 0, 0, 0),
                            borderRadius: BorderRadius.all(Radius.circular(15))
                          ),
                      child: Center(
                        child: Text(
                        "Male",
                        style:const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 23),
                        ),
                      ),
                      
                    ),
                  )
                  
                ),
            SizedBox(height: 25,),
                Center(
                  child: InkWell(
                    onTap: () {
                        _saveValues("female");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Addphoto(
                              camera: widget.camera,
                            ),
                          ),
                        );
                      },
                    child: Container(
                    width: width*0.85,
                    height: 67,
                    decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          color: const Color.fromARGB(120, 0, 0, 0),
                          borderRadius: BorderRadius.all(Radius.circular(15))
                        ),
                    child: Center(
                      child: Text(
                      "Female",
                      style:const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 23),
                      ),
                    ),
                  ),
                  )
                  
                ),

            SizedBox(height: 25,),
            Center(
                  child: InkWell(
                    onTap: () {
                        _saveValues("other");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Addphoto(
                              camera: widget.camera,
                            ),
                          ),
                        );
                      },
                    child: Container(
                    width: width*0.85,
                    height: 67,
                    decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          color: const Color.fromARGB(120, 0, 0, 0),
                          borderRadius: BorderRadius.all(Radius.circular(15))
                        ),
                    child: Center(
                      child: Text(
                      "Other",
                      style:const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 23),
                      ),
                    ),
                  ),
                  )
                  
                  
                ),
              ],
            )
            
          ]),  

      ),
    );
  }
}
