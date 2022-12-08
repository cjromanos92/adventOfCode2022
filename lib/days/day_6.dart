import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class Ffile{
  String name;
  int size;
  List<String> directories;

  Ffile({required this.name, required this.size, required this.directories});
}

class Directory{
  String name;
  int totalSize;

  Directory({required this.name, required this.totalSize});
}

Future<void> getFileLines() async {
  final data = await rootBundle.load('assets/data/day_6.txt');
  final directory = (await getTemporaryDirectory()).path;
  final file = await writeToFile(data, '$directory/bot.txt');
  var instructions = await file.readAsLines();


  List<Ffile> masterListFile = [];
  List<Directory> masterListDir = [Directory(name: '/', totalSize: 0)];
  List<String> listOfDir = [];
  int fileSize = 0;
  int dirCount = 1;
  String name = '';
  for(var lines in instructions){
    var parseLines = lines.split(' ');
    if(parseLines[0] == '\$'){
      if(parseLines[1] == 'cd'){
        if(parseLines[2] == '/'){listOfDir = ['/'];}
        else if(parseLines[2] == '..'){listOfDir.removeLast();}
        else{listOfDir.add(parseLines[2]); masterListDir.add(Directory(name: parseLines[2], totalSize: 0)); dirCount = dirCount + 1;}
      }
      else if(parseLines[1] == 'ls'){
        //DO NOTHING
      }
    }
    else if(parseLines[0] == 'dir'){
      //DO NOTHING
    }
    else if(int.tryParse(parseLines[0]) != null){
      name = parseLines[1];
      fileSize = int.parse(parseLines[0]);
      List<String> tempDir = List.from(listOfDir);

      Ffile thisFile = new Ffile(name: name, size: fileSize, directories: tempDir);
      // print("FILE ${thisFile.name} ${thisFile.size} ${thisFile.directories}");
      masterListFile.add(thisFile);
      // print("MFILE ${masterListFile.elementAt(masterListFile.length-1).name} ${masterListFile.elementAt(masterListFile.length-1).size} ${masterListFile.elementAt(masterListFile.length-1).directories}");
    }
  }
  print("DIRCOUNT $dirCount");
  print("DONE 1");

  for(var dir in masterListDir){
    for(var file in masterListFile){
      if(file.directories.contains(dir.name)){
        dir.totalSize = dir.totalSize + file.size;
      }
    }
  }
  print("DONE 2");

  List<Directory> filteredList = [];
  for(var dir in masterListDir){
    if(dir.totalSize <= 100000){
      // print("DIR ${dir.name} ${dir.totalSize}");
      var newDir = dir;
      filteredList.add(newDir);
      // print("FDIR ${filteredList.elementAt(filteredList.length-1).name} ${filteredList.elementAt(filteredList.length-1).totalSize}");
    }
  }
  print("DONE 3");


  int finalSize = 0;
  print("LIST HAS BEEN FILTERED: ${filteredList.length} ITEMS");
  print("FILTERED LIST LENGTH ${filteredList.length}");
  for(var dir in filteredList){
    finalSize = finalSize + dir.totalSize;
  }
  print("DONE 4");
  print("FINAL TOTAL  SIZE IS $finalSize");
}

Future<File> writeToFile(ByteData data, String path) {
  return File(path).writeAsBytes(data.buffer.asUint8List(
    data.offsetInBytes,
    data.lengthInBytes,
  ));
}
