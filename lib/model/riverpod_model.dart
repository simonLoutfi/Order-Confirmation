import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class RiverpodModel extends ChangeNotifier {
  String gender;
  String image;
  List<CameraDescription> camera;

  RiverpodModel({
    required this.gender,
    required this.image,
    required this.camera,
  });

  setCamera(List<CameraDescription> camera){
    this.camera=camera;
  }

  setImage(String image){
    this.image=image;
  }

  setGender(String gender){
    this.gender=gender;
  }
  
}