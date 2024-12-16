import 'package:flutter/material.dart';
import 'package:proto/controller/preferences_controller.dart';
import 'package:proto/view/camera.dart';
import 'package:proto/view/gender.dart';



class Addphoto extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();

  Addphoto({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    PreferencesController().saveLastVisitedPage("Addphoto.dart");

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
                            
                            icon: const Icon(Icons.arrow_back_ios_new_rounded, color:  Color.fromARGB(255, 123, 123, 123)),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Gender()),
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
                                    child: const Center(
                                      child: Text(
                                        "100%",
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 123, 123, 123),
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Positioned.fill(
                                    child: CircularProgressIndicator(
                                      value: 1,
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
              padding:const EdgeInsets.only(left:20, top: 60, right: 20),
              child:   
                SizedBox(
                  width: width*3/4,
                  child: const Column(children: [
                    Text(
                      "Add a photo of your package",
                      style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30
                      ),
                      ),
                      
                  ],) 
                )           

            ),
            Padding(
              padding: const EdgeInsets.only(top: 70),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Camera(),
                          ),
                        );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(width * 0.85, 50), 
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255), 
                    side: const BorderSide(color: Color.fromARGB(255, 255, 255, 255), width: 1), 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), 
                    ),
                  ),
                  child: const Text(
                    "Take package photo",
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0), 
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top:50),
              child: 
                Center(
                  child: Container(
                    width: width*0.85,
                    height: 200,
                    decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          color: const Color.fromARGB(120, 0, 0, 0),
                          borderRadius: const BorderRadius.all(Radius.circular(15))
                        ),
                    child: 
                    const Padding(
                      padding: EdgeInsets.only(top:20,left: 20,right: 10,bottom: 15),
                      child:  
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Make sure that your image",
                            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),
                            ),
                            SizedBox(height: 20,),
                            Row(
                              children: [
                                Icon(Icons.check,color: Colors.grey),
                                SizedBox(width: 10,),
                                Text("Shows the package cleary",style: TextStyle(color: Colors.grey,fontSize: 16),)
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Icon(Icons.check,color: Colors.grey),
                                SizedBox(width: 10,),
                                Text("Shows the package order ID",style: TextStyle(color: Colors.grey,fontSize: 16),)
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Icon(Icons.check,color: Colors.grey),
                                SizedBox(width: 10,),
                                Text("No fake pic, objector anything else",style: TextStyle(color: Colors.grey,fontSize: 16),)
                              ],
                            )

                        ],
                      )                   

                      )

                    
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
