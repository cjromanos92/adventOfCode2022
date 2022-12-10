import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class Ffile {
  String name;
  int size;
  List<String> directories;

  Ffile({required this.name, required this.size, required this.directories});
}

class Directory {
  String name;
  int totalSize;

  Directory({required this.name, required this.totalSize});
}

Future<void> getFileLines() async {
  final data = await rootBundle.load('assets/data/day_6.txt');
  final directory = (await getTemporaryDirectory()).path;
  final file = await writeToFile(data, '$directory/bot.txt');
  var instructions = await file.readAsLines();
  int spaceLeft = 70000000;

  List<Ffile> masterListFile = [];
  List<Directory> masterListDir = [Directory(name: '/', totalSize: 0)];
  List<String> listOfDir = [];
  int fileSize = 0;
  int dirCount = 1;
  String name = '';
  for (var lines in instructions) {
    var parseLines = lines.split(' ');
    if (parseLines[0] == '\$') {
      if (parseLines[1] == 'cd') {
        if (parseLines[2] == '/') {
          listOfDir = ['/'];
        } else if (parseLines[2] == '..') {
          listOfDir.removeLast();
        } else {
          if (masterListDir.contains(parseLines[2].toString())) {
            listOfDir.add(parseLines[2]);
            masterListDir.add(Directory(name: parseLines[2], totalSize: 0));
            dirCount = dirCount + 1;
          }
          else{
            dirCount = dirCount + 1;
            String newName = parseLines[2] + dirCount.toString();
            listOfDir.add(newName);
            masterListDir.add(Directory(name: newName, totalSize: 0));

          }
        }
      } else if (parseLines[1] == 'ls') {
        //DO NOTHING
      }
    } else if (parseLines[0] == 'dir') {
      //DO NOTHING
    } else if (int.tryParse(parseLines[0]) != null) {
      name = parseLines[1];
      fileSize = int.parse(parseLines[0]);
      spaceLeft = spaceLeft - fileSize;
      List<String> tempDir = List.from(listOfDir);

      Ffile thisFile =
          new Ffile(name: name, size: fileSize, directories: tempDir);
      masterListFile.add(thisFile);
    }
  }

  for (var dir in masterListDir) {
    for (var file in masterListFile) {
      if (file.directories.contains(dir.name)) {
        dir.totalSize = dir.totalSize + file.size;
      }
    }
  }

  List<Directory> filteredList = [];
  for (var dir in masterListDir) {
    if (dir.totalSize <= 100000) {
      var newDir = dir;
      filteredList.add(newDir);
    }
  }

  int finalSize = 0;
  for (var dir in filteredList) {
    finalSize = finalSize + dir.totalSize;
  }
  print("PART 1 ANSWER IS $finalSize");
  int deleteSize = 30000000 - spaceLeft;
  masterListDir.sort((a, b) => b.totalSize.compareTo(a.totalSize));

  int availableSpace = 70000000 - masterListDir[0].totalSize;
  filteredList = [];
  //20807468
  for(var dir in masterListDir) {
    if(dir.totalSize >= 9192532) {
      filteredList.add(dir);
    }
  }
  filteredList.sort((a, b) => a.totalSize.compareTo(b.totalSize));
  print("REMOVABLE DIR IS ${filteredList[0].totalSize}");

}

Future<File> writeToFile(ByteData data, String path) {
  return File(path).writeAsBytes(data.buffer.asUint8List(
    data.offsetInBytes,
    data.lengthInBytes,
  ));
}
