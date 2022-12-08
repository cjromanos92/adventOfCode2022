import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

Future<void> getFileLines() async {
  final data = await rootBundle.load('assets/data/old.txt');
  final directory = (await getTemporaryDirectory()).path;
  final file = await writeToFile(data, '$directory/bot.txt');
  var sonar = await file.readAsLines();

  int baseNum = int.parse(sonar[0] + sonar[1] + sonar[2]);
  int increaseCount = 0;

  for (int i = 0; i < sonar.length-2; i++) {
    int newNum1 = int.parse(sonar[i]);
    int newNum2 = int.parse(sonar[i + 1]);
    int newNum3 = int.parse(sonar[i + 2]);
    int sumOfNewNums = newNum1 + newNum2 + newNum3;

    if (sumOfNewNums > baseNum) {
      increaseCount = increaseCount + 1;
    }
    baseNum = sumOfNewNums;
  }
  print("INCREASE COUNT = $increaseCount");
}

Future<File> writeToFile(ByteData data, String path) {
  return File(path).writeAsBytes(data.buffer.asUint8List(
    data.offsetInBytes,
    data.lengthInBytes,
  ));
}
