import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_app/helper/app_export.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:path_provider/path_provider.dart';

class ScanView extends StatefulWidget {
  const ScanView({super.key});

  @override
  State<ScanView> createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView> {
  String _recognizedText = '';
  XFile? image;
  bool isCropped = false;
  final _controller = CropController();
  Uint8List? imageData;
  String block1 = '';
  String block2 = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: Get.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
              ),
              if (imageData != null)
                Column(
                  children: [
                    SizedBox(
                      height: 300,
                      child: Crop(
                        image: imageData!,
                        controller: _controller,
                        onCropped: (data) async {
                          log("cropped");
                          final tempDir = await getTemporaryDirectory();
                          final tempPath = tempDir.path;
                          final file = File('$tempPath/image.jpg');
                          await file.writeAsBytes(data);
                          // image = XFile.fromData(
                          //   data,
                          //   name: "temp.jpg",
                          // );
                          log("path: ${file!.path}");
                          image = XFile(file.path);
                          _scanText();
                          // do something with image data
                        },
                        // aspectRatio: 4 / 3,
                        // initialSize: 0.5,
                        // initialArea: Rect.fromLTWH(240, 212, 800, 600),
                        initialRectBuilder: (rect, react2) => Rect.fromLTRB(
                            rect.left + 24,
                            rect.top + 32,
                            rect.right - 24,
                            rect.bottom - 32),
                        // withCircleUi: true,
                        baseColor: Colors.blue.shade900,
                        maskColor: Colors.white.withAlpha(100),
                        progressIndicator: const CircularProgressIndicator(),
                        radius: 5,
                        onMoved: (newRect) {
                          // do something with current crop rect.
                        },
                        onStatusChanged: (status) {
                          // do something with current CropStatus
                        },
                        willUpdateScale: (newScale) {
                          // if returning false, scaling will be canceled
                          return newScale < 5;
                        },
                        cornerDotBuilder: (size, edgeAlignment) =>
                            const DotControl(color: Colors.blue),
                        clipBehavior: Clip.none,
                        interactive: true,
                        // fixCropRect: true,
                        // formatDetector: (image) {},
                        // imageCropper: myCustomImageCropper,
                        // imageParser: (image, {format}) {},
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                image = null;
                                imageData = null;
                                block1 = '';
                                block2 = '';
                              });
                            },
                            child: Text("Clear Image")),
                        ElevatedButton(
                            onPressed: () {
                              _controller.crop();
                            },
                            child: Text("Crop")),
                      ],
                    )
                  ],
                ),
              block1.isEmpty
                  ? Text("Click to Scanned Code")
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(child: Text(block1)),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(child: Text(block2)),
                        ],
                      ),
                    ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
        child: const Text("Click Image"),
        onPressed: () {
          pickimage();
        },
      ),
    );
  }

  Future pickimage() async {
    final imagePicker = ImagePicker();
    var file = await imagePicker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      imageData = await file.readAsBytes().then((value) {
        setState(() {});
        return value;
      });
    }
  }

  Future<void> _scanText() async {
    // Assuming you're using an image picker to get an image from the camera or gallery
    // Replace this with your image handling logic
    // For simplicity, I'm using `ImagePicker` to pick an image from the gallery
    block1 = '';
    block2 = '';
    if (image == null) return;
    if (image != null) {
      TextRecognizer _textDetector = GoogleMlKit.vision
          .textRecognizer(script: TextRecognitionScript.latin);
      final inputImage = InputImage.fromFilePath(image!.path);
      final RecognizedText elements =
          await _textDetector.processImage(inputImage);

      // log("vvvv- ${elements.blocks}");
      for (int i = 0; i < (elements.blocks.length); ++i) {
        var textBlock = elements.blocks[i];
        log("block ${i + 1}");
        // log(" ${textBlock.text}");
        for (int j = 0; j < (textBlock.lines.length); ++j) {
          if (!containsNumeric(textBlock.lines[j].text)) {
            block1 += "\n" + textBlock.lines[j].text;
          } else {
            block2 += "\n" + textBlock.lines[j].text.replaceAll(' ', '');
          }
          TextLine line = textBlock.lines[j];
          log('line ${j + 1}: "${line.text}"');
          setState(() {});
        }

        // log("size: " + x.boundingBox.size.toString());

        log("========================");
      }
      String recognizedText = '';
      // List<String> strList = elements.text.split('\n');
      // for (var x in strList) {
      //   if (x.contains("Mfg") ||
      //       x.contains("MFG") ||
      //       x.contains("MRP") ||
      //       x.contains("Exp") ||
      //       x.contains("B.No") ||
      //       x.contains("M.R.P.")) {
      //     recognizedText += x + "\n";
      //   }
      // }
      // log(strList.toString());
      setState(() {
        _recognizedText = recognizedText;
      });
    }
  }

  bool containsNumeric(String input) {
    // Create a regular expression to match numeric characters
    RegExp numeric = RegExp(r'\d');

    // Use RegExp's hasMatch method to check if the input string contains numeric characters
    return numeric.hasMatch(input);
  }
}
