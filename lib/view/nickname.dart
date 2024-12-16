import 'package:flutter/material.dart';
import 'package:proto/controller/preferences_controller.dart';
import 'package:proto/view/birthday.dart';
import 'package:proto/view/gender.dart';

class Nickname extends StatefulWidget {
  const Nickname({super.key});
  @override
  State<Nickname> createState() => _NicknameState();
}

class _NicknameState extends State<Nickname> {
  final TextEditingController nameController = TextEditingController();

  Future<void> _loadSavedValues() async {
    nameController.text =await PreferencesController().loadSavedName();
  }

  @override
  void initState() {
    super.initState();
    _loadSavedValues();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    final pad=width*0.075;
    PreferencesController().saveLastVisitedPage("nickname.dart");


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
                            
                            icon:const Icon(Icons.arrow_back_ios_new_rounded, color: Color.fromARGB(255, 123, 123, 123)),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const Birthday()),
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
                                        "50%",
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
                                      value: 0.5,
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
              padding: EdgeInsets.only(left:pad, top: 70, right: 20),
              child:  
              SizedBox(
                width: width*0.5,
                child: const Text(
                  "Enter your name",
                  style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30
                   ),
                  ),
              )            
                
            ),
            Padding(
              padding: EdgeInsets.only(top:70,left: pad),
              child: 
                Container(
                    width: width*0.85,
                    decoration: BoxDecoration(border: Border.all(color: Colors.grey),borderRadius: BorderRadius.circular(15)),
                    child: TextField(
                      controller: nameController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        filled: true, 
                        fillColor: const Color.fromARGB(113, 0, 0, 0), 
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),),
                      ),
                      style:const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 35),
                    ),
                  
                )

            ),
            
              ],
            )
            
          ]),  

      ),
      floatingActionButton: Container(
        decoration:const BoxDecoration(
          shape: BoxShape.circle, 
          color: Colors.white,    
        ),
        child: FloatingActionButton(
          onPressed: () async {
            if(nameController.text.isEmpty){
              ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Enter you name!"),
                    ),
                  );

            }else{
              await PreferencesController().saveName(nameController.text); 
              if (context.mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>const Gender(),
                ),
              );
              }
            }

          },
          elevation: 0,           
          backgroundColor: Colors.transparent, 
          child:const Icon(
            Icons.arrow_forward,
            size: 40,            
            color: Colors.black,  
          ),
        ),
      ),




    );
  }
}
