import 'dart:io';
//import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tesseract_ocr/tesseract_ocr.dart';
import 'package:file_picker/file_picker.dart';

class FileUploadClass extends StatefulWidget {
  @override
  _FileUploadClassState createState() => _FileUploadClassState();
}

class _FileUploadClassState extends State<FileUploadClass> {
  File _image;
  final picker = ImagePicker();
  var file;
  File pdf;
  bool _scanning = true;
  PDFDocument doc;
  void selectpdf() async {
    _scanning = true;
    pdf = await FilePicker.getFile();
    doc = await PDFDocument.fromFile(pdf);
    // String text = doc.getAll().toString();
    // print(text);
    _scanning = false;
    setState(() {});
    String text = await pdf.toString();
    print(text);
    print(pdf);
  }

  // final DocumentTextRecognizer cloudDocumentTextRecognizer =
  // FirebaseVision.instance.cloudDocumentTextRecognizer();
  String _extractedTextFromCamera = '';
  Future fileUpload() async {
    print('Long pressed again.');
    _image = File(await FilePicker.getFilePath(type: FileType.any));
    setState(() {
      if (_image != null) {
        //_image = _image.path;
        print(_image);
      } else {
        print("No File Selected.");
      }
    });
  }

  Future readTextFromDocument() async {
    _extractedTextFromCamera =
        await TesseractOcr.extractText(pdf.path, language: 'amh');
    print(_extractedTextFromCamera);
  }

  Future readTextFromCamera() async {
    _extractedTextFromCamera =
        await TesseractOcr.extractText(_image.path, language: 'amh');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onLongPress: () async {
          Vibrate.feedback(FeedbackType.heavy);
          selectpdf();
          setState(() {});
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: Text('PDF Upload'),
            centerTitle: true,
            backgroundColor: Color(0xffb6461e5),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.read_more),
            onPressed: () {
              setState(() {
                //readTextFromDocument();
              });
            },
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                doc == null
                    ? Center(child: Text('Please select a pdf by long press'))
                    : Container(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: _scanning
                            ? Center(
                                child: SpinKitThreeBounce(
                                color: Colors.blue,
                              ))
                            : PDFViewer(
                                document: doc,
                              ),
                      )
              ],
            ),
          ),
        ));
  }
}
