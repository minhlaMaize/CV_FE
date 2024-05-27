import 'package:cv_fe/result.dart';
import 'package:cv_fe/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 150.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            //
            // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
            // action in the IDE, or press "p" in the console), to see the
            // wireframe for each widget.
            children: <Widget>[
              Text(
                "DOG OR CAT?",
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: 50.h,
                    shadows: [const Shadow()]),
              ),
              Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 30.h, vertical: 10.h),
                    child: SizedBox(
                      height: 50.h,
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {_handleTakePhoto();},
                        style: const ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(Color(0xff028391))),
                        child: Text("Take photo",
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.bold,
                                fontSize: 32.h,
                                color: Colors.white)),
                      ),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 30.h, vertical: 10.h),
                    child: SizedBox(
                      height: 50.h,
                      width: double.infinity,
                      child: OutlinedButton(
                          onPressed: () {_handleImageFromGallery();},
                          style: const ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(Color(0xffFEAE6F))),
                          child: Text("Image from gallery",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32.h,
                                  color: Colors.white))),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Future<void> _handleTakePhoto() async {
    final ImagePicker picker = ImagePicker();

    final XFile? photo = await picker.pickImage(source: ImageSource.camera);

        if(photo != null) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Result(image: photo)));
    }
  }
  
  Future<void> _handleImageFromGallery() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if(image != null) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Result(image: image)));
    }
  }
}
