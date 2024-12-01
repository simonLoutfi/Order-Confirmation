import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';
import 'nickname.dart';

class Birthday extends StatefulWidget {

    final List<CameraDescription> camera;
    Birthday({required this.camera});

  @override
  _BirthdayState createState() => _BirthdayState();
}

class _BirthdayState extends State<Birthday> {
  final TextEditingController dayController = TextEditingController();
  final TextEditingController monthController = TextEditingController();
  final TextEditingController yearController = TextEditingController();

  Future<void> _loadSavedValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      dayController.text = prefs.getString('birthday_day') ?? ''; 
      monthController.text = prefs.getString('birthday_month') ?? '';
      yearController.text = prefs.getString('birthday_year') ?? ''; 
    });
  }

  Future<void> _saveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('birthday_day', dayController.text);
    await prefs.setString('birthday_month', monthController.text);
    await prefs.setString('birthday_year', yearController.text);
    await prefs.setInt('ad', 1);

  }

    @override
  void initState() {
    super.initState();
    _loadSavedValues();
  }

  @override
  void dispose() {
    dayController.dispose();
    monthController.dispose();
    yearController.dispose();
    super.dispose();
  }


  String? validateInputs() {
    int? day = int.tryParse(dayController.text);
    int? month = int.tryParse(monthController.text);
    int? year = int.tryParse(yearController.text);

    if (day == null || day < 1 || day > 31) {
      return "Day must be between 1 and 31.";
    }

    if (month == null || month < 1 || month > 12) {
      return "Month must be between 1 and 12.";
    }

    int currentYear = DateTime.now().year;

    if (year == null || year > currentYear) {
      return "Year cannot be greater than the current year.";
    }

    if (month == 2 && day > 29){
      return "February has max 29 days";
    }

    return null;
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
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/stock.png'),
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
                          
                          icon: Icon(Icons.close, color: const Color.fromARGB(255, 123, 123, 123)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MyHomePage(camera: widget.camera,)),
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
                                      width: 2, // Grey border thickness
                                    ),
                                    color: Colors.transparent,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "25%",
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
                                    value: 0.25,
                                    color: Colors.white,
                                    strokeWidth: 2,
                                    backgroundColor: Colors.transparent, // Ensure transparency behind progress
                                  ),
                                ),
                              ],
                            )

                      

                    ),
                  ],
                ),
              SizedBox(
                width: width*(2/3),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 70),
                  child: Text(
                    "When's your birthday?",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      
                    ),
                  ),
                ),

              ),
                
                Padding(
                  padding: const EdgeInsets.only(top: 70, left: 20),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 80,
                            decoration: BoxDecoration(border: Border.all(color: Colors.grey),borderRadius: BorderRadius.circular(15)),
                            child: TextField(
                              controller: dayController,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color.fromARGB(113, 0, 0, 0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text("Day", style: TextStyle(fontSize: 16, color: Colors.grey)),
                        ],
                      ),
                      
                      const SizedBox(width: 20),
                      Column(
                        children: [
                          Container(
                            width: 80,
                            decoration: BoxDecoration(border: Border.all(color: Colors.grey),borderRadius: BorderRadius.circular(15)),
                            child: TextField(
                              controller: monthController,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color.fromARGB(113, 0, 0, 0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text("Month", style: TextStyle(fontSize: 16, color: Colors.grey)),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Column(
                        children: [
                          Container(
                            width: 100,
                            decoration: BoxDecoration(border: Border.all(color: Colors.grey),borderRadius: BorderRadius.circular(15)),
                            child: TextField(
                              controller: yearController,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color.fromARGB(113, 0, 0, 0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text("Year", style: TextStyle(fontSize: 16, color: Colors.grey))
                        ],
                      ),
                      
                      
                      
                    ],
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: FloatingActionButton(
          onPressed: () async {
            String? validationMessage = validateInputs();

            if (validationMessage != null) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Input Error"),
                    content: Text(validationMessage),
                    actions: <Widget>[
                      TextButton(
                        child: Text("OK"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            } else {
              await _saveValues();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Nickname(
                    camera: widget.camera,
                  ),
                ),
              );
            }
          },
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Icon(
            Icons.arrow_forward,
            size: 40,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
