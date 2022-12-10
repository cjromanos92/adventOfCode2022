import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class Tree {
  int height;
  List<int> location;
  bool visible;

  Tree({required this.height, required this.location, required this.visible});
}

Future<void> getFileLines() async {
  final data = await rootBundle.load('assets/data/day_8.txt');
  final directory = (await getTemporaryDirectory()).path;
  final file = await writeToFile(data, '$directory/bot.txt');
  var forest = await file.readAsLines();

  List<List<Tree>> trees = [];
  int ns = 0;
  int we = 0;
  for (var lines in forest) {
    we = 0;
    var tempLine = lines.split('');
    var tempRowInt = tempLine.map(int.parse).toList();
    List<Tree> row = [];
    while(ns<forest.length){
      row = [];
      while(we<tempRowInt.length){
        row.add(Tree(height: tempRowInt[we], location: [ns,we], visible: false));
        we++;
      }
      trees.add(row);
      ns++;
    }
  }

  ns = 0;
  we = 0;

  while(ns<forest.length){
    while(we<forest.length){
      print(trees[ns][we].height);
      print(trees[ns][we].location);
      print(we);
      we++;
    }
    print(ns);
    ns++;
    }
  }


Future<File> writeToFile(ByteData data, String path) {
  return File(path).writeAsBytes(data.buffer.asUint8List(
    data.offsetInBytes,
    data.lengthInBytes,
  ));
}
