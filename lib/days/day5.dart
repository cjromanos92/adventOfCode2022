import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

Future<void> getFileLines() async {
  final data = await rootBundle.load('assets/data/day_5.txt');
  final directory = (await getTemporaryDirectory()).path;
  final file = await writeToFile(data, '$directory/bot.txt');
  var buffer = await file.readAsLines();

  List<String> splitString = buffer[0].split('');
  print(splitString.length);
  bool matchFound = false;
  int letterProcessed = 13;
  int i = 0;

  while (i < splitString.length - 13 && matchFound == false) {
    var testList = [];
    String letter1 = splitString[i];
    String letter2 = splitString[i + 1];
    String letter3 = splitString[i + 2];
    String letter4 = splitString[i + 3];
    String letter5 = splitString[i + 4];
    String letter6 = splitString[i + 5];
    String letter7 = splitString[i + 6];
    String letter8 = splitString[i + 7];
    String letter9 = splitString[i + 8];
    String letter10 = splitString[i + 9];
    String letter11 = splitString[i + 10];
    String letter12 = splitString[i + 11];
    String letter13 = splitString[i + 12];
    String letter14 = splitString[i + 13];

    testList.add(letter1);
    testList.add(letter2);
    testList.add(letter3);
    testList.add(letter4);
    testList.add(letter5);
    testList.add(letter6);
    testList.add(letter7);
    testList.add(letter8);
    testList.add(letter9);
    testList.add(letter10);
    testList.add(letter11);
    testList.add(letter12);
    testList.add(letter13);
    testList.add(letter14);

    var duplicateCheck = testList.toSet().toList();
    if (duplicateCheck.length == 14) {
      matchFound = true;
    }
    letterProcessed++;
    i++;}

    print("LETTER PROCESSED = $letterProcessed");
  }

  Future<File> writeToFile(ByteData data, String path) {
    return File(path).writeAsBytes(data.buffer.asUint8List(
      data.offsetInBytes,
      data.lengthInBytes,
    ));
  }
