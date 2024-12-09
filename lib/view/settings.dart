import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:proto/controller/user_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'camera2.dart';

class Settings extends StatefulWidget {
  final XFile image;
  final List<CameraDescription> camera;

  const Settings({
    required this.image,
    required this.camera,
    super.key,
  });

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final InAppReview _inAppReview = InAppReview.instance;
  String day='',month='',year='',name='';
  String phone='',feedback='';
  double rating=0;

  final Map<int, String> monthNames = {
    1: 'Jan',
    2: 'Feb',
    3: 'Mar',
    4: 'Apr',
    5: 'May',
    6: 'Jun',
    7: 'Jul',
    8: 'Aug',
    9: 'Sep',
    10: 'Oct',
    11: 'Nov',
    12: 'Dec',
  };

  Future<void> _requestReview() => _inAppReview.openStoreListing(appStoreId: 'com.example.app');

  Future<void> _loadSavedValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    setState(() {
      day = prefs.getString('birthday_day') ?? ''; 
      year = prefs.getString('birthday_year') ?? ''; 
      name = prefs.getString('nickname') ?? ''; 
      phone = prefs.getString('phone') ?? ''; 

      final monthValue = prefs.getString('birthday_month') ?? '';
      if (monthValue.isNotEmpty) {
        int? numericMonth = int.tryParse(monthValue);
        month = numericMonth != null && monthNames.containsKey(numericMonth)
            ? monthNames[numericMonth]!
            : ''; 
      }
    }
    );
  }


  Future<void> _saveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('ad', 0);

  }

  Future<void> _initializeSettings() async {
    rating = await UserController().getRating();
    feedback = await UserController().getFeedback();
  }

  @override
  void initState() {
    super.initState();
    _loadSavedValues();
    
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    UserController().addPhoneUser(phone);
    _initializeSettings();


    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
              color: Colors.black,
              height: height,
              width: width,
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
                      border: Border.all(
                        color: const Color.fromARGB(255, 123, 123, 123),
                        width: 2,
                      ),
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Color.fromARGB(255, 123, 123, 123),
                      ),
                      onPressed: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Camera2(
                            camera: widget.camera,
                            image: widget.image,
                          ),
                        ),
                      );
                      },
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 35, left: 20),
                  child: Text(
                    "Settings",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: width * 0.85,
                    decoration: const BoxDecoration(
                      color:Color.fromARGB(255, 44, 44, 44),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: width*0.85,
                          padding: const EdgeInsets.all(15),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey,
                                width: 2,
                              ),
                            ),
                          ),
                          child:InkWell(
                            onTap: () async {
                                try {
                                  final isLocked = await UserController().getLock();

                                  if (!isLocked) {
                                    if(mounted){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text("App already unlocked"),
                                        ),
                                      );
                                    }

                                  } else {
                                      if(mounted){
                                        showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            scrollable: true,
                                            title: const Text('Confirmation'),
                                            content: const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                "Are you sure you want to unlock the app?",
                                                style: TextStyle(fontSize: 25),
                                              ),
                                            ),
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () => Navigator.pop(context),
                                                child: const Text("Cancel"),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  UserController().setLock();
                                                  _saveValues();
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => Camera2(
                                                        camera: widget.camera,
                                                        image: widget.image,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: const Text("Confirm"),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                    
                                  }
                                } catch (e) {
                                  if(mounted){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("An error occurred: $e"),
                                    ),
                                  );
                                  }
                                  
                                }
                              },

                              child:
                                  
                                const Text(
                                "Unlock App",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                                
                              ),
                              ) 
                          ), 
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                double selectedRating =  rating;
                                final TextEditingController feedbackController = TextEditingController();
                                feedbackController.text=feedback;
                                return StatefulBuilder(
                                  builder: (context, setState) {
                                    return AlertDialog(
                                      title: const Text("Rate Us"),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          RatingBar.builder(
                                            initialRating: selectedRating,
                                            minRating: 0.5,
                                            allowHalfRating: true,
                                            direction: Axis.horizontal,
                                            itemCount: 5,
                                            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                                            itemBuilder: (context, _) => const Icon(
                                              Icons.star,
                                              color: Colors.yellow,
                                            ),
                                            onRatingUpdate: (rating) {
                                              setState(() {
                                                selectedRating = rating;
                                              });
                                            },
                                          ),
                                          if (selectedRating > 0 && selectedRating < 4)
                                            Padding(
                                              padding: const EdgeInsets.only(top: 10),
                                              child: TextField(
                                                controller: feedbackController,
                                                decoration: const InputDecoration(
                                                  labelText: "Feedback",
                                                  border: OutlineInputBorder(),
                                                ),
                                                maxLines: 3,
                                              ),
                                            ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          child: const Text("Cancel"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                        ElevatedButton(
                                          child: Text(selectedRating >= 4 ? "Review" : "Submit"),
                                          onPressed: () {
                                            UserController().setRate(selectedRating, feedbackController.text);
                                            if (selectedRating >= 4) {
                                              _requestReview();
                                            } else if (feedbackController.text.isNotEmpty) {
                                              Navigator.pop(context);
                                            } else {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(
                                                  content: Text("Please provide feedback."),
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            child: const Text(
                              "Rate Us",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                 const Padding(
                  padding: EdgeInsets.only(top: 35, left: 20),
                  child: Text(
                    "My Account",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: width * 0.85,
                    decoration:const BoxDecoration(
                      color:Color.fromARGB(255, 44, 44, 44),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        Container(
                          width: width*0.85,
                          padding: const EdgeInsets.all(15),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey,
                                width: 2,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Username",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16
                                ),
                              ),
                              Text(
                                name,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                            ],
                          )
                          
                        ),
                        
                        Container(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Birthday",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "$day $month $year",
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              
                            ],
                          )
                        ),
                      ],
                    ),
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
