//import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proto/controller/preferences_controller.dart';
import 'package:proto/riverpod.dart';
//import 'package:flutter/services.dart';
//import 'package:gallery_saver/gallery_saver.dart';
//import 'package:path_provider/path_provider.dart';
import 'package:proto/view/add_photo.dart';
import 'package:proto/view/camera2.dart';
import 'dart:developer' as developer;


class Camera extends ConsumerStatefulWidget  {
  const Camera({super.key});

  @override
  ConsumerState<Camera> createState() => _CameraState();
}

class _CameraState extends ConsumerState<Camera> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  List<CameraDescription> camera=[];

  @override
  void initState() {
    super.initState();
      final cameraProvider = ref.read(riverpod);
      camera = cameraProvider.camera;
    _controller = CameraController(
      camera.first,
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
        newDescription = camera.firstWhere((description) => description.lensDirection == CameraLensDirection.back);
    }
    else{
        newDescription = camera.firstWhere((description) => description.lensDirection == CameraLensDirection.front);
    }

    _initCamera(newDescription);
      
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    camera=(ref.watch(riverpod).camera);
    PreferencesController().saveLastVisitedPage("camera.dart");


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
                                MaterialPageRoute(builder: (context) => Addphoto()),
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
                          child: IconButton(onPressed: _toggleCameraLens, icon: const Icon(Icons.repeat_rounded),color: const Color(0xFFCCCCCC), iconSize: 25,),
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
                              // final ByteData bytes = await rootBundle.load(image.path);
                              // final Uint8List imageData = bytes.buffer.asUint8List();
                              // final tempDir = await getTemporaryDirectory();
                              // final tempPath = '${tempDir.path}/temp_image.jpg';

                              // final tempFile = File(tempPath);
                              // await tempFile.writeAsBytes(imageData);
                              // await GallerySaver.saveImage(tempFile.path);
                              await PreferencesController().saveImage(image.path);
                                if (context.mounted) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>  
                                      Camera2(),
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
