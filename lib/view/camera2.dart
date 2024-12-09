import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:proto/controller/user_controller.dart';
import 'package:proto/model/user_model.dart';
import 'package:proto/view/phone.dart';
import 'package:proto/view/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'camera.dart';


class Camera2 extends StatefulWidget {
  final XFile image;
  final List<CameraDescription> camera;

  final AdSize adSize;
  final String adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111' 
      : 'ca-app-pub-3940256099942544/2935281174'; 

  Camera2({
    required this.image,
    required this.camera,
    this.adSize = AdSize.banner,
    super.key,
  });

  @override
  State<Camera2> createState() => _Camera2State();
}

class _Camera2State extends State<Camera2> {
  BannerAd? _bannerAd;
  bool? showAd, addedPhone, acc;
  int? localShowAd=1;
  String? day,month,year,name,gender;

  Future<void> _loadSavedValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    day=prefs.getString('birthday_day');
    month=prefs.getString('birthday_month');
    year=prefs.getString('birthday_year');
    name=prefs.getString('nickname');
    gender=prefs.getString('gender');
  }

  Future<void> _initializeShowAd() async {
    final value = await UserController().getLock();
    setState(() {showAd=value;});
  }

  Future<void> _initializeSettings() async {
    addedPhone = await UserController().getPhone();
    acc = await UserController().getName();
  }

  @override
  void initState() {
    super.initState();
    _loadSavedValues();
    _initializeShowAd();
    if (localShowAd == 1){
      _loadAd();
    }
    
    
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  void _loadAd() {
  final bannerAd = BannerAd(
    size: widget.adSize,
    adUnitId: widget.adUnitId,
    request: const AdRequest(),
    listener: BannerAdListener(
      onAdLoaded: (ad) {
        debugPrint('BannerAd loaded.');
        if (!mounted) {
          ad.dispose();
          return;
        }
        setState(() {
          _bannerAd = ad as BannerAd;
        });
      },
      onAdFailedToLoad: (ad, error) {
        debugPrint('BannerAd failed to load: ${error.toString()}');
        debugPrint('Error Domain: ${error.domain}');
        debugPrint('Error Code: ${error.code}');
        debugPrint('Error Message: ${error.message}');
        debugPrint('Response Info: ${error.responseInfo}');
        
        ad.dispose();
        setState(() {
          _bannerAd = null;
        });
      },
    ),
  );

  bannerAd.load();
}



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    _initializeSettings();
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.file(
              File(widget.image.path),
              fit: BoxFit.cover,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             Padding(
                      padding: const EdgeInsets.only(top: 50, left: 20),
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFCCCCCC), width: 2),
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          
                          icon:const Icon(Icons.arrow_back_ios_new_rounded, color:Color(0xFFCCCCCC)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Camera(camera: widget.camera,)),
                            );
                          },
                        ),
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.only(top: 50, right: 20),
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color(0xFFCCCCCC), width: 2),
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.settings_outlined,
                      color: Color(0xFFCCCCCC),
                    ),
                    onPressed: () {
                      if(acc!){
                          if(addedPhone!){
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Settings(
                                camera: widget.camera,
                                image: widget.image,
                              ),
                            ),
                          );
                        }else{
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Phone(
                                camera: widget.camera,
                                image: widget.image,
                              ),
                            ),
                          );
                        }
                      }
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Create an account first by clicking the banner x button"),
                                      ),
                                    );
                      }
                      
                      
                    },
                  ),
                ),
              ),
            ],
          ),
          if (showAd != true || localShowAd==0)
          
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: width,
                  height: height * 0.15,
                  color: Colors.transparent, 
                  
                ),
            )
            else 
            Align(
              alignment: Alignment.bottomCenter,
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: width,
                      height: height * 0.15,
                      color: Colors.black, 
                      child: _bannerAd == null
                          ? const SizedBox() 
                          : AdWidget(ad: _bannerAd!),
                    ),
                  ),
                  Positioned(
                    bottom: height * 0.15, 
                    right: 1, 
                    child: 
                    InkWell(
                      onTap: () {
                        final user = UserModel(day: day!, month: month!, year: year!, name: name!, gender: gender!,image: widget.image.path);
                        UserController().createUser(user);
                        setState(() {
                            localShowAd = 0; 
                            _bannerAd?.dispose(); 
                            _bannerAd = null;
                        });
                      },
                      child: Container(
                      height: 20,
                      width: 80,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage('assets/images/button.jpg'),
                                ),
                         
                      ),
                    )
                  
                    ),
                  ),
                ],
              ),
              
              ),
        ],
      ),
    );
  }
}
