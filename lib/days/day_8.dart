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


  //BUILDS "TABLE" CORRECTLY
  //REFER TO TREES FOR TREE OBJECTS
  //REFER TO TREEROWS FOR ROWS OF INTS
  //REFER TO TREECOLS FOR COLUMNS OF INTS

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

        var tempRight = treeRows[i].getRange(j + 1, treeRows[i].length);
        List<int> scenicRight = tempRight.toList();

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

        var tempDown = treeCols[j].getRange(i + 1, treeCols[j].length);
        List<int> scenicDown = tempDown.toList();

        int upMax = tempUp.reduce(max);
        int downMax = tempDown.reduce(max);
        int multiplied = scenicScoreLeft *
            scenicScoreRight *
            scenicScoreTop *
            scenicScoreBottom;
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
      visibleFromBottom = false;
      visibleFromTop = false;
      visibleFromRight = false;
      visibleFromLeft = false;
    }
    i++;
  }

  print("VISIBLE COUNT IS : $visibleCount");

  i = 0;
  j = 0;
  scenicScoreLeft = 0;
  scenicScoreRight = 0;
  scenicScoreTop = 0;
  scenicScoreBottom = 0;
  while (i < treeRows.length) {
    j = 0;
    while (j < treeCols[j].length) {
      scenicScoreBottom = 0;
      scenicScoreTop = 0;
      scenicScoreRight = 0;
      scenicScoreLeft = 0;
      int totalScenicScore = 0;
      Tree thisTree = trees[i][j];
      bool viewBlocked = false;
      var tempLeft = treeRows[i].getRange(0, j);
      List<int> scenicLeft = tempLeft.toList();

      scenicLeft = scenicLeft.reversed.toList();
      viewBlocked = false;
      while (viewBlocked == false) {
        if (scenicLeft.length == 0) {
          viewBlocked = true;
        } else {
          int nextTree = scenicLeft[0];
          if (nextTree < thisTree.height) {
            scenicScoreLeft++;
            scenicLeft.removeAt(0);
          } else {
            scenicScoreLeft++;
            viewBlocked = true;
          }
        }
      }


      var tempRight = treeRows[i].getRange(j + 1, treeRows[i].length);
      List<int> scenicRight = tempRight.toList();

      viewBlocked = false;
      while (viewBlocked == false) {
        if (scenicRight.length == 0) {
          viewBlocked = true;
        } else {
          int nextTree = scenicRight[0];
          if (nextTree < thisTree.height) {
            scenicScoreRight++;
            scenicRight.removeAt(0);
          } else {
            scenicScoreRight++;
            viewBlocked = true;
          }
        }
      }


      var tempUp = treeCols[j].getRange(0, i);
      List<int> scenicUp = tempUp.toList();
      scenicUp = scenicUp.reversed.toList();

      viewBlocked = false;
      while (viewBlocked == false) {
        if (scenicUp.length == 0) {
          viewBlocked = true;
        } else {
          int nextTree = scenicUp[0];
          if (nextTree < thisTree.height) {
            scenicScoreTop++;
            scenicUp.removeAt(0);
          } else {
            scenicScoreTop++;
            viewBlocked = true;
          }
        }
      }


      var tempDown = treeCols[j].getRange(i + 1, treeCols[j].length);
      List<int> scenicDown = tempDown.toList();

      viewBlocked = false;
      while (viewBlocked == false) {
        if (scenicDown.length == 0) {
          viewBlocked = true;
        } else {
          int nextTree = scenicDown[0];
          if (nextTree < thisTree.height) {
            scenicScoreBottom++;
            scenicDown.removeAt(0);
          } else {
            scenicScoreBottom++;
            viewBlocked = true;
          }
        }
      }
      totalScenicScore = scenicScoreLeft * scenicScoreRight * scenicScoreTop * scenicScoreBottom;
      if(totalScenicScore > highestScore) {
        highestScore = totalScenicScore;
      }
      j++;
    }
    i++;
  }
  print("HIGHEST SCORE IS : $highestScore");
}

Future<File> writeToFile(ByteData data, String path) {
  return File(path).writeAsBytes(data.buffer.asUint8List(
    data.offsetInBytes,
    data.lengthInBytes,
  ));
}
