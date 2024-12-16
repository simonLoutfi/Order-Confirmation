import 'package:flutter/material.dart';
import 'package:proto/controller/preferences_controller.dart';
import 'home.dart';
import 'nickname.dart';

class Birthday extends StatefulWidget {
  const Birthday({super.key});

  @override
  BirthdayState createState() => BirthdayState();
}

class BirthdayState extends State<Birthday> {
  final TextEditingController dayController = TextEditingController();
  final TextEditingController monthController = TextEditingController();
  final TextEditingController yearController = TextEditingController();

  Future<void> _loadSavedValues() async {
    dayController.text = await PreferencesController().loadSavedDay();
    monthController.text = await PreferencesController().loadSavedMonth();
    yearController.text = await PreferencesController().loadSavedYear();
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
    int currentMonth = DateTime.now().month;
    int currentDay = DateTime.now().day;

    int minimumYear = currentYear - 100;

    if (year == null || year > currentYear) {
      return "Year cannot be greater than the current year.";
    }

    if (year < minimumYear) {
      return "Year cannot be less than $minimumYear.";
    }

    if (month == 2 && day > 29) {
      return "February has max 29 days.";
    }

    if (month == 2 && day > 28 && !(year % 4 == 0 && (year % 100 != 0 || year % 400 == 0))) {
      return "February has max 28 days in the given year.";
    }

  if (year == currentYear) {
    if (month > currentMonth) {
      return "Month cannot be greater than the current month.";
    } else if (month == currentMonth && day > currentDay) {
      return "Day cannot be greater than today's date.";
    }
  }

  return null;
}


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    PreferencesController().saveLastVisitedPage("birthday.dart");
    

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
                          
                          icon: const Icon(Icons.close, color: Color.fromARGB(255, 123, 123, 123)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>const MyHomePage()),
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
                                      "25%",
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
                                    value: 0.25,
                                    color: Colors.white,
                                    strokeWidth: 2,
                                    backgroundColor: Colors.transparent, 
                                  ),
                                ),
                              ],
                            )

                      

                    ),
                  ],
                ),
              SizedBox(
                width: width*(2/3),
                child: const Padding(
                  padding: EdgeInsets.only(left: 20, top: 70),
                  child: Text(
                    "When's your birthday?",
                    style: TextStyle(
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
                          const Text("Day", style: TextStyle(fontSize: 16, color: Colors.grey)),
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
                          const Text("Month", style: TextStyle(fontSize: 16, color: Colors.grey)),
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
                          const Text("Year", style: TextStyle(fontSize: 16, color: Colors.grey))
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
        decoration:const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: FloatingActionButton(
          onPressed: () async {
            String? validationMessage = validateInputs();

            if (validationMessage != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(validationMessage),
                    ),
                  );
            } else {
                await PreferencesController().saveBirthday(dayController.text, monthController.text, yearController.text);

                if (!mounted) return; 
                
                if (context.mounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>const Nickname(),
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
