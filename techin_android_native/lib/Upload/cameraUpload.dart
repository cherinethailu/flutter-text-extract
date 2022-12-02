import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
//import 'package:mlkit/mlkit.dart';
// import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:tesseract_ocr/tesseract_ocr.dart';

class CameraClass extends StatefulWidget {
  @override
  _CameraClassState createState() => _CameraClassState();
}

class _CameraClassState extends State<CameraClass> {
  File _image;
  final picker = ImagePicker();
  String _extractedTextFromCamera = "";
  bool _scanning = false;
  Future cameraConnect() async {
    final img = await ImagePicker.pickImage(
        source: ImageSource.gallery); //changed from picker.getImage()..
    setState(() {
      if (img != null) {
        _image = File(img.path);
        print(_image);
      } else {
        print("No Image Selected.");
      }
    });
  }

  Future readTextFromCamera() async {
    setState(() {
      _scanning = true;
    });
    _extractedTextFromCamera =
        await TesseractOcr.extractText(_image.path, language: 'amh');
    setState(() {
      _scanning = false;
    });
    print(_extractedTextFromCamera);
  }

  selectImage() {
    if (_image != null) {
      return Image.file(_image);
    } else
      return Text('Double tap again to open from camera');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onDoubleTap: () {
          Vibrate.feedback(FeedbackType.heavy);
          cameraConnect();
          Vibrate.feedback(FeedbackType.heavy);
          print('double tapped');
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: Text('Camera Upload'),
            centerTitle: true,
            backgroundColor: Color(0xffb6461e5),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.read_more),
            onPressed: () {
              readTextFromCamera();
            },
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: selectImage(),
                ),
                SizedBox(height: 20),
                Center(
                  child: _scanning
                      ? SpinKitThreeBounce(
                          color: Colors.blue,
                        )
                      : SelectableText(_extractedTextFromCamera + '\n'),
                )
              ],
            ),
          ),
        ));
  }
}
