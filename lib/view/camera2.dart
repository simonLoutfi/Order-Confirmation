import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gal/gal.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:proto/controller/preferences_controller.dart';
import 'package:proto/controller/user_controller.dart';
import 'package:proto/model/user_model.dart';
import 'package:proto/riverpod.dart';
import 'package:proto/view/phone.dart';
import 'package:proto/view/settings.dart';
import 'camera.dart';


class Camera2 extends ConsumerStatefulWidget {
  final AdSize adSize;
  final String adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111' 
      : 'ca-app-pub-3940256099942544/2935281174'; 

  Camera2({
    this.adSize = AdSize.banner,
    super.key,
  });

  @override
  ConsumerState<Camera2> createState() => _Camera2State();
}

class _Camera2State extends ConsumerState<Camera2> {
  BannerAd? _bannerAd;
  bool? showAd, addedPhone, acc;
  int? localShowAd=1;
  String? day,month,year,name,gender;
  String? imagePath;

  Future<void> _loadSavedValues() async {
    day=await PreferencesController().loadSavedDay();
    month=await PreferencesController().loadSavedMonth();
    year=await PreferencesController().loadSavedYear();
    name=await PreferencesController().loadSavedName();
    imagePath=await PreferencesController().loadSavedImage();
    gender=ref.watch(riverpod).gender;
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
    PreferencesController().saveLastVisitedPage("camera2.dart");

    return Scaffold(
      body: imagePath == null
        ? const Center(
            child: CircularProgressIndicator(), 
          )
          : Stack(
        children: [
          Positioned.fill(
            child: Image.file(
              File(imagePath!),
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
                              MaterialPageRoute(builder: (context) => const Camera()),
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
                              builder: (context) =>const Settings(),
                            ),
                          );
                        }else{
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>const Phone(),
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
                      onTap: () async {
                        await Gal.putImage(await PreferencesController().loadSavedImage());
                        final user = UserModel(day: day!, month: month!, year: year!, name: name!, gender: gender!,image: imagePath!);
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
