import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:proto/settings.dart';
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
  int? showAd;
  int? localShowAd=1;

  Future<void> _loadSavedValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      showAd = (prefs.getInt('ad') ?? '') as int?; 
    });
  }

  @override
  void initState() {
    super.initState();
    _loadSavedValues();
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Settings(
                            camera: widget.camera,
                            image: widget.image,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          if (showAd != 1 || localShowAd==0)
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
