import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proto/controller/preferences_controller.dart';
import 'package:proto/riverpod.dart';
import 'package:proto/view/add_photo.dart';
import 'nickname.dart';

class Gender extends ConsumerStatefulWidget {
  const Gender({super.key});

  @override
  ConsumerState<Gender> createState() => _GenderState();
}

class _GenderState extends ConsumerState<Gender> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    PreferencesController().saveLastVisitedPage("gender.dart");

    

    return Scaffold(
      body: Center(
        child: 
           Stack(children: <Widget>[
            Container(
              decoration:const BoxDecoration(
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
              decoration:const BoxDecoration(
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
                            
                            icon:const Icon(Icons.arrow_back_ios_new_rounded, color:Color.fromARGB(255, 123, 123, 123)),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>const Nickname()),
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
                                    child:const Center(
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
                                  const Positioned.fill(
                                    child: CircularProgressIndicator(
                                      value: 0.75,
                                      color: Colors.white,
                                      strokeWidth: 2,
                                      backgroundColor: Colors.transparent, 
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
                  child:const Column(children: [
                    Text(
                      "Which gender do you identify as?",
                      style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30
                      ),
                      ),
                      SizedBox(height: 15,),
                      Text(
                        "Your gender helps us fix the issue in a more optimized way",
                        style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15
                        ),
                      )
                  ],) 
                )           

            ),
            const SizedBox(height: 50,),
            Center(
                  child: 
                    InkWell(
                      onTap: () {
                      ref.read(riverpod).setGender('male');
                        if(context.mounted){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Addphoto(),
                            ),
                          );
                        }

                      },
                      child: Container(
                      width: width*0.85,
                      height: 67,
                      decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            color: const Color.fromARGB(120, 0, 0, 0),
                            borderRadius:const BorderRadius.all(Radius.circular(15))
                          ),
                      child:const Center(
                        child: Text(
                        "Male",
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 23),
                        ),
                      ),
                      
                    ),
                  )
                  
                ),
            const SizedBox(height: 25,),
                Center(
                  child: InkWell(
                    onTap: () {
                      ref.read(riverpod).setGender('female');
                        if(context.mounted){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Addphoto(),
                            ),
                          );
                        }

                      },
                    child: Container(
                    width: width*0.85,
                    height: 67,
                    decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          color: const Color.fromARGB(120, 0, 0, 0),
                          borderRadius:const BorderRadius.all(Radius.circular(15))
                        ),
                    child: const Center(
                      child: Text(
                      "Female",
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 23),
                      ),
                    ),
                  ),
                  )
                  
                ),

            const SizedBox(height: 25,),
            Center(
                  child: InkWell(
                    onTap: () {
                      ref.read(riverpod).setGender('other');
                        if(context.mounted){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Addphoto(),
                            ),
                          );
                        }
                        
                      },
                    child: Container(
                    width: width*0.85,
                    height: 67,
                    decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          color: const Color.fromARGB(120, 0, 0, 0),
                          borderRadius:const BorderRadius.all(Radius.circular(15))
                        ),
                    child: const Center(
                      child: Text(
                      "Other",
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 23),
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
