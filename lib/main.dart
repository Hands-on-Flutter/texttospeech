import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(TextToSpeechApp());
}

class TextToSpeechApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text to Speech app',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ColorsScreen(),
    );
  }
}

class ColorObject {
  final String name;
  final MaterialColor color;

  ColorObject(this.name, this.color);
}

class ColorsScreen extends StatefulWidget {
  @override
  _ColorsScreenState createState() => _ColorsScreenState();
}

class _ColorsScreenState extends State<ColorsScreen> {
  FlutterTts flutterTts = FlutterTts();

  List<ColorObject> colorObjects = [
    ColorObject('Blue', Colors.blue),
    ColorObject('Red', Colors.red),
    ColorObject('Green', Colors.green),
    ColorObject('Orange', Colors.orange),
    ColorObject('Teal', Colors.teal),
    ColorObject('Purple', Colors.purple),
  ];

  void playColorName(String colorName) async {
    await flutterTts.speak(colorName);
  }

  @override
  Widget build(BuildContext context) {
    // By using MediaQuery can we get the size of current device
    Size deviceSize = MediaQuery.of(context).size;
    // We want the carousel to have 80% of the device height
    double carouselHeight = deviceSize.height * 0.8;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: CarouselSlider(
            options: CarouselOptions(
              height: carouselHeight,
              onPageChanged: (int index, CarouselPageChangedReason reason) {
                playColorName(colorObjects[index].name);
              }
            ),
            items: colorObjects.map((ColorObject colorObj) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  color: colorObj.color,
                  borderRadius: BorderRadius.circular(16.0),
                ),
              );
            }).toList()
          ),
        )
      ),
    );
  }
}
