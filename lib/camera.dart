import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:proto/add_photo.dart';
import 'package:proto/camera2.dart';
import 'dart:developer' as developer;


class Camera extends StatefulWidget {
  final List<CameraDescription> camera;

  const Camera({
    required this.camera,
    super.key,
  });

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera.first,
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _initCamera(CameraDescription description) async{
    _controller = CameraController(description, ResolutionPreset.max, enableAudio: true);

    try{
      await _controller.initialize();
      setState((){}); 
    }
    catch(e){
      developer.log(e.toString());
    }  
  }

  void _toggleCameraLens() {
    final lensDirection =  _controller.description.lensDirection;
    CameraDescription newDescription;
    if(lensDirection == CameraLensDirection.front){
        newDescription = widget.camera.firstWhere((description) => description.lensDirection == CameraLensDirection.back);
    }
    else{
        newDescription = widget.camera.firstWhere((description) => description.lensDirection == CameraLensDirection.front);
    }

    _initCamera(newDescription);
      
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Stack(
            children: [
              SizedBox(
                width: width,
                height: height,
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: CameraPreview(_controller),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            border: Border.all(color: const Color(0xFFCCCCCC), width: 2),
                            color: Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            
                            icon: const Icon(Icons.arrow_back_ios_new_rounded, color:Color(0xFFCCCCCC)),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Addphoto(camera: widget.camera)),
                              );
                            },
                          ),
                        ),
                      ),Padding(
                        padding: const EdgeInsets.only(top: 50, right: 20),
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFCCCCCC), width: 2),
                            color: Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(onPressed: _toggleCameraLens, icon: const Icon(Icons.swap_horiz_rounded),color: const Color(0xFFCCCCCC), iconSize: 25,),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                      padding:const EdgeInsets.only(bottom: 35),
                      child: SizedBox(
                        height: 84, 
                        width: 84,  
                        child: FloatingActionButton(
                          backgroundColor: Colors.transparent, 
                          elevation: 0,
                          onPressed: () async {
                            try {
                              await _initializeControllerFuture;
                              final image = await _controller.takePicture();
                              if (!mounted) return; 
                              if (context.mounted) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>  
                                    Camera2(
                                      camera: widget.camera,
                                      image: image,
                                    ),
                                  ),
                                );
                              }
                            } catch (e) {
                              developer.log(e.toString());
                            }
                          },
                          child: Container(
                            height: 84, 
                            width: 84,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromARGB(83, 100, 96, 96),
                                width: 10,
                              ),
                              color: const Color.fromARGB(255, 255, 255, 255),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    )

                  
                ],
              ),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
