import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:advent_of_code/days/day_5.dart' as stacks;

Future<void> getFileLines() async {
  final data = await rootBundle.load('assets/data/day_5.txt');
  final directory = (await getTemporaryDirectory()).path;
  final file = await writeToFile(data, '$directory/bot.txt');
  var instructions = await file.readAsLines();

  List<String> stack1 = stacks.stackOne;
  List<String> stack2 = stacks.stackTwo;
  List<String> stack3 = stacks.stackThree;
  List<String> stack4 = stacks.stackFour;
  List<String> stack5 = stacks.stackFive;
  List<String> stack6 = stacks.stackSix;
  List<String> stack7 = stacks.stackSeven;
  List<String> stack8 = stacks.stackEight;
  List<String> stack9 = stacks.stackNine;
  List<List<String>> stackList = [
    [],
    stack1,
    stack2,
    stack3,
    stack4,
    stack5,
    stack6,
    stack7,
    stack8,
    stack9
  ];

  //PART 1

  // for (var task in instructions) {
  //   var parseTask = task.split(' ');
  //   int qtyMove = int.parse(parseTask[1]);
  //   int fromStack = int.parse(parseTask[3]);
  //   int toStack = int.parse(parseTask[5]);
  //
  //   for (int i = 0; i < qtyMove; i++) {
  //     stackList[toStack].add(stackList[fromStack].removeLast());
  //   }
  // }
  // List<String> topCrates =[];
  // String output = '';
  // for(int i = 1; i < stackList.length; i++){
  //   topCrates.add(stackList[i].last);
  //   output = topCrates.join('');
  //   print(output);
  // }

  // PART 2

  for (var task in instructions) {
    var parseTask = task.split(' ');
    int qtyMove = int.parse(parseTask[1]);
    int fromStack = int.parse(parseTask[3]);
    int toStack = int.parse(parseTask[5]);

    for (int j = qtyMove; j > 0; j--) {
      stackList[toStack]
          .add(stackList[fromStack][stackList[fromStack].length - j]);
    }
    stackList[fromStack].removeRange(
        stackList[fromStack].length - qtyMove, stackList[fromStack].length);
  }
  List<String> topCrates = [];
  String output = '';
  for (int i = 1; i < stackList.length; i++) {
    topCrates.add(stackList[i].last);
    output = topCrates.join('');
  }
  print(output);
}

Future<File> writeToFile(ByteData data, String path) {
  return File(path).writeAsBytes(data.buffer.asUint8List(
    data.offsetInBytes,
    data.lengthInBytes,
  ));
}
