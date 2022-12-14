import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class Head {
  int x;
  int y;

  Head({required this.x, required this.y});
}

class Tail {
  int x;
  int y;

  Tail({required this.x, required this.y});
}

class Previous {
  int x;
  int y;

  Previous({required this.x, required this.y});
}

Future<void> getFileLines() async {
  final data = await rootBundle.load('assets/data/day_9.txt');
  final directory = (await getTemporaryDirectory()).path;
  final file = await writeToFile(data, '$directory/bot.txt');
  var instructions = await file.readAsLines();

  int repeat = 0;
  List<String> visitedList = [];
  List<int> location = [0, 0];
  Head hhead = Head(x: 0, y: 0);
  Tail ttail = Tail(x: 0, y: 0);
  Previous prev = Previous(x: 0, y: 0);

  for(var lines in instructions){
    List<String> line = lines.split(" ");
    String direction = line[0];
    print("DIRECTION IS $direction");
    repeat = int.parse(line[1]);
    print("REPEAT IS $repeat");

    int i = 0;
    while(i < repeat){

      prev = Previous(x: hhead.x, y: hhead.y);
      hhead = moveHead(direction, hhead);
      ttail = moveTail(hhead, ttail, visitedList, prev);
      // checkVisited();
      print("Head: ${hhead.x}, ${hhead.y}");
      i++;
    }
  }
  print(visitedList.length);
  var distinctList = visitedList.toSet().toList();
  print(distinctList.length);

}


Head moveHead(String direction, Head hhead){
  switch(direction){
    case "R":
      hhead.x = hhead.x+1;
      print("ADDED ONE TO X");
      break;
    case "L":
      hhead.x = hhead.x-1;
      break;
    case "U":
      hhead.y = hhead.y+1;
      break;
    case "D":
      hhead.y = hhead.y-1;
      break;
  }
  return hhead;
}

Tail moveTail(Head hhead, Tail ttail, visitedList, prev){
  if(((hhead.x-ttail.x) > 1 || (hhead.x - ttail.x) < -1) && hhead.y == ttail.y){
    ttail.x = prev.x;
  } else if(((hhead.y-ttail.y) > 1 || (hhead.y - ttail.y) < -1) && hhead.x == ttail.x){
    ttail.y = prev.y;
  } else if(hhead.x != ttail.x && hhead.y != ttail.y){
    ttail.x = prev.x;
    ttail.y = prev.y;
  }

  visitedList.add("${ttail.x}, ${ttail.y}");
  return ttail;
}

Future<File> writeToFile(ByteData data, String path) {
  return File(path).writeAsBytes(data.buffer.asUint8List(
    data.offsetInBytes,
    data.lengthInBytes,
  ));
}
