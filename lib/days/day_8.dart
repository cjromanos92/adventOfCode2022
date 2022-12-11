import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:math';

class Tree {
  int height;
  List<int> location;
  bool visible;
  int scenicScore;

  Tree(
      {required this.height,
      required this.location,
      required this.visible,
      required this.scenicScore});
}

Future<void> getFileLines() async {
  final data = await rootBundle.load('assets/data/day_8.txt');
  final directory = (await getTemporaryDirectory()).path;
  final file = await writeToFile(data, '$directory/bot.txt');
  var forest = await file.readAsLines();
  var length = forest.length;

  List<List<Tree>> trees = [];
  List<List<int>> treeRows = [];
  List<List<int>> treeCols = [];
  int i = 0;
  i = 0;
  int j = 0;
  while (i < forest.length) {
    var tempLine = forest[i].split('');
    List<int> tempRow = tempLine.map(int.parse).toList();
    trees.add([]);
    treeRows.add(tempRow);
    j = 0;
    while (j < tempLine.length) {
      treeCols.add([]);
      int treeHeight = int.parse(tempLine[j]);
      Tree thisTree = Tree(
          height: treeHeight, location: [i, j], visible: false, scenicScore: 0);
      trees[i].add(thisTree);
      treeCols[j].add(treeHeight);
      j++;
    }
    i++;
  }

  i = 0;
  j = 0;
  int visibleCount = 0;
  bool visibleFromLeft = false;
  bool visibleFromRight = false;
  bool visibleFromTop = false;
  bool visibleFromBottom = false;
  int highestScore = 0;
  int scenicScoreLeft = 0;
  int scenicScoreRight = 0;
  int scenicScoreTop = 0;
  int scenicScoreBottom = 0;
  while (i < treeRows.length) {
    j = 0;
    while (j < treeCols[j].length) {
      if (i == 0 ||
          j == 0 ||
          i == treeRows.length - 1 ||
          j == treeCols[j].length - 1) {
        trees[i][j].visible = true;
        visibleCount++;
      } else {
        //CHECK LEFT & RIGHT
        var tempLeft = treeRows[i].getRange(0, j);
        List<int> scenicLeft = tempLeft.toList();
        bool viewBlocked = false;
        while( viewBlocked == false){
          for (var tree in scenicLeft.reversed) {
            if (tree < trees[i][j].height) {
              scenicScoreLeft++;
              viewBlocked = false;
            } else {
              viewBlocked = true;
              break;
            }
          }
        }
        var tempRight = treeRows[i].getRange(j + 1, treeRows[i].length);
        List<int> scenicRight = tempRight.toList();
        viewBlocked = false;
        while( viewBlocked == false){
          for (var tree in scenicRight.reversed) {
            if (tree < trees[i][j].height) {
              scenicScoreRight++;
              viewBlocked = false;
            } else {
              viewBlocked = true;
              break;
            }
          }
        }
        int leftMax = tempLeft.reduce(max);

        int rightMax = tempRight.reduce(max);

        if (trees[i][j].height > leftMax) {
          visibleFromLeft = true;
        }
        if (trees[i][j].height > rightMax) {
          visibleFromRight = true;
        }

        //CHECK UP & DOWN
        var tempUp = treeCols[j].getRange(0, i);
        List<int> scenicUp = tempUp.toList();
        viewBlocked = false;
        while( viewBlocked == false){
          for (var tree in scenicUp.reversed) {
            if (tree < trees[i][j].height) {
              scenicScoreTop++;
              viewBlocked = false;
            } else {
              viewBlocked = true;
              break;
            }
          }
        }
        var tempDown = treeCols[j].getRange(i + 1, treeCols[j].length);
        List<int> scenicDown = tempDown.toList();
        viewBlocked = false;
        while( viewBlocked == false){
          for (var tree in scenicDown.reversed) {
            if (tree < trees[i][j].height) {
              scenicScoreBottom++;
            } else {
              viewBlocked = true;
              break;
            }
          }
        }
        int upMax = tempUp.reduce(max);
        int downMax = tempDown.reduce(max);
        print("SCENIC SCORE ******************");
        print(
            "SCENIC SCORE LEFT: $scenicScoreLeft RIGHT: $scenicScoreRight TOP: $scenicScoreTop BOTTOM: $scenicScoreBottom");
        int multiplied = scenicScoreLeft *
            scenicScoreRight *
            scenicScoreTop *
            scenicScoreBottom;
        print("MULTIPLIED: $multiplied");
        if (multiplied > highestScore) {
          highestScore = multiplied;
        }
        if (trees[i][j].height > upMax) {
          visibleFromTop = true;
        }
        if (trees[i][j].height > downMax) {
          visibleFromBottom = true;
        }
        if (visibleFromLeft ||
            visibleFromRight ||
            visibleFromTop ||
            visibleFromBottom == true) {
          trees[i][j].visible = true;
          visibleCount++;
        }
      }
      j++;
      scenicScoreLeft = 0;
      scenicScoreRight = 0;
      scenicScoreTop = 0;
      scenicScoreBottom = 0;
      visibleFromBottom = false;
      visibleFromTop = false;
      visibleFromRight = false;
      visibleFromLeft = false;
    }
    j = 0;
    i++;
  }

  print("VISIBLE COUNT IS : $visibleCount");
  print("HIGHEST SCORE IS : $highestScore");
}

Future<File> writeToFile(ByteData data, String path) {
  return File(path).writeAsBytes(data.buffer.asUint8List(
    data.offsetInBytes,
    data.lengthInBytes,
  ));
}
