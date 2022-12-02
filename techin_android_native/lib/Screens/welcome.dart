//Welcome page
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter_vibrate/flutter_vibrate.dart';
import '../Upload/cameraUpload.dart';
import '../Upload/fileUploader.dart';

void main() {
  runApp(Welcome());
}

class Welcome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Welcome();
  }
}

class _Welcome extends State<Welcome> {
  File cameraImage;

  Widget placeHolderBeforeImage() {
    return Column(
      children: [
        Text(
          'Double tap the screen anywhere to open camera | ካሜራውን ለመክፈት በ ስክሪኑ ላይ ሁለቴ ይጫኑ። ',
          style: TextStyle(
              color: Color(0xffb6461e5),
              fontSize: 18,
              fontStyle: FontStyle.italic),
        ),
        SizedBox(height: 20),
        Text(
          'OR | ወይም ',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        SizedBox(height: 20),
        Text(
          'Long press the screen anywhere to open from files | ከ ሰነድ ውስጥ ለመክፈት ስክሪኑን ጫን ብለው ይቆዩ። ',
          style: TextStyle(
              color: Color(0xffb6461e5),
              fontSize: 18,
              fontStyle: FontStyle.italic),
        ),
      ],
    );
  }

  filePicker() {}
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    var route;
    return Scaffold(
      //debugShowCheckedModeBanner: false,
      //onGenerateRoute: route.generateRoute,
      //initialRoute: '/',
      body: GestureDetector(
        onDoubleTap: () {
          Vibrate.feedback(FeedbackType.heavy);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CameraClass()));

          print("Double tapped"); //double tap
        },
        onLongPress: () {
          Vibrate.feedback(FeedbackType.heavy);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => FileUploadClass()));
          print('Long pressed');
        },
        child: Builder(
          builder: (context) => Scaffold(
            drawer: Drawer(
              child: IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    //Navigator.pop(context);
                  }),
            ),
            body: SingleChildScrollView(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 20),
                        Card(
                          margin: EdgeInsets.all(11),
                          elevation: 30,
                          shadowColor: Color(0xffb6461e5),
                          color: Color(0xffb6461e5),
                          child: Column(children: [
                            SizedBox(height: 50),
                            Text(
                              'TECH-IN EYE | ቴክ-ኢን አይ',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 20),
                            Positioned(
                              left: .1,
                              top: .1,
                              right: .0,
                              child: Center(
                                child: CircleAvatar(
                                    radius: 100,
                                    backgroundImage: AssetImage(
                                      'assets/tie-logo.jpg',
                                    )),
                              ),
                            ),
                          ]),
                        ),
                        SizedBox(height: 50),
                        Container(
                          child: placeHolderBeforeImage(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
