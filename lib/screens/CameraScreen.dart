import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/screens/CameraView.dart';
import 'package:whatsapp/screens/VideoView.dart';

List<CameraDescription> cameras = [];

class CameraScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CameraScreenState();
  }
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  late Future<void> cameraValue;

  bool isRecording = false;
  bool isFlashOn = false;
  bool isCameraFront = true;
  double transform = pi;

  @override
  void initState() {
    super.initState();
    switchCamera(isCameraFront ? 1 : 0);
  }

  @override
  void dispose() {
    super.dispose();
    _cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: cameraValue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: CameraPreview(
                    _cameraController,
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          Positioned(
            bottom: 0,
            child: Container(
              padding: EdgeInsets.only(bottom: 5, top: 5),
              color: Colors.black,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              isFlashOn = !isFlashOn;
                            });
                            _cameraController.setFlashMode(
                                isFlashOn ? FlashMode.torch : FlashMode.off);
                          },
                          icon: Icon(
                            isFlashOn ? Icons.flash_on : Icons.flash_off,
                            color: Colors.white,
                            size: 28,
                          )),
                      GestureDetector(
                          onLongPress: () async {
                            if (!isRecording) {
                              print(await _cameraController
                                  .startVideoRecording()
                                  .toString());

                              setState(() {
                                isRecording = true;
                              });
                            }
                          },
                          onLongPressUp: () async {
                            if (isRecording) {
                              XFile path =
                                  await _cameraController.stopVideoRecording();

                              setState(() {
                                isRecording = false;
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VideoViewPage(
                                        path: path.path.toString()),
                                  ));
                              print(path);
                            }
                          },
                          onTap: () {
                            if (!isRecording) takePhoto(context);
                          },
                          child: isRecording
                              ? Icon(
                                  Icons.radio_button_on,
                                  color: Colors.red,
                                  size: 70,
                                )
                              : Icon(
                                  Icons.panorama_fish_eye,
                                  color: Colors.white,
                                  size: 70,
                                )),
                      IconButton(
                          onPressed: () async {
                            setState(() {
                              isCameraFront = !isCameraFront;
                              transform += pi;
                            });
                            switchCamera(isCameraFront ? 1 : 0);
                          },
                          icon: Transform.rotate(
                            angle: transform,
                            child: Icon(
                              Icons.flip_camera_ios,
                              color: Colors.white,
                              size: 28,
                            ),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Hold for video ',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void takePhoto(BuildContext context) async {
    XFile path = await _cameraController.takePicture();

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CameraViewPage(path: path.path.toString()),
        ));
  }

  void switchCamera(int cameraNumber) {
    _cameraController =
        CameraController(cameras[cameraNumber], ResolutionPreset.ultraHigh);
    cameraValue = _cameraController.initialize();
  }
}
