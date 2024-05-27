import 'dart:convert';
import 'dart:io';

import 'package:cv_fe/size_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class Result extends StatefulWidget {
  const Result({super.key, required this.image});
  final XFile image;
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  bool isLoading = true;
  late String text;
  @override
  void initState() {
    super.initState();
    _handlePrediction(widget.image);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 350.h,
                  height: 480.h,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20.h)),
                      clipBehavior: Clip.antiAlias,
                  child: Image.file(
                    File(
                      widget.image.path,
                    ),
                    fit: BoxFit.cover,
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: isLoading
                    ? const CircularProgressIndicator()
                    : Text(text,
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold, fontSize: 32.h)),
              ),
            ],
          )
        ],
      ),
    );
  }
  
  Future<void> _handlePrediction(XFile image) async {
    final data = FormData.fromMap({"file": [MultipartFile.fromBytes(await image.readAsBytes(), filename: image.name)]});
    Dio().post("https://cv-server-i8s2.onrender.com/predict", data: data).then((value) {
      final result = value.data;
      setState(() {
        text = result["svm"]["class"].toString();
        isLoading = false;
      });
    });
  }
}
