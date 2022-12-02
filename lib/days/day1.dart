import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

Future<void> getFileLines() async {
  final data = await rootBundle.load('assets/data/day_1.txt');
  final directory = (await getTemporaryDirectory()).path;
  final file = await writeToFile(data, '$directory/bot.txt');
  var check = await file.readAsLines();
  int elfCount = 1;
  int sumOfCalories = 0;
  int highestElf = 0;
  int highestCalories = 0;
  List<int> listOfElves = [];
  for(var item in check){
    if(item.isNotEmpty){
      int newItem = int.parse(item);
      sumOfCalories = sumOfCalories + newItem;
    }
    else{
      listOfElves.add(sumOfCalories);
      if(sumOfCalories > highestCalories){
        highestCalories = sumOfCalories;
        highestElf = elfCount;
      }
      sumOfCalories = 0;
      elfCount++;
    }
  }
  listOfElves.sort();
  var top3 = listOfElves[listOfElves.length-1] + listOfElves[listOfElves.length-2] + listOfElves[listOfElves.length-3];
  print("SUM OF TOP 3 = $top3");
  print("HIGHEST CALORIES = $highestCalories");
  print("ELF ID CARRYING HIGHEST CALORIES = $highestElf");
}

Future<File> writeToFile(ByteData data, String path) {
  return File(path).writeAsBytes(data.buffer.asUint8List(
    data.offsetInBytes,
    data.lengthInBytes,
  ));
}