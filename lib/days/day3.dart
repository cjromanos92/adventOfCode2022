import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

Future<void> getFileLines() async {
  final data = await rootBundle.load('assets/data/day_3.txt');
  final directory = (await getTemporaryDirectory()).path;
  final file = await writeToFile(data, '$directory/bot.txt');
  var rucksack = await file.readAsLines();
  int totalScore = 0;

  List<String> letters = [];
  // Add lowercase letters a through z to the list
  for (int i = 97; i <= 122; i++) {
    letters.add(String.fromCharCode(i));
  }
  // Add uppercase letters A through Z to the list
  for (int i = 65; i <= 90; i++) {
    letters.add(String.fromCharCode(i));
  }


  int index = 0;
  //SEPARATE RUCKSACKS BY GROUPS OF 3
  while (index < rucksack.length) {

    var rucksack1 = rucksack[index];
    var rucksack2 = rucksack[index + 1];
    var rucksack3 = rucksack[index + 2];

    //SPLIT FIRST RUCKSACK INTO A LIST OF CHARACTERS
    var firstStringSplit = rucksack1.split('');
    for (var letter in firstStringSplit) {
      if (rucksack2.contains(letter) && rucksack3.contains(letter)) {
        int letterScore = letters.indexOf(letter) + 1;
        totalScore = totalScore + letterScore;
        print("TOTAL SCORE IS: $totalScore");
        break;
      }
    }
    index = index + 3;
  }
}

Future<File> writeToFile(ByteData data, String path) {
  return File(path).writeAsBytes(data.buffer.asUint8List(
    data.offsetInBytes,
    data.lengthInBytes,
  ));
}

// int totalScore = 0;
// List<String> letters = [];
// // Add lowercase letters a through z to the list
// for (int i = 97; i <= 122; i++) {
// letters.add(String.fromCharCode(i));
// }
// // Add uppercase letters A through Z to the list
// for (int i = 65; i <= 90; i++) {
// letters.add(String.fromCharCode(i));
// }
// for (var item in rucksack) {
// List<String> itemList = [];
// final divisionIndex = item.length ~/ 2;
// for (int i = 0; i < item.length; i++) {
// if (i % divisionIndex == 0) {
// final tempString = item.substring(i, i + divisionIndex);
// itemList.add(tempString);
// }
// }
// String firstString = itemList[0];
// var firstStringSplit = firstString.split('');
// for (var letter in firstStringSplit) {
// if(itemList[1].contains(letter)){
// totalScore = totalScore + letters.indexOf(letter) + 1;
// break;
// }
// }
// }
// print(totalScore);
